'use strict';
const util = require('../utils/utils');

module.exports = function(Caregiveraddresstype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */

	var totalCount;
	Caregiveraddresstype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Caregiveraddresstype.find(request);

	};

	Caregiveraddresstype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Caregiveraddresstype.count(function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Caregiveraddresstype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Caregiveraddresstype.remoteMethod('list', {
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
	
	Caregiveraddresstype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
   	Caregiveraddresstype.observe('access', (ctx, next) => util.access(ctx, next));
    	Caregiveraddresstype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
