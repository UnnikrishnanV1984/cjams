'use strict';
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Provideragreement) {
	
	var totalCount;
	Provideragreement.list = function(request) {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
			
			} 

	    return Provideragreement.find({
	    	where: {provideragreementtypekey:request.provideragreementtypekey},
	              include:{  
	                        relation : "provideragreementtype",
                            scope : {
                            	fields: "description"
                            }
	                           
	                    }
	        }) 
		
		};
		
		Provideragreement.beforeRemote('list', function(ctx, data, next) {

			if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
				
			Provideragreement.count(JSON.parse(ctx.req.query.filter).where, function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});
			
			}

			next();
		});

		Provideragreement.afterRemote('list', function(ctx, resultset, next) {
			if (ctx.result) {
				ctx.result = {
					'data' : resultset,
					'count' : totalCount
				};
			}
			next();
		});
	
	Provideragreement.remoteMethod(
			'list', {
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
				type : 'Object',
				root : true
			}
		});

		Provideragreement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Provideragreement.observe('access', (ctx, next) => util.access(ctx, next));
		Provideragreement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
