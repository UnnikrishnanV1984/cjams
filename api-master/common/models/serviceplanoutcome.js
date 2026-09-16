'use strict';
const LOGGER = require("log4js").getLogger("serviceplanoutcome");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Serviceplanoutcome) {

    Serviceplanoutcome.addupdate = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const insertedon = new Date().toLocaleString();
        const response = [];
        let result = [];

        var sql = 'UPDATE serviceplanoutcome SET activeflag=0 WHERE serviceplanactionid = $1';
        return util.executeDBQuery(sql, [request.serviceplanactionid])
            .then(() => {
            var arr = request.serviceplanoutcomename;
            if(arr!=null){
            if (Array.isArray(arr)) {
                arr.forEach(element => {
                    request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
                    request.insertedon = insertedon;
                    request.activeflag = true;
                    request.serviceplanoutcomename = element;
                    response.push(
                        app.models.Serviceplanoutcome.create(request));
                })
                Promise.all(response).then(function(values) {
                     values.map(x => {
                        result.push(x);
                    });
                });
                LOGGER.info(result);

            }

        }
        return Promise.all(response);
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    Serviceplanoutcome.updateserviceplanoutcome = (request) => {
        var sql = 'UPDATE serviceplanoutcome SET activeflag=0 WHERE serviceplanactionid = $1';
        return util.executeDBQuery(sql, [request.serviceplanactionid])
            .then(() => {
                request.serviceplanoutcomeid=null;
                return Serviceplanoutcome.addupdate(request);
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };



    Serviceplanoutcome.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var serviceplanactionid = request.where.serviceplanactionid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from serviceplanoutcome where activeflag=1 and serviceplanactionid = $1';

        return util.executeDBQuery(sql, [serviceplanactionid])
            .then(data => {
                    if (data !== null && data.length > 0) {totalcount = data[0].totalcount;}
                    var result;
                    result = {
                        'data': data,
                        'count': totalcount
                    };
                    return result;
            })
            .then(data => data)
            .catch(err => util.logError(err));
    };

    Serviceplanoutcome.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplanoutcome.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplanoutcome.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanoutcome.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanoutcome.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}
