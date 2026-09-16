'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');

module.exports = function(Publicproviderhouseholdchecklist) {

	Publicproviderhouseholdchecklist.list = request => {
		var checklist_type= request.where.checklist_type;
        const sql = 'Select * from publicproviderhouseholdchecklist where checklist_type=$1 order by checklist_task';
        return util.executeDBQuery(sql, [checklist_type])
		.then(data => data)
		.catch(err => util.logError(err));
		};
		
    
    Publicproviderhouseholdchecklist.remoteMethod('list', {
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
		

		Publicproviderhouseholdchecklist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Publicproviderhouseholdchecklist.observe('access', (ctx, next) => util.access(ctx, next));
		Publicproviderhouseholdchecklist.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};