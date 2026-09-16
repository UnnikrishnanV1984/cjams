'use strict';
const util = require('../utils/utils');

module.exports = function(Gendertype) {

	Gendertype.genderlist = (request) => {
		return Gendertype.find({
			where: request.where,
            order: request.order,
            nolimit: request.nolimit,
		}).then(data => {
			return util.encryptresponse(data);
		}).catch(err => util.logError(err));	
	};

	Gendertype.remoteMethod('genderlist', {
		http: {
			path: '/genderlist',
			verb: 'post'
		},
		accepts: [
			{ arg: 'request', type: 'object', http: { source: 'body' } }],
		returns: {
			type : 'object',
				root : true
		}
	});

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
    var totalCount;
	Gendertype.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Gendertype.find(request);

	};

	Gendertype.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

			Gendertype.count(JSON.parse(ctx.req.query.filter).where,function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Gendertype.afterRemote('list', function(ctx, project, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : project,
				'count' : totalCount
			};
		}
		next();
	});

	Gendertype.remoteMethod('list', {
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

	Gendertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Gendertype.observe('access', (ctx, next) => util.access(ctx, next));
	Gendertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
