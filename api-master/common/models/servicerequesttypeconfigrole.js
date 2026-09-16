'use strict';
const LOGGER = require("log4js").getLogger("servicerequesttypeconfigrole");

var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Servicerequesttypeconfigrole) {

	Servicerequesttypeconfigrole.list = function(data) {

		/*
		 * "where":{"servicerequesttypeconfigid":"0FC6A955-7194-4498-93B5-5811D37BAB01","activeflag":1,"entityroletype":"UserRole"}
		 * Possible Entity Type: UserRole, EntityRole, DocumentType,
		 * PersonRole,EntityRoleType
		 */

		var sql = 'select * from getrequesttypeconfigrolelist($1,$2,$3)';
		var params = [data.where.servicerequesttypeconfigid,data.where.activeflag,data.where.entityroletype];

		LOGGER.debug("sql : " + sql);

		return util.executeDBQuery(sql, params)
			.then(data1 => {
				return data1[0].getrequesttypeconfigrolelist[0];
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Servicerequesttypeconfigrole.remoteMethod('list', {
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

    Servicerequesttypeconfigrole.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicerequesttypeconfigrole.observe('access', (ctx, next) => util.access(ctx, next));
    Servicerequesttypeconfigrole.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
