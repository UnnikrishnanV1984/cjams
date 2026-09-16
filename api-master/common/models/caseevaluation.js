'use strict';
const LOGGER = require("log4js").getLogger("caseevaluation");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');

module.exports = function(CaseEvaluation) {

    CaseEvaluation.list = request => {
		var caseId= request.where.caseid;
        const sql = 'Select * from caseevaluation where caseid=$1';
        return util.executeSecondaryNodeDBQuery(sql, [caseId]).then((data) => {
				return data;
		}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
		};

		
		CaseEvaluation.addUpdate = request => {
					const sql = 'Select * from addupdatecaseevaluation($1)';
					return util.executeDBQuery(sql, [JSON.stringify(request)])
			.then(data => data)
			.catch(err => util.logError(err));
			};
    
    CaseEvaluation.remoteMethod('list', {
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
		
		// Adding Service Agreement
    CaseEvaluation.remoteMethod('addUpdate', {
			http: {
							path: '/addupdate',
							verb: 'post'
			},
			accepts : [ {arg : '',type : 'object',
					http : {source : 'body'}} ],
			returns: {
					type : 'object',
					root : true
			}
	});

	// NOSONAR
	// CaseEvaluation.CaseEvaluationRouting = function (request,cb) {
	// 	var ds = app.dataSources.hcuewelfare;
	// 	var userid = app.currentUser.securityusersid;
	// 	var status = 15;
	// 	var nofitymsg = 'Progress Review Submitted for review';
    //     LOGGER.debug(nofitymsg);
	// 	if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "rejected") {
	// 		status = 17;
	// 		nofitymsg = 'Progress Review Rejected ';
	// 	}
	// 	else if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "accepted") {
	// 		status = 16;
	// 		nofitymsg = 'Progress Review Approved ';
    //     }
    //     LOGGER.debug(nofitymsg);
	// 	if(request && request.caseid == null && request.caseid == undefined){
	// 		request.caseid = '';
	// 	} 
    //     LOGGER.debug(nofitymsg);
	// 	var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
    //     LOGGER.debug(sql);
    //     LOGGER.debug(request.agreementid, userid, 'IHSA', status, request.attentiontx, '', false, false, false, nofitymsg,'',request.caseid);
	// 	ds.connector.execute(sql, [request.agreementid, userid, 'IHSA', status, request.attentiontx, '', false, false, false, nofitymsg,'',request.caseid],
	// 		function (err, data) {
	// 			if (err) {
	// 				LOGGER.error(err);
	// 				return cb(err);
    //             };
    //             LOGGER.debug('routingintake'+JSON.stringify(data));
	// 		});
	// }

	CaseEvaluation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	CaseEvaluation.observe('access', (ctx, next) => util.access(ctx, next));
	CaseEvaluation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};