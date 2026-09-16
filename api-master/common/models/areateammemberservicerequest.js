'use strict';
const LOGGER = require("log4js").getLogger("areateammemberservicerequest");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Areateammemberservicerequest) {


  Areateammemberservicerequest.updateassignedstatus = function(data, reqctx) {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
  var assigneduserid=(data && data.securityuserid?data.securityuserid: _securityusersid);
  var intakeservid = data.intakeserviceid;
  var isaccepted = data.isaccepted;
  var isrejected = data.isrejected;
  var reason = data.rejectreason;
  var servicerequestid = data.intakeserviceid;

  var sql = 'SELECT * FROM servicerequestassignedstatus($1,$2,$3,$4,$5)';
  return util.executeDBQuery(sql, [intakeservid,assigneduserid,isaccepted,isrejected,reason])
    .then(_data => {
      app.models.Intakedastaging.sendintakenotification(servicerequestid);
      return _data;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};

 
Areateammemberservicerequest.remoteMethod (
  'updateassignedstatus',
  {
      http: {
          path: '/updateassignedstatus',
          verb: 'post'
      },
     accepts : [{
      arg : 'data',
      type : 'object',
      http : {
        source : 'body'
      }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
      returns: {
        type : 'object',
        root : true
      }
     }
);


    Areateammemberservicerequest.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Areateammemberservicerequest.observe('access', (ctx, next) => util.access(ctx, next));
    Areateammemberservicerequest.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
