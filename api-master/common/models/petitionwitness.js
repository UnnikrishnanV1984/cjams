'use strict';
const LOGGER = require("log4js").getLogger("petitionwitness");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Petitionwitness) {

    Petitionwitness.remoteMethod('list', {
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

    Petitionwitness.list =(request)=> {
        if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
        var petitionid = request.where.petitionid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from Petitionwitness where petitionid=$1 limit $2 offset $3';

		return util.executeDBQuery(sql, [petitionid, request.page, request.skip])
		.then(data => {
                    if (data!==null && data.length>0) {totalcount= data[0].totalcount;}
                    var result;
                    result = {
                        'data' : data,
                        'count' : totalcount
                    };
					return result;
		})
		.catch(err => util.logError(err));
    };


    
    
    Petitionwitness.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Petitionwitness.observe('access', (ctx, next) => util.access(ctx, next));
    Petitionwitness.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
