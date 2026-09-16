'use strict';
const util = require('../utils/utils');

module.exports = function(Employeetype) {


	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */

	var totalCount;
	Employeetype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Employeetype.find(request);

	};

	Employeetype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Employeetype.count(JSON.parse(ctx.req.query.filter).where,function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Employeetype.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});

	Employeetype.remoteMethod('list', {
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
	
	Employeetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
   	Employeetype.observe('access', (ctx, next) => util.access(ctx, next));
    	Employeetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
