'use strict';
const util = require('../utils/utils');

module.exports = function(Ammapping) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */

	Ammapping.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Ammapping.find(request);

	};

	Ammapping.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
			Ammapping.count({"activeflag":1, "activitytypekey":"Allegation"},function(err, count) {

			if (err) {
				throw err;
			}
			ctx.totalCount = count;

		});
		
		}

		next();
	});

	Ammapping.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : ctx.totalCount
			};
		}
		next();
	});

	Ammapping.remoteMethod('list', {
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
	
	Ammapping.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Ammapping.observe('access', (ctx, next) => util.access(ctx, next));
	Ammapping.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
