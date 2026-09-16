'use strict';
const LOGGER = require("log4js").getLogger("publicproviderhousehold");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');

module.exports = function(Publicproviderhousehold) {

	Publicproviderhousehold.list = request => {
		var applicant_id= request.where.applicant_id;
        const sql = 'Select * from getpublicproviderhouseholdchecklist($1)';
        return util.executeDBQuery(sql, [applicant_id])
		.then(data => data)
		.catch(err => util.logError(err));
		};
		
    
    Publicproviderhousehold.remoteMethod('list', {
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
		

		Publicproviderhousehold.addchecklist = function (request, reqctx) {

			let _securityusersid = undefined;
			if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
			  _securityusersid = reqctx.req.headers.securityusersid;
			} 
			var appid = request.applicant_id;
			
			const response = [];
			var result = [];
			const checklist = request.checklist;
			if (checklist) {
				if (Array.isArray(checklist)) {
					checklist.forEach(element => {
						response.push(
							app.models.Publicproviderhousehold.create({
								applicant_id: appid,
								checklist_task : element.checklist_task,
								comment : null,
								review_date : null,
								date_type : element.date_type,
								status : null,    
								create_ts: (request && request.securityuserid  ? request.securityuserid  : suserid),
								update_ts: (request && request.securityuserid  ? request.securityuserid  : suserid)
								
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
	
		Publicproviderhousehold.remoteMethod(
			'addchecklist', {
				http: {
					path: '/addchecklist',
					verb: 'post'
				},
				accepts: [{
					arg: 'data', type: 'object',
					http: { source: 'body' }
				}, {
						arg: 'reqctx',
						type: 'object',
						http: {source: 'context'}
					  }],
				returns: {
					type: 'object',
					root: true
				}
			}
		);





		Publicproviderhousehold.updatechecklist = function (request) {

			if (request) {
				if (Array.isArray(request.checklist)) {
					var appid = request.checklist[0].applicant_id;
					var perid = request.checklist[0].personid;
					LOGGER.debug('---------------'+appid);
					const response = [];
					var result = [];
					const checklist = request.checklist;

					Publicproviderhousehold.deleteCheckList(appid,perid);
					LOGGER.debug('--------------2122------'+appid);
					LOGGER.debug('--------------2122------'+JSON.stringify(checklist));
					checklist.forEach(element => {
						response.push(
							app.models.Publicproviderhousehold.create({
								applicant_id: appid,
								checklist_task : element.checklist_task,
								comment : element.comment,
								review_date : element.review_date === '' ? null : element.review_date,
								date_type : element.date_type,
								status : element.status,    
								insertedby: (request.securityuserid  ? request.securityuserid  : suserid),
								updatedby: (request.securityuserid  ? request.securityuserid  : suserid)
								

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


		Publicproviderhousehold.deleteCheckList = function (applicant_id,personid) {
			const sql = 'delete from publicproviderhousehold where applicant_id=$1 ';
			return util.executeDBQuery(sql, [applicant_id])
			.then(data => data)
			.catch(err => util.logError(err));
		}

		Publicproviderhousehold.remoteMethod(
			'updatechecklist', {
				http: {
					path: '/updatechecklist',
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

		Publicproviderhousehold.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Publicproviderhousehold.observe('access', (ctx, next) => util.access(ctx, next));
		Publicproviderhousehold.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
