'use strict';
const LOGGER = require("log4js").getLogger("amgoal");

module.exports = function(Amgoal) {
	
	
	var totalCount;
	Amgoal.list = function(request) {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;

			}

		return Amgoal.find(request);

		};
		Amgoal.add= function(data){
			return	Amgoal.find({
				   where:{and:[{name:data.where.name},
					   {activitytypekey: data.where.activitytypekey}]}
			   }).then(res => {
				   if(res.length  === 0){
					   return Amgoal.create(data.where);
				   }else if(res.length > 0){
					   return "Already Exist";
				   }
			   }).catch(err => err);
			   }
	   
		
	
		Amgoal.beforeRemote('list', function(ctx, request, next) {

			if (JSON.parse(ctx.req.query.filter).page !== undefined && JSON.parse(ctx.req.query.filter).page === 1) {
				Amgoal.count(JSON.parse(ctx.req.query.filter).where, function(err, count) {
				if (err) {
					throw err;
				}
				totalCount = count;
				LOGGER.debug(count);
				});
			}

			next();
		});

		
		Amgoal.afterRemote('list',
				function(ctx, resultset, next) {

					if (ctx.result) {
						ctx.result = {
							'data' : resultset,
							'count' : totalCount
						};
					}
					next();
				});

		Amgoal.remoteMethod('list', {
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


};
