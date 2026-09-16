'use strict';
const util = require('../utils/utils');

module.exports = function(Assessmentscoringmethod) {
	
	var totalCount;
	Assessmentscoringmethod.list = function(request) {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;

			}

		return Assessmentscoringmethod.find(request);

		};
		
		Assessmentscoringmethod.beforeRemote('list', function(ctx, request, next) {

			if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

				Assessmentscoringmethod.count({and:[
 
			      ]}, function(err, count) {

					if (err) {
						throw err;
					}
					totalCount = count;
                 
				});

				}

			next();
		});

		Assessmentscoringmethod.afterRemote('list',
				function(ctx, resultset, next) {

					if (ctx.result) {
						ctx.result = {
							'data' : resultset,
							'count' : totalCount
						};
					}
					next();
				});

		
		Assessmentscoringmethod.remoteMethod('list', {
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

		Assessmentscoringmethod.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Assessmentscoringmethod.observe('access', (ctx, next) => util.access(ctx, next));
		Assessmentscoringmethod.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
