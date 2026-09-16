'use strict';

const LOGGER = require("log4js").getLogger("tb_fmis_pmnt_vendor_dt");

const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Fmis_payment_vendor_date) {

      Fmis_payment_vendor_date.remoteMethod('Fmis_payment_vendor_date_update', {
        http: {
                path: '/Fmis_payment_vendor_date_update',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }
         ],
        returns: {
            type : 'object',
            root : true
        
    }
    });

    Fmis_payment_vendor_date.remoteMethod('Fmis_payment_vendor_date_update_audit', {
        http: {
                path: '/Fmis_payment_vendor_date_update_audit',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });
    
    Fmis_payment_vendor_date.remoteMethod('Fmis_payment_vendor_date_year_list', {
        http: {
                path: '/Fmis_payment_vendor_date_year_list',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Fmis_payment_vendor_date.remoteMethod('Fmis_payment_vendor_date_nxtyr_update', {
        http: {
                path: '/Fmis_payment_vendor_date_nxtyr_update',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }  ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Fmis_payment_vendor_date.Fmis_payment_vendor_date_update = function(request,reqctx){
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }

var obj = [];
obj = request.yearsObj;
    var promises = obj.map(element => {
        var p_year = element.year;
        var p_month = element.month;
        var p_vendor_file_1_dt = element.vendor_file_1_dt;
        var p_pay_file_1_dt = element.pay_file_1_dt;
        var p_vendor_file_2_dt = element.vendor_file_2_dt;
        var p_pay_file_2_dt = element.pay_file_2_dt;
        var securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
        var comments_tx = element.comments_tx;
        var sql = "select * from update_fmis_vendor_payment_Date($1,$2,$3,$4,$5,$6,$7,$8)"

    return util.executeDBQuery(sql, [p_year,p_month,p_vendor_file_1_dt,p_pay_file_1_dt,p_vendor_file_2_dt,p_pay_file_2_dt,comments_tx,securityuserid]);

    });
    return Promise.all(promises)
    .then(res => {
    return res;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

    

    Fmis_payment_vendor_date.Fmis_payment_vendor_date_update_audit = function(request){
		var p_yr = request.year;
		var p_mth = request.month;

            var sql = "select * from update_fmis_vendor_payment_Date_audit($1,$2)"
            return util.executeDBQuery(sql, [p_yr,p_mth])
        .then(res => {
            return res;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Fmis_payment_vendor_date.Fmis_payment_vendor_date_year_list = function(request){
            var sql = "select distinct year_no from tb_fmis_pmnt_vendor_dt where year_no is not null and teamtypekey = 'CW' order by year_no asc"
            return util.executeDBQuery(sql, [])
        .then(res => {
            return res;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Fmis_payment_vendor_date.Fmis_payment_vendor_date_nxtyr_update = function(request,reqctx){
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		var p_yr = request.year;
		var p_userid = (request && request.securityuserid?request.securityuserid: suserid);

            var sql = "select update_fmis_vendor_payment_nxtyr_update($1,$2)"
            return util.executeDBQuery(sql,[p_yr,p_userid])
        .then(res => {
            return res;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
 
    Fmis_payment_vendor_date.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Fmis_payment_vendor_date.observe('access', (ctx, next) => util.access(ctx, next));
    Fmis_payment_vendor_date.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
