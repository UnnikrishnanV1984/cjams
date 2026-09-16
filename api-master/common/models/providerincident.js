'use strict';
const LOGGER = require("log4js").getLogger("providerincident");
const util = require('../utils/utils');
var app = require('../../server/server');
var email = require('../models/email');

module.exports = function(Providerincident) {

	Providerincident.addincidentreport= function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		request.where.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var adduir = 'select * from addincidentreportinfo($1)';
		return util.executeDBQuery(adduir, [JSON.stringify(request.where)])
			.then(data => {
				return {data : data};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};
		
	Providerincident.remoteMethod(
		'addincidentreport', 
				{
					http: {
							path: '/addincidentreport',
							verb: 'post'
					},
					accepts : [{
						arg : 'data',
						type : 'object',
						http : {
							source : 'body'
						}
					}

					,{
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

	Providerincident.getincidentreport= function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		request.where.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var incidentno = request.where.incident_no;
		var getuir = 'select * from getincidentreport($1)';
		return util.executeDBQuery(getuir, [incidentno])
			.then(data => {
				return {data : data};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};
		
	Providerincident.remoteMethod(
		'getincidentreport', 
				{
					http: {
							path: '/getincidentreport',
							verb: 'get'
					},
					accepts : [{
						arg : 'filter',
						type : 'object',
						http : {
							source : 'query'
						}
					}

					,{
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

		Providerincident.sendemailnotification= function(request,reqctx){
			let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
			request.where.securityuserid = (request && request.securityuserid?request.securityuserid:suserid);
			var emailmessage = request.where.email_content;
			var emailaddresses = request.where.emails 
			return Promise.resolve(email.SendProvrefEmail(emailaddresses, 'Incident Report Notification', emailmessage));			};
			
		Providerincident.remoteMethod(
			'sendemailnotification', 
					{
						http: {
								path: '/sendemailnotification',
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
							type : 'string',
							root : true
						}
						}
			);
	Providerincident.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerincident.observe('access', (ctx, next) => util.access(ctx, next));
	Providerincident.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
