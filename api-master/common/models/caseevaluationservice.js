'use strict';
const LOGGER = require("log4js").getLogger("caseevaluationservice");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');

module.exports = function(CaseEvaluationService) {

    CaseEvaluationService.list = request => {
        var servicelogid= request.where.servicelogid;
        var personid= request.where.personid;
        let sql = 'Select * from caseevaluationservice where 1=1 ';
        var paramList = [];
        if( servicelogid ){
           sql = sql + ' and servicelogid=$1'
           paramList.push(servicelogid);
        }
        if( personid ){
            sql = sql + ' and personid=$2'
            paramList.push(personid);
         }
         LOGGER.debug(paramList);

        return util.executeDBQuery(sql, paramList)
		.then(data => data)
		.catch(err => util.logError(err));
		};
		
		CaseEvaluationService.addUpdate = request => {
					const sql = 'Select * from addupdatecaseevaluationservice($1)';
					return util.executeDBQuery(sql, [JSON.stringify(request)])
			.then(data => data)
			.catch(err => util.logError(err));
			};
    
        CaseEvaluationService.remoteMethod('list', {
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
        CaseEvaluationService.remoteMethod('addUpdate', {
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

	CaseEvaluationService.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	CaseEvaluationService.observe('access', (ctx, next) => util.access(ctx, next));
	CaseEvaluationService.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
