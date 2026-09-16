'use strict';
const LOGGER = require("log4js").getLogger("serviceplanneed");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Serviceplanneed) {


    Serviceplanneed.addupdate = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const insertedon = new Date().toLocaleString();
        const response = [];
        let updatePromise = Promise.resolve();
        if(request.splanobjectiveid!=null || request.splanobjectiveid!=undefined){
        var sql = 'UPDATE serviceplanneed SET activeflag=0 WHERE serviceplanfocusid = $1';
        updatePromise = util.executeDBQuery(sql, [request.splanobjectiveid]);
        }
        return updatePromise.then(() => {
        var arr = request.serviceplanneed;
        if(arr!=null){
        if (Array.isArray(arr)) {
            arr.forEach(element => {
                request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
                request.insertedon = insertedon;
                request.activeflag = true;
                request.serviceplanneedname = element;
                request.serviceplanfocusid = request.splanobjectiveid;

                response.push(
                    app.models.Serviceplanneed.create(request))
            })

        }
    }
    return Promise.all(response);
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Serviceplanneed.updateserviceplanneed = (request,suserid) => {
        var sql = 'UPDATE serviceplanneed SET activeflag=0 WHERE serviceplanfocusid = $1';
        return util.executeDBQuery(sql, [request.splanobjectiveid])
            .then(() => {
                request.serviceplanneedid = null;
                return Serviceplanneed.addupdate(request,suserid);
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    Serviceplanneed.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var intakeserviceid = request.where.intakeserviceid;
        var servicecaseid = request.where.servicecaseid;
        var totalcount = 0;
        let sql3;
        let paramsdata = [];
        if (request.servicecaseid == undefined || request.servicecaseid == null) {
            sql3 = 'select DISTINCT serviceplanneedname  from serviceplanneed where activeflag=1 and intakeserviceid = $1';
            paramsdata = [intakeserviceid];
        } else {
            sql3 = 'select DISTINCT serviceplanneedname from serviceplanneed where activeflag=1 and servicecaseid = $1 and intakeserviceid = $2';
            paramsdata = [servicecaseid,intakeserviceid];
        }

        return util.executeSecondaryNodeDBQuery(sql3, paramsdata)
            .then(data => {
                    if (data !== null && data.length > 0){ totalcount =  data.length;}
                    var result;
                    result = {
                        'data': data,
                        'count': totalcount
                    };
                    return result;
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    /**
     * Add multiple needs
     */
    Serviceplanneed.addneeds = (request,suserid) => {
        const insertedon = new Date().toLocaleString();
        const response = [];
        var arr = request.serviceplanneeds;

        if (Array.isArray(arr)) {
            arr.forEach(element => {
                request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
                request.insertedon = insertedon;
                request.activeflag = true;
                request.serviceplanneedname = element.needname;
                request.serviceplanneedvalue = element.needvalue;
                request.serviceplanneedsection = element.needsection;

                response.push(
                    app.models.Serviceplanneed.create(request))
            })
            return Promise.all(response);
        }
    };


    /**
     * Remote methods
     */
    Serviceplanneed.remoteMethod('addupdate', {
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
          } ],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplanneed.remoteMethod('list', {
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


    Serviceplanneed.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanneed.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanneed.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}