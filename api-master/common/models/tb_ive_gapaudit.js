'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');
const LOGGER = require('log4js').getLogger("utils");

module.exports = function(Tb_ive_gapaudit) {

	Tb_ive_gapaudit.list = request => {
		let clientid= request.where.clientid;
		let guardian_subsidy_id = request.where.removalid
		const sql = `select tpe.approvalid,tpe.eligibility_period_id,tce.guardian_subsidy_id, tpe.sqnm_sw, tpe.progressnoteid, tpe.ivenarrativesection, (select description_tx from tb_picklist_values where picklist_type_id = 262 and trim(picklist_value_cd) = trim(tpe.status_cd)) as gapeligibilitystatus, tpe.approvalstatus, tpe.approvalid, tee.event_dt,
						(select remarks from routing where objectid = tpe.approvalid)
						from tb_client_eligibility tce 
						join tb_eligibility_period tpe on tpe.eligibility_id = tce.eligibility_id
						join tb_eligibility_events tee on tee.eligibility_period_id = tpe.eligibility_period_id
						where tce.eligibility_type_cd = '2935' and tce.delete_sw = 'N' and tce.client_id = $1 and tce.guardian_subsidy_id = $2  order by tpe.sqnm_sw, tee.event_id desc`;
        
		 return util.executeSecondaryNodeDBQuery(sql,[clientid,guardian_subsidy_id])
				.then(data => {
				   return data;
				})
				.catch(err => {
					LOGGER.error(err);
					return {};
		});

	};
		

		Tb_ive_gapaudit.remoteMethod('list', {
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

		Tb_ive_gapaudit.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Tb_ive_gapaudit.observe('access', (ctx, next) => util.access(ctx, next));
		Tb_ive_gapaudit.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
