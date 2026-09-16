'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Racetype) {

	Racetype.list = async (request, reqctx) => {
		var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var requestuserinfo = {'token': '', 'email': _email};
		var teamtypekey ;
    	await util.getuserinfo(requestuserinfo).then (data => {
			teamtypekey = data.teamtypekey;
		});
		let nolimit = false;
		if(request.nolimit){
			nolimit = true;
		}
		const sql = 'select * from listracetypes($1, $2, $3, $4)';

		return util.executeDBQuery(sql, [teamtypekey, request.page, request.limit, nolimit])
		.then(data => {
			const returnData = {};
			
			if(!request.nolimit) {
				returnData.count = 0;
				if (data.length > 0){
					returnData.count = parseInt(data[0].totalcount);}
			}
			
			returnData.data = data;
			returnData.data.forEach(x => delete x.totalcount);

			return returnData;
		})
		.catch(err => util.logError(err));
	};


	Racetype.remoteMethod('list', {
		accepts : [{
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		{arg: 'reqctx', type: 'object',
			http: {source: 'context'}}],
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});
	
		
	Racetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Racetype.observe('access', (ctx, next) => util.access(ctx, next));
    Racetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};