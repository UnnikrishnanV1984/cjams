'use strict';
const LOGGER = require("log4js").getLogger("rolemapping");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Rolemapping) {
	
	
	
    
	Rolemapping.remoteMethod('list', {
	        accepts : [
	        	{
	        	   arg: 'id',
	                type: 'string',
	                required: true,
	                http: {source: 'path'}
	        	},
	         {
	                arg: 'filter',
	                type: 'Object',
	                required: false,
	                http: {source: 'query'}
	            },
	            
	   ],
	        http: {"verb": "get", "path": "/list/:id"},
	     returns: {
   	       type : 'object',
			root : true
     }
	    });
	
	
  
	 
	
	
	Rolemapping.list = function (id,req) {
		var ID,assignedrolejson = {};
		var sql = 'SELECT * FROM muser WHERE securityusersid =\'' + id + '\'';
		return util.executeDBQuery(sql,[])
		.then(data => {
			if (data.length > 0) {
				ID = data[0].id;
			}
			return Rolemapping.find({
				where: { id: ID }
			}).then(res => {
				if (res.length > 0) {
					ID = res[0].roleid;
				}
				var sql1 = 'SELECT * FROM role WHERE id =\'' + ID + '\'';
				return util.executeDBQuery(sql1,[])
					.then(response => {
						var sql2 = 'SELECT * FROM userprofile WHERE securityusersid =\'' + id + '\'';
						return util.executeDBQuery(sql2,[])
							.then(resp => {
								assignedrolejson.username = resp[0].displayname;
								assignedrolejson.role = response[0].description;
								return assignedrolejson;
							});
					});
			});
		})
		.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
		})
	};

	Rolemapping.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Rolemapping.observe('access', (ctx, next) => util.access(ctx, next));
	Rolemapping.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
