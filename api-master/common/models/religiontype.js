'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Religiontype) {

    Religiontype.list = async (request, reqctx) =>{
		var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var requestuserinfo = {'token': '', 'email': _email};
		var teamtypekey ;
    	await util.getuserinfo(requestuserinfo).then (data => {
			teamtypekey = data.teamtypekey;
		});
		//D-07178 Start
		if(teamtypekey === undefined || teamtypekey === ''){
			teamtypekey = request.where.teamtypekey;
		}
		//D-07178 End
		const sql = 'Select * from getreligiontype($1)';

		return util.executeDBQuery(sql, [teamtypekey])
		.then(data => data)
		.catch(err => util.logError(err));
      }


      Religiontype.remoteMethod('list', {
		accepts : [{
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		{arg: 'reqctx', type: 'object',
			http: {source: 'context'}}],
		http : {
			path: '/list',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});
    Religiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Religiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Religiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}