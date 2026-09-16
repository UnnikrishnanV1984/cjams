'use strict';
const LOGGER = require("log4js").getLogger("usernotification");
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
const loopback = require('loopback');
var email = require('../models/email');
var datasource = app.dataSources.hcuewelfare;
var config = require('../../server/config.json');
const cjamsnotification = 'CJAMS Notification';
const mailsentmsg = "Mail sent successfully";
const noRecordsMsg = "No record found";
module.exports = function (Usernotification) {

    Usernotification.getUserNotificationold = function (data) {
        var Totalcount = 0;
        var showCount = false;
        const userid = server.currentUser.securityusersid;
        if (data.page === 1) {
            showCount = true;
        }/*else {                             //SonarQube fix - commented as showCount is already set to false above
            showCount = false
        }; */
        var newJsonStructure = data.where;
        newJsonStructure["pagenumber"] = data.page;
        newJsonStructure["pagesize"] = data.limit;
        newJsonStructure["userid"] = userid;
        var source = 'list';
        const newJsonStructureDate = JSON.stringify(newJsonStructure);
        if (showCount) {
            var countQuery = 'select * from getusernotificationcount($1,$2)';
            LOGGER.debug(countQuery);
            util.executeSecondaryNodeDBQuery(countQuery, [userid,source], function (err, data1) {
                if (err) {
                    throw err;
                } else {
                    Totalcount = data1[0].count;
                    if (Totalcount > 0) {
                        var sql3= 'select * from getusernotification($1)';
                        util.executeSecondaryNodeDBQuery(sql3,[newJsonStructureDate])
                        .then(data2 => {
                            var result;
                            result = {
                                'data': data2,
                                'count': Totalcount
                            };
                            return result;
                        })
                        .catch(_err => { LOGGER.error('>>>>ERROR:', _err); throw _err; })
                    } else {
                        var result1;
                        result1 = {
                            'data': [],
                            'count': Totalcount
                        };
                        return result1;
                    }
                }
            });
        } else {
            var sql = 'select * from getusernotification($1)';
            LOGGER.debug(sql);
            util.executeSecondaryNodeDBQuery(sql,[newJsonStructureDate])
            .then(data3 => {
                return {
                    'data': data3,
                    'count': data3.length
                };
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
        }
    }


    Usernotification.getUserNotification = function (data, reqctx) {
        const userid = util.getSecurityDetails(data, reqctx).securityuserid;
        
        var showCount = false;
        var newJsonStructure = data.where;
        var isextentity = data.where.isexternalentity;

        newJsonStructure["pagenumber"] = data.page;
        newJsonStructure["pagesize"] = data.limit;
        newJsonStructure["startdate"] = !data.where.startdate ? null : data.where.startdate;
        newJsonStructure["enddate"] = !data.where.enddate ? null : data.where.enddate;
        newJsonStructure["source"] = !data.where.source ? null : data.where.source;
        newJsonStructure["userid"] = userid;

        if (data.page == 1) {
            showCount = true
        }

        if (isextentity==undefined || isextentity == null ) {isextentity=false;}

        var sql = 'select * from getusernotification( $1,$2)';
        return util.executeSecondaryNodeDBQuery(sql, [JSON.stringify(newJsonStructure), isextentity])
            .then(data4 => {
                var result;
                if (showCount && data4.length > 0) {
                    result = {
                        'data': data4,
                        'count': data4[0].totalcount
                    };
                } else {
                    result = { 'data': data4 };
                }
                return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
    }



    Usernotification.getUserNotificationCount = function (request, reqctx) {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        const userid = request && request.securityuserid ? request.securityuserid : suserid;
        var source = 'count';
        var countQuery = 'select * from getusernotificationcount($1,$2)';
        LOGGER.debug(countQuery);
        return util.executeDBQuery(countQuery, [userid, source])
            .then(data => {
                return {
                    'systemcount': data[0].systemcount,
                    'externalcount': data[0].externalcount
                };
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Usernotification.getSingle = function (request) {
        return Usernotification.find({ where: { and: [{ subject: request.subject, securityusersid: request.securityusersid }] } })
            .then(records => {
                if (records.length > 0) {
                    var sql = 'select * from usernotification WHERE subject = $1 and securityusersid = $2';
                    return util.executeDBQuery(sql, [request.subject, request.securityusersid]);
                }
                return [];
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }

    Usernotification.deleteNotification = function (request) {
        if (request.usernotificationid !== undefined) {
            return Usernotification.find({ where: { and: [{ usernotificationid: request.usernotificationid }] } })
                .then(records => {
                    if (records.length > 0) {
                        var sql = 'UPDATE usernotification SET activeflag=0 WHERE usernotificationid = $1';
                        return util.executeDBQuery(sql, [request.usernotificationid])
                            .then(data => {
                                LOGGER.info(data);
                                return "Success";
                            });
                    }
                    return noRecordsMsg;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        } else if (request.usernotificationids !== undefined) {

            if (request.usernotificationids.length > 0) {
                const notificationIds = [];
                request.usernotificationids.forEach(usernotificationid => {
                    notificationIds.push({ usernotificationid });
                });
                return Usernotification.find({ fields: { usernotificationid: true }, where: { or: notificationIds } })
                    .then(records => {
                        if (records.length > 0) {
                            const usernotificationids = [];
                            records.forEach(notificationId => {
                                usernotificationids.push("'" + notificationId.usernotificationid + "'");
                            });

                            const sql = 'UPDATE usernotification SET activeflag=0 WHERE usernotificationid = ANY($1::uuid[])';
                            const cleanedIDs = usernotificationids.map(id => id.replaceAll("'", ""));
                            return util.executeDBQuery(sql, [cleanedIDs]);
                        }
                        LOGGER.debug("Usernotification Failed to update records");
                        return noRecordsMsg;
                    })
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            } else {
              LOGGER.debug("Usernotification Failed to update records");
              return Promise.resolve(noRecordsMsg);
            }
        }
        return Promise.resolve(noRecordsMsg);
    };

    Usernotification.updateNotification = function (request,reqctx) {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            suserid = reqctx.req.headers.securityusersid
        }
        
       var securityusersid =  request.securityuserid ? request.securityuserid :suserid;

        if (request.usernotificationid !== undefined) {
            return Usernotification.find({ where: { and: [{ usernotificationid: request.usernotificationid }] } })
                .then(records => {
                    if (records.length > 0) {
                        var sql = 'UPDATE usernotification SET isread=true , updatedby = $1, updatedon = now() where usernotificationid = $2';
                        return util.executeDBQuery(sql, [securityusersid, request.usernotificationid])
                            .then(() => "Success");
                    }
                    return noRecordsMsg;
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
        }
        return Promise.resolve(noRecordsMsg);
    };

    Usernotification.Add = function (request,reqctx) {
        if (!request) {
            return Promise.resolve({ data: { status: 400, message: "Failed to add notification" } });
        }
        const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
        request.teamtypekey = 'CW';
        return Usernotification.create(request)
            .then(res => {
                if (res.usernotificationid != null && res.usernotificationid != undefined) {
                    var responseJson = {};
                    responseJson.usernotificationid = res.usernotificationid;
                    responseJson.tosecurityusersid = res.securityusersid;
                    responseJson.isreplied = false;
                    responseJson.teammemberid = res.teammemberid;
                    responseJson.fromsecurityusersid = suserid;
                    LOGGER.debug(responseJson)
                    return server.models.Usernotificationmap.create(responseJson)
                        .then(() => {
                            return {data:{usernotificationid:res.usernotificationid,
                                status:200,message:"Successfully Added"}};
                        });
                }
                return { data: { status: 200, message: "No data to add" }};
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Usernotification.remoteMethod(
        'Add',
        {
            http: {
                path: '/Add',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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

    Usernotification.remoteMethod(
        'getSingle',
        {
            http: {
                path: '/getSingle',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
            }],
            returns: {
                type: 'array',
                root: true
            }
        }
    );

    Usernotification.getnotificationemail=(objectid)=>{
        var sql =  'select * from getnotificationemail($1)';
        return util.executeDBQuery(sql, [objectid])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }



    Usernotification.remoteMethod(
        'getUserNotification',
        {
            http: {
                path: '/getUserNotification',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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

    Usernotification.remoteMethod('getUserNotificationCount', {
        accepts: [{
            arg: 'filter',
            type: 'object',
            required: false

        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        http: {
            path: '/getUserNotificationCount',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Usernotification.remoteMethod(
        'deleteNotification',
        {
            http: {
                path: '/deleteNotification',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );
    Usernotification.remoteMethod(
        'updateNotification',
        {
            http: {
                path: '/updateNotification',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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

    Usernotification.remoteMethod('getCaseCountByUser', {
        accepts: [{
            arg: 'filter',
            type: 'object',
            required: false
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        http: {
            path: '/getCaseCountByUser',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Usernotification.remoteMethod('getTasksCountByUser', {
        accepts: [{
            arg: 'filter',
            type: 'object',
            required: false
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        http: {
            path: '/getTasksCountByUser',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Usernotification.getCaseCountByUser = function (request, reqctx) {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        const userid = request && request.securityuserid?request.securityuserid:suserid;
        var countQuery = 'select * from getcasecountbyuser(\'' + userid + '\')';
        return util.executeDBQuery(countQuery, [])
            .then(data => data[0])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Usernotification.getTasksCountByUser = function (request, reqctx) {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        const userid = request && request.securityuserid?request.securityuserid:suserid;
        var countQuery = 'select * from gettaskscountbyuser(\'' + userid + '\')';
        LOGGER.debug(countQuery);
        return util.executeDBQuery(countQuery, [])
            .then(data5 => data5[0])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }


    Usernotification.remoteMethod(
        'getActivityTasksByUser',
        {
            http: {
                path: '/getActivityTasksByUser',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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

    Usernotification.getActivityTasksByUser = function (data, reqctx) {
        const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
        const userid = suserid;

        let filtertype = data.where.filtertype;
        let searchobj = data?.where?.searchobj ?? null;
        let sortorder = data?.where?.sortorder ? data.where.sortorder : null;
        let sortcolumn = data?.where?.sortcolumn ? data.where.sortcolumn : null; 
        let exportpagelimit = data?.where?.exportlimit ? data?.where?.exportlimit : null; 
        let status = data?.where?.status ?? null;
        
        if(exportpagelimit) {
            data.limit = exportpagelimit;
        }
        
        let sql = 'select * from getactivitytaskbyuser($1,$2,$3,$4,$5,$6,$7,$8)';
        
        // FIX 1: Add "return" here so the Promise chain is returned to the caller
        return connectDbAndExecute(sql,[userid,data.page,data.limit,filtertype,searchobj,sortorder,sortcolumn,status])
            .then(data2 => {
                // FIX 2: Safely handle if data2 is null or undefined
                if (!data2) {
                    return {
                        'data': [],
                        'count': 0
                    };
                }

                return {
                    'data': data2,
                    'count': data2[0]?.count ? data2[0].count : data2.length
                };
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };



    Usernotification.remoteMethod(
        'updateMyTaskbyUser',
        {
            http: {
                path: '/updateMyTaskbyUser',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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

    Usernotification.updateMyTaskbyUser = function (data, reqctx) {
        const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
        const userid = suserid;

        let sql =  'select * from spcloseduemytasks($1,$2,$3, $4)';
        return util.executeDBQuery(sql, [userid, data.personid, data.alerttype, data.ispageopened])
            .then(_data => _data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }


    function connectDbAndExecute(sqlQuery, data){
        return util.executeSecondaryNodeDBQuery(sqlQuery, data);
    }

    Usernotification.remoteMethod(
        'getTeamCaseCountByUser',
        {
            http: {
                path: '/getTeamCaseCountByUser',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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

    Usernotification.remoteMethod(
        'getcaseworkerdashboard',
        {
            http: {
                path: '/getcaseworkerdashboard',
                verb: 'get'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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
    Usernotification.getcaseworkerdashboard = function (request, reqctx) {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        const userId = request && request.securityuserid?request.securityuserid:suserid;
        var dashboardQuery = 'select * from getcwdashboard($1)';
        return util.executeDBQuery(dashboardQuery, [userId])
            .then(data => data[0])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Usernotification.remoteMethod(
        'listiveplacement',
        {
            http: {
                path: '/listiveplacement',
                verb: 'get'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
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

    Usernotification.getTeamCaseCountByUser = function (request, reqctx) {
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        const userid = request && request.securityuserid?request.securityuserid:suserid;
        var countQuery = 'select * from getteamcasecountbyuser($1,$2)';
        LOGGER.debug(countQuery);
        return util.executeDBQuery(countQuery, [userid, request.where.source])
            .then(data6 => data6[0])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    ////// Report Start
	Usernotification.remoteMethod('getqnetrpt_positionnotificationsRpt', {
        http: {
              path: '/getqnetrpt_positionnotificationsRpt',
              verb: 'get'
        },
       accepts : [{
          arg : 'data',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
       });

	   Usernotification.getqnetrpt_positionnotificationsRpt = (request) => {
        const loadnumber = request.loadnumber;
        const fromDate = request.fromdate;
        const toDate = request.todate;
        const rptQuery = "select * from qnetrpt_positionnotifications('"+loadnumber+"','ALL','ANY','"+fromDate+"', '"+toDate+"')";
        LOGGER.debug('123 ' + rptQuery);
        return util.executeDBQuery(rptQuery, [])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };


  Usernotification.notificationmail =  (request, reqctx) =>{
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
    var result = [];
    var response = [];
    request.map(x => {
          if(x.email){
            if (util.isNullorEmpty(x.url))
            {
              var authtoken =''
              var loginparams ={};
              loginparams.email = 'weiner@cjams.com';
        
              loginparams.fromdevice =1;

               //  app.models.User.login(loginparams,'user').then(
                app.models.Userprofile.generateAccessToken(loginparams).then(
                  resp=>
                 {
                   LOGGER.debug(resp + "resp")
                  if (resp!=null && resp.token!=null)
                  {
                     authtoken =resp.token.id;
                  }
                  response = sendAssementMailandlog(authtoken, x, cjamsnotification, url, _securityusersid, response);
                 });
            }
            else
            {
                response = sendMailandNotification(x, cjamsnotification, _securityusersid, response);
            }
            }
    });
    return Promise.all(response).then(function(values) {
      values.map(x=>{
          result.push(x);
      });
      return result;
    });
   }

    function sendAssementMailandlog(authtoken, x, cjamsnotification1, url, _securityusersid, response) {
        if (authtoken !== '') {
            var url1 = x.url + "?access_token=" + authtoken;
            var msg = email.SendAssessmentEmail(x.email,cjamsnotification1,url1,x.objecttypekey)
            LOGGER.debug(msg)
            if (msg == mailsentmsg) {
                if (x.bassessment == 1) {
                    var sql = 'update notificationlog set ismailsent = 1 where notificationlogid = ($1)';
                    return util.executeDBQuery(sql,[x.usernotificationid])
                        .then(result => {
                            return result;
                        })
                        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
                } else {
                    x.securityuserid = _securityusersid;
                    app.models.Notificationlog.add(x,_securityusersid);
                }
            }
            response.push(msg);
        }
        return response;
    }

    function sendMailandNotification(x,cjamsnotification2,_securityusersid,response) {
        if (util.isNullorEmpty(x.attachment)) {
            var msg1 = email.SendEmailAttachment(x.email,cjamsnotification2,x.message,x.attachment.filename,x.attachment.content);
            LOGGER.debug(msg1);
            x.securityuserid = _securityusersid;
            if (msg1 === mailsentmsg) {
                app.models.Notificationlog.add(x,_securityusersid);
                response.push(msg1);
            }
        }
        else {
            var msg2 = email.SendEmail(x.email,cjamsnotification2,x.message)
            LOGGER.debug(msg2);
            x.securityuserid = _securityusersid;
            if (msg2 === mailsentmsg) {
                app.models.Notificationlog.add(x,_securityusersid);
                response.push(msg2);
            }
        }
        return response;
    }

  Usernotification.remoteMethod('notificationmail', {
    accepts : [{
            arg : 'data',
            type : 'array',

            http : { source: 'body' }
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    http: {
        'verb': 'post',
        'path': '/notificationmail'
        },
    returns : {
        type : 'Object',
        root : true
        }
});
Usernotification.getactivitytaskbyremindate= (request,reqctx) =>{
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    var securityusersid = request && request.securityuserid?request.securityuserid: suserid;
    var page = request.page;
    var limit = request.limit;

    var Totalcount = 0;

    const sql = 'Select * from getactivitytaskbyremindate($1,$2,$3)';
    return util.executeDBQuery(sql, [securityusersid, page, limit])
        .then(data => {
            if (data != null && data.length > 0) {Totalcount = data[0].totalcount;}
            return {
                'data': data,
                'count': Totalcount
            };
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  }

Usernotification.remoteMethod(
    'getactivitytaskbyremindate',
    {
        http: {
            path: '/getactivitytaskbyremindate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
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

Usernotification.getactivitytaskbyduedate= (request,reqctx) =>{
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    var securityusersid = request && request.securityuserid?request.securityuserid: suserid;
    var page = request.page;
    var limit = request.limit;
    LOGGER.debug(securityusersid+"securityusersid");
    var Totalcount = 0;

    const sql = 'Select * from getactivitytaskbyduedate($1,$2,$3)';
    return util.executeDBQuery(sql, [securityusersid,page,limit])
        .then(data => {
            if (data!=null && data.length > 0) {Totalcount = data[0].totalcount;}
            var result;
            result = {
              'data': data,
              'count': Totalcount
            };
            return result;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  }

Usernotification.remoteMethod(
    'getactivitytaskbyduedate',
    {
        http: {
            path: '/getactivitytaskbyduedate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
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

    ////// Report End

Usernotification.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Usernotification.observe('access', (ctx, next) => util.access(ctx, next));
Usernotification.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};