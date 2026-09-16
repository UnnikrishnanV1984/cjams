'use strict';
const LOGGER = require("log4js").getLogger("providerapplicantportal");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('../models/email');
var uuid = require('node-uuid');


module.exports = function(Providerapplicantportal) {

			Providerapplicantportal.getassignedstaff = function (request) {
				var appid = request.where.provider_applicant_id;
				var getappstaff = 'select * from tb_provider_applicant_staff tpas join tb_provider_staff tps on tps.provider_staff_id = tpas.provider_staff_id::int  where tpas.provider_applicant_id =$1';
				return util.executeDBQuery(getappstaff, [appid])
					.then(data => {
						return data;
					})
					.catch(err => {
						LOGGER.error('>>>>ERROR:', err);
						throw err;
					});
			};
		
			Providerapplicantportal.remoteMethod(
				'getassignedstaff', {
					http: {
						path: '/getassignedstaff',
						verb: 'post'
					},
					accepts: {
						arg: 'data',
						type: 'object',
						http: {
							source: 'body'
						}
					},
					returns: {
						type: 'object',
						root: true
					}
				}
			);

	Providerapplicantportal.updateapplicantprofile= function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		request.securityuserid=(request && request.securityuserid?request.securityuserid: suserid);
		var upappprof = 'select * from updateappprofile($1)';
		return util.executeDBQuery(upappprof,[request])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}

	Providerapplicantportal.remoteMethod(
		'updateapplicantprofile', 
				{
					http: {
							path: '/updateapplicantprofile',
							verb: 'PUT'
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

	Providerapplicantportal.updateapplprograminfo= function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		request.securityuserid=(request && request.securityuserid?request.securityuserid:suserid);
		var upappprog = 'select * from updateapplprograminfo($1)';
		return util.executeDBQuery(upappprog,[request])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}

	Providerapplicantportal.remoteMethod(
		'updateapplprograminfo', 
				{
					http: {
							path: '/updateapplprograminfo',
							verb: 'PUT'
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

	Providerapplicantportal.getapplprofileinfo= function(request){
		var getappprofile = 'select * from getapplicantprofileinfo($1)';
		return util.executeDBQuery(getappprofile,[request.appid])
			.then(data => {
				return {data:data[0].getapplicantprofileinfo};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}

	Providerapplicantportal.remoteMethod(
		'getapplprofileinfo', 
				{
					http: {
							path: '/getapplprofileinfo',
							verb: 'POST'
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

	Providerapplicantportal.insertapplnarrative =function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 

		var userid = (request && request.securityuserid?request.securityuserid: suserid);
		var insprovnarr = 'INSERT INTO tb_provider_applicant_narrative(applicant_id, narrative, narravtivefrom,insertedby, updatedby)VALUES($1,$2,$3,$4,$5)';
		var appid=request.where.provider_applicant_id;
		var narr= request.where.narrative;
		var narrfrom = request.where.narrativefrom;
		return util.executeDBQuery(insprovnarr,[appid,narr,narrfrom,userid,userid])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicantportal.remoteMethod(
				'insertapplnarrative', 
						{
							http: {
									path: '/insertapplnarrative',
									verb: 'POST'
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
	Providerapplicantportal.getnarrative= function(request){
		var applid = request.where.applicant_id;
		var getnarr ='Select * from tb_provider_applicant_narrative where applicant_id = $1';
		return util.executeDBQuery(getnarr,[applid])
			.then(data => {
				return {data: data};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};
	
	Providerapplicantportal.remoteMethod(
			'getnarrative', 
					{
						http: {
								path: '/getnarrative',
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
	Providerapplicantportal.addappemail =function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 

		var userid = (request && request.securityuserid?request.securityuserid: suserid);
		var uniqueid = uuid();
		var addemail = 'INSERT INTO tb_provider_applicant_email	(email_unique_id,object_id,email,email_type,insertedby,updatedby)VALUES($1,$2,$3,$4,$5,$6)';
		var objid=request.where.object_id;
		var email1= request.where.email;
		var emailtype = request.where.email_type;
		return util.executeDBQuery(addemail,[uniqueid,objid,email1,emailtype,userid,userid])
			.then(data => {
				return {email_unique_id:uniqueid};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicantportal.remoteMethod(
				'addappemail', 
						{
							http: {
									path: '/addappemail',
									verb: 'POST'
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

	Providerapplicantportal.addappphone =function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		var userid = (request && request.securityuserid?request.securityuserid: suserid);
		var uniqueid = uuid();
		var addemail = 'INSERT INTO tb_provider_applicant_phone	(phone_id,object_id, phone_no, phone_type, insertedby, updatedby)VALUES($1,$2,$3,$4,$5,$6)';
		var objid=request.where.object_id;
		var phone= request.where.phone_no;
		var phonetype = request.where.phone_type;
		return util.executeDBQuery(addemail,[uniqueid,objid,phone,phonetype,userid,userid])
			.then(data => {
				return {phone_id:uniqueid};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicantportal.remoteMethod(
				'addappphone', 
						{
							http: {
									path: '/addappphone',
									verb: 'POST'
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
		

	Providerapplicantportal.addapplicantaddress =function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var addadrress = 'Select * from addprogaddress($1)';
		return util.executeDBQuery(addadrress,[request])
			.then(data => {
				return {address_id:data[0].addprogaddress};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicantportal.remoteMethod(
				'addapplicantaddress', 
						{
							http: {
									path: '/addapplicantaddress',
									verb: 'POST'
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
			Providerapplicantportal.updateapplicantaddress =function(request,reqctx){
				let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
				request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
				LOGGER.debug(request.address_id)
				LOGGER.debug(request.adr_street_no)
				var newJsonDataStringyfied = JSON.stringify(request)
				var updateadrress = 'Select * from updateprogaddress($1)';
				return util.executeDBQuery(updateadrress,[newJsonDataStringyfied])
					.then(data => {
						return data;
					})
					.catch(err => {
						LOGGER.error('>>>>ERROR:', err);
						throw err;
					});
			};
		
			Providerapplicantportal.remoteMethod(
						'updateapplicantaddress', 
								{
									http: {
											path: '/updateapplicantaddress',
											verb: 'POST'
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
	Providerapplicantportal.deleteapplicantaddress =function(request){
		var addressId= request.where.address_id;
		var address_mapping_id=request.where.address_mapping_id;

		var deleteaddress = 'delete from tb_provider_applicant_addresses  where address_id=$1';
		var deletemappingaddress = 'delete from tb_provider_address_mapping where address_mapping_id=$1';
		var countsql='select count(*) from tb_provider_address_mapping where address_id=$1';

			util.executeDBQuery(countsql, [addressId])
			.then(data => {
				if(data[0].count===1){
					return util.executeDBQuery(deleteaddress,[addressId])
					.then(data1 => {
						return {data : data1};
					});
				}
			})
			.catch(err => {
				LOGGER.error(err);
				return err;
			})

			return util.executeDBQuery(deletemappingaddress,[address_mapping_id])
			.then(data => {
				return {data : data};
			})
			.catch(err => {
				LOGGER.error(err);
				return err;
			})
			};
													
							  Providerapplicantportal.remoteMethod(
								'deleteapplicantaddress', 
								{
								  accepts : {
									arg : 'data',
									type : 'object',
									http : {
									  source : 'body'
									},
								  },
								  http: {
									path: '/deleteapplicantaddress',
									verb: 'POST'
								  },
								  returns : {
									type : 'object',
									root : true
								  }
								}
							  );					
	Providerapplicantportal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerapplicantportal.observe('access', (ctx, next) => util.access(ctx, next));
	Providerapplicantportal.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		
};
