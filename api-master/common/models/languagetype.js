'use strict';
const util = require('../utils/utils');

module.exports = function(Languagetype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
    var totalCount;
	Languagetype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Languagetype.find(request);

	};

	Languagetype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
		Languagetype.count(JSON.parse(ctx.req.query.filter).where,function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
		
		}

		next();
	});

	Languagetype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Languagetype.remoteMethod('list', {
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

	
	Languagetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Languagetype.observe('access', (ctx, next) => util.access(ctx, next));
	Languagetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
	
};
