'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestcourthearing");
const util = require('../utils/utils');
let app = require('../../server/server');
var config = require('../../server/config.json');
const usermsg = 'This method is only allowed for DJS user';

module.exports = function(Intakeservicerequestcourthearing) {
  Intakeservicerequestcourthearing.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Intakeservicerequestcourthearing.observe('access', (ctx, next) => util.access(ctx, next));
  Intakeservicerequestcourthearing.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

  Intakeservicerequestcourthearing.remoteMethod('addhearing', {
    http: {
      path: '/addhearing',
      verb: 'post',
    },
    accepts: [{arg: 'data', type: 'object',
      http: {source: 'body'}}],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestcourthearing.remoteMethod('gethearingdetails', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
    http: {
      verb: 'get',
    },
    returns: {
      type: 'Object',
      root: true,
    },
  });

  // Mani added for DJS
  Intakeservicerequestcourthearing.remoteMethod('createHearing', {
    http: {
      path: '/createhearing',
      verb: 'post',
    },
    accepts: [{arg: 'data', type: 'object',
      http: {source: 'body'}},
      {arg: 'reqctx', type: 'object',
      http: {source: 'context'}}],
    returns: {
      type: 'string',
      root: true,
    },
  });
  Intakeservicerequestcourthearing.remoteMethod('updatecourthearing', {
    http: {
      path: '/updatecourthearing/:id',
      verb: 'patch',
    },
    accepts: [
      {
        arg: 'id',
        type: 'data',
        required: true,
        http: {source: 'path'},
      },
      {
        arg: 'data',
        type: 'object',
        http: {source: 'body'},
      },
      {arg: 'reqctx', type: 'object',
      http: {source: 'context'}}],
    returns: {
      type: 'string',
      root: true,
    },
  });
  Intakeservicerequestcourthearing.remoteMethod('deleteHearing', {
    http: {
      path: '/deletehearing/:id',
      verb: 'delete',
    },
    accepts: [{
      arg: 'id',
      type: 'string',
      required: true,
      http: {source: 'path'}},
      {arg: 'reqctx', type: 'object',
      http: {source: 'context'}}],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestcourthearing.remoteMethod('list', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
    http: {
      verb: 'get',
    },
    returns: {
      type: 'Object',
      root: true,
    },
  });
  
  Intakeservicerequestcourthearing.remoteMethod('listWithCourtAction', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
    http: {
      verb: 'get',
    },
    returns: {
      type: 'Object',
      root: true,
    },
  });

  // DJS services ends
  Intakeservicerequestcourthearing.remoteMethod('updatehearing', {
    http: {
      path: '/updatehearing/:id',
      verb: 'patch',
    },
    accepts: [
      {
        arg: 'id',
        type: 'data',
        required: true,
        http: {source: 'path'},
      },
      {
        arg: 'data',
        type: 'object',
        http: {source: 'body'},
      },
      {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'},
      }],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestcourthearing.remoteMethod('courtactiontype', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
    http: {
      verb: 'get',
    },
    returns: {
      type: 'Object',
      root: true,
    },
  });
  
  Intakeservicerequestcourthearing.list = request => {
    let intakenumber = '';
    if (request.where)
      {intakenumber = request.where.intakenumber;}
    const pageno = request.page;
    const pagesize = request.limit;
    const sortcolumn = request.sortcolumn;
    const sortorder = request.sortorder;
    const sql = 'select * from listhearings($1, $2, $3, $4, $5)';
    return util.executeDBQuery(sql, [intakenumber, pageno, pagesize, sortcolumn, sortorder])
    .then(data => data)
    .catch(err => util.logError(err));
  };

  Intakeservicerequestcourthearing.listWithCourtAction = request => {
    let intakenumber = '';
    if (request.where)
      {intakenumber = request.where.intakenumber;}
    const pageno = request.page;
    const pagesize = request.limit;
    const sortcolumn = request.sortcolumn;
    const sortorder = request.sortorder;
    const sql = 'select * from listcourtactions($1, $2, $3, $4, $5)';
    return util.executeDBQuery(sql, [intakenumber, pageno, pagesize, sortcolumn, sortorder])
    .then(data => data)
    .catch(err => util.logError(err));
  };

  Intakeservicerequestcourthearing.createHearing = async (hearing, reqctx) => {
    var _email;
    if(reqctx?.req?.headers?.user_email_captureby_application){
        _email = reqctx.req.headers.user_email_captureby_application;
    }  
    var requestuserinfo = {'token': '', 'email': _email};
    var teamtypekey ;
    
    // Fix: Add catch to avoid unhandledRejection if user lookup fails
    await util.getuserinfo(requestuserinfo)
      .then(data => {
        teamtypekey = data.teamtypekey;
      })
      .catch(err => {
        LOGGER.error("Error fetching user info:", err);
        throw err;
      });

    let hearingObj;
    hearing.intakeserviceid = util.emptyUUID;
    if (teamtypekey === 'DJS') {
      return Intakeservicerequestcourthearing.create(hearing)
      .then(res => {
        hearingObj = JSON.parse(JSON.stringify(res));
        const prs = hearing.petitions.map(petition => {
          petition.intakenumber = hearing.intakenumber;
          petition.intakeservicerequestcourthearingid = hearingObj.intakeservicerequestcourthearingid;
          return app.models.Intakeservreqpetitionhearingconfig.create(petition);
        });
        return Promise.all(prs);
      })
      .then(res =>{
        const prssh = hearing.petitions.map(petition => {
          const sql = "update intakeservicerequestpetition set petitionstatustypekey='SCH' where intakeservicerequestpetitionid= $1";
          return util.executeDBQuery(sql, [petition.intakeservicerequestpetitionid]);
        });
        return Promise.all(prssh);
      })
      .then(res =>{
        const prssh = hearing.petitions.map(petition => {
          const sql = "Update intakeservicerequestevaluation set complaintstatustypekey = 'HS' where intakeservicerequestevaluationid in (select intakeservicerequestevaluationid from intakeservreqevalpetitionconfig where intakeservicerequestpetitionid= $1 )";
          return util.executeDBQuery(sql, [petition.intakeservicerequestpetitionid]);
        });
        return Promise.all(prssh);
      })
      .then(res => {
        return {
          intakeservicerequestcourthearing: hearingObj,
          intakeservreqpetitionhearingconfig: JSON.parse(JSON.stringify(res)),
        };
      })
      .catch(err => { 
          util.logError(err);
          throw err; 
      });
    } else {
      return usermsg;
    }
  };

  Intakeservicerequestcourthearing.deleteHearing = async (id, reqctx) => {
    var _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
    }  
    let suserid=undefined;
    if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
    }
    var requestuserinfo = {'token': '', 'email': _email};
    const prs = [];
    let teamtypekey ;

    // Fix: Add catch to avoid unhandledRejection if user lookup fails
    await util.getuserinfo(requestuserinfo)
      .then(data => {
        teamtypekey = data.teamtypekey;
        LOGGER.info(teamtypekey);
      })
      .catch(err => {
        LOGGER.error("Error fetching user info:", err);
        throw err;
      });

      prs.push((() => {
        const sql = 'Update intakeservicerequestcourthearing set activeflag = 0, updatedby = $1, updatedon = now() where intakeservicerequestcourthearingid = $2 and activeflag = 1';
        return util.executeDBQuery(sql, [suserid, id]).catch(err => {
          LOGGER.error(err);
          throw err;
        });
      })());
      prs.push((() => {
        const sql = 'Update hearingclients set activeflag = 0, updatedby = $1, updatedon = now() where courthearingid = $2 and activeflag = 1';
        return util.executeDBQuery(sql, [suserid, id]).catch(_err => {
          LOGGER.error(_err);
          throw _err;
        });
      })());
      
      return Promise.all(prs)
      .then(data => data)
      .catch(err => {
          util.logError(err);
          throw err;
      });
  };

  // DJS related
  Intakeservicerequestcourthearing.updatecourthearing = async (id, request, reqctx) => {
    var _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
    }  
    var requestuserinfo = {'token': '', 'email': _email};
    var teamtypekey ;
    
    // Fix: Add catch to avoid unhandledRejection if user lookup fails
    await util.getuserinfo(requestuserinfo)
      .then(data => {
        teamtypekey = data.teamtypekey;
      })
      .catch(err => {
        LOGGER.error("Error fetching user info:", err);
        throw err;
      });

    const hearingid = id;
    var sql;
    if (teamtypekey === 'DJS') {
              
              return Intakeservicerequestcourthearing.updateAll({intakeservicerequestcourthearingid:hearingid},request)
              .then(res =>{
                  sql ="Update intakeservreqpetitionhearingconfig set activeflag = 0 where intakeservicerequestcourthearingid = $1";

                  util.executeDBQuery(sql,[hearingid]).catch(err => {
                        LOGGER.error('>>>>ERROR:', err);
                        throw err;
                  });
                  if ( request.petitions!=null &&  request.petitions !=undefined)
                  {
                  request.petitions.map(petitionsobj=>{
                      petitionsobj.intakeservicerequestcourthearingid = hearingid;
                      petitionsobj.intakenumber = request.intakenumber;
                      app.models.Intakeservreqpetitionhearingconfig.create(petitionsobj);
                      });
                  }
                
                  return request;
              })
              .catch(err => { throw err; }); // Fix: Added catch handler for updateAll
      
    } else {
      return usermsg;
    }

  };


  Intakeservicerequestcourthearing.addhearing = function(request, reqctx)    {
    let _securityusersid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
        _securityusersid = reqctx.req.headers.securityusersid;
    }
    var securityuserid = (request && request.securityuserid ? request.securityuserid : _securityusersid);
    
    if ((request.intakeservicerequestid == null && request.intakeservicerequestid === undefined) && (request.servicecaseid == null && request.servicecaseid === undefined))        {
      return app.models.Intakeservicerequest.find({
        fields: ['intakeserviceid', 'intakenumber','servicecaseid'],
        where: {intakenumber: request.intakenumber},
      })
      .then(data => {
        var result = [];
        if (data.length > 0){
          request.insertedby = securityuserid;
          request.updatedby = securityuserid;
          var response = createCourtHearing(data,request);
          return Promise.all(response).then(function(values) {
            values.map(x=>{
              result.push(x);
            });
            return result;
          });
        }
      })
      .catch(err => { throw err; }); // Fix: Added catch handler for find
    } else {
      request.intakeserviceid = request.intakeservicerequestid;
      request.insertedby = securityuserid;
      request.updatedby = securityuserid;
      mapHearingParentsToColumns(request);
      return Intakeservicerequestcourthearing.create(request).then(res => {
        request.courthearingid = res.intakeservicerequestcourthearingid;

        const prs = [];

        if (request.hearingClients && request.hearingClients.length > 0) {
          request.hearingClients.forEach(element => {
            let hearingclientsreq = element;
            hearingclientsreq.courthearingid = res.intakeservicerequestcourthearingid;
            hearingclientsreq.insertedby = securityuserid;
            hearingclientsreq.updatedby = securityuserid;

            prs.push(app.models.Hearingclients.create(hearingclientsreq));
          });
        }

        return Promise.all(prs);
      })
      .catch(err => { throw err; }); // Fix: Added catch handler for create
    }
  };

  function mapHearingParentsToColumns(request) {
    const parents = request.hearingParents || [];

    const parent1 = parents[0] || null;
    const parent2 = parents[1] || null;

    request.parent1actorid = parent1?.intakeservicerequestactorid || null;
    request.parent1personid = parent1?.personid || null;
    request.parent1name = parent1?.name || null;
    request.parent1unknown = parent1 ? !parent1.intakeservicerequestactorid : false;

    request.parent2actorid = parent2?.intakeservicerequestactorid || null;
    request.parent2personid = parent2?.personid || null;
    request.parent2name = parent2?.name || null;
    request.parent2unknown = parent2 ? !parent2.intakeservicerequestactorid : false;
  }

  function createCourtHearing(data,request) {
    var intakeservreqid;
    var servicecaseid;
    var response = [];
    data.map(x => {
      intakeservreqid = x.intakeserviceid;
      servicecaseid = x.servicecaseid;
      if (intakeservreqid == null || intakeservreqid == '' || intakeservreqid == undefined) { /* Add some code here */
      } else {
        request.intakeserviceid = intakeservreqid;
      }
      if (servicecaseid != null || servicecaseid == '' || servicecaseid == undefined) {   /* Add some code here */
      } else {
        request.servicecaseid = servicecaseid;
      }
      var res = Intakeservicerequestcourthearing.create(request);
      response.push(res);

    });
    return response;
  }
  
  Intakeservicerequestcourthearing.gethearingdetails = (request) =>{
    var objectid;
    var objecttype ='servicerequest';

    if(request.where.objecttype == 'servicecase'){
        objectid =   request.where.objectid;
        objecttype = 'servicecase';
    }else {
      objectid =   request.where.intakeservicerequestid;
    } 
    const iscaseexpunged  = request.where.iscaseexpunged ?? 0; 
      const sql = 'select * from gethearingdetails_v2($1, $2, $3, $4)';
      return util.executeSecondaryNodeDBQuery(sql, [objecttype,objectid,request.where.isExpungementSuperUser,iscaseexpunged])
    .then(data => {
        return data && data[0] && data[0].gethearingdetails_v2 ? data[0].gethearingdetails_v2 : [];
    })
   .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    
  };

   Intakeservicerequestcourthearing.updatehearing = function(id, request, reqctx)    {
    let _securityusersid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
        _securityusersid = reqctx.req.headers.securityusersid;
    }
    var securityuserid = (request && request.securityuserid ? request.securityuserid : _securityusersid);

  // The data arg is declared without required:true, so a call whose body is
  // missing or unparsable arrives here as undefined -- as the guard on the line
  // above already anticipates. Reject with a message that names the problem
  // instead of throwing a TypeError on the next line: error-logger flattens
  // both into a 400, and only one of them is diagnosable from the log.
  if (!request) {
    const noBody = new Error('updatehearing requires a request body');
    noBody.statusCode = 400;
    return Promise.reject(noBody);
  }

  request.hearingtype = JSON.stringify(request.hearingtype);
  request.updatedby = securityuserid;
  mapHearingParentsToColumns(request);
  return Intakeservicerequestcourthearing.updateAll(
    { intakeservicerequestcourthearingid: id },
    request
  ).then(res => {
    const prs = [];

    if (request.hearingClients && request.hearingClients.length > 0) {
      request.hearingClients.forEach(element => {
        // LoopBack strips undefined keys out of a where clause (juggler
        // dao.js doUpdate -> removeUndefined, default 'ignore'), so an element
        // carrying no hearingclientid would build an UPDATE with no WHERE and
        // overwrite every row in hearingclients. Skip it instead.
        if (!element.hearingclientid) {
          LOGGER.warn('updatehearing: skipping hearing client with no hearingclientid for hearing %s', id);
          return;
        }
        element.updatedby = securityuserid;
        prs.push(
          app.models.Hearingclients.updateAll(
            { hearingclientid: element.hearingclientid },
            element
          )
        );
      });
    }

    return Promise.all(prs);
  })
  .catch(err => { throw err; }); // Fix: Added catch handler for updateAll
};

  Intakeservicerequestcourthearing.courtactiontype = function(data) {
    var intakeserviceid = data.where.intakeservicerequestid;
    var sql = 'SELECT * FROM getcourtactionslist($1)';
    var params = [intakeserviceid];
    return util.executeDBQuery(sql, params)
      .then(_data => {
        return _data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };
};