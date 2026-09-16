'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');
const LOGGER = require('log4js').getLogger("utils");

module.exports = function(Tb_ive_adoption_audit) {

	Tb_ive_adoption_audit.list = request => {
		var clientid= request.where.clientid;
		const sql =  `select tpe.approvalid,tpe.eligibility_period_id, tpe.sqnm_sw as category,tce.create_user_id as migratedcase, tpe.progressnoteid, tpe.ivenarrativesection, (select description_tx from tb_picklist_values where picklist_type_id = 262 and trim(picklist_value_cd) = trim(tee.resulting_status_cd)) as adoptioneligibilitystatus, tpe.approvalstatus, tpe.approvalid, tee.event_dt,
						(select remarks from routing where objectid = tpe.approvalid)
						from tb_client_eligibility tce join tb_eligibility_period tpe on tpe.eligibility_id = tce.eligibility_id
						join tb_eligibility_events tee on tee.eligibility_period_id = tpe.eligibility_period_id
						where tce.eligibility_type_cd = '2934' and tce.delete_sw = 'N' and tce.client_id = $1 order by tpe.sqnm_sw, tee.event_id desc`;
        
			return util.executeSecondaryNodeDBQuery(sql, [clientid])
					.then(data => {
					   return data;
					}).catch(err => {
					  LOGGER.error(err);
					  return {};
			});
	};
		

		Tb_ive_adoption_audit.remoteMethod('list', {
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
		

		Tb_ive_adoption_audit.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Tb_ive_adoption_audit.observe('access', (ctx, next) => util.access(ctx, next));
		Tb_ive_adoption_audit.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};