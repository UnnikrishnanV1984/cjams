'use strict';
const util = require('../utils/utils');

module.exports = function(Provideragreementdocumenttype) {
	
	var totalCount;
	Provideragreementdocumenttype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Provideragreementdocumenttype.find(request);

	};

	Provideragreementdocumenttype.beforeRemote('list', function(ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Provideragreementdocumenttype.count((JSON.parse(ctx.req.query.filter)).where, function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Provideragreementdocumenttype.afterRemote('list',
			function(ctx, resultset, next) {

				if (ctx.result) {
					ctx.result = {
						'data' : resultset,
						'count' : totalCount
					};
				}
				next();
			});

	Provideragreementdocumenttype.remoteMethod('list', {
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

	Provideragreementdocumenttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Provideragreementdocumenttype.observe('access', (ctx, next) => util.access(ctx, next));
	Provideragreementdocumenttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
