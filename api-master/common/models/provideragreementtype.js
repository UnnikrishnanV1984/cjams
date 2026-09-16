'use strict';
const util = require('../utils/utils');

module.exports = function(Provideragreementtype) {
	
	var totalCount;
	Provideragreementtype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Provideragreementtype.find(request);

	};

	Provideragreementtype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
		Provideragreementtype.count({activeflag :ctx.req.param('activeflag')}, function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
		
		}

		next();
	});

	Provideragreementtype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Provideragreementtype.remoteMethod('list', {
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

	Provideragreementtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Provideragreementtype.observe('access', (ctx, next) => util.access(ctx, next));
	Provideragreementtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 
};
