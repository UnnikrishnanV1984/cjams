'use strict';
const util = require('../utils/utils');

module.exports = function(Alerteventtype) {
	
	var totalCount;
	Alerteventtype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Alerteventtype.find(request);

	};

	Alerteventtype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
			Alerteventtype.count({and: [
		       
		        {activeflag: 1},
		      ]},function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
		
		}

		next();
	});

	Alerteventtype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Alerteventtype.remoteMethod('list', {
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

	Alerteventtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Alerteventtype.observe('access', (ctx, next) => util.access(ctx, next));
	Alerteventtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
