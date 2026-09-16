'use strict';
const LOGGER = require("log4js").getLogger("adoptioncase");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function (Adoptioncase) {
  
  Adoptioncase.remoteMethod('createadoptioncase', {
    accepts: [{
      arg: 'data',
      type: 'Object',
      http: {
        source: 'body'
      },
      required: true
    }, {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
    http: {
      path: '/createadoptioncase',
      verb: 'post'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Adoptioncase.createadoptioncase = function (request, reqctx) {
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
    var userid = _securityusersid;

    var sql = 'select * from createadoptioncase($1,$2,$3,$4,$5)';
    var params = [request.adoptionplanningid, request.servicecaseid,JSON.stringify(request.person), userid, request.assigntoid];
    if (request.fromIntake) {
      sql = 'select * from createadoptioncasefromintake($1,$2, $3)';
      params = [request.intakeNumber, request.intakeserviceid ,userid];
    }/*else {
      sql = 'select * from createadoptioncase($1,$2,$3,$4,$5)';
      params = [request.adoptionplanningid, request.servicecaseid,JSON.stringify(request.person), userid, request.assigntoid];
    }*/
    return util.executeDBQuery(sql, params)
    .then( async data =>{
      //@Simar - Making the chessie placement update call
      if (data && Array.isArray(data)){
        if ( data[0].newpersonid  ) {
          await app.models.Person.createMdmUsingPersonid(data[0].newpersonid, _securityusersid);
        }
        if (data[0].parent1id  ) {
          await app.models.Person.createMdmUsingPersonid(data[0].parent1id, _securityusersid);
        }
        if (data[0].parent2id  ) {
          await app.models.Person.createMdmUsingPersonid(data[0].parent2id, _securityusersid);
        }
      }
      return data;
   }).catch(err => util.logError(err));
  };

  Adoptioncase.remoteMethod('assigncase', {
    http: {
      path: '/assigncase',
      verb: 'post'
    },
    accepts: [{
      arg: 'data',
      type: 'object',
      http: {
        source: 'body'
      }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
    returns: {
      type: 'object',
      root: true
    }
  });

  Adoptioncase.assigncase = (data, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }
    var userid = (data && data.securityuserid?data.securityuserid: _securityusersid);
    var appeventcode = data.appeventcode;
    var assignedusers = [{userid:data.assignedusers}];
    var adoptioncaseid = data.adoptioncaseid;

    var params = [appeventcode, adoptioncaseid, userid, JSON.stringify(assignedusers)];

    var sql = "SELECT * FROM assignadoptioncase($1,$2,$3,$4)"
    return util.executeDBQuery(sql, params)
      .then(data1 => {
        // NOSONAR
        // app.models.Auditlog.create({
        //     // logtypekey:'WL001',
        //     logtypekey:'ADOPTIONTESTING',
        //     intakeserviceid:null,
        //     servicerequestnumber:null,
        //     referenceid:null,
        //     description:'A program assigment is made',
        //     isnew :false,
        //     isedit:true,
        //     isdelete:true,
        //     insertedby:(request && request.securityuserid?request.securityuserid: app.currentUser.securityusersid),
        //     updatedby:(request && request.securityuserid?request.securityuserid: app.currentUser.securityusersid),
        //     insertedon:new Date(),
        //     updatedon:new Date(),
        //     metadata:null,
        //     ipaddress:null,
        //     old_id:null,
        //     modifieddata:null,
        //     objectid:adoptioncaseid,
        //     objecttype: 'adoptioncase'
        // }).catch(err => LOGGER.error(err));

        return data1;
      }).catch(err => util.logError(err));

  }

  Adoptioncase.remoteMethod('adoptioncaselist', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      verb: 'get'
    },
    returns: {
      type: 'string',
      root: true
    }
  });

  Adoptioncase.adoptioncaselist = (request) => {
    var sql = 'select * from adoptioncaselist($1,$2,$3)';
    return util.executeSecondaryNodeDBQuery(sql, [request.where.adoptioncaseid, request.page, request.limit])
      .then(data => {
        return (data?data[0].adoptioncaselist:null);
      })
      .then(data => { return data; })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  }

  Adoptioncase.remoteMethod('addupdate', {
    accepts: [{
      arg: 'data',
      type: 'object',

      http: { source: 'body' }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
    http: {
      'verb': 'post',
      'path': '/addupdate'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Adoptioncase.addupdate = (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }
    const insertedon = new Date().toLocaleString();

    if (request.adoptioncaseid === undefined || request.adoptioncaseid == null) {
        request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
        request.insertedon = insertedon;
        request.activeflag = true;
        return Adoptioncase.create(request);
        
    } else {
        return Adoptioncase.updateAll({
          adoptioncaseid: request.adoptioncaseid             
    }, {
        narrative: request.narrative,  
        activeflag: request.activeflag,
        updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)
    }).catch(err => util.logError(err));
  }
  };

  Adoptioncase.remoteMethod('adoptioncaselistbyid', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      verb: 'get'
    },
    returns: {
      type: 'string',
      root: true
    }
  });

  Adoptioncase.adoptioncaselistbyid = (request) => {
    var sql = 'select * from adoptioncaselistbyid($1,$2,$3)';
    return util.executeSecondaryNodeDBQuery(sql, [request.where.adoptioncaseid, request.page, request.limit])
      .then(data => {
        return (data?data[0].adoptioncaselistbyid:null);
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  }

  Adoptioncase.remoteMethod('adoptionpaymenthistory', {
    http: {
    path: '/adoptionpaymenthistory',
    verb: 'get'
    },
    accepts : [ 
    {
      arg : 'filter',
      type : 'object',
      http : {source : 'query'}
    } ], 
    returns: {
      type : 'object',
      root : true
    } 
  });
  
  Adoptioncase.adoptionpaymenthistory =(request)=> {  
    var providerid = request.where.providerid; 
    var clientid = request.where.clientid;  
    var caseid = request.where.caseid; 
    var page = request.page;
    var limit = request.limit;
    var totalcount = 0;
    var sql = 'select * from getadoptionpaymenthistory($1,$2,$3,$4,$5)';

    return util.executeDBQuery(sql, [providerid,clientid,caseid,page,limit])
    .then(data => {
      if (data != null && data.length > 0) {totalcount = data[0].totalcount;}
      return {
        'data': data,
        'count': totalcount
      };
    })
    .then(datas => datas)
    .catch(err => util.logError(err));
  };

  Adoptioncase.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Adoptioncase.observe('access', (ctx, next) => util.access(ctx, next));
  Adoptioncase.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
