'use strict';
const LOGGER = require("log4js").getLogger("serviceplanfocus");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Serviceplanfocus) {

    Serviceplanfocus.addupdate = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const insertedon = new Date().toLocaleString();
        var strengths= request.serviceplanstrength;
        var needs= request.serviceplanneed;
        var intakeserviceid = request.intakeserviceid;
        if(request.serviceplanfocusid == ''){
            request.serviceplanfocusid =null;
        }
        if (request.serviceplanfocusid == undefined || request.serviceplanfocusid == null || request.serviceplanfocusid == '') {
            request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            request.insertedon = insertedon;
           
            return Serviceplanfocus.create(request).then(res => {
               
                request.serviceplanfocusid = res.serviceplanfocusid;
                return app.models.Serviceplanneed.addupdate(request,suserid).then(res1 => {
                        return app.models.Serviceplanstrength.addupdate(request,suserid).then(res2 => {
                            request.strengths=null;
                            request.needs=null;
                            request.strengths=strengths;
                            request.needs=needs;
                            request.intakeserviceid=intakeserviceid;
                            return request;
                        });
                    }
                );
            });
        } else {
            return Serviceplanfocus.updateserviceplanfocus(request,suserid);
        }
    };

    Serviceplanfocus.updateserviceplanfocus = (request,suserid) => {
        var strengths= request.serviceplanstrength;
        var needs= request.serviceplanneed;

        return Serviceplanfocus.updateAll({
            serviceplanfocusid: request.serviceplanfocusid,
            serviceplanid: request.serviceplanid
        }, {
            focusname:request.focusname,
            activeflag:request.activeflag,
            updatedby: (request && request.securityuserid?request.securityuserid: suserid),
            updatedon: new Date().toLocaleString()
        }).then(data => {
            return app.models.Serviceplanneed.updateserviceplanneed(request,suserid).then(res => {
                return app.models.Serviceplanstrength.updateserviceplanstrength(request,suserid).then(res3 => {
                    request.serviceplanstrength=null;request.serviceplanneed=null;
                    request.strengths=strengths;
                    request.needs=needs;
                    return request;
                });
            })

        })
    };



    Serviceplanfocus.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var serviceplanid = request.where.serviceplanid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from serviceplanfocus where serviceplanid=$1 limit $2 offset $3';

        return util.executeDBQuery(sql, [serviceplanid, request.page, request.skip])
            .then(data => {
                    if (data !== null && data.length > 0) {totalcount = data[0].totalcount;}
                    var result;
                    result = {
                        'data': data,
                        'count': totalcount
                    };
                    return result;
            })
            .catch(err => util.logError(err));
    };
   
    Serviceplanfocus.remoteMethod('addupdate', {
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


    Serviceplanfocus.remoteMethod('list', {
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


    Serviceplanfocus.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanfocus.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanfocus.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}
