'use strict';
const util = require('../utils/utils');
let app = require('../../server/server');
const plansubmittedmsg = 'Permanency plan Submitted for review';
const LOGGER = require("log4js").getLogger("permanencyplan");

module.exports = function (Permanencyplan) {


  Permanencyplan.remoteMethod('add', {
    http: {
      path: '/add',
      verb: 'post'
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
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

  Permanencyplan.add = (request, reqctx) => {
    const v_securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;

    if (request.permanencyplanid == undefined && request.permanencyplanid == null) {
    return app.models.Permanencyplan.create({
      intakeservicerequestactorid: request.intakeservicerequestactorid,
      servicecaseid: request.servicecaseid,
      placementid: request.placementid,
      modifiedjson: request.modifiedjson,
      projecteddate: request.primaryplandate,
      establisheddate: request.concurrentplandate,
      caseworkername: request.caseworkername,
      courtorderreceived: request.courtorderreceived,
      permanencyplanremainssame: request.permanencyplanremainssame,
      permanencyplanremainssamedate: request.permanencyplanremainssamedate,
      reviewdate: request.reviewdate,
      primarypermanencytype: request.primarypermanencytype,
      concurrentpermanencytype: request.concurrentpermanencytype,
      primaryarrangetype: request.primaryarrangetype,
      concurrentarrangetype: request.concurrentarrangetype,
      remarks: request.remarks,
      concurrentcomments: request.concurrentcomments,
      reason:request.reason,
      enddate:request.enddate,
      parentname:request.parentname,
      parent2name:request.parent2name,
      achieveddate: request.achieveddate,
      insertedby: v_securityusersid,
      updatedby:  v_securityusersid  ,
      permplanquestdata: request.permplanquestdata
    }).then(res => {
      if (request.isreviewsubmit===1 && res.permanencyplanid && request.intakeservicerequestactorid)  {
        var status = 15;
        var nofitymsg = plansubmittedmsg;
        var routeddescription = plansubmittedmsg;
        var comments = plansubmittedmsg;
        var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        util.executeDBQuery(sql, [res.permanencyplanid, _securityusersid, 'PPLR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
        .then(result => {
            LOGGER.info(result);
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
      }
      if (request.modifiedjson && res.permanencyplanid)  {
        let sql1 = 'SELECT * FROM update_permanencyplan_history($1::uuid, $2::json, $3::uuid, $4::character varying) ';
        util.executeDBQuery(sql1, [res.permanencyplanid, request.modifiedjson, _securityusersid, null])
        .then(result => {
            LOGGER.info(result);
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        })
      }

      return res
    })
      .catch(err => err)
  } else {
    return app.models.Permanencyplan.updateAll(
       { permanencyplanid: request.permanencyplanid },
       {
      modifiedjson: request.modifiedjson,
      projecteddate: request.primaryplandate,
      establisheddate: request.concurrentplandate,
      caseworkername: request.caseworkername,
      primarypermanencytype: request.primarypermanencytype,
      concurrentpermanencytype: request.concurrentpermanencytype,
      primaryarrangetype: request.primaryarrangetype,
      courtorderreceived: request.courtorderreceived,
      permanencyplanremainssame: request.permanencyplanremainssame,
      permanencyplanremainssamedate: request.permanencyplanremainssamedate,
      reviewdate: request.reviewdate,
      concurrentarrangetype: request.concurrentarrangetype,
      remarks: request.remarks,
      concurrentcomments: request.concurrentcomments,
      reason:request.reason,
      enddate:request.enddate,
      parentname:request.parentname,
      parent2name:request.parent2name,
      achieveddate: request.achieveddate,
      insertedby: _securityusersid,
      updatedby: _securityusersid,
      permplanquestdata: request.permplanquestdata
    }).then(res => {
      if (request.isreviewsubmit===1 && request.permanencyplanid && request.intakeservicerequestactorid)  {
        var status = 15;
        var nofitymsg = plansubmittedmsg;
        var routeddescription = plansubmittedmsg;
        var comments = plansubmittedmsg;
        var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        util.executeDBQuery(sql, [request.permanencyplanid, _securityusersid, 'PPLR', status, comments, '', false, false, false, nofitymsg, routeddescription, request.servicecaseid, '', 1])
        .then(result => {
            LOGGER.info(result);
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }
      return "Permanency Plan Updated Succussfully"
    }) .catch(err => err)
  }
  }
  

  Permanencyplan.remoteMethod('list', {
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
      type: 'Object',
      root: true
    }
  });

  Permanencyplan.list = (request) => {
    if (request.where.objectid !== undefined && request.where.objectid !== null) {
      return Permanencyplan.servicecasepermanencylist(request);
    } else if (request.where.servicecaseid !== undefined && request.where.servicecaseid !== null) {
      return Permanencyplan.casepermanencylist(request);
    } else {
      return Permanencyplan.getpermanencyplanlist(request);
    }
  }

  Permanencyplan.casepermanencylist = (request) => {
    var sql = 'select * from cjams.permanencyplanbypersonid($1,$2)';

    return util.executeSecondaryNodeDBQuery(sql, [request.where.servicecaseid, request.where.personid])
      .then(data => data && data[0] ? data[0].permanencyplanbypersonid : null)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };
  
  Permanencyplan.servicecasepermanencylist = (request) => {
    const pageno = request.page;
    const pagesize = request.limit;
    var sql = 'select * from servicecasepermanencylist($1,$2,$3)';
    return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid, pageno, pagesize])
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };


  Permanencyplan.getpermanencyplanlist = (request) => {

    var intakeserviceid = request.where.intakeserviceid;
    var page = request.page;
    var limit = request.limit;
    var Totalcount = 0;

    const sql = 'Select * from getpermanencylist($1,$2,$3)';

    return util.executeDBQuery(sql, [intakeserviceid, page, limit])
      .then(data => {
        if (data.length > 0){ Totalcount = data[0].totalcount;}
        var result;
        result = {
          'data': data,
          'count': Totalcount
        };
        return result;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  }

  Permanencyplan.remoteMethod('permanencygapvalidation', {
    http: {
      path: '/permanencygapvalidation',
      verb: 'get'
    },
    accepts: [
      {
        arg: 'filter',
        type: 'object',
        http: { source: 'query' }
      }],
    returns: {
      type: 'object',
      root: true
    }
  });

  Permanencyplan.permanencygapvalidation = (request) => {
    var intakeservicerequestactorid = request.where.intakeservicerequestactorid;
    var intakeserviceid = request.where.intakeserviceid;
    var sql = 'select * from permanencygapvalidation($1,$2)';
    return util.executeDBQuery(sql, [intakeservicerequestactorid, intakeserviceid])
      .then(data => data[0])
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

  Permanencyplan.remoteMethod('permanencyplanvalidation', {
    http: {
        path: '/permanencyplanvalidation',
        verb: 'get'
    },
    accepts: [
        {
            arg: 'filter',
            type: 'object',
            http: { source: 'query' }
        }],
    returns: {
        type: 'object',
        root: true
    }
});

Permanencyplan.permanencyplanvalidation = (request) => {
    var sql = 'select * from permanencyplanvalidation($1, $2, $3)';
    return util.executeDBQuery(sql, [request.where.servicecaseid, request.where.intakeservicerequestactorid, request.where.placementtype])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};


Permanencyplan.remoteMethod('getpermanencyplacement', {
  http: {
      path: '/getpermanencyplacement',
      verb: 'get'
  },
  accepts: [
      {
          arg: 'filter',
          type: 'object',
          http: { source: 'query' }
      }],
  returns: {
      type: 'object',
      root: true
  }
});

Permanencyplan.getpermanencyplacement = (request) => {
  var sql = 'select * from getpermanencyplacement($1,$2,$3)';
  return util.executeDBQuery(sql, [request.where.permanencyplanid,request.where.transkey,request.where.transid])
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return []; });
};
  Permanencyplan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Permanencyplan.observe('access', (ctx, next) => util.access(ctx, next));
  Permanencyplan.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PPLAN',
  ctx.isNewInstance?ctx.instance.intakeservicerequestactorid:ctx.data.intakeservicerequestactorid));
  Permanencyplan.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
 
};