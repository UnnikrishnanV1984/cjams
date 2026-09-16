'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(GetSameRACrossRefDA) {
GetSameRACrossRefDA.getDetails = data => {
	
	const sql = 'select * from getsameracrossrefda($1, $2, $3)';
	const params = [data.where.firstname, data.where.lastname, data.where.role];
	
	return util.executeSecondaryNodeDBQuery(sql, params)
	.then(_data => _data)
	.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
};

GetSameRACrossRefDA.remoteMethod(
	'getDetails', 
	{
		http: {
			path: '/getDetails',
			verb: 'post'
		},
		accepts : [ {
			arg : 'data',
			type : 'object',
			http : {
				source : 'body'
			}
		} ],   
		returns: {
			arg: 'data', 
			type: 'object'
		}
	});

	GetSameRACrossRefDA.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	GetSameRACrossRefDA.observe('access', (ctx, next) => util.access(ctx, next));
	GetSameRACrossRefDA.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
