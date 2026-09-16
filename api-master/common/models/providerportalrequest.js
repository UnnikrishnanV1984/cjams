'use strict';
const LOGGER = require("log4js").getLogger("providerportalrequest");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Providerportalrequest) {

	Providerportalrequest.changerequestlicenseinfo =function(request){
		var reqNo = request.where.request_no;
		var minAge = request.where.minimum_age_no;
		var maxAge = request.where.maximum_age_no;
		var gender = request.where.gender_cd;
		var childrenNo = request.where.children_no;
		var sql = 'UPDATE tb_prov_accomodation pa SET minimum_age_no=$1, maximum_age_no=$2, gender_cd=$3, children_no=$4 WHERE license_application_id = (select license_application_id from tb_provider_licensing where site_id = (select site_id from providerportalrequest where request_no = $5)::int)';
		return util.executeDBQuery(sql,[minAge,maxAge,gender,childrenNo,reqNo])
		  .then(data => {return {data : data};})
		  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	  };
	
	  Providerportalrequest.remoteMethod(
		'changerequestlicenseinfo', 
		{
		  accepts : {
			arg : 'data',
			type : 'object',
			http : {
			  source : 'body'
			},
		  },
		  http: {
			path: '/changerequestlicenseinfo',
			verb: 'POST'
		  },
		  returns : {
			type : 'object',
			root : true
		  }
		}
		);

		Providerportalrequest.getchangerequestlicenseinfo =function(request){
			var reqNo = request.where.request_no;
			var sql = 'select * from tb_prov_accomodation  WHERE license_application_id = (select license_application_id from tb_provider_licensing where site_id = (select site_id from providerportalrequest where request_no = $1)::int)';
			return util.executeDBQuery(sql,[reqNo])
			  .then(data => {return {data : data};})
			  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
		  };
		
		  Providerportalrequest.remoteMethod(
			'getchangerequestlicenseinfo', 
			{
			  accepts : {
				arg : 'data',
				type : 'object',
				http : {
				  source : 'body'
				},
			  },
			  http: {
				path: '/getchangerequestlicenseinfo',
				verb: 'POST'
			  },
			  returns : {
				type : 'object',
				root : true
			  }
			}
			);
    Providerportalrequest.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerportalrequest.observe('access', (ctx, next) => util.access(ctx, next));
	Providerportalrequest.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 
};
