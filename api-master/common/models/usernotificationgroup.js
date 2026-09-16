'use strict';
const LOGGER = require("log4js").getLogger("usernotificationgroup");
const util = require('../utils/utils');
const app = require('../../server/server');
module.exports = function(Usernotificationgroup) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	var totalCount;
	Usernotificationgroup.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Usernotificationgroup.find(request);

	};

	Usernotificationgroup.delete = (id) => {

		var sql = 'UPDATE Usernotificationgroup SET activeflag=0 WHERE usernotificationgroupid=\''+id+'\'';

        return util.executeDBQuery(sql, [])
			.then(data => data)
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	}




	Usernotificationgroup.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Usernotificationgroup.count(function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});
 
		}

		next();
	});

	Usernotificationgroup.afterRemote('list', function(ctx, resultset, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Usernotificationgroup.remoteMethod('list', {
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

	Usernotificationgroup.remoteMethod('delete', {
		accepts: 
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
		http: { "verb": "delete", "path": "/delete/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});

	
    Usernotificationgroup.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Usernotificationgroup.observe('access', (ctx, next) => util.access(ctx, next));
    Usernotificationgroup.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
