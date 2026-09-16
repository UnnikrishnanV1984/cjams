'use strict';
const LOGGER = require("log4js").getLogger("youthtransitionplan");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(YouthTransitionPlan) {
    const AUDIT_TYPE_KEY = 'youthtransitionplan';

    YouthTransitionPlan.addupdate = (request,reqctx) => {
        let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }
            const insertedon = new Date().toLocaleString();
            request.activeflag=true;
            if(request.youthtransitionplanid == undefined || request.youthtransitionplanid == null) {
               request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
               request.insertedon = insertedon;
               return YouthTransitionPlan.create(request);
            } else {
              request.updatedby = (request && request.securityuserid?request.securityuserid: suserid);
              request.updatedon = insertedon;
              return YouthTransitionPlan.updatesYouthTransitionPlan(request);
            }
      };
  

      function createYtpAuditRow(youthtransitionplanid) {
        if (!youthtransitionplanid) {
          return Promise.resolve();
        }
      
        return util.generateAuditData(AUDIT_TYPE_KEY, youthtransitionplanid)
          .then(() => undefined);
      }
      
    YouthTransitionPlan.updatesYouthTransitionPlan = (request) => {
        return YouthTransitionPlan.updateAll(
           {
               youthtransitionplanid: request.youthtransitionplanid
           },
           {
               documentationjson: request.documentationjson,
               sraccjson: request.sraccjson,
               healthjson: request.healthjson,
               moneymanagementjson: request.moneymanagementjson,
               housingjson: request.housingjson,
               educationjson: request.educationjson,
               employmentjson: request.employmentjson,
               strengths: request.strengths,
               issueconcerns: request.issueconcerns,
               servicedeliveryneeds: request.servicedeliveryneeds,
               clientid:request.clientid,
               intakeserviceid: request.intakeserviceid,
               sevicecaseid:request.sevicecaseid,
               updatedby:request.updatedby,
               updatedon:request.updatedon
           }).then (data => {
               return data;
           })
   };
   YouthTransitionPlan.list = function(request) {
     if (!request.limit || request.limit < 100) {
       request.limit = 100;
   }
       if (request.page !== 'undefined') {
                 request.skip = (request.page - 1) * request.limit;
           }

       var clientid = request.where.clientid;
       var sql = 'select ytp.*, up.fullname as approvedBy from youthtransitionplan ytp left join userprofile up on up.securityusersid = ytp.updatedby where ytp.clientid=$1 ' ;

       var params = [];
       params.push(clientid);
       LOGGER.debug(params);
       if(request.where.intakeserviceid){
           sql = sql + ' and  ytp.intakeserviceid=$2';
           params.push(request.where.intakeserviceid);
       } else {
           sql = sql + ' and  ytp.sevicecaseid=$2';
           params.push(request.where.sevicecaseid);
       }
       if(request.where.fromdate!= null && request.where.todate!=null) {
           sql = sql + 'and  $3 <= ytp.insertedon::date and $4 >= ytp.insertedon::date order by ytp.insertedon desc';
           params.push(request.where.fromdate);
           params.push(request.where.todate);
       }
       else {
         sql = sql + ' order by ytp.insertedon desc limit $3 offset $4 ';
         params.push(request.limit);
         params.push(request.skip);
       }
       LOGGER.debug(params);
       LOGGER.debug(sql);
       return util.executeDBQuery(sql, params)
           .then(data => data)
           .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
   };

   YouthTransitionPlan.youthTransitionPlanRouting = function (request,reqctx) {
     const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
       var userid = suserid;
       var applicantId=request.objectid; // This is intakeserviceid
       var toUserID=request.tosecurityusersid;
       var eventcode="YTP";
       var serviceNumber=request.serviceNumber;
       var ytpID=request.serviceplanid;
       var returnNote=request.returnreason;
       var status = 15;
       var nofitymsg = 'Youth Transition Plan Submitted for review';
       LOGGER.debug(nofitymsg);
       if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "return") {
         status = 17;
         nofitymsg = 'Youth Transition Plan Return ';
       }
       else if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "approved") {
         status = 16;
         nofitymsg = 'Youth Transition Plan Approved ';
       }
       LOGGER.debug(nofitymsg);

       if(!applicantId){
         applicantId ='';
       }

       if(!toUserID){
         toUserID='';
       }

       if(!eventcode){
         eventcode='';
       }

       if(!serviceNumber){
           serviceNumber=0;
       }

       if(!ytpID){
           ytpID = '';
       }

       var sql = 'select * from publiccaseplanrouting($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)';
       LOGGER.debug(sql);
       LOGGER.debug(applicantId, userid,toUserID, status,eventcode, nofitymsg,serviceNumber,ytpID,request.approvalstatustypekey,returnNote);
       return util.executeDBQuery(sql, [applicantId, userid,toUserID, status,eventcode, nofitymsg,nofitymsg,serviceNumber,ytpID,request.approvalstatustypekey,returnNote])
         .then(data => ({
             action: request.approvalstatustypekey.toLowerCase(), // return "return" or "approved"
             data: data
         }))
         .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
     }

     YouthTransitionPlan.importYTPtoSP = function (request,reqctx) {
       let suserid = undefined;
       if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
         suserid = reqctx.req.headers.securityusersid
       }
       var userId = (request && request.securityuserid?request.securityuserid: suserid);
       var servicePlanID=request.servicePlanID; // This is intakeserviceid
       var ytpID=request.ytpID;
       var sql = 'select * from importytptoserviceplan($1,$2,$3)';
       LOGGER.debug(sql);
       LOGGER.debug(ytpID,servicePlanID,userId);
       return util.executeDBQuery(sql, [ytpID,servicePlanID,userId])
         .then(data1 => ({ data: data1 }))
         .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
     }

   YouthTransitionPlan.remoteMethod('youthtransitionplandelete', {
     accepts: {
         arg: 'filter',
         type: 'Object',
         http: {
             source: 'query'
         },
         required: true
     },
     http: {
         path: '/youthtransitionplandelete',
         verb: 'get'
     },
     returns: {
         type: 'Object',
         root: true
     }
 });

 YouthTransitionPlan.youthtransitionplandelete = function (request) {
     var sql = 'delete from youthtransitionplan where youthtransitionplanid =$1';
     var params = [request.where.id];

     return util.executeDBQuery(sql, params)
         .then(data => {
             return "Record deleted succesfully";
         })
         .catch(err => {
             LOGGER.error('>>>>ERROR:', err);
             throw err;
         });

 };

   YouthTransitionPlan.remoteMethod('addupdate', {
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


   YouthTransitionPlan.remoteMethod('list', {
       http: {
           path: '/list',
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

   YouthTransitionPlan.remoteMethod(
       'youthTransitionPlanRouting', {
         http: {
           path: '/youthTransitionPlanRouting',
           verb: 'post'
         },
         accepts:[ {
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
       }
     );

     YouthTransitionPlan.remoteMethod(
       'importYTPtoSP', {
         http: {
           path: '/importYTPtoSP',
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
       }
     );


   YouthTransitionPlan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
   YouthTransitionPlan.observe('access', (ctx, next) => util.access(ctx, next));
   YouthTransitionPlan.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    YouthTransitionPlan.observe('after save', (ctx, next) => {
        if (ctx.options && ctx.options.skipAudit) {
            return next();
        }

        var inst = ctx.instance || ctx.currentInstance;
        var ytpId =
            (inst && inst.youthtransitionplanid) ||
            (ctx.where && ctx.where.youthtransitionplanid);

        if (!ytpId && inst && inst.id) {
            ytpId = inst.id;
        }

        if (!ytpId) {
            LOGGER.warn('after save: youthtransitionplanid not found in ctx.instance/ctx.where');
            return next();
        }

        LOGGER.debug('after save YTP audit for id =', ytpId);

        createYtpAuditRow(ytpId)
            .then(() => next())
            .catch((err) => {
                LOGGER.error('after save audit call failed for YouthTransitionPlan', err);
                next();
            });
    });

};