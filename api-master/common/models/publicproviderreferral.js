'use strict';
const LOGGER = require("log4js").getLogger("publicproviderreferral");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('../models/email');

module.exports = function (Publicproviderreferral) {

    Publicproviderreferral.getproviderapplicanthousehold =function(request){
        var referralId = request.where.referral_id;

        var sql = 'SELECT * FROM tb_public_provider_referral_household where referral_id=$1 order by referral_id desc';

        return util.executeDBQuery(sql,[referralId])
          .then(data => {return {data : data};})
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      };
    
      Publicproviderreferral.remoteMethod(
        'getproviderapplicanthousehold', 
        {
          accepts : {
            arg : 'data',
            type : 'object',
            http : {
              source : 'body'
            },
          },
          http: {
            path: '/getproviderapplicanthousehold',
            verb: 'POST'
          },
          returns : {
            type : 'object',
            root : true
          }
        }
        );


        Publicproviderreferral.addproviderapplicanthousehold =function(request,reqctx){
          let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
            request.create_ts= new Date();
            request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);

            var newJsonDataStringyfied = JSON.stringify(request);
            LOGGER.debug('dheeraj\' s log '+ newJsonDataStringyfied);
            if (request!=null && request!=undefined)
            {
              var addprovservices = 'select * from addproviderreferralhousehold($1)';
              return util.executeDBQuery(addprovservices,[newJsonDataStringyfied])
                .then(data => data)
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            }
              return Promise.resolve({ data: null, message: 'Invalid request' });
          };
                    
          Publicproviderreferral.remoteMethod(
                'addproviderapplicanthousehold', 
                      {
                        http: {
                            path: '/addproviderapplicanthousehold',
                            verb: 'post'
                        },
                        accepts : [ {arg : 'data',type : 'object',
                            http : {source : 'body'}},{
                              arg: 'reqctx',
                              type: 'object',
                              http: {source: 'context'}
                            } ],   
                        returns: {
                          type : 'object',
                        root : true
                        }
                        }
              );


        Publicproviderreferral.approvepublicproviderreferral =function(request,reqctx){
          const suserid = util.getSecurityDetails(request, reqctx).securityuserid;

                var referralId = request.referral_id;
                var applicationId = referralId;
                applicationId = applicationId.replace('R', 'A');

                request.create_ts= new Date();
                request.create_user_id =  suserid;
                request.applicant_id = applicationId;

                var newJsonDataStringyfied = JSON.stringify(request);

                if (request!=null && request!==undefined)
                {


                    if (request.referral_status == 'accepted' && request.tosecurityusersid !== null && request.tosecurityusersid !== undefined){

                     var sqlc = 'select * from publicproviderrouting($1,$2,$3,$4,$5,$6,$7)';
                     return util.executeDBQuery(sqlc,[applicationId, suserid,request.tosecurityusersid,84,'PRASS','A new Inquiry Submitted',request.comments])
                        .then(data2 => data2)
                        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                   }

                  var sql = 'select * from approvepublicproviderreferral($1)';
                  return util.executeDBQuery(sql,[newJsonDataStringyfied])
                    .then(data3 => data3)
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                }
                  return Promise.resolve({ data: null, message: 'Invalid request' });
              };
                        
              Publicproviderreferral.remoteMethod(
                    'approvepublicproviderreferral', 
                          {
                            http: {
                                path: '/approvepublicproviderreferral',
                                verb: 'post'
                            },
                            accepts : [ {arg : 'data',type : 'object',
                                http : {source : 'body'}}
                                ,{
                                            arg: 'reqctx',
                                            type: 'object',
                                            http: {source: 'context'}
                                          } ],   
                            returns: {
                              type : 'object',
                            root : true
                            }
                            }
                  );

                  Publicproviderreferral.getassignedlist = function (request,reqctx) {
                    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
                    var userid = (request && request.securityuserid?request.securityuserid: suserid);
                    var requesttype = request.where.requesttype;
                    var objectid = request.where.objectid;
                    var activeflag = request.where.activeflag;
                    var query = '';
                    var params = [];
              
                    if (requesttype === 'dashboard') {
                      // Get all applications assigned to a specific user
                      query = 'select * from routing r join tb_public_provider_referral tpa on r.objectid = tpa.referral_id where r.tosecurityusersid=$1 and r.activeflag = $2';
                      params.push(userid);
                      params.push(activeflag);
                    } else if (requesttype === 'assigneduserslog') {
                      // Get all user assignments for a specific application
                      query = `select r.*,uptouser.firstname as tofirstname,uptouser.lastname as tolastname,upfromuser.firstname as fromfirstname,upfromuser.lastname as fromlastname from
                              routing r 
                              inner join userprofile uptouser on uptouser.securityusersid=r.tosecurityusersid 
                              inner join userprofile upfromuser on upfromuser.securityusersid=r.fromsecurityusersid 
                              where r.objectid = $1 
                              order by r.insertedon desc`;
                      params.push(objectid);
                    }
                    LOGGER.debug("query", query);
                    LOGGER.debug("params");
                    return util.executeDBQuery(query, params)
                      .then(data => {return {data: data};})
                      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                  };

                  Publicproviderreferral.remoteMethod(
                    'getassignedlist', {
                      http: {
                        path: '/getassignedlist',
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
                    }
                  );

                  Publicproviderreferral.createproviderapplicant = function (request,reqctx) {
                    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
                    var d = new Date();
                   var applicationno=null;
                    var userid = (request && request.securityuserid?request.securityuserid: suserid);
                    var approval_type = request.approval_type;
                    var providerid = request.providerid;
                    var comments = request.comments;
                    var tosecurityuserid = request.tosecurityuserid;
                    var requested_date = request.requested_date;
                    var communication = request.communication;
                    var isclosereopen = null;
                    if (request.isclosereopen){
                      isclosereopen = true;
                    }

                    var apptype = 'providerreferral'
                    var sql = 'select * from getNextNumber(\'' + apptype + '\')';
                    return util.executeDBQuery(sql, [])
                    .then(data => {
                      applicationno = "R"+d.getFullYear()+("000" + d.getDay()).slice(-3)+  ("00000" + data[0].getnextnumber).slice(-5);

                      let sql3 = 'select * from createkinshipapplicant($1,$2,$3,$4,$5,$6,$7,$8,$9)';
                      return util.executeDBQuery(sql3,[providerid,applicationno,userid,
                          tosecurityuserid,approval_type,comments,communication,requested_date,isclosereopen]);
                    })
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                  };

                  Publicproviderreferral.remoteMethod(
                    'createproviderapplicant', {
                      http: {
                        path: '/createproviderapplicant',
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
                    }
                  );
    
    Publicproviderreferral.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Publicproviderreferral.observe('access', (ctx, next) => util.access(ctx, next));
    Publicproviderreferral.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
