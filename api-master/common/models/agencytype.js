'use strict';
const util = require('../utils/utils');

module.exports = function(Agencytype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
    var totalCount;
	Agencytype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Agencytype.find(request);

	};

	Agencytype.beforeRemote('list', function(ctx, data, next) {
 	if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			 
			Agencytype.count(JSON.parse(ctx.req.query.filter).where,function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});
		}

		next();
	});

	Agencytype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Agencytype.remoteMethod('list', {
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

	Agencytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Agencytype.observe('access', (ctx, next) => util.access(ctx, next));
	Agencytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
	
};
