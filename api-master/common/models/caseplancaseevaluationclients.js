'use strict';
const LOGGER = require("log4js").getLogger("caseplancaseevaluationclients");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');

module.exports = function(CaseplanCaseeValuationClients) {

    CaseplanCaseeValuationClients.list = request => {
        var caseevaluationid= request.where.servicelogid;
        var personid= request.where.personid;
        let sql = 'Select * from caseplancaseevaluationclients where 1=1 ';
        var paramList = [];
        if( servicelogid ){
           sql = sql + ' and caseevaluationid=$1'
           paramList.push(caseevaluationid);
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
		
		CaseplanCaseeValuationClients.addUpdate = request => {
					const sql = 'Select * from addupdatecaseplancaseevaluationclients($1)';
					return util.executeDBQuery(sql, [JSON.stringify(request)])
			.then(data => data)
			.catch(err => util.logError(err));
			};
    
            CaseplanCaseeValuationClients.remoteMethod('list', {
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
        CaseplanCaseeValuationClients.remoteMethod('addUpdate', {
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

	CaseplanCaseeValuationClients.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	CaseplanCaseeValuationClients.observe('access', (ctx, next) => util.access(ctx, next));
	CaseplanCaseeValuationClients.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
