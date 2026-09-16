'use strict';
const LOGGER = require("log4js").getLogger("routing");
const util = require('../utils/utils');
var app = require('../../server/server');
const Placement = require('../models/placement');
const childRemoval = require('../models/intakeservreqchildremoval');

module.exports = function(routing) {

  routing.getreviewdetails =function(request, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    var pageNumber = request.page;
    var pageLimit = request.limit;
    let userid;
    if (request.where.securityusersid) {
      userid = request.where.securityusersid
    } else {
      userid = request && request.securityuserid ? request.securityuserid : _securityusersid
    }
    var sql = 'select * from getreviewdetails($1,$2,$3,$4,$5)';
    var Totalcount=0;

        return util.executeDBQuery(sql, [request.where.eventcode,userid,pageNumber,pageLimit,request?.where?.servicerequestnumber])
          .then(data => {
              if (data!=null&& data.length>0){
               Totalcount= data[0].totalcount ;
              }

              var result;
                result = {
                'result' : data,
                'count' : Totalcount
                };
           return result;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });

 }


    routing.remoteMethod (
      'getreviewdetails',
      {
        http: {
            path: '/reviewdetails',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'Object',
            http: {
              source: 'body'
                }}, {
                  arg: 'reqctx',
                  type: 'object',
                  http: {source: 'context'}
                  }

        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
       });



  routing.getroutingdetails = function(request) {
    if(request.where.intakeserviceid !== undefined && request.where.intakeserviceid !== null){
      return routing.routingbyintakeservice(request.where.intakeserviceid)
    }else if (request.where.servicecaseid !== undefined && request.where.servicecaseid !== null){
      return routing.routingbyservicecase(request.where.servicecaseid)
    }else{
      return routing.routingbyintakenumber(request.where.intakenumber)}
    }

  routing.routingbyintakeservice = data => {
    var sql = 'select * from getroutingdetails($1)';
    return util.executeDBQuery(sql, [data])
   .then(res => res)
    .catch(err => err);
  }

  routing.routingbyservicecase = data => {
    var sql = 'select * from getservicecaserouting($1)';
    return util.executeDBQuery(sql, [data])
   .then(res => res)
    .catch(err => err);
  }

  routing.routingbyintakenumber = data => {
    var sql = 'select * from getintakeroutingdetails($1)';
    return util.executeDBQuery(sql, [data])
   .then(res => res)
    .catch(err => err);
  }

	routing.remoteMethod ('getroutingdetails',{
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'Object',
			root : true
		}
	});



  routing.getldssusers = function(request) {

    var sql = 'select * from getldssusers($1)';
    var params = [request.where.intakeserviceid];

    return util.executeDBQuery(sql, params)
        .then(data => {
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }


    routing.remoteMethod ('getldssusers',{
      accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
          source : 'query'
        }
      },
      http : {
        verb : 'get'
      },
      returns : {
        type : 'Object',
        root : true
      }
    });

  routing.routingupdate = function (request, reqctx) {
		var { securityusersid, _securityusersid } = returnSecurityusersidFn(request, reqctx);

    var { serviceid, isservicecacse } = returnCaseAndIdFn(request);
    request.comments = util.nullcheck(request.comments);
    request.notifymsg = util.nullcheck(request.notifymsg);
    request.routeddescription = util.nullcheck(request.routeddescription);
    var status = returnStatusFn(request);
    if(request.objectid && request.eventcode && request.status) {
      request.intakeserviceid = util.nullcheck(request.intakeserviceid);
      
     var { tosecurityusersid, bmanualrouting } = returnRoutingAndUserIdFn(request);

     LOGGER.debug('tosecurityusersid',tosecurityusersid);
      var qry = 'SELECT * FROM routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
      return util.executeDBQuery(qry, [request.objectid, securityusersid, request.eventcode, status, request.comments, tosecurityusersid, bmanualrouting, false, false, request.notifymsg, request.routeddescription, serviceid, '', isservicecacse])
        .then(async result => {
          const updateResult = await updateData(request, status, serviceid, securityusersid, _securityusersid);

          if (updateResult?.familyfinding) {
            if (returnResultFn(result)) {
              result[0].familyfinding = updateResult.familyfinding;
            } else {
              result = {
                routingintake: result,
                familyfinding: updateResult.familyfinding,
              };
            }
          }

        return result;
      })
      .catch(err => {
          LOGGER.error(err);
          return err;
      })
    } else {return Promise.resolve(null);}

  }

  function updateData(request, status, serviceid, securityusersid, _securityusersid) {
    let familyFindingResult = null;
    let familyFindingPromise = Promise.resolve();
    let childRemovalExitPromise = Promise.resolve();

    if (request.eventcode === 'PLTR') {
      request.placementevent = 'DECISION';
      request.placementid = request.objectid;
      LOGGER.debug("chessie update call during routing ->> ", request);
      Placement.callupdatechessie(request);
    }

    if(hasPltrEventCodeAndStatusFn(request, status)){
      let sql1 = 'select * from sendNotificationForPrevRunAwayPlacement($1, $2, $3)';
      util.executeDBQuery(sql1, [serviceid, request.objectid, securityusersid])
      .then(result => {
          LOGGER.info(result);
      })
      .catch(err => {
          LOGGER.error(err);
          return err;
      })
    }


    if(request.eventcode === 'CHRR') {
      if (status === 16) {
        let sql = `
          select insertedby
          from routing
          where objectid = $1
            and eventcode = 'CHRR'
            and routingstatustypeid = 15
          order by insertedon desc
          limit 1`;
        familyFindingPromise = util.executeSecondaryNodeDBQuery(sql, [request.objectid])
          .then((reviewRoutingResult) => {
            const reviewSubmitterSecurityUserId = reviewRoutingResult?.[0]?.insertedby;
    
          const ffRequest = returnFfRequestFn(request, reviewSubmitterSecurityUserId);
    
            return childRemoval.triggerInitFamilyFindings(ffRequest, reviewSubmitterSecurityUserId);
          })
            .then((ffResult) => {
            familyFindingResult = ffResult;
            LOGGER.info('CHRR approval Family Findings trigger result', familyFindingResult);
            })
            .catch((ffErr) => {
              LOGGER.error('CHRR approval Family Findings trigger failed', ffErr);
            familyFindingResult = returnFamilyFindingResultFn(ffErr);
        });
      childRemovalExitPromise = childRemoval.updatechildremovalexitdata(request, _securityusersid)
        .catch((exitErr) => {
          LOGGER.error('CHRR approval child removal exit data update failed', exitErr);
        });
    }

    if(hasIndrEventCodeAndStatusFn(request, status)){
      let sql2 = 'select * from endAllegedVictimOnInvestigationClosure($1, $2)';
      util.executeDBQuery(sql2, [serviceid, securityusersid])
      .then(result => {
          LOGGER.info(result);
      })
      .catch(err => {
          LOGGER.error(err);
          return err;
      })
    }
    else if (hasAcdrEventCodeAndStatusFn(request, status)){
      app.models.Adoptioncasedisposition.find({
        where: {adoptioncasedispositionid: request.objectid},fields: ['adoptioncaseid']})
        .then(data => {
          if(hasAdoptionCaseIdFn(data)){
            var adoptionobjectid = data[0].adoptioncaseid;
            app.models.Adoptioncase.updateAll({adoptioncaseid:data[0].adoptioncaseid},{statustypekey:'Closed', updatedby: _securityusersid}).then(
              data1 => {
                var sql3 = 'update caseassignment SET enddate = now()::date, updatedon = now()::date, updatedby =\''+securityusersid+'\'  WHERE objectid=\''+adoptionobjectid +'\' AND enddate IS NULL';                   
                return util.executeDBQuery(sql3, [])
                .then(result => {
                    LOGGER.info(result);
                    return result;
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                });
              }
            );
          }
          })
        .catch(err => util.logError(err));
    }

    return Promise.all([familyFindingPromise, childRemovalExitPromise]).then(() => ({
      familyfinding: familyFindingResult,
    }));
  }}

  routing.remoteMethod(
    'routingupdate',
    {
      http: {
        path: '/routingupdate',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  routing.getroutinginfo = function(request) {
    var sql = 'select * from getroutinginfo($1,$2)';
    return util.executeDBQuery(sql,[request.where.intakeserviceid,request.where.eventcode])
      .then(data => data)
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }
  routing.changereviewer = function(request, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
    var sql = 'select * from updatereviewer($1, $2, $3, $4)';
    return util.executeDBQuery(sql,[request.appeventcode, request.objectid, request.fromuserid, securityusersid])
    .then(data => {
        return data;
    })
    .catch(err => util.logError(err));
}
  
routing.remoteMethod('changereviewer', {
    http: {
        path: '/changereviewer',
        verb: 'post'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'body'}
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],  
    returns: {
        type : 'object',
        root : true
    } 
});
//ASSIGNMENT END - COMPLETE APPEAL 
routing.remoteMethod('completeappeal', {
  http: {
    path: '/completeappeal/:id',
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
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
  returns: {
    type: 'object',
    root: true,
  },
});
routing.completeappeal = function(id, request, reqctx)    {
  let _securityusersid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    _securityusersid = reqctx.req.headers.securityusersid;
  }  
  return routing.update({
    routingid: id}, request).then(x=>{
      var resp =x;
		/* WHEN COMPLETE APPEAL END THE ASSIGNMENT */
		var sql = 'SELECT * FROM assignmentupdate($1,$2,$3,$4,$5)';
		return util.executeDBQuery(sql, ['APPL', 'COMPLETE',request.objectid,'',(request && request.securityuserid?request.securityuserid: _securityusersid)])
			.then(() => resp)
			.catch(() => resp);
    });
};

routing.deleteByObjectId = (request, reqctx) => {
  let suserid = undefined;
  if (reqctx && reqctx.req && reqctx.req.headers) {
    suserid = reqctx.req.headers.securityusersid
  }
  var sql = ` UPDATE cjams.routing
              SET activeflag=0, updatedby = $2, updatedon = now()
              WHERE objectid= $1 `;
  var params = [request?.id, suserid];

  return util.executeDBQuery(sql, params)
    .then(data => {
      return data;
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });
}

routing.remoteMethod(
  'deleteByObjectId', {
    http: {
      path: '/deleteByObjectId',
      verb: 'post'
    },
    accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {
          source: 'context'
        }
      }
    ],
    returns: {
      arg: 'data',
      type: 'Object'
    }
  });

  routing.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  routing.observe('access', (ctx, next) => util.access(ctx, next));
  routing.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}

