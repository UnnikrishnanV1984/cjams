'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');

module.exports = function(Reverserelationship) {

	Reverserelationship.list = request => {
		var relationshiptypekey= request.where.relationshiptypekey;
        const sql = 'select * from cjams.reverserelationship where relationshiptypekey =$1';
        return util.executeDBQuery(sql, [relationshiptypekey])
		.then(data => data)
		.catch(err => util.logError(err));
		};
		

		Reverserelationship.remoteMethod('list', {
		accepts: {
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true
		},
		http: {
			verb: 'get'
		},
		returns: {
			type: 'object',
			root: true
		}
		});
		

		Reverserelationship.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Reverserelationship.observe('access', (ctx, next) => util.access(ctx, next));
		Reverserelationship.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};