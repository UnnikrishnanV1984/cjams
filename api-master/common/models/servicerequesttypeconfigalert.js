'use strict';
const util = require('../utils/utils');

module.exports = function(Servicerequesttypeconfigalert) {

	var totalCount;
	Servicerequesttypeconfigalert.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Servicerequesttypeconfigalert.find(request);

	};

	Servicerequesttypeconfigalert.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Servicerequesttypeconfigalert.count(function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Servicerequesttypeconfigalert.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});

	Servicerequesttypeconfigalert.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			path: '/list',
			verb : 'get'
			
		},
		returns : {
			type : 'string',
			root : true
		}
	});
	
	Servicerequesttypeconfigalert.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Servicerequesttypeconfigalert.observe('access', (ctx, next) => util.access(ctx, next));
	Servicerequesttypeconfigalert.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
