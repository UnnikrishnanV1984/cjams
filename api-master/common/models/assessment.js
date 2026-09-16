'use strict';
const LOGGER = require("log4js").getLogger("assessment");
var app = require('../../server/server');
var config = require('../../server/config.json');
var uuid = require('node-uuid');
const util = require('../utils/utils');
var datasource = app.dataSources.hcuewelfare;
var email = require('../models/email');
const axios = require('axios');
const pdf = require('../models/pdf');
const content_type = "application/json";
const dummyid = '00000000-0000-0000-0000-000000000000';
const successmsg = "Successfully added";
const userloginurl = "/user/login";
const jwttokenstr = 'x-jwt-token';
const jwttokenpath = "?x-jwt-token=";

var formoptions = {

	method: config.postoption,
	headers: {
		"accept": content_type,
		"content-type": content_type,
		'User-Agent': 'request'
	},
	body: {
		"formBuilderUserId": "formsuser@cjams.com",
	},
	json: true
};

module.exports = function (Assessment) {

	var totalCount;
	Assessment.list = async function (data, reqctx) {
		var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
          }
        var requestuserinfo = {'token': '', 'email': _email};
		 data.limit = 50; // CDM-44480 Increasing limit to display all assessments
		var pageno = (data.page - 1) * data.limit
		var sroletypekey ;
		await util.getuserinfo(requestuserinfo).then (_data => {
			sroletypekey = _data.roletypekey;
		});
		// @Simar - This atrocious code was already here, the entire logic is wrong to get assessment list based on 'role code'
		// which is then used for available tempates which in DB are tied to 'CW'
		// CWCW -> got turned to 'CW' -> so worked
		// CWSP -> got turned to 'SP' and next they are turning 'SP' -> '' and then in stored proc if '' then setting to 'CW'
		// CWAPPEALCO -> no way it would work with this convoluted logic, so appeal workers were not getting assessments list in cases
		// Assessments should have been based on the 'case type' alone
		if (sroletypekey != null && sroletypekey !== undefined){
			sroletypekey = sroletypekey.substring(0, 2); //getting first 2 chars 'CW' so that at least it would work for all CW worker roles
		}

		if (data.nolimit == null || data.nolimit === undefined) {
			data.nolimit = false;}
		const iscaseexpunged = data.where.iscaseexpunged ?? 0;
		var sql = 'select * from listassessment($1,$2,$3,$4,$5,$6,$7,$8)';
		var params = [data.where.servicerequestid, data.where.assessmentstatus, pageno, data.limit, sroletypekey, data.nolimit,data.where.isExpungementSuperUser,iscaseexpunged];
		
		if (data.where.objecttypekey === 'servicecase' && (data.where.objectid != null && data.where.objectid !== undefined)) {
			sql = 'SELECT * FROM listassessmentbyservicecase($1, $2, $3, $4)';
			params = [data.where.objectid, pageno, data.limit,sroletypekey];
		}
		LOGGER.debug(sql);
		totalCount = 0;

		try {
			const result = await util.executeDBQuery(sql, params);
			if (result.length > 0) {
				totalCount = result[0].totalcount;
			} else {
				totalCount = 0;
			}
			return result;
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}
	};

	Assessment.afterRemote('list', function (ctx, data, next) {
		if (ctx.result) {
			ctx.result = {
				'data': data,
				'count': totalCount
			};
		}
		next();
	});

	function updateAssessmetDateCheck(request) {
		const now = new Date();
		if (request?.submissiondata?.safetyassessmentapprovaldate) {
			request.submissiondata.safetyassessmentapprovaldate = now;
		}
		if (request?.submissiondata?.approveddate) {
			request.submissiondata.approveddate = now;
		}
		if (request?.submissiondata?.familyAccess?.facilitatormeetingassessmentapprovaldate) {
			request.submissiondata.familyAccess.facilitatormeetingassessmentapprovaldate = now;
		}
		if (request?.submissiondata?.youthplacementservice?.assessmentapprovaldate) {
			request.submissiondata.youthplacementservice.assessmentapprovaldate = now;
		}
	}

	Assessment.updateassessment = function (request, reqctx) {
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
		var fromuserid = _securityusersid;
		if (request != null && request !== undefined &&
			request.submissionid != null && request.submissionid !== undefined) {
			if (request.assessmentstatustypekey1 == null || request.assessmentstatustypekey1 === '' || request.assessmentstatustypekey1 === undefined ||
				request.assessmentstatustypekey1.toLowerCase() === "open") {
				request.assessmentstatustypekey1 = "InProcess";
			}
			request.updatedby = fromuserid;
			LOGGER.debug("userid updateassessment() - ",request.updatedby);
			var templateid = request.submissionid;

			updateAssessmetDateCheck(request);

			return Assessment.updateAll({ submissionid: request.submissionid },
				{
					assessmentstatustypekey1: request.assessmentstatustypekey1,
					intakeservicerequestactorid: request.intakeservicerequestactorid,
					updatedby: request.updatedby ,
					submissiondata:request.submissiondata,
					actualdata:request.submissiondata,
					score: request.score,
					personid:request.submissiondata.personid
				})
				.then(res => {
						var sql = "select * from updateassessment($1)";
						util.executeDBQuery(sql,[request.assessmentid])
						.then(data => {
						app.models.Assessmentcomments.create({
							assessmentid: request.assessmentid,
							insertedby: fromuserid,
                            updatedby: fromuserid,
							status: request.assessmentstatustypekey1,
							comments: request.comments
						});
						}).then(data => {
							return checkAssessmentrouting(request)
						}).then(_res => {
								if (request.assessmentactor !== undefined || request.assessmentactor != null ) {
									return Assessment.assessmentactoradd(request.assessmentactor, request.updatedby, request.assessmentid).catch(_err => util.logError(_err));
								}
								return request;
							}).then(results =>{
								sendQRTPNotification(request, fromuserid);
								return results;
							}).then(results =>{
								senuntimelyreasoncreteriaupdate(request,fromuserid);
								 return results;
							})
							.catch(_err=>{
								LOGGER.error(_err);
							});
						return { data: { submissionid: templateid, status: 200, message: "Successfully updated" } };
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});

		}

		return Promise.resolve('Invalid request');
	};

	function sendQRTPNotification(request,fromuserid) {
		if (request.submissiondata.sendNotification) {
			var youthname = request.submissiondata?.youthinformation?.YouthName;
			var cjamspid = request.submissiondata?.youthinformation?.YouthCjamspid;
			var subject = 'QI Assessment Form is completed by the Qualified Individual for the Client' + ' ' + youthname + '' + '(' + cjamspid + ')';
			const sql = 'select * from send_qrtppartb_notification($1, $2, $3,$4::uuid,$5)';
			util.executeDBQuery(sql,[fromuserid,subject,request.servicecaseid,request.assessmentid,'QRTP01'])
				.then((data) => {
					return data;
				}).catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
		}
		if (request.submissiondata.sendFmrfNotification) {
			const sql = 'select * from send_group_notification($1, $2, $3, $4)';
			util.executeDBQuery(sql,[fromuserid,request.servicecaseid,request.submissiondata.ftdmUser,'fmrfapproved'])
				.then((data) => {
					return data;
				}).catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
		}
	}

	function checkAssessmentrouting(request){
		if (request.assessmentstatustypekey1.toLowerCase() !== "inprocess"){
			return Assessment.Assessmentrouting(request);
			}
		else{
			return request;
			}
	}

	Assessment.GetSummary = function (data) {

		var sql = 'select * from getassessmentsummary(\'' + data.where.investigationid + '\')';
		LOGGER.debug(sql);
		return util.executeSecondaryNodeDBQuery(sql, [])
			.then(_data => {
				return _data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};
	Assessment.afterRemote('GetSummary', function (ctx, data, next) {
		if (ctx.result) {
			ctx.result = {
				'data': data
			};
		}
		next();
	});

	
	Assessment.Add = async function (request, reqctx) {
		if (request != null && request !== undefined &&
			(!request.submissionid || request.submissionid == null || request.submissionid === undefined)) {
				var generatedId = '';
				var genid = "select * from gen_random_uuid()"; //@TM: generate submission id using db function
				await util.executeDBQuery(genid, [])
				.then(subid => {
					LOGGER.info(subid);
					generatedId = JSON.parse(JSON.stringify(subid));
					request.submissionid = generatedId[0].gen_random_uuid;
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				})
		}

		if (request != null && request !== undefined) {
			if (request.intakeservicerequestactorid === undefined || request.intakeservicerequestactorid === '') {
				request.intakeservicerequestactorid = null
			}
			if(request.submissiondata){
				var submissiondata = request.submissiondata;
				if(submissiondata.childdatagrid){
					var childrendatagrid = submissiondata.childdatagrid;
					updateassessmentRace(childrendatagrid, request);
				}
			}
			// }
			return addupdateAssessment(request, reqctx);

		}
		else {
			return { data: { message: "Invalid Request" } };
		}
	};

	function updateassessmentRace(childrendatagrid, request){
		childrendatagrid.forEach(element =>{
			const Race = element.Race;
			const personid = element.personid;
			if(Array.isArray(Race) && Race.length >0 ){
				var securityusersid = request.securityusersid;
				const Racejson = {};
				Racejson.race = [];
				Race.forEach(_element => {
					var racetypekey = {
						racetypekey:_element
					};
					Racejson.race.push(racetypekey);
				});
				LOGGER.debug(JSON.stringify(Racejson));
					var sql = "SELECT * FROM updateassessmentrace($1,$2,$3)";
					util.executeDBQuery(sql,[Racejson,personid,securityusersid])
					.then(data => {
						LOGGER.info(data);
					})
					.catch(err => {
						LOGGER.error(err)
						throw err;
					})
			}
			}	)
	}

	function checksubmissionData(request, _securityusersid){
		if (request.assessmentstatustypekey1 && request.assessmentstatustypekey1.toLowerCase() === "accepted") {
			if (request.submissiondata.routingsupervisors) {
				var sups = [];
				if(Array.isArray(request.submissiondata.routingsupervisors)) {
					sups = request.submissiondata.routingsupervisors;
				} else {
					sups = JSON.parse(request.submissiondata.routingsupervisors);
				}
				sups.forEach(sup => {
					if (sup.userid === _securityusersid){
						request.submissiondata.oldsupervisorname = request.submissiondata.supervisorname;
						request.submissiondata.approvedsupervisorname = sup.username;
						request.submissiondata.supervisorname = sup.username;
					}
				});
			}
		}
		return request;
	}

	function addupdateAssessment(request, reqctx){
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
		if (request.objectid.startsWith("I")) {
			request.intakenumber = request.objectid;
			request.objectid = dummyid;
		}

		if (request.ischildsafe == null || request.ischildsafe === undefined || request.ischildsafe === '') {
			request.ischildsafe = null
		}
		return app.models.Assessment.find({
			where: { submissionid: (request.submissionid ? request.submissionid : '')}
		}).then(result => {
			if(result && result.length>0 && (result[0].assessmentstatustypekey === 'Approved'||result[0].assessmentstatustypekey === 'Accepted') && result[0].__data?.submissiondata?.isCompleted){
				return {errormessage:'Assessment is in Approved status.'};
			}

			request  = checksubmissionData(request, _securityusersid);
			if (result.length > 0) {
				request.assessmentid = result[0].assessmentid;
				return Assessment.updateassessment(request,reqctx);
			} else {

				request.actualdata = request.submissiondata;
				return Assessment.createAssessment(request, _securityusersid);
			}
		}).catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
	}

	Assessment.createAssessmentInternal = async function (request, reqctx) {
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
		var loggedInUserId = dummyid;
		loggedInUserId = _securityusersid;

		if (util.isNullorEmpty(request)) {
			//@Simar: Crate a submisssion id only if doesn't exist for the request
			if (request.submissionid == null || request.submissionid === undefined) {
				var genid = "select * from gen_random_uuid()"; //@TM: use generated subsidy agreement id if unavailable
				await util.executeDBQuery(genid, []).then((resp)=>{
					resp = JSON.parse(JSON.stringify(resp));
					request.submissionid = resp[0].gen_random_uuid
				}).catch((error)=>{
					LOGGER.error('>>>>ERROR:', error);
					throw error;
				});
		}
	//@Simar This will get us the 'INTERNAL' template id to be use in ASSESSMENT table
			//The column 'external_templateid' is being re-used to manage internal names also
			return app.models.Assessmenttemplate.find({
				where: {and: [{external_templateid: request.internaltemplateid},{activeflag : 1}]}
			}).then(result => {
				if (result.length > 0) {
					if (request.assessmentstatustypekey1 == null || request.assessmentstatustypekey1 === undefined ||
						request.assessmentstatustypekey1.toLowerCase() === "open") {
						request.assessmentstatustypekey1 = "InProcess";
					}

					request.assessmenttemplateid = result[0].assessmenttemplateid;
					request.objectname = "servicerequest";
					request.insertedby = loggedInUserId;
					request.updatedby = loggedInUserId;
					request.activeflag = true;
					request.securityusersid = loggedInUserId;
					request.servicecaseid = request.objectid;
					return Assessment.upsert(request)
					.then(data => {
						request.assessmentid = data.assessmentid;
							Assessment.internalAssessmentRouting(request, _securityusersid);		//SonarQube  fix - removed the unwanted assignments
							return { data: { assessmentid: request.assessmentid,submissionid: request.submissionid, status: 200, message: successmsg } };
							});
				}
				else {
					return { data: { message: "Invalid External Templateid " } };

				}
			}).catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

		}

	};

	Assessment.createAssessment = function (request, _securityusersid) {
		var loggedInUserId = dummyid;
		var fromuserid = _securityusersid;
		if(app.currentUser && fromuserid){
			loggedInUserId = fromuserid;
		}
		if (request.assessmentstatustypekey1 == null || request.assessmentstatustypekey1 === undefined ||
			request.assessmentstatustypekey1.toLowerCase() === "open") {
			request.assessmentstatustypekey1 = "InProcess";
		}
		LOGGER.debug("***Assessment userid createAssessment() - ",loggedInUserId);
		if (util.isNullorEmpty(request)) {
			return app.models.Assessmenttemplate.find({
				where: {
					external_templateid: request.externaltemplateid
				}
			}).then(result => {
				if (result.length > 0) {

					request.assessmenttemplateid = result[0].assessmenttemplateid;
					LOGGER.debug(result[0].assessmenttemplateid);
					LOGGER.debug(request.assessmenttemplateid);
					request.objectname = "servicerequest";
					request.insertedby = loggedInUserId;
					request.updatedby = loggedInUserId;
					request.activeflag = true;
					request.securityusersid = loggedInUserId;
					return Assessment.create(request)
						.then(res => {
							var assessmentid = res.assessmentid;
							return app.models.Assessmentcomments.create({
									assessmentid: assessmentid,
									comments: request.comments,
									insertedby: loggedInUserId,
                                    updatedby: loggedInUserId,
									status: request.assessmentstatustypekey
								}).then(data => {
									request.assessmentid = res.assessmentid;
									return checkAssessmentrouting(request);

								}).then(_res => {
									return checkassessmentactor(request, assessmentid);

								}).then(results =>{
									sendNotification(request, fromuserid);
								 	return results;
								}).then(results =>{
									senuntimelyreasoncreteriaupdate(request,fromuserid);
									return results;
								}).then(() => {
									return { data: { assessmentid: res.assessmentid, submissionid: res.submissionid, status: 200, message: successmsg } };
								});
						});
				}
				return { data: { message: "Invalid External Templateid " } };
			}).catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		}
	};

	async function senuntimelyreasoncreteriaupdate(request,fromuserid){
		// Service case MFIRA and SAFEC Assessment
		if (request.servicecaseid != null && request.assessmentstatustypekey1 != 'InProcess' && (request.externaltemplateid == '5b6d56a7e881f068be283e60' || request.assessmentName == 'SAFE-C' || request.assessmenttemplateid == '0f01e16c-73db-42d8-ad84-04eeb5e26418')) {
			let assesmentname = request.externaltemplateid == '5b6d56a7e881f068be283e60' ? 'MFIRA' : 'SAFE-C';
			let updateSenUntimelySql = "SELECT * FROM senuntimelyreasoncreteriaupdate($1,$2,$3,$4)";
			await util.executeDBQuery(updateSenUntimelySql, [request.servicecaseid,fromuserid,assesmentname,request.assessmentid])
			.then(data1 => {
				LOGGER.info(data1);
				return data1;
			})
			.catch(err => {
				LOGGER.error('>>> Assessment add save senuntimelyreasoncreteriaupdate error '+err);
				throw err;
			})
		}
		
	}

	function sendNotification(request, fromuserid){
		if(request.submissiondata.sendNotification) {
			var youthname  = request.submissiondata?.youthinformation?.YouthName;
var cjamspid=  request.submissiondata?.youthinformation?.YouthCjamspid;
var subject='QI Assessment Form is completed by the Qualified Individual for the Client'+ ' ' + youthname + '' + '(' + cjamspid + ')';
    const sql = 'select * from send_qrtppartb_notification($1, $2, $3,$4::uuid,$5)';
    util.executeDBQuery(sql,[fromuserid,subject,request.servicecaseid,request.assessmentid,'QRTP01'])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error(err)
				throw err;
			})
		}
		if(request.submissiondata.sendFmrfNotification) {
			const sql = 'select * from send_fmrform_notification($1, $2, $3)';
			util.executeDBQuery(sql,[fromuserid,request.servicecaseid, request.submissiondata.ftdmUser])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error(err)
				throw err;
			})
		}
	}

	function checkassessmentactor(request, assessmentid){
		if (request.assessmentactor !== undefined && request.assessmentactor != null && request.assessmentactor.length > 0) {
			return Assessment.assessmentactoradd(request.assessmentactor, request.updatedby, assessmentid).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
		} else {
			return request;
		}
	}

	function getsupervisorname(request){
		var supervisorname = request.submissiondata.supervisorname ? request.submissiondata.supervisorname : '';
		supervisorname = request.submissiondata.oldsupervisorname ? request.submissiondata.oldsupervisorname : supervisorname;
		return supervisorname;
	}
	
	Assessment.internalAssessmentRouting = function (request, _securityusersid) {
		if (request.assessmentstatustypekey1.toLowerCase() !== "inprocess" && request.assessmentstatustypekey1.toLowerCase() !== "draft"){
		var userid = _securityusersid;
		var supervisorname = getsupervisorname(request);
		request.supervisorid = '';
		request.bmanualrouting = false;

		//@Simar - The assessmentrouting is written wrong, it is getting supervisor based on the name instead of id
		//will have to fix this but for now creating a separate souting for internal assessments
		if (supervisorname !== '' && request.submissiondata.routingsupervisors) {
			var sups = request.submissiondata.routingsupervisors;
			sups.forEach(sup => {
				if (sup.username === supervisorname){
					request.supervisorid = sup.userid;
					request.bmanualrouting = true;
				}
			});

		}

		var status = 15;
		var isservicecase = 0;
		request.intakeserviceid = request.objectid;

		var nofitymsg = 'Assessment Submitted for review';
		
		if (request.assessmentstatustypekey1.toLowerCase() === "rejected") {
			status = 17;
			nofitymsg = 'Assessment Rejected ';
		}
		else if (request.assessmentstatustypekey1.toLowerCase() === "accepted") {
			status = 16;
			nofitymsg = 'Assessment Approved ';

		}
		if(request.servicecaseid != null && request.servicecaseid !== undefined){
			request.intakeserviceid = request.servicecaseid ;
			isservicecase = 1;
		}
		LOGGER.debug("ROUTING NOW - " + JSON.stringify(request));
		LOGGER.debug("userid internalAssessmentRouting() - ",userid);
		LOGGER.debug("status internalAssessmentRouting() - ",status);
		var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
		util.executeDBQuery(sql, [request.assessmentid, userid, 'ASST', status, request.comments, request.supervisorid, request.bmanualrouting,
							false, false, nofitymsg,'',request.intakeserviceid,'',isservicecase])
		.then(data => {
			LOGGER.info(data);
		})
		.catch(err => {
			LOGGER.error(err)
			throw err;
		})
		}
	}

	const getNotifyMsg = (request, status)=>{
		let nofitymsg =  request.assessmentName
		? request.assessmentName +' Assessment Submitted for review'
		: 'Assessment Submitted for review';
		

		if (request.assessmentstatustypekey1.toLowerCase() === "rejected") {
			status = 17;
			nofitymsg = request.assessmentName
				? request.assessmentName + ' Assessment Rejected'
				: 'Assessment Rejected';
			request.supervisorid = '';
		} else if (request.assessmentstatustypekey1.toLowerCase() === "accepted") {
			status = 16;
			nofitymsg = request.assessmentName
				? request.assessmentName + ' Assessment Approved'
				: 'Assessment Approved';
			request.supervisorid = '';
		}

		return {nofitymsg: nofitymsg,  supervisorid: request.supervisorid, statusData:status}
	}

	Assessment.Assessmentrouting = function (request) {
		var userid = request.updatedby;

		LOGGER.debug("***Assessment updated by ",userid);
		var reroutesupervisor = (request.submissiondata.reroutesupervisor ? request.submissiondata.reroutesupervisor : '');
		var supervisorname = request.submissiondata.supervisorname ? request.submissiondata.supervisorname : reroutesupervisor;
		supervisorname = request.submissiondata.oldsupervisorname ? request.submissiondata.oldsupervisorname : supervisorname;
		request.supervisorid = '';
		request.bmanualrouting = false;

		if (supervisorname !== '' && request.submissiondata.routingsupervisors) {
			var sups = [];
			if(Array.isArray(request.submissiondata.routingsupervisors)) {
				sups = request.submissiondata.routingsupervisors;
			} else {
				sups = JSON.parse(request.submissiondata.routingsupervisors);
			}
			sups.forEach(sup => {
				LOGGER.debug(sup);
				if (sup.username === supervisorname){
					request.supervisorid = sup.userid;
					request.bmanualrouting = true;
				}
			});
			request.submissiondata.routingsupervisors = [];
		}

		LOGGER.debug("***Assessment Supervisor name from frontend ",supervisorname);
		LOGGER.debug("***Assessment Supervisor id ", request.supervisorid);
		LOGGER.debug("***Assessment routing flag ", request.bmanualrouting);

		var status = 15;
		var isservicecase = 0;
		request.intakeserviceid = request.objectid;

		var { nofitymsg, supervisorid, statusData } = getNotifyMsg(request, status)
		request.supervisorid = supervisorid;
		status = statusData;

		if(util.isNullorEmpty(request.servicecaseid)){
			request.intakeserviceid = request.servicecaseid ;
			isservicecase = 1;
		}
		LOGGER.debug("***Assessment ROUTING NOW ", request);
		var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
		return util.executeDBQuery(sql, [request.assessmentid, userid, 'ASST', status, request.comments, request.supervisorid,
								request.bmanualrouting, false, false, nofitymsg,'',request.intakeserviceid,'',isservicecase])
		.then((resp)=>{
			LOGGER.info(resp);
		}).catch(err=>{
			LOGGER.error("***Assessment ",err);
			throw err;
		});
	}


	Assessment.generateassessmentpdf = (request,res) =>{
        return Promise.resolve(pdf.assessmentspdf(request));
    }

    Assessment.remoteMethod('generateassessmentpdf', {
        http: {
            path: '/generateassessmentpdf',
            verb: 'post'
        },
        accepts: [{
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body'
                }
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res'
                }
            }

        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    })

	Assessment.remoteMethod('Add', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		}, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
		http: {
			verb: 'post'
		},
		returns: {
			type: 'string',
			root: true
		}
	});
	Assessment.remoteMethod('createAssessmentInternal', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		}, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
		http: {
			verb: 'post'
		},
		returns: {
			type: 'string',
			root: true
		}
	});
	Assessment.remoteMethod('list', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true},
			{arg: 'reqctx', type: 'object',
			http: {source: 'context'}}],
		http: {
			verb: 'get'
		},
		returns: {
			type: 'object',
			root: true
		}
	});
	Assessment.remoteMethod('updateassessment', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		}, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
		http: {
			verb: 'put'
		},
		returns: {
			type: 'string',
			root: true
		}
	});
	Assessment.remoteMethod('GetSummary', {
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

	Assessment.remoteMethod('Assessmentrouting', {
		accepts: {
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		},
		http: {
			verb: 'post'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	////// Report Start
	Assessment.remoteMethod('getAssessmentDetailRpt', {
		http: {
			path: '/getAssessmentDetailRpt',
			verb: 'get'
		},
		accepts: [{
			arg: 'data',
			type: 'object',
			http: { source: 'query' }
		}],
		returns: {
			type: 'object',
			root: true
		}
	});

	Assessment.getAssessmentDetailRpt = (request) => {
		const fromDate = request.fromdate;
		const toDate = request.todate;
		const rptQuery = "select * from qnetrpt_ccassessmentdetail_prc('" + fromDate + "', '" + toDate + "')";
		LOGGER.debug('123' + rptQuery);
		return util.executeSecondaryNodeDBQuery(rptQuery,[]).then((data) => {
			return data;
		}).catch((err) => {
			LOGGER.error('>>>>ERROR:', err);
			return err;
		});
	};

	////// Report End

	Assessment.remoteMethod('getassessment', {
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

	Assessment.getassessment = function (request) {
		var sql = 'select * from getassessment($1,$2,$3,$4)';
		return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid, request.where.assessmenttemplatename,
		request.page, request.limit]).then((data) => {
				return data;
		}).catch((err) => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
		});
	}



	Assessment.remoteMethod('getchilddatqyitasssessment', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		},{arg: 'reqctx', type: 'object',
		http: {source: 'context'}}],
		http: {
			verb: 'post'
		},
		returns: {
			type: 'object',
			root: true
		}
	})
 
	Assessment.getchilddatqyitasssessment = function (request,reqctx) {
		var sql = 'select * from getchilddatqyitasssessment($1)';
		return util.executeSecondaryNodeDBQuery(sql, [request.objectid]).then((data12) => {
				return data12;
		}).catch((err) => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
		});
	}
	Assessment.remoteMethod('getplacementreqformadetails', {
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
	})
	Assessment.getplacementreqformadetails = function (request) {
		var sql = 'select * from getplacementreqformadetails($1,$2,$3,$4)';
		return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid, request.where.assessmenttemplatename,
		request.page, request.limit]).then((data2) => {
			return data2;
		}).catch((err) => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
	}


	/* GET Assessment Submission Details GET method*/
	Assessment.remoteMethod('getsubmissiondetail', {
		accepts: [{
			arg: 'externalid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: false
		},
		{
			arg: 'submissionid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: false
		}],
		http: {
			verb: 'get',
			"path": "/getassessmentform/:externalid/submission/:submissionid",
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Assessment.getsubmissiondetail = (externalid, submissionid) => {

		return Assessment.find({
			where: {
				submissionid: submissionid,
				// ismigrated: 1
			}
		}).then(result => {
			if (result != null && result.length > 0) {
				return Assessment.getmigrateddsubmissionetail(externalid, submissionid);
			}
			else {
				return Assessment.getformsubmissiondetail(externalid, submissionid);
			}
		});
	}

	const aftRemotefn = (ctx, resultset, next) => {

		if (ctx.result) {
			if (resultset != null && resultset.length > 0)
				{ctx.result = resultset[0];}
			else
				{ctx.result = null;}

		}
		next();
	}

	Assessment.afterRemote('getsubmissiondetail', aftRemotefn);

	Assessment.getformsubmissiondetail = (externalid, submissionid) => {
		let options = { method: config.getoption };
		let url = `${config.formbuilderurl}/form/${externalid}/submission/${submissionid}${jwttokenpath}${res.headers[jwttokenstr]}`;
		return formBuilderLoginFn(externalid, url, options, 'get');
	}
	/* GET Assessment Submission Details Post method*/
	Assessment.remoteMethod('getsubmissiondetail', {
		accepts: [{
			arg: 'externalid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: false
		},
		{
			arg: 'submissionid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: false
		}],
		http: {
			verb: 'put',
			"path": "/getassessmentform/:externalid/submission/:submissionid",
		},
		returns: {
			type: 'object',
			root: true
		}
	});
	Assessment.getsubmissiondetailpost = (externalid, submissionid) => {
		return Promise.resolve(externalid);
	}

	/* GET Assessment form Details GET method*/
	Assessment.remoteMethod('getassessmentform', {

		accepts: {
			arg: 'externalid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: false
		},
		http: {
			verb: 'get',
			"path": "/getassessmentform/:externalid"
		},
		returns: {
			type: 'object',
			root: true
		}
	});


	Assessment.getassessmentform = (externalid, arg) => {
		let options = { method: config.getoption };
		let url = `${config.formbuilderurl}/form/${externalid}${jwttokenpath}${res.headers[jwttokenstr]}`;
		return formBuilderLoginFn(externalid, url, options, 'get');
	}

	/* GET Assessment form Details POST method*/
	Assessment.remoteMethod('getassessmentformpost', {

		accepts: [{
			arg: 'externalid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: true
		},
		{
			arg: 'obj',
			type: 'object',
			http: {
				source: 'body'
			},
			required: false
		}],
		http: {
			verb: 'post',
			"path": "/getassessmentform/:externalid/submission"
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Assessment.getassessmentformpost = (externalid, arg) => {
		let options = {
			method: config.postoption,
			headers: {
				"accept": content_type,
				"content-type": content_type,
				'User-Agent': 'request'
			},
			body: arg,
			json: true
		};
		let url = `${config.formbuilderurl}/form/${externalid}/submission/${submissionid}${jwttokenpath}${res.headers[jwttokenstr]}`;
		return formBuilderLoginFn(externalid, url, options, 'post');
	}

	Assessment.getmigrateddsubmissionetail = (externalid, submissionid) => {
		var sql = 'select * from getsubmissiondetails($1)';
		return util.executeSecondaryNodeDBQuery(sql, [submissionid])
			.then(data => {
				const result = JSON.parse(JSON.stringify(data))
				return result.map(res => {
					if (res.getsubmissiondetails) {
						res = checkSubmissionDetails(res);
					}
					return res.getsubmissiondetails;
				})
			}).catch(err => {
				LOGGER.error(err)
			})

	}


	function checkSubmissionDetails(res){
		let tempkey;
		for (const key in res.getsubmissiondetails) {
			tempkey = key;
			if (res.getsubmissiondetails[key] != null &&
				res.getsubmissiondetails[key].length !== 0) {
				if (res.getsubmissiondetails[key].substring(0, 1) === '{' ||
					res.getsubmissiondetails[key].substring(0, 1) === '[') {
					res = checkSubmission(res, tempkey);
				}
				else if (res.getsubmissiondetails[key].substring(0, 4) === 'true' )
					{res.getsubmissiondetails[tempkey] = true;}
				else if (res.getsubmissiondetails[key].substring(0, 5) === 'false' )
					{res.getsubmissiondetails[tempkey] = false;}
				else if (res.getsubmissiondetails[key].substring(0, 1) === '0' )
					{res.getsubmissiondetails[tempkey] = 0;}
			}
		}
		return res;
	}

	function checkSubmission(res, tempkey){
		res.getsubmissiondetails[tempkey] = JSON.parse(res.getsubmissiondetails[tempkey]); //this function does not have a 'key' variable
		for (const keyj in res.getsubmissiondetails[tempkey]) {
			res.getsubmissiondetails[tempkey][keyj] = stringtoBoolean(res.getsubmissiondetails[tempkey][keyj]);
		if(res.getsubmissiondetails[tempkey][keyj] != null
			&& res.getsubmissiondetails[tempkey][keyj] !== undefined
			&& typeof res.getsubmissiondetails[tempkey][keyj] !== 'string') //strings cannot be divided unlike objects or arrays
				{
					Object.keys(res.getsubmissiondetails[tempkey][keyj]).forEach(x => {
				if(tempkey && keyj && x)
				{
					if(res.getsubmissiondetails[tempkey][keyj][x] != null && res.getsubmissiondetails[tempkey][keyj][x] !== undefined)
					{
						res.getsubmissiondetails[tempkey][keyj][x] = stringtoBoolean(res.getsubmissiondetails[tempkey][keyj][x]);
			}
			}								
			});
		}
		}
		return res;
	}

	function stringtoBoolean(val){
		if(val === 'true'){
			return true;
		}
		if(val === 'false'){
			return false;
		}
		return val;

	}

	Assessment.getmigrateddsubmissionetail2 = async (externalid, submissionid) => {

		var sql = 'select * from getsubmissiondetails($1)';

		try {
			const data = await util.executeDBQuery(sql, [submissionid]);
			const result = JSON.parse(JSON.stringify(data))

			return result.map(res => {
				var subdtl = res.getsubmissiondetails;
				//SonarQube fix - emoved the unwanted assignment
				Object.values(subdtl).forEach(x => {
					if (x === "true"){
						x = true;
					}
					else if (x === "false")
						{x = false;}
					else if (x === "0")
						{x = 0;}
					LOGGER.info(x);
				});
				if (res.getsubmissiondetails) {
					res.getsubmissiondetails = getJsonResp(res);
				}
				return res.getsubmissiondetails;
			})
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}

	}

	function getJsonResp(res) {
			if (res.getsubmissiondetails.panel6035565487672137DataGrid)
				{res.getsubmissiondetails.panel6035565487672137DataGrid = JSON.parse(res.getsubmissiondetails.panel6035565487672137DataGrid);}
			if (res.getsubmissiondetails.familygrid)
				{res.getsubmissiondetails.familygrid = JSON.parse(res.getsubmissiondetails.familygrid);}
			if (res.getsubmissiondetails.familygrid1)
				{res.getsubmissiondetails.familygrid1 = JSON.parse(res.getsubmissiondetails.familygrid1);}
			if (res.getsubmissiondetails.panel7129350397125523DataGrid)
				{res.getsubmissiondetails.panel7129350397125523DataGrid = JSON.parse(res.getsubmissiondetails.panel7129350397125523DataGrid);}

			if (res.getsubmissiondetails.addchildren)
				{res.getsubmissiondetails.addchildren = JSON.parse(res.getsubmissiondetails.addchildren);}
			if (res.getsubmissiondetails.disableforms)
				{res.getsubmissiondetails.disableforms = JSON.parse(res.getsubmissiondetails.disableforms);}
			if (res.getsubmissiondetails.safeCDangerInfluence)
				{res.getsubmissiondetails.safeCDangerInfluence = JSON.parse(res.getsubmissiondetails.safeCDangerInfluence);}
			if (res.getsubmissiondetails.childdetails)
				{res.getsubmissiondetails.childdetails = JSON.parse(res.getsubmissiondetails.childdetails);}
			if (res.getsubmissiondetails.childdetails2)
				{res.getsubmissiondetails.childdetails2 = JSON.parse(res.getsubmissiondetails.childdetails2);}
			if (res.getsubmissiondetails.childisunsafe5)
				{res.getsubmissiondetails.childisunsafe5 = JSON.parse(res.getsubmissiondetails.childisunsafe5);}
			if (res.getsubmissiondetails.ProtectiveCapacitycommunity)
				{res.getsubmissiondetails.ProtectiveCapacitycommunity = JSON.parse(res.getsubmissiondetails.ProtectiveCapacitycommunity);}
			if (res.getsubmissiondetails.protectivecapacityofthecaregiver)
				{res.getsubmissiondetails.protectivecapacityofthecaregiver = JSON.parse(res.getsubmissiondetails.protectivecapacityofthecaregiver);}
			if (res.getsubmissiondetails.childisunsafe)
				{res.getsubmissiondetails.childisunsafe = JSON.parse(res.getsubmissiondetails.childisunsafe);}
			if (res.getsubmissiondetails.protectivecapacityofthechilddtl)
				{res.getsubmissiondetails.protectivecapacityofthechilddtl = JSON.parse(res.getsubmissiondetails.protectivecapacityofthechilddtl);}
		
			return res.getsubmissiondetails;
	}
	 
	Assessment.submissionadd = (request, id, submissionid, securityusersid) => {
		//@TM: list of formbuilder properties to look for and store as JSON object
		
		const JSONobjectlist = ['ql7', 'ql8', 'ql10', 'ql16', 'timeframe'];

		var v_iscollection, v_datavalue;
		var assessmentdata = Object.entries(request);

		return new Promise((resolve, reject) => {
			assessmentdata.forEach((obj, indx) => {
				var record = [obj];
				return record.map(asstdata => {
					var v_iscollectiondata = asstdata[1];
					if (Array.isArray(v_iscollectiondata)) {
						v_iscollection = 1;
						v_datavalue = null;
					} else if (v_iscollectiondata === Object(v_iscollectiondata)) {
						if (JSONobjectlist.includes(asstdata[0])) {
							v_iscollection = 0;
							v_datavalue = JSON.stringify(asstdata[1]);
						} else {
							var v_iscollectiondata1 = [];
							var v_iscollectiondata2 = [];
							v_iscollectiondata1.push(v_iscollectiondata);
							v_iscollectiondata2.push(v_iscollectiondata1[0]);
							v_iscollectiondata = v_iscollectiondata2;
							v_iscollection = 2;
							v_datavalue = null;
						}
					} else {
						v_iscollection = 0;
						v_datavalue = asstdata[1];
					}

					return app.models.Assessmentsubmission.create({
						assessmentid: id,
						submissionid: submissionid,
						datakey: asstdata[0],
						datavalue: v_datavalue,
						insertedby: securityusersid,
						updatedby: securityusersid,
						iscollection: v_iscollection

					}).then(res => {
						return createSubmissioncollection(res, v_iscollectiondata, securityusersid);
					})
				})
			})
		}).then(data => {
			return "Success";
		}).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
		
	}

	function createSubmissioncollection(res, v_iscollectiondata, securityusersid) {
		var iscollection = res.iscollection;
		var assessmentsubmissionid = res.assessmentsubmissionid;
		if (iscollection === 1 || iscollection === 2) {
			v_iscollectiondata.forEach((element, i) => {
				var submissiondata = Object.entries(element);
				submissiondata.forEach(assdat => {
					//prs.push(
						app.models.Submissioncollection.create({
							assessmentsubmissionid: assessmentsubmissionid,
							insertedby:  securityusersid,
							updatedby:  securityusersid,
							dataindex: i + 1,
							datatype: 'String',
							datakey: assdat[0],
							datavalue: assdat[1]
						})
					//)
				})
			})
		}
	}

	Assessment.assessmentactoradd = (assessmentactors, securityusersid, id) => {

		const prs = [];

		if (Array.isArray(assessmentactors)) {
			assessmentactors.forEach(assessmentactor => {
				prs.push(
					app.models.Assessmentactor.create({
						assessmentid: id,
						intakeservicerequestactorid: assessmentactor.intakeservicerequestactorid,
						issafe: assessmentactor.issafe,
						insertedby: securityusersid,
						updatedby: securityusersid
					})
				)
			})
		}
		return Promise.all(prs);

	}
	Assessment.remoteMethod(
		'getassessmentdetailsbytitleheadertext',
		{
		  http: {
			path: '/getassessmentdetailsbytitleheadertext',
			verb: 'post'
		  },
		  accepts: {
			arg: 'data',
			type: 'Object',
			http: {
			  source: 'body'
			}
		  },
		  returns: {
			arg: 'data',
			type: 'Object'
		  }
		});
	
	Assessment.getassessmentdetailsbytitleheadertext = function(request){
		var rolecode = '';
		var sql = 'SELECT * FROM getassessmentdetailsbytitleheadertext($1,$2,$3)';
		return util.executeDBQuery(sql, [JSON.stringify(request.assessment),request.intakeserviceid,rolecode])
			.then((data) => {
				return data;
			})
			.catch((err2) => {
				LOGGER.error('>>>>ERROR:',err2);
				throw err2;
			});
      };


	  module.exports.Notificationmail= function (request) {
	
		var weburl = config.weburl;
		var req = [];
		request.url = weburl+'/'+request.body
		req.push(request);
	
		 app.models.Usernotification.notificationmail(req)

	  };
	  

	
	
	  Assessment.sendemailassessment = function (request) {		
		var subject='C.A.R.E. HOME PROVIDER APPLICATION';	
		var body='<h5 style="font-size:16px;">Dear Applicant,</h5><p style="font-size:14px;">Thank you for contacting us regarding your interest in Maryland<sup>,</sup>s C.A.R.E. Home services.</p><p style="font-size:14px;">To begin the application you will need to log into the portal with the following username and password.<br> You will be prompted to the change your password as soon as you log into the portal for security measures.</p><p style="font-size:14px;font-weight:600;">Username:<span>XXXXX</span></p><p style="font-size:14px;font-weight:600;">Password:<span>XXXXX</span></p><p style="font-size:14px;">START APPLICATION</p><h5>Best regards,</h5><p>State of Maryland</p>';
		return Promise.resolve(email.SendEmail(request.tomail,subject,body ));
	  }

	  Assessment.remoteMethod(
		'sendemailassessment',
		{
		  http: {
			path: '/sendemailassessment',
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


		Assessment.sendemailattchment = function (request) {
			//SonarQube fix - removed unwanted assignments
			return Promise.resolve(email.SendEmailAttachment(request.tomail,request.subject,request.body,request.filename,request.content ));

			}

			Assessment.remoteMethod(
			'sendemailattchment',
			{
				http: {
				path: '/sendemailattchment',
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
	  
	Assessment.remoteMethod('deleteassessment', {
        http: {
                path: '/deleteassessment',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
        returns: {
            type : 'string',
            root : true
        }
    });

	Assessment.deleteassessment=async (request, reqctx)=> {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
		var sql = 'select * from deleteassessment($1,$2)';
		try {
			await util.executeDBQuery(sql,[request.assessmentid,(request && request.securityuserid?request.securityuserid: _securityusersid)]);
			senuntimelyreasoncreteriaupdate(request,_securityusersid);
			return "UPDATED SUCCESSFULLY";
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}
	}

	Assessment.getassesmentbyactorid = async request => {
		var actorID = request.where.actorID;
		var removalDate =  request.where.removalDate;
		var rangeType =  request.where.rangeType;
		var sql = 'SELECT assessmentactor.insertedon as assessement_date,templateX.name as type,assessment.submissiondata,assessment.ischildsafe as outcome,assessment.ismigrated,' +
		' assessment.assessmentstatustypekey, ' +
	  '	assessment.intakeservicerequestactorid,assessment.servicecaseid, ' +
		' assessmentactor.issafe,assessmentactor.assessmentactorid,assessment.insertedon AS completeddate '+
		' FROM assessmenttemplate templateX '+
		' INNER JOIN assessment ON assessment.assessmenttemplateid=templateX.assessmenttemplateid '+
		' LEFT OUTER JOIN assessmentactor ON assessmentactor.assessmentid=assessment.assessmentid  '+
		' WHERE templateX.activeflag=1 AND assessment.assessmentstatustypekey=\'Accepted\'' +
		' AND assessmentactor.intakeservicerequestactorid=$1 ';
      var params = [];
			params.push(actorID);
			if(rangeType){
				sql = sql + ' and assessmentactor.insertedon>$2 and assessmentactor.insertedon<$3 order by assessmentactor.insertedon desc'
				params.push(removalDate);
				switch(rangeType){
					case 1:params.push(Assessment.addDays(removalDate,60));
							 break;
					case 2 :params.push(Assessment.addDays(removalDate,90));
							break;
					case 3 :params.push(Assessment.addDays(removalDate,180));
							break;
					default:params.push(new Date());
									break;
				}
			}
			LOGGER.debug('sql ::: '+sql)
			LOGGER.debug('params ::: '+params)
		try {
			return await util.executeDBQuery(sql, params);
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}
		};
		
		Assessment.addDays = (date, days) => {
			var result = new Date(date);
			var data= new Date(date);
			result.setDate(data.getDate() + days);
			return result;
	  }

	Assessment.getassessmentvalue = request => {
		let intakenumber ='';
		let intakeserviceid = null;
		let assessmentname = '';
		let fieldname = '';
		let fieldvalue = '';
		
		if (request.where) {
			intakenumber = request.where.intakenumber;
			intakeserviceid = request.where.intakeserviceid;
			assessmentname = request.where.assessmentname;
			fieldname = request.where.fieldname;
			fieldvalue = request.where.fieldvalue;
		}

		var sql = 'select * from getassessmentvalue($1,$2, $3, $4, $5)';
		return util.executeSecondaryNodeDBQuery(sql,[intakenumber,intakeserviceid, assessmentname, fieldname, fieldvalue])
		.then(data => {
			if (data.length > 0) {
				return data[0].getassessmentvalue;
			}
			return false;
		})
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
	}

	
	Assessment.remoteMethod('getassessmentvalue', {
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

	Assessment.remoteMethod('getassesmentbyactorid', {
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


	Assessment.remoteMethod('getsubmissiondetailinternal', {
		accepts: [{
			arg: 'externalid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: false
		},
		{
			arg: 'submissionid',
			type: 'string',
			http: {
				source: 'path'
			},
			required: false
		}],
		http: {
			verb: 'get',
			"path": "/getassessmentforminternal/:externalid/submissioninternal/:submissionid",
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Assessment.getsubmissiondetailinternal = (externalid, submissionid) => {

		return Assessment.find({
			where: {
				submissionid: submissionid,
				// ismigrated: 1
			}
		}).then(result => {
			return result;
		});
	}


	Assessment.afterRemote('getsubmissiondetailinternal', aftRemotefn);
	

	Assessment.remoteMethod(
		'getpersoncompletedetail',
		{
		  http: {
			path: '/getpersoncompletedetail',
			verb: 'post'
		  },
		  accepts: [{
			arg: 'data',
			type: 'Object',
			http: {
			  source: 'body'
			}
		  }
	
		  ],
		  returns: {
			arg: 'data',
			type: 'Object'
		  }
		});

   
	Assessment.getpersoncompletedetail = function (data) {
		var personid = data.where.personid;
		var servicecaseid = data.where.servicecaseid;
		var sql = 'SELECT * FROM getpersoncompletedetail($1,$2)';
		return util.executeSecondaryNodeDBQuery(sql, [personid, servicecaseid]).then((_data) => {
		  return _data;
		}).catch((_err1) => {
			LOGGER.error('>>>>ERROR:', _err1);
			throw _err1;
		});
	  };

	
	  Assessment.remoteMethod(
		'getFMFDetails',
		{
		  http: {
			path: '/getFMFDetails',
			verb: 'post'
		  },
		  accepts: [{
			arg: 'data',
			type: 'Object',
			http: {
			  source: 'body'
			}
		  } ],
		  returns: {
			arg: 'data',
			type: 'Object'
		  }
		});

	Assessment.getFMFDetails = function (data) {
		var assessmentid = data.where.assessmentid;
		var sql = "select submissiondata from assessment where assessmentid = $1::uuid";

		return util.executeSecondaryNodeDBQuery(sql, [assessmentid]).then((_data) => {
				if (_data.length > 0) {
					return _data[0];
				}
				return null;
				})
			.catch((err) => { util.logError(err); throw err; });
		};

	Assessment.remoteMethod(
		'getstateconfiginfo', {
		http: {
			path: '/getstateconfiginfo',
			verb: 'post'
		},
		accepts: {
			arg: 'data',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		},
		returns: {
			type: 'string',
			root: true
		}
	}
	);

	Assessment.getstateconfiginfo = function (request) {
		const sql = "select * from getstateconfiginfo()";
		return util.executeSecondaryNodeDBQuery(sql, []).then((_data) => {		// NOSONAR
			if (_data.length > 0) {
				return _data[0];
			}
			return null;
		})
			.catch((err) => { util.logError(err); throw err; });
	};

	Assessment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessment.observe('access', (ctx, next) => util.access(ctx, next));
	Assessment.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}

function formBuilderLoginFn(externalid, url, options, action) {
	let loginurl = config.formbuilderurl + userloginurl;

	return new Promise((resolve, reject) => {
		/* invoke Form builder login service  */
		let formbuildercred = config.formbuilderpwd;
		formoptions.body.formBuilderPassword = util.decrypt(formbuildercred);

		axios.post(loginurl, formoptions.body, {
			headers: formoptions.headers
		})
			.then((res) => {
				if (res?.statusCode !== 200) {
					reject(res.statusCode);
				}
				if (res.headers != null && res.headers[jwttokenstr] != null) {
					actionToPerformFn(action, url, options, resolve, reject);
				}
				else {
					resolve(null);
				}
			})
			.catch((loginErr) => {
				if (loginErr?.response) {
					reject(loginErr?.response?.status);
				} else {
					reject(loginErr);
				}
			});
	});
}
function actionToPerformFn(action, url, options, resolve, reject) {
	if (action === 'post') {
		postformbuilderSubmision(url, options)
			.then(data => {
				resolve(data);
			}).catch(_err => {
				reject(_err);
			});
	} else {
		getformbuilder(url, options)
			.then(data => {
				resolve(data);
			}).catch(_err => {
				reject(_err);
			});
	}
}
function postformbuilderSubmision(url, options){
	return new Promise((resolve, reject)=>{
		/*Invoke Form builder submission service*/
		axios.post(url, options)
			.then((res) => {
				if (res?.statusCode !== 200) {
					resolve(res.body);
				}
				resolve(res); 
			})
			.catch((postformbuilderFnErr) => {
				if (postformbuilderFnErr.response) {
					if (postformbuilderFnErr.response.status !== 200) {
						resolve(postformbuilderFnErr.response.data);
					}
				} else {
					reject(postformbuilderFnErr);
				}
			});
	})
}

function getformbuilder(url, options){
	return new Promise((resolve, reject)=>{
		/*Invoke Form builder submission service*/
		axios.get(url, options)
			.then((res) => {
				if (res?.statusCode !== 200) {
					reject(res?.statusCode);
				}
				
				resolve(res.data);
			})
			.catch((getformbuilderFnErr) => {
				if (getformbuilderFnErr?.response) {
					reject(getformbuilderFnErr?.response?.status);
				} else {
					reject(getformbuilderFnErr);
				}
			});
	})
}