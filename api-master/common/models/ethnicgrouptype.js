'use strict';
const util = require('../utils/utils');

module.exports = function(Ethnicgrouptype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */

	var totalCount;
	Ethnicgrouptype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Ethnicgrouptype.find(request);

	};

	Ethnicgrouptype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Ethnicgrouptype.count(JSON.parse(ctx.req.query.filter).where,function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Ethnicgrouptype.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});

	Ethnicgrouptype.remoteMethod('list', {
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

	Ethnicgrouptype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Ethnicgrouptype.observe('access', (ctx, next) => util.access(ctx, next));
	Ethnicgrouptype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
