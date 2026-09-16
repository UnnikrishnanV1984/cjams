'use strict';
const util = require('../utils/utils');

module.exports = function(Agencyphonenumbertype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
    var totalCount;
	Agencyphonenumbertype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Agencyphonenumbertype.find(request);

	};

	Agencyphonenumbertype.beforeRemote('list', function(ctx, data, next) {
		
		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
		 
		Agencyphonenumbertype.count(JSON.parse(ctx.req.query.filter).where, function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
		
		}

		next();
	});

	Agencyphonenumbertype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Agencyphonenumbertype.remoteMethod('list', {
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

	Agencyphonenumbertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Agencyphonenumbertype.observe('access', (ctx, next) => util.access(ctx, next));
	Agencyphonenumbertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
