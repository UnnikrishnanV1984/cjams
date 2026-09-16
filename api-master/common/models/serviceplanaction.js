'use strict';
const LOGGER = require("log4js").getLogger("serviceplanaction");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Serviceplanaction) {

    Serviceplanaction.addupdate = (request,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        const insertedon = new Date().toLocaleString();
        var person= request.personinvolved;
        if(request.serviceplanactionid == ''){
            request.serviceplanactionid =null;
        }
        if (request.serviceplanactionid == undefined || request.serviceplanactionid == null) {
            request.insertedby = suserid;
            request.insertedon = insertedon;
            request.activeflag = true;
            return Serviceplanaction.create(request).then(res => {

                request.serviceplanactionid = res.serviceplanactionid;
                return app.models.Serviceplanpersoninvolved.addupdate(request).then(res1 => {
                    request.personinvolved=null;
                    request.personinvolved=person;
                    return request;
                })
            })
        } else {
            if (request.activeflag === 0) {
                var sql = 'select * from deletesplanaction($1,$2);';
                return util.executeDBQuery(sql, [request.serviceplanactionid, suserid])
                .then(data => data)
                .catch(err => util.logError(err));
            } else {
                return Serviceplanaction.updateserviceplanaction(request,suserid);
            }
        }
    };

    Serviceplanaction.updateserviceplanaction = (request,suserid) => {

        return Serviceplanaction.updateAll({
            serviceplanactionid: request.serviceplanactionid,
            splanobjectiveid: request.splanobjectiveid
        }, {
            serviceplanactionname: request.serviceplanactionname,
         //   personinvolved: request.personinvolved,
            personresponsible: request.personresponsible,
            startdate: request.startdate,
            enddate: request.enddate,
            status: request.status,
            activeflag: request.activeflag,
            updatedby: suserid,
            comments:request.comments,
            goalreason: request.goalreason
        }).then(data => {
            return app.models.Serviceplanpersoninvolved.updateserviceplanpersoninvolved(request,suserid).then(res => {
                return request;
            })
             
        })
    };

    Serviceplanaction.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var splanobjectiveid = request.where.splanobjectiveid;
        var totalcount = 0;
        var sql = 'select count(1) over() as totalcount,* from serviceplanaction where where activeflag=1 and splanobjectiveid=\'' + splanobjectiveid + '\'';

        return util.executeDBQuery(sql, [])
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

    Serviceplanaction.remoteMethod('addupdate', {
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


    Serviceplanaction.remoteMethod('list', {
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


    Serviceplanaction.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanaction.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanaction.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}
