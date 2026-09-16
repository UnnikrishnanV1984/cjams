'use strict';
const LOGGER = require("log4js").getLogger("splanobjective");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Splanobjective) {

    Splanobjective.addupdate = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const insertedon = new Date().toLocaleString();
        var strengths= request.serviceplanstrength;
        var needs= request.serviceplanneed;
        var intakeserviceid = request.intakeserviceid;
        if(request.splanobjectiveid == ''){
            request.splanobjectiveid =null;
        }
        if (request.splanobjectiveid == undefined || request.splanobjectiveid == null || request.splanobjectiveid == '') {
            request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            request.insertedon = insertedon;
           
            return Splanobjective.create(request).then(res => {
               
                request.splanobjectiveid = res.splanobjectiveid;
                return app.models.Serviceplanneed.addupdate(request).then(res1 => {
                        return app.models.Serviceplanstrength.addupdate(request).then(res2 => {
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
            return Splanobjective.updateserviceplanfocus(request,suserid);
        }
    };

    Splanobjective.updateserviceplanfocus = (request,suserid) => {
        var strengths= request.serviceplanstrength;
        var needs= request.serviceplanneed;

        return Splanobjective.updateAll({
            splanobjectiveid: request.splanobjectiveid,
            splangoalid: request.splangoalid
        }, {
            objectivename:request.objectivename,
            comments:request.comments,
            status:request.status,
            activeflag:request.activeflag,
            needs:request.needs,
            strengths:request.strengths,
            updatedby: (request && request.securityuserid?request.securityuserid: suserid)
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



    Splanobjective.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var splangoalid = request.where.splangoalid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from splanobjective where splangoalid=$1 limit $2 offset $3';

        return util.executeDBQuery(sql, [splangoalid, request.page, request.skip])
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
   

    Splanobjective.remoteMethod('addupdate', {
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
        }
        ,{
                  arg: 'reqctx',
                  type: 'object',
                  http: {source: 'context'}
                }],
        returns: {
            type: 'object',
            root: true
        }
    });


    Splanobjective.remoteMethod('list', {
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

Splanobjective.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Splanobjective.observe('access', (ctx, next) => util.access(ctx, next));
Splanobjective.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}

