'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmentscoretype) {
	
	var totalCount;
	Assessmentscoretype.list = function(request) {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;

			}

		return Assessmentscoretype.find(request);

		};
		
		Assessmentscoretype.beforeRemote('list', function(ctx, request, next) {

			if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

				Assessmentscoretype.count({and:[
 
			      ]}, function(err, count) {

					if (err) {
						throw err;
					}
					totalCount = count;
                 
				});

				}

			next();
		});

		Assessmentscoretype.afterRemote('list',
				function(ctx, resultset, next) {

					if (ctx.result) {
						ctx.result = {
							'data' : resultset,
							'count' : totalCount
						};
					}
					next();
				});

		
		Assessmentscoretype.remoteMethod('list', {
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

		Assessmentscoretype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Assessmentscoretype.observe('access', (ctx, next) => util.access(ctx, next));
		Assessmentscoretype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
