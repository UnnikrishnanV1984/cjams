'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_placement_cpa_homes) {

    Tb_placement_cpa_homes.remoteMethod('cpahomeplacementadd', {
        http: {
                path: '/cpahomeplacementadd',
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

    Tb_placement_cpa_homes.cpahomeplacementadd = function(request,reqctx)
    {   let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);
        request.update_user_id = (request && request.securityuserid?request.securityuserid: suserid);
        request.create_ts = new Date().toLocaleString();
        request.update_ts = new Date().toLocaleString();
        return Tb_placement_cpa_homes.create(request);
    };

    Tb_placement_cpa_homes.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_placement_cpa_homes.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_placement_cpa_homes.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}