'use strict';
const util = require('../utils/utils');
module.exports = function(Region) {

	var totalCount;
	Region.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Region.find(request);

	};
	
	
	//if count is zero don't execute the listing else
	 // return the list also *
	
	Region.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
			Region.count(function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
		
		}

		next();
	});
	
	Region.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});
	
	//list remote method
	Region.remoteMethod('list', {
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
	
	Region.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Region.observe('access', (ctx, next) => util.access(ctx, next));
	Region.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
