'use strict';
const LOGGER = require("log4js").getLogger("providerreferral");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('../models/email');


module.exports = function(Providerreferral) {

	Providerreferral.addproviderreferral =function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var provprogram_type = [];
		provprogram_type = request.provider_program_type;
		request.prov_program_type = provprogram_type;
		LOGGER.debug(provprogram_type, "requestprov_program_name");

		var newJsonDataStringyfied = JSON.stringify(request)
		LOGGER.debug(request);

		if (request!=null && request!=undefined &&
		request.provider_referral_id !=null && request.provider_referral_id!=undefined)
		{
			var addprovref = 'select * from addproviderreftable($1)';
			return util.executeDBQuery(addprovref, [newJsonDataStringyfied])
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
	}
		return Promise.resolve('Invalid request');
	};

	Providerreferral.remoteMethod(
				'addproviderreferral', 
					    {
					      http: {
					      		path: '/addproviderreferral',
					      		verb: 'post'
					      },
					     accepts : [ {arg : 'data',type : 'object',
					     		http : {source : 'body'}},{
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
	Providerreferral.updateproviderreferral =function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var newJsonDataStringyfied = JSON.stringify(request)
		LOGGER.debug(request);
		if (request!=null && request!=undefined &&
		request.provider_referral_id !=null && request.provider_referral_id!=undefined)
		{
		request.updatedby=(request && request.securityuserid?request.securityuserid:suserid);
		var updateprovref = 'select * from updateproviderreftable($1)';
		return util.executeDBQuery(updateprovref, [newJsonDataStringyfied])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}
		return Promise.resolve('Invalid request');
	};

	Providerreferral.remoteMethod(
				'updateproviderreferral', 
						{
							http: {
									path: '/updateproviderreferral',
									verb: 'put'
							},
							accepts : [ {arg : 'data',type : 'object',
									http : {source : 'body'}},{
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
	Providerreferral.getproviderreferral =function(request){
		var getprovref = 'select * from getprovreftable($1)';
		var newJsonDataStringyfied = JSON.stringify(request.where)
		return util.executeDBQuery(getprovref, [newJsonDataStringyfied])
			.then(data => {
				return {data : data[0].getprovreftable};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerreferral.remoteMethod(
				'getproviderreferral', 
						{
							http: {
									path: '/getproviderreferral',
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


	Providerreferral.approveproviderreferral = function(request,reqctx) {
		const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
		const rejMessage = "Dear Applicant, \n\nThe State of Maryland hereby denies your request to become a provider.\n\nBest regards,\nState of Maryland %s";
		const approveMessage ="Dear Applicant, \n\nThank you for contacting us regarding your agencies interest in Maryland's foster care services.\n\nI have compiled the information you have provided and listed it below.\nPlease confirm this information is correct by following the next steps to begin the application process.\n\nAgency Name:    MD Foster Care\nContact:     referralName\nEmail:   %s'\nphone:     xxx\nReferral Type:     xxxx\nReferral Contact:      xxxxx\n\nTo begin the application you will need to log into the portal with the following username and password.You will be promted to the change your password as soon as you log into the portal for security measures.\n\nUsername:xxxxx\nPassword:xxxx\nSTART APPLICATION\n\n\nBest regards,\nState of Maryland";
		var refid = request.provider_referral_id;
		var userid= suserid;
		request.securityuserid = suserid;
		var refstatus = request.referral_status;
		var refdecision = request.referral_decision;
		var comment = request.comments_tx;
		var d = new Date();
		var respemail;
		var response;
		var refappid;
		var providerId;
		var respprovider;
		var updateprovref = "UPDATE tb_provider_referral SET  referral_status= $1, referral_decision= $2 , comments_tx =$3 WHERE provider_referral_id=$4";
		var getprovref = 'select adr_email_tx , referral_decision , provider_referral_program, pt.program_type from tb_provider_referral left join tb_prov_ref_program_type pt on provider_referral_id = pt.referral_id where provider_referral_id = $1';
		
		return util.executeDBQuery(updateprovref,[refstatus, refdecision, comment, refid])
		.then(data1 => {
			return data1;
		})
		.then(response2 => {
			return util.executeDBQuery(getprovref,[refid])
			.then(data2 => {
				return data2;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
		}).then(data3 =>{
			response = JSON.parse(JSON.stringify(data3));
			LOGGER.debug(response,"response of get");
			if(response[0].referral_decision === "Approved"){
			var apptype = 'providerid'
			var sql = 'select * from getNextNumber(\'' + apptype + '\')';
			return util.executeDBQuery(sql,[])
			.then(data4 => {
				return data4;
			})
			.then(data5 => {
				providerId = d.getFullYear()+("000" + d.getDay()).slice(-3)+ + ("00000" + data5[0].getnextnumber).slice(-5);
				request.provider_id = providerId;
				refappid = refid;
				refappid = refappid.replace('R', 'A');
				var addprovapp = 'select * from addapplicantprofileandprovider($1)';
				return util.executeDBQuery(addprovapp,[JSON.stringify(request)])
				.then(data6 => {
					return data6;
				})
				.then(data7=>
				{
					respprovider=data7[0].providerid;
					return addproviderprofile(response, refappid, data7, userid, refid, request, suserid);
			})
			.then(data8=>
				{
					respemail=response[0].adr_email_tx;
					var refferalid=request.provider_referral_id;
					
					let sql1 = 'Select * from createdynamnicuserprofile($1)';
					
					return util.executeDBQuery(sql1, [refferalid])
					.then(data9 => {
						return data9;
					})
					.catch(err => {
						LOGGER.error('>>>>ERROR:', err);
						throw err;
					})
					
				})
				.then(data10=>
					{
						LOGGER.debug(data10,"data");
						var ressecurityuser=data10[0].d_securityusersid;
						const sql2 = 'Select * from createprovideruserconfig($1,$2,$3)';
						return util.executeDBQuery(sql2, [request.provider_referral_id,ressecurityuser,respprovider])
						.then(data11 => {
							return data11;
						})
						.catch(err => {
							LOGGER.error('>>>>ERROR:', err);
							throw err;
						})
					})
				.then(data12=>
				{
					LOGGER.debug(data12,"data");
					email.SendProvrefEmail(respemail, 'Agency Referral Request', approveMessage);
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				})
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
			}
			else if (response[0].referral_decision == "Rejected"){
				email.SendProvrefEmail(response[0].adr_email_tx, 'Provider Referral status Notification', rejMessage);
				}
			
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
	};

	function addproviderprofile(response, refappid, data, userid, refid, request, suserid) {
		var i=1;
		let response1 = [];
		if (Array.isArray(response)) {
			response1 = response.forEach(element1 => {
				(function (element) {
					var applicantId;
					applicantId = refappid + i;
					element.provid = data[0].providerid;
					element.profileid = data[0].applicantprofileid;
					element.provider_applicant_id = applicantId;
					element.securityuserid = userid;
					element.provider_referral_id = refid;
					i = i + 1;
					var addprovapp = 'select * from addproviderapplicantandprofile($1)';
					return util.executeDBQuery(addprovapp,[JSON.stringify(element)])
						.then(data13 => {
							// Refferal Approval
							if (request.tosecurityusersid) {
								var objectls = {};
								objectls.fromsecurityuserid = suserid;
								objectls.status = request.referral_status;
								objectls.objectid = applicantId;
								objectls.eventcode = 'PTA';
								objectls.decisiondate = new Date();
								objectls.fromroleid = request.fromroleid;
								objectls.toroleid = request.toroleid;
								objectls.tosecurityusersid = request.tosecurityusersid;
								var subdecision = 'select * from submitproviderdecision($1)';
								return util.executeDBQuery(subdecision,[objectls])
									.then(data14 => {
										return data14;
									})
									.catch(err => {
										LOGGER.error('>>>>ERROR:', err);
										throw err;
									})
							}
						})
						.catch(err => {
							LOGGER.error('>>>>ERROR:', err);
							throw err;
						})
				})(element1);
			})
		}
		return response1;
	}

	Providerreferral.remoteMethod(
		'approveproviderreferral', 
				{
					http: {
							path: '/approveproviderreferral',
							verb: 'put'
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


	Providerreferral.listprogramnames =function(request){
			const ProviderProgramNameObj = {
			fields: ['programtype','programname'],
			scope: {
				fields: ['programtype','programname'],
				nolimit:true
			},
		};

		ProviderProgramNameObj.where = {providertype: request.providertype};
		
		return app.models.provprogramtype.find(ProviderProgramNameObj)
			.then(response => {
				var result = [];
				const data = JSON.parse(JSON.stringify(response));
				var x = mapProgramNames(data);
				
				for (var [key,value] of x) {
					var finalResponseObj = {
						"programtype": key,
						"programnames": value,
					};
					result.push(finalResponseObj);
				}
				return result;
			})
			
	};

	function mapProgramNames(data){
		var x = new Map();
		for (const element2 of data) {
			if (element2.programtype.length > 0) {
				var programNames = [];
				for (const element3 of data) {
					if (element2.programtype === element3.programtype && element3.programname.length > 0 && element3.programname) {
						programNames.push(element3.programname);
					}
				}
				x.set(element2.programtype,programNames);
			}
		}
		return x;
	}

	Providerreferral.remoteMethod(
				'listprogramnames', 
						{
							accepts: {
								arg: 'data',
								type: 'object',
								http: {
								  source: 'body'
								}
							  },
							http : {
								verb : 'post'
							},
							returns : {
								type : 'object',
								root : true
							}
						}
			);
	
	/* Get the routed DA based on USER */
	Providerreferral.routereferralda = function (data,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		var userid = (data && data.securityuserid?data.securityuserid: suserid);
		var appeventcode = data.where.appeventcode;
		var provreqid = data.where.serreqid;
		var assigneduserid = data.where.assigneduserid;
		var sql = 'SELECT * FROM routereferralda($1,$2,$3,$4)';
		var params = [appeventcode, provreqid, userid, assigneduserid];
		return util.executeDBQuery(sql, params)
		  .then(routereferraldadata => {
				return routereferraldadata;
			})
		  .catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	  };

	  Providerreferral.remoteMethod(
		'routereferralda',
		{
		  http: {
			path: '/routereferralda',
			verb: 'post'
		  },
		  accepts: [{
			arg: 'data',
			type: 'object',
			http: {
			  source: 'body'
			}
		  },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
		  returns: {
			type: 'object',
			root: true
		  }
		}
	  );
	 
	Providerreferral.listparentorganizations =function(){
		var providercategorycd = "3049";
		var sql = 'select provider_nm,tax_id_no from tb_provider where provider_category_cd= $1' ;
		return util.executeDBQuery(sql, [providercategorycd])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerreferral.remoteMethod(
				'listparentorganizations', 
						{
							accepts : {
								arg : 'request',
								type : 'string',
								http : {
									source : 'query'
								},
							},
							http: {
								path: '/listparentorganizations',
								verb: 'get'
							},
							returns : {
								type : 'object',
								root : true
							}
						}
			);


	Providerreferral.listcountycodes =function(){
		var picklisttypeid = 104;
		var sql = 'select picklist_value_cd, value_tx from tb_picklist_values where picklist_type_id= $1' ;
		return util.executeDBQuery(sql, [picklisttypeid])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerreferral.remoteMethod(
				'listcountycodes', 
						{
							accepts : {
								arg : 'request',
								type : 'string',
								http : {
									source : 'query'
								},
							},
							http: {
								path: '/listcountycodes',
								verb: 'get'
							},
							returns : {
								type : 'object',
								root : true
							}
						}
			);
	
	
	
	Providerreferral.providersearch =function(request){
		const providercategorycd = request.providercategorycd;
		const providercategorystr = request.providercategorystr;
		var providerstatuscd;
		if (request.providerstatuscd){
			 providerstatuscd = request.providerstatuscd;
		}
		var count_cd ; 	
		if (request.jurisdiction){
			count_cd = request.jurisdiction;
		}
		let providerid = request.providerid;
		const providername = request.providername;
	

		const Providerinfoobj = {
			nolimit:true,
			order: request.order? request.order : 'insertedon desc',
			fields: ['provider_category_cd', 'provider_id','provider_nm','provider_first_nm','provider_middle_nm','provider_last_nm','vacancy_no','county_cd','tax_id_no','adr_work_phone_tx','affiliate_provider_id','provider_status_cd','county_cd_tx'],
			scope: {
				fields: ['provider_category_cd', 'provider_id','provider_nm','provider_first_nm','provider_middle_nm','provider_last_nm','vacancy_no','county_cd','tax_id_no','adr_work_phone_tx', 'affiliate_provider_id','provider_status_cd','county_cd_tx'],
				nolimit:true
			},
		};
		
		if(providercategorycd!==null && providercategorycd!==undefined && providercategorycd.length>0 && providercategorystr ==='public'){
			Providerinfoobj.where = { 
							provider_status_cd:providerstatuscd,
							county_cd_tx:count_cd,
							provider_id: { "ilike": '%' + providerid + '%'},
							provider_first_nm: { "ilike": '%' + providername + '%'},
							provider_category_cd: {"inq":providercategorycd}};


							return app.models.Providerinfo.find(Providerinfoobj)
							.then(response=>{ return JSON.parse(JSON.stringify(response)); });
			}
		else if (providercategorycd!=null && providercategorycd!=undefined && providercategorycd.length>0 && providercategorystr =='private'||'vendor'){
			if(providerid === '' || providerid === undefined){
				providerid = null;
			}else{
				providerid = Number(providerid);
			}

			Providerinfoobj.where = { 
							provider_status_cd:providerstatuscd,
							county_cd_tx:count_cd,
							provider_id: providerid,
							provider_nm: providername,
							pagenumber: request.page,
							pagesize: request.limit
						};
							const sql = 'Select * from searchprovider($1)';// and provider_id like $3 and provider_category_cd in $5';
							
							return util.executeDBQuery(sql, [Providerinfoobj.where])
							.then(data => {
								return data;
							})
							.then(data => data)
							.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
							});
			}
			
		else {		
			Providerinfoobj.where = { 
							provider_status_cd:providerstatuscd,
							county_cd_tx:count_cd,
							provider_id: { "ilike": '%' + providerid + '%'},
							provider_nm: { "ilike": '%' + providername + '%'},
							provider_category_cd: {"nin": ["1781","1784", "3050","3306", "3307","3788", "3789","3790", "3791"]}
						};

						return app.models.Providerinfo.find(Providerinfoobj)
						.then(response=>{
							return JSON.parse(JSON.stringify(response));
							});
			}
	}
	


	Providerreferral.remoteMethod(
				'providersearch', 
						{
							accepts : {
								arg : 'request',
								type : 'object',
								http : {
									source : 'body'
								},
							},
							http: {
								path: '/providersearch',
								verb: 'POST'
							},
							returns : {
								type : 'object',
								root : true
							}
						}
			);	
			
			

	
					Providerreferral.remoteMethod('getreferrallist', {
						http: {
								path: '/getreferrallist',
								verb: 'get'
						},
						accepts : [ 
						{
								arg : 'filter',
								type : 'object',
								http : {source : 'query'}
						} ],  
						returns: {
								type : 'object',
								root : true
						} 
				});
		
				Providerreferral.getreferrallist = function(request){
				 var page = request.page;
				 var limit = request.limit;
				 if(!page){
					 page =1;
				 }
				 if(!limit){
					 limit =10;
				 }
						var sql = "select * from getreferrallist($1,$2,$3)"
						return util.executeDBQuery(sql, [request.where,page,limit])
							.then(res =>{
								return res
							})
							.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
							});
						}

						Providerreferral.remoteMethod('getportaldecisionlist', {
							http: {
									path: '/getportaldecisionlist',
									verb: 'get'
							},
							accepts : [ 
							{
									arg : 'filter',
									type : 'object',
									http : {source : 'query'}
							},{
								arg: 'reqctx',
								type: 'object',
								http: {source: 'context'}
							  } ],  
							returns: {
									type : 'object',
									root : true
							} 
					});
			
					Providerreferral.getportaldecisionlist = function(request,reqctx){
						let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
					 var page = request.page;
					 var limit = request.limit;
					 var jsonvalue = request.where;
					 var securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
					 jsonvalue.securityuserid = securityuserid;
					 if(!page){
						 page =1;
					 }
					 if(!limit){
						 limit =10;
					 }
							var sql = "select * from getportaldecisionlist($1,$2,$3)"
							return util.executeDBQuery(sql, [jsonvalue,page,limit])
								.then(res =>{
									return res
								})
								.catch(err => {
									LOGGER.error('>>>>ERROR:', err);
									throw err;
								});
							}

	Providerreferral.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerreferral.observe('access', (ctx, next) => util.access(ctx, next));
	Providerreferral.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		
};
