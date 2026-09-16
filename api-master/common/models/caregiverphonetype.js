'use strict';
const util = require('../utils/utils');

module.exports = function(Caregiverphonetype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
    var totalCount;
	Caregiverphonetype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Caregiverphonetype.find(request);

	};

	Caregiverphonetype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Caregiverphonetype.count({
				archiveon : null
			}, function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});
		}

		next();
	});

	Caregiverphonetype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Caregiverphonetype.remoteMethod('list', {
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

	Caregiverphonetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    	Caregiverphonetype.observe('access', (ctx, next) => util.access(ctx, next));
    	Caregiverphonetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
