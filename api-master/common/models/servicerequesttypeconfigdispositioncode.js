'use strict';
const LOGGER = require("log4js").getLogger("servicerequesttypeconfigdispositioncode");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Servicerequesttypeconfigdispositioncode) {
  
  Servicerequesttypeconfigdispositioncode.getdispositionlist = async (request, reqctx) =>{
    var _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
    }  
    var requestuserinfo = {'token': '', 'email': _email};
    var sroletypekey ;
    await util.getuserinfo(requestuserinfo).then (data => {
      sroletypekey = data.roletypekey;
    });  
    let recommendationtype = 'Final';
    if(request.where.recommendationtype) {recommendationtype = request.where.recommendationtype;}
    const auditLogQuery = "select * from listdispositionbydastatus($1, $2, $3, $4, $5, $6);";
    return util.executeDBQuery(auditLogQuery, [request.where.intakeservreqtypeid, request.where.servicerequestsubtypeid, request.where.intakeserviceid, request.where.statuskey, recommendationtype, sroletypekey])
    .catch(err => util.logError(err));
  };




Servicerequesttypeconfigdispositioncode.remoteMethod('getdispositionlist', {
  accepts : [{
    arg : 'filter',
    type : 'Object',
    http : {
      source : 'query'
    },
    required : true
  },
  {
    arg: 'reqctx',
    type: 'object',
    http: {source: 'context'}
    }],
  http : {
    verb : 'get'
  },
  returns : {
    type : 'object',
    root : true
  }
});

Servicerequesttypeconfigdispositioncode.remoteMethod('getsubdispositionlist', {
  accepts : {
    arg : 'filter',
    type : 'Object',
    http : {
      source : 'query'
    },
    required : true
  },
  http : {
    verb : 'get'
  },
  returns : {
    type : 'object',
    root : true
  }
});

Servicerequesttypeconfigdispositioncode.getsubdispositionlist = (request) =>{
  LOGGER.debug(request.where.servicerequesttypeconfigiddispostionid)
  const auditLogQuery = "select * from getsubdispositionlist($1)";
  return util.executeDBQuery(auditLogQuery, [request.where.servicerequesttypeconfigiddispostionid])
  .catch(err => util.logError(err));
};

Servicerequesttypeconfigdispositioncode.remoteMethod('getclosingcodelist', {
  accepts : {
    arg : 'filter',
    type : 'Object',
    http : {
      source : 'query'
    },
    required : true
  },
  http : {
    verb : 'get'
  },
  returns : {
    type : 'object',
    root : true
  }
});

Servicerequesttypeconfigdispositioncode.getclosingcodelist = (request) =>{
  LOGGER.debug(request.where.servicerequesttypeconfigiddispostionid)
      const auditLogQuery = "select * from getclosingcodelist($1,$2)";
  return util.executeSecondaryNodeDBQuery(auditLogQuery, [request.where.intakeserreqstatustypeid,request.where.servicerequesttypeconfigid])
  .then(data => { return data; })
  .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
};




    Servicerequesttypeconfigdispositioncode.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicerequesttypeconfigdispositioncode.observe('access', (ctx, next) => util.access(ctx, next));
    Servicerequesttypeconfigdispositioncode.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};