'use strict';
const util = require('../utils/utils');

module.exports = function(Personidentifiertype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	var totalCount;
	Personidentifiertype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Personidentifiertype.find(request);

	};

	Personidentifiertype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Personidentifiertype.count(JSON.parse(ctx.req.query.filter).where,function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Personidentifiertype.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});

	Personidentifiertype.remoteMethod('list', {
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

	Personidentifiertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Personidentifiertype.observe('access', (ctx, next) => util.access(ctx, next));
	Personidentifiertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
