'use strict';
const util = require('../utils/utils');

	module.exports = function(Intakeservicerequestplantype) {
		
		var totalCount;
		Intakeservicerequestplantype.list = function(request) {

			if (request.page !== 'undefined') {

				request.skip = (request.page - 1) * request.limit;

				}

			return Intakeservicerequestplantype.find(request);

			};
	        
			Intakeservicerequestplantype.beforeRemote('list', function(ctx, request, next) {

				if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

					Intakeservicerequestplantype.count({and:[
				      
				        {activeflag:true},
				        
				      ]}, function(err, count) {

						if (err) {
							throw err;
						}
						totalCount = count;
	                 
					});

					}

				next();
			});

			Intakeservicerequestplantype.afterRemote('list',
					function(ctx, resultset, next) {

						if (ctx.result) {
							ctx.result = {
								'data' : resultset,
								'count' : totalCount
							};
						}
						next();
					});

			Intakeservicerequestplantype.remoteMethod('list', {
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

			Intakeservicerequestplantype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
			Intakeservicerequestplantype.observe('access', (ctx, next) => util.access(ctx, next));
			Intakeservicerequestplantype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		
	};


