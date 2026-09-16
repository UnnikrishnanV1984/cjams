'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_vendor_email) {

    Tb_vendor_email.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }
         ],
        returns: {
            type : 'string',
            root : true
        }
    });   

    Tb_vendor_email.addupdate = function(request,reqctx)
    { 
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
        if(request.vendoremailid== null || request.vendoremailid == undefined)
        {
            request.create_ts=new Date().toLocaleString();
            request.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
            request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
            request.update_ts = new Date().toLocaleString();
            return Tb_vendor_email.create(request)
            .then(res => res)
            .catch(err => util.logError(err));
        }
        else
        {
            request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
            request.update_ts = new Date().toLocaleString();
          return Tb_vendor_email.updateAll({vendoremailid:request.vendoremailid},request)
          .catch(err => util.logError(err));
        }
    };

    Tb_vendor_email.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_vendor_email.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_vendor_email.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}