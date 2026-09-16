'use strict';
const LOGGER = require("log4js").getLogger("intakeserreqstatustype");
const util = require('../utils/utils');

module.exports = function(Intakeserreqstatustype) {


	var totalCount;
	Intakeserreqstatustype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Intakeserreqstatustype.find(request);

	};
	
	
	//if count is zero don't execute the listing else
	 // return the list also *
	
	Intakeserreqstatustype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
			
			if  (JSON.parse(ctx.req.query.filter).where !== undefined) {

				Intakeserreqstatustype.count( (JSON.parse(ctx.req.query.filter)).where, function(err, count) {
                      
					if (err) {
					 throw err;
					}
					totalCount = count;
					LOGGER.debug(count);
				   });
			}else{

				Intakeserreqstatustype.count(function(err, count) {

					if (err) {
						throw err;
					}
					totalCount = count;
		
				});
			}
		
		
		}

		next();
	});
	
	Intakeserreqstatustype.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});
	
	//list remote method
	Intakeserreqstatustype.remoteMethod('list', {
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

        Intakeserreqstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeserreqstatustype.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeserreqstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
