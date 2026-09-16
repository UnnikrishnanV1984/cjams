'use strict';
const LOGGER = require("log4js").getLogger("tb_placement_validation");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_placement_validation) {

    Tb_placement_validation.remoteMethod('addvalidation', {
        http: {
                path: '/addvalidation',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Tb_placement_validation.addvalidation = function(request,reqctx)
    {  let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);
        request.update_user_id = (request && request.securityuserid?request.securityuserid: suserid);
        return Tb_placement_validation.create(request)
        .then(data => data)
        .catch(err => util.logError(err));
    }
    Tb_placement_validation.remoteMethod('updatePlacementValidation', {
        http: {
                path: '/updatePlacementValidation',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {
                  source: 'context'
                }
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

Tb_placement_validation.updatePlacementValidation = function(request, reqctx)
{ 
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
   LOGGER.debug(request.create_user_id);
   request.placement.forEach(item => item.update_ts = new Date().toLocaleString());
    return Promise.all(request.placement.map(newreq => {
        newreq.update_user_id = request && request.securityuserid?request.securityuserid: _securityusersid;
        Tb_placement_validation.updateAll({placement_validation_id:newreq.placement_validation_id}, newreq);
    }))
    .then(data => data)
    .catch(err => util.logError(err));
}
    Tb_placement_validation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_placement_validation.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_placement_validation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
