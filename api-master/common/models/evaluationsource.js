'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Evaluationsource) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	
	Evaluationsource.list = request => {
		let searchkey = ''
		let evalsrcagencykeysearchkey = '';
		if(request.where) {
			searchkey = request.where.searchkey;
			evalsrcagencykeysearchkey = request.where.evaluationsourceagencykey;
		}
		
		const sql = 'Select * from searchEvaluationSources($1, $2)';

		return util.executeSecondaryNodeDBQuery(sql, [searchkey, evalsrcagencykeysearchkey]).then(data => { return data; })
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
	};

	

	Evaluationsource.remoteMethod('list', {
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

	Evaluationsource.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Evaluationsource.observe('access', (ctx, next) => util.access(ctx, next));
	Evaluationsource.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};