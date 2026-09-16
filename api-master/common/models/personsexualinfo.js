'use strict';
const util = require('../utils/utils');
let server = require('../../server/server');
let app = require('../../server/server');
const moment = require('moment');
const LOGGER = require('log4js').getLogger("personsexualinfo");
module.exports = function(Personsexualinfo) {

    Personsexualinfo.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
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

    Personsexualinfo.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if(request.personsexualinfoid== null || request.personsexualinfoid == undefined)
        {   
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);

            return Personsexualinfo.create(request)
            .then(res => res)
            .catch(err => util.logError(err));
        }
        else
        {
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            return Personsexualinfo.updateAll({personsexualinfoid:request.personsexualinfoid},request)
            .catch(err => util.logError(err));
        }
    };
 


    Personsexualinfo.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Personsexualinfo.list = request =>{
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        let limit = request.limit;
        if(!request.skip){
            request.skip=1
        }
        if(!limit){
            limit=10
        }
        let totalcount = 0;
        let sql = 'select * from getpersonsexualinfofilter($1,$2,$3)';

        return util.executeSecondaryNodeDBQuery(sql, [request.where, request.skip,limit])
            .then(data => {
                if (data !== null && data.length > 0) {
                    totalcount = data[0].totalcount;
                }
                let result;
                result = {
                    'personsexualinfo': data,
                    'count': totalcount
                };
                return result;
            })
            .catch(err => {
                return LOGGER.error('>>>>ERROR:', err);
            });
    }

    Personsexualinfo.getpregnants = function (request, reqctx) {
        return util.executeSecondaryNodeDBQuery('select * from getpregnants($1)', [request?.where?.v_pids])
            .then(data => data)
           .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
	};

	Personsexualinfo.remoteMethod('getpregnants', {
        accepts : [{
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
        }],
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Personsexualinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personsexualinfo.observe('access', (ctx, next) => util.access(ctx, next));
    Personsexualinfo.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PSEXINFO',
    (ctx.isNewInstance || (ctx.instance && ctx.instance.personid)) ? ctx.instance.personid : ctx.where.personid));
    Personsexualinfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}