function hasPltrEventCodeAndStatusFn(request, status) {
  return request.eventcode === 'PLTR' && status === 16;
}

function hasAdoptionCaseIdFn(data) {
  return data.length && data[0] && data[0].adoptioncaseid;
}

function hasAcdrEventCodeAndStatusFn(request, status) {
  return request.eventcode === 'ACDR' && status == 16;
}

function hasIndrEventCodeAndStatusFn(request, status) {
  return request.eventcode === 'INDR' && status == 16;
}

function returnFamilyFindingResultFn(ffErr) {
  return {
    success: false,
    data: {
      message: ffErr?.message || 'Failed to trigger init family findings',
    },
  };
}

function returnFfRequestFn(request, reviewSubmitterSecurityUserId) {
  return {
    ...request,
    binti: request?.binti || request?.bintiinfo || request?.bintiInfo || null,
    reviewsubmittersecurityuserid: reviewSubmitterSecurityUserId || null,
  };
}

function returnResultFn(result) {
  return Array.isArray(result) && result.length > 0 && result[0] && typeof result[0] === 'object';
}

function returnCaseAndIdFn(request) {
  var isservicecacse = 0;
  var serviceid = request.intakeserviceid;

  if (request.intakeserviceid === null || request.intakeserviceid === undefined) {
    serviceid = request.servicecaseid;
    isservicecacse = 1;
  }
  return { serviceid, isservicecacse };
}

function returnSecurityusersidFn(request, reqctx) {
  const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
  var securityusersid = request && request.v_securityusersid ? request.v_securityusersid : _securityusersid;
  return { securityusersid, _securityusersid };
}

function returnStatusFn(request) {
  var status = 16;
  if (request.status === "Review") {
    status = 15;
  } else if (request.status === "Rejected") {
    status = 17;
  }
  return status;
}

function returnRoutingAndUserIdFn(request) {
  var bmanualrouting = false;
  var tosecurityusersid = '';
  if (request.tosecurityusersid) {
    tosecurityusersid = request.tosecurityusersid;
    bmanualrouting = true;
  }

  if (request.eventcode === 'SPLR') {
    request.comments = request.assessmmentName;
  }
  return { tosecurityusersid, bmanualrouting };
}
