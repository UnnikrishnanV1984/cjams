'use strict';
const LOGGER = require("log4js").getLogger("cinasubpoenad");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Cinasubpoenad) {

    Cinasubpoenad.remoteMethod('list', {
        http: {
            path: '/list',
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

   Cinasubpoenad.list =(request)=> {
        if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
        var cinapetitionid = request.where.cinapetitionid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from Cinasubpoenad where cinapetitionid=$1 limit $2 offset $3';
		
		return util.executeSecondaryNodeDBQuery(sql, [cinapetitionid, request.limit, request.skip]).then((data) => {
                if (data!==null && data.length>0) {
                    totalcount= data[0].totalcount;
                }
                var result;
                result = {
                    'data' : data,
                    'count' : totalcount
                };
                return result;
            }).catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };


    
    
    Cinasubpoenad.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Cinasubpoenad.observe('access', (ctx, next) => util.access(ctx, next));
    Cinasubpoenad.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}