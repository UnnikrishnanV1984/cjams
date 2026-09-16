'use strict';
const LOGGER = require("log4js").getLogger("cinasibling");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Cinasibling) {

    Cinasibling.remoteMethod('list', {
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

    Cinasibling.list =(request)=> {
        if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
        var cinapetitionid = request.where.cinapetitionid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from Cinasibling where cinapetitionid=$1 limit $2 offset $3';
	
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


    
    
    Cinasibling.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Cinasibling.observe('access', (ctx, next) => util.access(ctx, next));
    Cinasibling.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}