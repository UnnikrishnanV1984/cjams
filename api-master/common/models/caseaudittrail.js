'use strict';
const errorUtils = require('../../server/utils/error-utils');
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Caseaudittrail) {    
   
    Caseaudittrail.remoteMethod('list', {
        http: {
                path: '/list',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: 'application/json',
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
            type : 'string',
            root : true
        }
    });

    Caseaudittrail.list = (request, reqctx, req) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const objecttype = request.where.objecttype;
        const objectKey = request.where.objectKey;
        const module = request.where.module;
        const fromDate = request.where.fromDate;
        const toDate = request.where.toDate;
        const selecteduser = request.where.selecteduser ? request.where.selecteduser : null;
        const pageno = request.page;
        const pagesize = request.limit;
        const sort = request.where.sorting;
        const action = request.where.sortcolumn;
        const clientid = (request.where.module == 'Medication_Psychotropic' || request.where.module == 'Health_Conditions' || request.where.module == 'Person Health Summary') && request.where.clientid ? request.where.clientid : null;

        var sql = 'select *from getpageauditloglist($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)';
        return util.executeSecondaryNodeDBQuery(sql, [objecttype,objectKey, module,selecteduser, clientid,fromDate,toDate,pageno,pagesize,sort,action]).then((data)=>{
            return data;
        }).catch((err)=>{
            LOGGER.error('>>>>ERROR:', err);
            util.logError(err);
            throw err;
        });
    }


    Caseaudittrail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Caseaudittrail.observe('access', (ctx, next) => util.access(ctx, next));
    Caseaudittrail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}   