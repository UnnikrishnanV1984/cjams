'use strict';
const util = require('../utils/utils');

module.exports = function(Servicerequestsubtype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	var totalCount;
	Servicerequestsubtype.list = function(request) {

		if (request.page !== 'undefined') {
      request.skip = (request.page - 1) * request.limit;
      request.where.isvisible = true;
		}

		return Servicerequestsubtype.find(request);

	};

	Servicerequestsubtype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Servicerequestsubtype.count(function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Servicerequestsubtype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Servicerequestsubtype.remoteMethod('list', {
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

	Servicerequestsubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Servicerequestsubtype.observe('access', (ctx, next) => util.access(ctx, next));
	Servicerequestsubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
