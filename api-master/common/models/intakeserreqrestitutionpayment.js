'use strict';
const LOGGER = require("log4js").getLogger("intakeserreqrestitutionpayment");
const util = require('../utils/utils');
var app = require('../../server/server');

// The payment submit/approve endpoints resolve identically - the returned rows
// wrapped in `data`, and a logged rethrow on failure. Shared so the same block
// is not repeated per endpoint. `data` is always an array: an empty result used
// to resolve undefined, so callers got no `data` key at all on that path.
const runPaymentSql = (sql, params) => util.executeDBQuery(sql, params)
    .then(rows => ({data: rows || []}))
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });

module.exports = function(Intakeserreqrestitutionpayment) {

    


    Intakeserreqrestitutionpayment.remoteMethod('getrestitutiondashboarddetails', {
                http: {
                    path: '/getrestitutiondashboarddetails',
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
            
            Intakeserreqrestitutionpayment.getrestitutiondashboarddetails = function(request)
            {
                let totalcount = 0;
                var type = request.where.pagetype;

                var pagesize = request.limit;
                var pagenumber = request.page;


                var sql = "select * from getrestitutiondashboarddetails($1,$2,$3)";

                return util.executeDBQuery(sql,[type,pagenumber,pagesize])
                    .then(data => {
                        if (data!==null && data.length>0) {totalcount= data[0].totalcount;}

                        var result;
                        result = {
                            'data' : data,
                            'count' : totalcount
                        };
                        LOGGER.debug(result)
                        return result;
                    })
                    .catch(err => util.logError(err));
                };

        Intakeserreqrestitutionpayment.remoteMethod(
        'restitutionpaymentsubmit',
        {
            http: {
            path: '/restitutionpaymentsubmit',
            verb: 'post'
            },
            accepts: [{
            arg: 'data',
            type: 'Object',
            http: {
                source: 'body'
            }
            }, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
            returns: {
            arg: 'data',
            type: 'Object'
            }
        });

    Intakeserreqrestitutionpayment.restitutionpaymentsubmit = function (data, reqctx) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        var securityuserid = data && data.securityuserid?data.securityuserid: _securityusersid;

        var tempReqStructure = JSON.stringify(data);
        var finalReqStructure = tempReqStructure.replace(/'/g, "''");

        var sql = 'SELECT * FROM saverestitutionpaymentsubmit($1,$2)';
        return runPaymentSql(sql, [finalReqStructure, securityuserid]);
    };


        
        Intakeserreqrestitutionpayment.remoteMethod(
            'approverestitutionpayment',
            {
                http: {
                path: '/approverestitutionpayment',
                verb: 'post'
                },
                accepts: [{
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body'
                }
                }, {
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  }],
                returns: {
                arg: 'data',
                type: 'Object'
                }
            });
    
        Intakeserreqrestitutionpayment.approverestitutionpayment = function (data, reqctx) {
            let _securityusersid = undefined;
            if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
              _securityusersid = reqctx.req.headers.securityusersid;
            }
            var tempReqStructure = JSON.stringify(data);
            var finalReqStructure = tempReqStructure.replace(/'/g, "''");

            var sql = 'SELECT * FROM approverestitutionpayment($1)';
            return runPaymentSql(sql, [finalReqStructure]);
        };
    

        Intakeserreqrestitutionpayment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
        Intakeserreqrestitutionpayment.observe('access', (ctx, next) => util.access(ctx, next));
        Intakeserreqrestitutionpayment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
