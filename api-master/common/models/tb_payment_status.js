'use strict';
const LOGGER = require("log4js").getLogger("tb_payment_status");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Tb_payment_status) {



    Tb_payment_status.ancillarysupervisorapprove = function (request,reqctx) {
        const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
        const payment_id = request.payment_id;
        const fromsecurityusersid = request.fromsecurityusersid;
        const intakeserviceid = request.intakeserviceid;
        const insertedon = new Date().toLocaleString();
        return Tb_payment_status.updateAll({
            payment_id: request.payment_id
        },
            {
                payment_status_cd: '1634',
                update_user_id: suserid,
                update_ts: insertedon
            }).then(res => {
                LOGGER.debug(payment_id);
                LOGGER.debug(suserid + "(request && request.securityuserid?request.securityuserid: suserid)");
                LOGGER.debug(JSON.stringify(request) + "request.paymentid");
                LOGGER.debug(payment_id + "payment_id");
                var comments = 'Ancillary payment Approved';
                var sql = 'select * from routingfinance($1,$2,$3,$4,$5)';
                return util.executeDBQuery(sql,[payment_id,suserid,'ANPAYADAPP',52,comments]);

            }
            ).then(res => {

                var comments = 'Ancillary payment Approved';
                var sql = 'select * from send_notification($1,$2,$3,$4,$5,$6,$7,$8)';
                return util.executeDBQuery(sql,[fromsecurityusersid,suserid,fromsecurityusersid,'System','High',comments,comments,intakeserviceid])

                    .then(_res => {
                        var sql1 = "select * from updatacceobligation($1)"
                        request.securityusersid = suserid;
                        return util.executeDBQuery(sql1,[request]);
                    })
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });



    };

Tb_payment_status.remoteMethod('ancillarysupervisorapprove', {
    http: {
            path: '/ancillarysupervisorapprove',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}},{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
    returns: {
        type : 'string',
        root : true
    }
});

Tb_payment_status.remoteMethod('paymentafsfmis', {
    http: {
        path: '/paymentafsfmis',
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

Tb_payment_status.paymentafsfmis = function(request){

    var sql = "select * from get_paymentafsfmis($1,$2,$3,$4,$5)"
    return util.executeDBQuery(sql, [request.where.payment_id,request.page,request.limit,request.fmspage,request.fmslimit]).then(res =>{
        return res
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

Tb_payment_status.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Tb_payment_status.observe('access', (ctx, next) => util.access(ctx, next));
Tb_payment_status.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
