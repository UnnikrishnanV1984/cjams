'use strict';
const LOGGER = require("log4js").getLogger("splangoal");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Splangoal) {
// Splangoal changes to checkin
    Splangoal.addupdate = (request,reqctx) => {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
        const insertedon = new Date().toLocaleString();
        if(request.splangoalid == ''){
            request.splangoalid =null;
        }
        if (request.splangoalid == undefined || request.splangoalid == null || request.splangoalid == '') {
            request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            request.insertedon = insertedon;
           
            return Splangoal.create(request).then(res => {
               
                request.splangoalid = res.splangoalid;
                return request;
                
            });
        } else {
            return Splangoal.updateserviceplangoal(request,suserid);
        }
    };

    Splangoal.updateserviceplangoal = (request,suserid) => {
        return Splangoal.updateAll({
            splangoalid: request.splangoalid,
            serviceplanid: request.serviceplanid
        }, {
            goalname:request.goalname,
            status:request.status,
            activeflag:request.activeflag,
            updatedby: (request && request.securityuserid?request.securityuserid: suserid)
        }).then(data => {
            return request;
        })
    };



    Splangoal.list = function(request) {
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
   

    Splangoal.remoteMethod('addupdate', {
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


    Splangoal.remoteMethod('list', {
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

Splangoal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Splangoal.observe('access', (ctx, next) => util.access(ctx, next));
Splangoal.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}

