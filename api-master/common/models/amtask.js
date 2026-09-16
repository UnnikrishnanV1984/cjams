'use strict';
const LOGGER = require("log4js").getLogger("amtask");
const util = require('../utils/utils');

module.exports = function(Amtask) {
	
	var totalCount;
	Amtask.list = function(request) {
		if (request.page !== 'undefined') {

			request.skip = (request.page - 1) * request.limit;

			}

		return Amtask.find(request);
		};

		Amtask.add= function(data){
			return	Amtask.find({
				   where:{and:[{name:data.where.name},
					   {activitytypekey: data.where.activitytypekey}]}
			   }).then(res => {
				   if(res.length  === 0){
					   return Amtask.create(data.where);
				   }else if(res.length > 0){
					   return "Already Exist";
				   }
			   }).catch(err => err);
			   }
	   
        
		Amtask.beforeRemote('list', function(ctx, request, next) {

			if (JSON.parse(ctx.req.query.filter).page !== undefined && JSON.parse(ctx.req.query.filter).page === 1) {

				Amtask.count(JSON.parse(ctx.req.query.filter).where, function(err, count) {
			
					if (err) {
						throw err;
					}
					totalCount = count;
					LOGGER.debug(count);
				});
			
			}

			next();
		});

		Amtask.afterRemote('list',
				function(ctx, resultset, next) {

					if (ctx.result) {
						ctx.result = {
							'data' : resultset,
							'count' : totalCount
						};
					}
					next();
				});

		Amtask.remoteMethod('list', {
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
				type : 'string',
				root : true
			}
		});
		Amtask.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Amtask.observe('access', (ctx, next) => util.access(ctx, next));
		Amtask.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
