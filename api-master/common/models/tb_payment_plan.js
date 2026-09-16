'use strict';
const LOGGER = require("log4js").getLogger("tb_payment_plan");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_payment_plan) {
      
    
    Tb_payment_plan.remoteMethod('getPaymentPlan', {
            accepts :[ {
           arg : 'filter',
           type : 'Object',
           http : {
           source : 'query'
           },
           required : true
           }
           ,{
                     arg: 'reqctx',
                     type: 'object',
                     http: {source: 'context'}
                   } ],
           http : {
           path: '/getPaymentPlan',
           verb : 'get'
           },
           returns : {
           type : 'Object',
           root : true
           }
           });
       
       

    Tb_payment_plan.getPaymentPlan = function(request,reqctx){

        const skip = (request.page - 1) * request.limit;
        const limit = request.limit;
        const sql = `SELECT count(1) over() as totalcount,
          payment_plan_id, 
          plan_dt,
          pp.delete_sw,
            pp.receivable_id, 
            coalesce(pp.amount_no,0)
            - 
            (	select coalesce(sum(trdd.receivable_balance_no),0) 
              from tb_receivable_detail trdd 
            where trdd.receivable_detail_id :: character varying 
                    in 
              (	select objectid 
                from routing r1
                  join tb_receivable_detail trde on trde.receivable_detail_id::character varying = r1.objectid
                  join tb_receivable_header trhr on trhr.receivable_id=trde.receivable_id
                where r1.eventcode = 'MANREC' 
                  and trhr.provider_id = $1
                  and trhr.receivable_id =rh.receivable_id
                  and r1.routingstatustypeid  in (73,75) 
                  and r1.activeflag = 1 
              )
             ) as amount_no,
           pp.percentage_no, 
           pp.months_no, 
           pp.start_dt,  
             pp.end_dt, 
           pp.offset_sw, 
           pp.payment_option_sw, 
           pp.offset_option_sw, 
             coalesce(current_receivable_amount,0)
             - 
             (select coalesce(sum(trdd.receivable_balance_no),0) 
            from tb_receivable_detail trdd 
            where trdd.receivable_detail_id :: character varying 
                in 
              (	select objectid from routing r1
                  join tb_receivable_detail trde on trde.receivable_detail_id :: character varying = r1.objectid
                  join tb_receivable_header trhr on trhr.receivable_id = trde.receivable_id
                where r1.eventcode = 'MANREC' and trhr.provider_id = $1
                  and trhr.receivable_id =rh.receivable_id
                  and r1.routingstatustypeid  in (73,75) 
                  and r1.activeflag = 1 
              )
            ) as current_receivable_amount, 
          coalesce(up.fullname,'Finance') as entered_by,
          (case when exists (select * from tb_placement tp 
                      join tb_receivable_header trh on trh.provider_id = tp.provider_id 
                      join tb_receivable_detail trd on trd.receivable_id = trh.receivable_id 
                      join tb_receivable_collection_status trcs on trcs.receivable_detail_id = trd.receivable_detail_id
                    where tp.provider_id=rh.provider_id 
                      and tp.exit_dt is null) then true else false end) as placementexists 
            ,case when coalesce((select trd.approval_status_cd 
                      from tb_receivable_detail trd 
                    where trd.receivable_id = rh.receivable_id 
                      and trd.manual_sw = 'Y' 
                    limit 1) ,'') = '' then '3047' 
           else 
                 (select trd.approval_status_cd 
              from tb_receivable_detail trd 
              where trd.receivable_id = rh.receivable_id 
              and trd.manual_sw = 'Y' 
              limit 1) 
           end as approvalstatus 
        FROM tb_payment_plan pp 
          join tb_receivable_header rh on rh.receivable_id = pp.receivable_id 
            left join userprofile up on up.securityusersid = pp.create_user_id 
        where rh.provider_id = $1 
          and pp.delete_sw = $4 
        order by pp.start_dt desc	
        limit $3 offset $2`;
         //and  pp.delete_sw='N'
        return util.executeDBQuery(sql,[request.where.providerid,skip,limit,request.where.is_history])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_payment_plan.remoteMethod('paymentplanedit', {
        http: {
                path: '/paymentplanedit',
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
  
    Tb_payment_plan.paymentplanedit = function(request,reqctx)
    {  let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }
  
        var insertedby = (request && request.securityuserid?request.securityuserid: suserid);
        var inputjson = request;
        inputjson.securityusersid = insertedby;
        LOGGER.debug(JSON.stringify(inputjson)+"inputjson");
        const sql = 'select * from paymentplanedit($1)';
        return util.executeDBQuery(sql,[inputjson])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
  
  
    Tb_payment_plan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_payment_plan.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_payment_plan.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
