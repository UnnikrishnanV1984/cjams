'use strict';
const LOGGER = require("log4js").getLogger("reviewresulttemplate");
const util = require('../utils/utils');

module.exports = function(Reviewresulttemplate) {
	
	var totalCount;
	Reviewresulttemplate.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Reviewresulttemplate.find(request);

	};

	Reviewresulttemplate.beforeRemote('list', function(ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== undefined && JSON.parse(ctx.req.query.filter).page === 1) {
		
			LOGGER.debug(JSON.parse(ctx.req.query.filter).where);
			
			if (JSON.parse(ctx.req.query.filter).where !== undefined && JSON.parse(ctx.req.query.filter).where.reviewtypekey !== undefined) {

				LOGGER.debug(":: Inside :: ");
				Reviewresulttemplate.count({reviewtypekey:JSON.parse(ctx.req.query.filter).where.reviewtypekey}, function(err, count) {

					if (err) {
						throw err;
					}
					totalCount = count;

				});
 
				
			}else {

				Reviewresulttemplate.count({}, function(err, count1) {

					if (err) {
						throw err;
					}
					totalCount = count1;

				});
				
			}	
			


		}

		next();
	});

	Reviewresulttemplate.afterRemote('list',
			function(ctx, resultset, next) {

				if (ctx.result) {
					ctx.result = {
						'data' : resultset,
						'count' : totalCount
					};
				}
				next();
			});

	Reviewresulttemplate.remoteMethod('list', {
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

	Reviewresulttemplate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Reviewresulttemplate.observe('access', (ctx, next) => util.access(ctx, next));
	Reviewresulttemplate.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
