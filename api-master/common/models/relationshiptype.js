'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Relationshiptype) {
    

      Relationshiptype.list = async (request, reqctx) =>{
		var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var requestuserinfo = {'token': '', 'email': _email};
		var teamtype;
    	await util.getuserinfo(requestuserinfo).then (data => {
			teamtype = data.teamtypekey;
		});
		let teamtypekey;
		  if(request.where.teamtypekey){
			teamtypekey = request.where.teamtypekey;
		  }
		  else{
			teamtypekey = teamtype;
		  }
		
		if (teamtypekey === 'IV-E') {
			teamtypekey = 'CW';
		}

        const sql = 'Select * from getrelationshiptype($1)';
        
		return util.executeSecondaryNodeDBQuery(sql, [teamtypekey])
		.then(data => {
			return data;
		})
		.then(data => { return data; })
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      }


      Relationshiptype.remoteMethod('list', {
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
      
    Relationshiptype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Relationshiptype.observe('access', (ctx, next) => util.access(ctx, next));
    Relationshiptype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};