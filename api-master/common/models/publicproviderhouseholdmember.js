'use strict';
const LOGGER = require("log4js").getLogger("publicproviderhouseholdmember");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');

module.exports = function(Publicproviderhouseholdmember) {

	Publicproviderhouseholdmember.memberchecklist = request => {
		var applicant_id= request.where.applicant_id;
		var personid= request.where.personid;
					const sql =  'Select * from getproviderhouseholdmemberchecklist($1,$2)';
					return util.executeDBQuery(sql, [applicant_id, personid])
		.then(data => data)
		.catch(err => util.logError(err));
		};
		
    
    Publicproviderhouseholdmember.remoteMethod('memberchecklist', {
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
		
		Publicproviderhouseholdmember.getmemberapplicant = request => {
			var applicant_id= request.where.applicant_id;
			var household_member_id= request.where.household_member_id;
					const sql = 'select hm.household_member_id,household_member_first_name,household_member_middle_name,household_member_last_name,applicant_id,checklist_task,comment,review_date,date_type,status  from publicproviderhouseholdmember hm, tb_public_provider_applicant_household hh where hh.household_member_id = hm.household_member_id and hm.applicant_id = $1 and hm.household_member_id = $2 order by hm.household_member_id,checklist_task';
					return util.executeDBQuery(sql, [applicant_id, household_member_id])
			.then(data => data)
			.catch(err => util.logError(err));
			};
			
			
			Publicproviderhouseholdmember.remoteMethod('getmemberapplicant', {
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
		
			

		Publicproviderhouseholdmember.addchecklist = function (request,reqctx ) {
			let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		} 
			var appid = request.applicant_id;
			var householdMemberId = request.householdMemberId;
			var persnid = request.personid;
			const response = [];
			var result = [];
			const checklist = request.checklist;
			if (checklist) {
				if (Array.isArray(checklist)) {
					checklist.forEach(element => {
						response.push(
							app.models.Publicproviderhouseholdmember.create({
								household_member_id: householdMemberId,
								applicant_id: appid,
								checklist_task : element.checklist_task,
								comment : null,
								review_date : null,
								date_type : element.date_type,
								status : null,
								personid : persnid,
								create_ts: (request && request.securityuserid  ? request.securityuserid  : _securityusersid),
								update_ts: (request && request.securityuserid  ? request.securityuserid  : _securityusersid)
							})
						)
					})
					return Promise.all(response).then(function (values) {
						values.map(x => {
							result.push(x);
						});
						LOGGER.info(result);
						return "Success";
					});
				}
			}
			return Promise.resolve('Invalid request');
		}
	
		Publicproviderhouseholdmember.remoteMethod(
			'addchecklist', {
				http: {
					path: '/addchecklist',
					verb: 'post'
				},
				accepts : [ {arg : 'data',type : 'object',
				http : {source : 'body'}},
						{arg: 'req', type: 'object',
				http: { source: 'req'}}, {
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

		Publicproviderhouseholdmember.updatememberchecklist = function (request) {

			if (request) {
				if (Array.isArray(request.checklist)) {
					LOGGER.debug('1');
					var appid = request.applicant_id;
					var household_member_id = request.checklist[0].household_member_id;
					const response = [];
					var result = [];
					const checklist = request.checklist;
					var personid = request.checklist[0].personid;
					
					LOGGER.debug('2');
					Publicproviderhouseholdmember.deletemember(household_member_id,appid,personid);
					LOGGER.debug('3');
					checklist.forEach(element => {
						response.push(
							app.models.Publicproviderhouseholdmember.create({
								household_member_id: element.household_member_id,
								applicant_id: appid,
								checklist_task : element.checklist_task,
								comment : element.comment,
								review_date : element.review_date === '' ? null : element.review_date,
								date_type : element.date_type,
								status : element.status,
								personid : element.personid,
								create_ts: (request.securityuserid  ? request.securityuserid  : _securityusersid),
								update_ts: (request.securityuserid  ? request.securityuserid  : _securityusersid)
							})
						)
					})
					return Promise.all(response).then(function (values1) {
						values1.map(x => {
							result.push(x);
						});
						LOGGER.info(result);
						return "Success";
					});
				}
			}
			return Promise.resolve('Invalid request');
		}


		Publicproviderhouseholdmember.deletememberchecklist = function (household_member_id) {
			//Publicproviderhouseholdmember.deletemember
			return Promise.resolve(null);
		}

		Publicproviderhouseholdmember.deletemember = function (household_member_id,applicant_id,personid) {
			const sql = 'delete from publicproviderhouseholdmember where  applicant_id=$1 and personid=$2';
			return util.executeDBQuery(sql, [applicant_id,personid])
			.then(data => data)
			.catch(err => util.logError(err));
		}







		Publicproviderhouseholdmember.remoteMethod(
			'deletememberchecklist', {
				http: {
					path: '/deletememberchecklist',
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


		Publicproviderhouseholdmember.remoteMethod(
			'updatememberchecklist', {
				http: {
					path: '/updatememberchecklist',
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
	

		Publicproviderhouseholdmember.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Publicproviderhouseholdmember.observe('access', (ctx, next) => util.access(ctx, next));
		Publicproviderhouseholdmember.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
