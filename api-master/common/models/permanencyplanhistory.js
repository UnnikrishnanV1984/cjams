'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Permanencyplanhistory) {

    Permanencyplanhistory.remoteMethod('list', {
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

    Permanencyplanhistory.list = (request) => {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }

        var personid = request.where.personid;
        var limit = request.limit;
        var totalcount = 0;
        var updatedfrom = '';
        var updatedto = '';
        var updatedby = '';
        var sortcol = '';
        var sortby = '';

        if (request.where.updatedfrom != undefined) {
            updatedfrom = request.where.updatedfrom;
        }
        if (request.where.updatedto != undefined) {
            updatedto = request.where.updatedto;
        }
        if (request.where.updatedby != undefined) {
            updatedby = request.where.updatedby;
        }
        if (request.where.sortcol != undefined) {
            sortcol = request.where.sortcol;
        }
        if (request.where.sortby != undefined) {
            sortby = request.where.sortby;
        }

        var sql = 'select * from getpermanencyhistory($1 , $2  ,$3, $4, $5,$6,$7,$8)';

        return util.executeDBQuery(sql, [personid, request.page, limit, sortcol, sortby
            , updatedfrom, updatedto, updatedby])
            .then(data => {
                if (data !== null && data.length > 0) { totalcount = data[0].totalcount; }
                var result;
                result = {
                    'data': data,
                    'count': totalcount
                };
                return result;
            })
            .catch(err => util.logError(err));
    };



    Permanencyplanhistory.remoteMethod('details', {
        http: {
            path: '/details',
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

    Permanencyplanhistory.details = (request) => {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }

        var personid = request.where.objectid;
        var sql = `select u2.fullname as phcaseworker, u1.fullname as fromuser, r.insertedon as routinginsert, u3.fullname as touser , ph.* from permanencyplanhistory ph 
        inner join userprofile u2 on u2.securityusersid = ph.insertedby 
        left join routing r on r.routingid = ph.objectid 
        left join userprofile u1 on u1.securityusersid = r.fromsecurityusersid
        left join userprofile u3 on u3.securityusersid = r.tosecurityusersid
        where permanencyplanid = $1 order by ph.updatedon desc`;

        return util.executeDBQuery(sql, [personid])
            .then(data => {
                if (data !== null && data.length > 0) {
                    return data;
                }
            })
            .catch(err => util.logError(err));
    };


    
    
    Permanencyplanhistory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Permanencyplanhistory.observe('access', (ctx, next) => util.access(ctx, next));
    Permanencyplanhistory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}