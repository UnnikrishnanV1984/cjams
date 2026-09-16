'use strict';
const util = require('../utils/utils');

module.exports = function(Agencycategory) {
	
	var totalCount;
	Agencycategory.list = function(request) {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;

			}

		return Agencycategory.find(request);

		};
        
		Agencycategory.beforeRemote('list', function(ctx, request, next) {

			if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

				Agencycategory.count({and:[
			       
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

		Agencycategory.afterRemote('list',
				function(ctx, resultset, next) {

					if (ctx.result) {
						ctx.result = {
							'data' : resultset,
							'count' :totalCount
						};
					}
					next();
				});

		Agencycategory.remoteMethod('list', {
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

		Agencycategory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Agencycategory.observe('access', (ctx, next) => util.access(ctx, next));
		Agencycategory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
	 
};
