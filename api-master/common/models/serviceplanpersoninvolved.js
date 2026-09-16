'use strict';
const LOGGER = require("log4js").getLogger("serviceplanpersoninvolved");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Serviceplanpersoninvolved) {

    Serviceplanpersoninvolved.addupdate = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const insertedon = new Date().toLocaleString();
        const response = [];
        var result = [];
       var sql = 'UPDATE serviceplanpersoninvolved SET activeflag=0 WHERE serviceplanactionid = $1';
        return util.executeDBQuery(sql, [request.serviceplanactionid])
            .then(() => {
            var arr = request.serviceplanpersoninvolved;
            if(arr!=null){
            if (Array.isArray(arr)) {
                arr.forEach(element => {
                    request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
                    request.insertedon = insertedon;
                    request.activeflag = true;
                    request.personinvolved = element;
                    response.push(
                        app.models.Serviceplanpersoninvolved.create(request))
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

    Serviceplanpersoninvolved.updateserviceplanpersoninvolved = (request,suserid) => {
        var sql = 'UPDATE serviceplanpersoninvolved SET activeflag=0 WHERE serviceplanpersoninvolvedid = $1';
        return util.executeDBQuery(sql, [request.serviceplanactionid])
            .then(() => {
                request.serviceplanpersoninvolvedid=null;
                return Serviceplanpersoninvolved.addupdate(request,suserid);
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    Serviceplanpersoninvolved.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var serviceplanactionid = request.where.serviceplanactionid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from serviceplanpersoninvolved where activeflag=1 and serviceplanactionid = $1';

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

    Serviceplanpersoninvolved.remoteMethod('addupdate', {
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


    Serviceplanpersoninvolved.remoteMethod('list', {
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


    Serviceplanpersoninvolved.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanpersoninvolved.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanpersoninvolved.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}
