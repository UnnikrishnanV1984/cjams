'use strict';
const LOGGER = require("log4js").getLogger("dispositioncode");
const util = require('../utils/utils');

module.exports = function(Dispositioncode) {
	// defining the list
	
	var totalCount;
	Dispositioncode.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Dispositioncode.find(request);

	};
	
	
	//if count is zero don't execute the listing else
	 // return the list also *
	
	Dispositioncode.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			if  (JSON.parse(ctx.req.query.filter).where !== undefined) {

				Dispositioncode.count( (JSON.parse(ctx.req.query.filter)).where, function(err, count) {
                      
					if (err) {
					 throw err;
					}
					totalCount = count;
					LOGGER.debug(count);
				   });
			}else{
			
			Dispositioncode.count(function(err, count) {

			if (err) {
				throw err;
			}
			totalCount = count;

		});
	}
		}

		next();
	});
	
	Dispositioncode.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});
	
	//list remote method
	Dispositioncode.remoteMethod('list', {
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

	Dispositioncode.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Dispositioncode.observe('access', (ctx, next) => util.access(ctx, next));
	Dispositioncode.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
