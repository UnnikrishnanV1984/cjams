'use strict';
const LOGGER = require("log4js").getLogger("providerservice");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Providerservice) {

  Providerservice.listservicecategories =function(){
		var picklisttypeid = "1196";
		var sql = 'select picklist_value_cd, value_tx from tb_picklist_values where picklist_type_id= $1' ;
		return util.executeDBQuery(sql,[picklisttypeid])
		    .then(data => data)
		    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};

	Providerservice.remoteMethod(
				'listservicecategories', 
						{
							accepts : {
								arg : 'request',
								type : 'string',
								http : {
									source : 'query'
								},
							},
							http: {
								path: '/listservicecategories',
								verb: 'get'
							},
							returns : {
								type : 'object',
								root : true
							}
						}
			);


	Providerservice.getserviceslist =function(request){
		var servicecategorycd = request.where.service_category_cd;
		var sql = 'SELECT service_id, service_nm, structure_service_cd, paid_non_paid_cd FROM tb_services where service_category_cd = $1';
		return util.executeDBQuery(sql,[servicecategorycd])
			.then(data => {return {data : data};})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};

	Providerservice.remoteMethod(
				'getserviceslist', 
						{
							accepts : {
								arg : 'data',
								type : 'object',
								http : {
									source : 'body'
								},
							},
							http: {
								path: '/getserviceslist',
								verb: 'POST'
							},
							returns : {
								type : 'object',
								root : true
							}
						}
			);

			Providerservice.deleteservices =function(request){
				var servicecategorycd = request.where.provider_service_id;
				var sql = "update tb_provider_applicant_services set end_dt=now() ,service_status='Closed'  where applicant_service_id = $1";
				LOGGER.debug(sql)
				return util.executeDBQuery(sql,[servicecategorycd])
					.then(data => {return {data: data};})
					.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
			};
		
			Providerservice.remoteMethod(
						'deleteservices', 
								{
									accepts : {
										arg : 'data',
										type : 'object',
										http : {
											source : 'body'
										},
									},
									http: {
										path: '/deleteservices',
										verb: 'POST'
									},
									returns : {
										type : 'object',
										root : true
									}
								}
					);

      Providerservice.observe('before save', (ctx, next) => util.beforesave(ctx, next));
      Providerservice.observe('access', (ctx, next) => util.access(ctx, next));
      Providerservice.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
