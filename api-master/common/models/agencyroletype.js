'use strict';
const util = require('../utils/utils');

module.exports = function(Agencyroletype) {

    var totalCount;
	Agencyroletype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Agencyroletype.find(request);

	};

	Agencyroletype.beforeRemote('list', function(ctx, data, next) {
		
		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
		 
            Agencyroletype.count(JSON.parse(ctx.req.query.filter).where, function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
		
		}

		next();
	});

	Agencyroletype.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Agencyroletype.remoteMethod('list', {
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


    Agencyroletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Agencyroletype.observe('access', (ctx, next) => util.access(ctx, next));
    Agencyroletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
