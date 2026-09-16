'use strict';
const LOGGER = require("log4js").getLogger("providerlicense");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('../models/email');


module.exports = function(Providerlicense) {

	Providerlicense.getproviderlicensing= function(request){
			var provlid = request.where.objectid;
			var getprovlic = 'Select pc.provider_id, pc.program_id, pc.license_no, pc.license_issue_dt, pc.license_expiry_dt, pc.license_level, pc.license_type, tp.provider_nm, tp.adr_work_phone_tx, pra.minimum_age_no, pra.maximum_age_no, pra.gender_cd, pra.children_no,tpa.adr_street_no,tpa.adr_street_nm,tpa.adr_city_nm,tpa.adr_county_cd,tpa.adr_state_cd,tpa.adr_zip5_no,tpa.adr_country_tx,cast( tpa.adr_street_no || \',\' ||tpa.adr_street_nm || \',\' ||tpa.adr_city_nm ||\',\' || tpa.adr_state_cd ||\',\' || tpa.adr_zip5_no as character varying) formatted_address from tb_provider_licensing pc join tb_provider tp on tp.provider_id = pc.provider_id join tb_prov_accomodation pra on pra.license_application_id = pc.license_application_id left join tb_provider_addresses tpa on (tpa.parent_key_id)::int = pc.provider_id where pc.provider_id = $1 ';
			return util.executeDBQuery(getprovlic, [provlid])
				.then(data => {
					return {data : data};
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
			};
		
	Providerlicense.remoteMethod(
				'getproviderlicensing', 
						{
							http: {
									path: '/getproviderlicensing',
									verb: 'post'
							},
							accepts : {
								arg : 'data',
								type : 'object',
								http : {
									source : 'body'
								}
							},   
							returns: {
								type : 'object',
								root : true
							}
							}
	);

	Providerlicense.updateproviderlicensing= function(request){
	var license_no = request.where.license_no;
	var effective_dt = request.where.license_issue_dt;
	var expiry_dt = request.where.license_expiry_dt;
	var updatelicensing ='UPDATE tb_provider_licensing pc set license_issue_dt= $1 , license_expiry_dt = $2 where license_no = $3';
	return util.executeDBQuery(updatelicensing, [effective_dt,expiry_dt,license_no])
		.then(data => {
			return {data : data};
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
	};

	Providerlicense.remoteMethod(
				'updateproviderlicensing', 
						{
							http: {
									path: '/updateproviderlicensing',
									verb: 'post'
							},
							accepts : {
								arg : 'data',
								type : 'object',
								http : {
									source : 'body'
								}
							},   
							returns: {
								type : 'object',
								root : true
							}
							}
	);

	Providerlicense.generatelicense= function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		var d = new Date();
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var licenseNO;
		var apptype = 'providerlicense'
		var sql = 'select * from getNextNumber(\'' + apptype + '\')';
		return util.executeDBQuery(sql, []).then(data => {
			LOGGER.debug(data, "data of next number");
			licenseNO = "DHS" + d.getFullYear() + ("00" + data[0].getnextnumber);
			request.license_no = licenseNO;
			var addprovlicense = 'select * from addprovlicensinginfo($1)';
			return util.executeDBQuery(addprovlicense, [JSON.stringify(request)]);
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};
	
		Providerlicense.remoteMethod(
					'generatelicense', 
							{
								http: {
										path: '/generatelicense',
										verb: 'post'
								},
								accepts : [{
									arg : 'data',
									type : 'object',
									http : {
										source : 'body'
									}
								},{
									arg: 'reqctx',
									type: 'object',
									http: {source: 'context'}
								  } ],   
								returns: {
									type : 'object',
									root : true
								}
								}
		);

    Providerlicense.getlicenseinformation =function(request){
		var contractLicenseTypeNo = request.where.contractLicenseTypeNo;

		var sql = 'select * from tb_provider_licensing tpl join tb_provider_addresses tpa on tpl.site_id::text = tpa.parent_key_id  join tb_contract_program tcp on tcp.license_no = tpl.license_no where tcp.program_id=$1 and tpa.adr_type_cd = \'3357\'';

		return util.executeDBQuery(sql, [contractLicenseTypeNo])
		  .then(data => {
			  return {data : data};
			})
		  .catch(err => {
			  LOGGER.error('>>>>ERROR:', err);
			  throw err;
			});
	  };
	
	  Providerlicense.remoteMethod(
		'getlicenseinformation', 
		{
		  accepts : {
			arg : 'data',
			type : 'object',
			http : {
			  source : 'body'
			},
		  },
		  http: {
			path: '/getlicenseinformation',
			verb: 'POST'
		  },
		  returns : {
			type : 'object',
			root : true
		  }
		}
		);


		Providerlicense.updateproviderinfo =function(request){
			var sql = 'select * from updateproviderinfo($1)'
			return util.executeDBQuery(sql, [JSON.stringify(request.where)])
			  .then(data => {
				  return {data : data};
				})
			  .catch(err => {
				  LOGGER.error('>>>>ERROR:', err);
				  throw err;
				});
		  };
		
		  Providerlicense.remoteMethod(
			'updateproviderinfo', 
			{
			  accepts : {
				arg : 'data',
				type : 'object',
				http : {
				  source : 'body'
				},
			  },
			  http: {
				path: '/updateproviderinfo',
				verb: 'POST'
			  },
			  returns : {
				type : 'object',
				root : true
			  }
			}
			);


	Providerlicense.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerlicense.observe('access', (ctx, next) => util.access(ctx, next));
	Providerlicense.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		
};
