'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Servicetype) {

    Servicetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicetype.observe('access', (ctx, next) => util.access(ctx, next));
    Servicetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


    Servicetype.list = async (request, reqctx) =>{
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var requestuserinfo = {'token': '', 'email': _email};
        var teamtypekey ;
    	await util.getuserinfo(requestuserinfo).then (data => {
			teamtypekey = data.teamtypekey;
		});
        return app.models.Servicetype.find({
            where: {
                and: [{activeflag:1},{placementtypekey:request.where.placementtypekey},{teamtypekey}]
              }
           })
           .then(data=>{
               return data;
           })
    }

    
    Servicetype.remoteMethod('list', {
        accepts: [{
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        http : {
			path: '/list',
			verb : 'get'
		},
        returns: {
            type: 'string',
            root: true
        }
    });


};