'use strict';
const LOGGER = require("log4js").getLogger("intakeservreqcourtorder");
const util = require('../utils/utils');
var app = require('../../server/server');
var config = require('../../server/config.json');

module.exports = function(Intakeservreqcourtorder) {


    Intakeservreqcourtorder.add = function (request, reqctx) {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        let prs = [];        
        const allPrs = [];        
        var intakeservreqcourtorderid;

            request.bulkHearing.forEach(hearing => {
                allPrs.push(new Promise((resolve, reject) => {
                    var clientname = hearing.clientdetails && hearing.clientdetails?.clientname ? hearing.clientdetails?.clientname : null;
                    var dob = checkDOB(hearing);

                if (hearing.intakeservreqcourtorderid == null || hearing.intakeservreqcourtorderid === undefined) { 
                    return Intakeservreqcourtorder.create({
                        intakeservicerequestpetitionid: request.intakeservicerequestpetitionid,
                        intakeservicerequesthearingid:hearing.intakeservicerequestcourthearingid,
                        intakeserviceid: request.intakeserviceid,
                        servicecaseid: request.servicecaseid,
                        courtorderdate: request.courtorderdate,
                        childpermanencyplankey:request.childpermanencyplankey,
                        hearingoutcometypekey: request.hearingoutcometypekey,
                        remarks: request.remarks,
                        coreceiveddate: request.coreceiveddate,
                        courtorderdelayremoval: request.courtorderdelayremoval,
                        courtorderdelaytimeframe: request.courtorderdelaytimeframe,             /*SonarQube Removed duplicate fields*/
                        intakeservicerequestactorid : hearing.intakeservicerequestactorid,
                        removalid : request.removalepisode,
                        county: nullcheck(request.county),
                        clientname: clientname, 
                        dob: dob,
                        personsappeared: nullcheck(request.personsappeared),
                        courtreview: nullcheck(request.courtreview),
                        childsneed : nullcheck(request.childsneed),
                        childneedcantmet : nullcheck(request.childneedcantmet),
                        childpermanencyplan: nullcheck(request.childpermanencyplan),
                        childmosteffplan: nullcheck(request.childmosteffplan),
                        qrtpapproval: nullcheck(request.qrtpapproval),
                        judgedate: nullcheck(request.judgedate),
                        judgename: nullcheck(request.judgename),
                        judgeid: nullcheck(request.judgeid),
                        qrtpapprovaldecision: nullcheck(request.qrtpapprovaldecision),
                        otherpersonsappeared: nullcheck(request.otherpersonsappeared),
                        insertedby: _securityusersid,
                        updatedby: _securityusersid
                    }).then(data => {
                        intakeservreqcourtorderid = data.intakeservreqcourtorderid;
                        sendQRTPNotification(request, hearing);
                       
                        prs = createIntakeservreqDetails(request, data.intakeservreqcourtorderid, _securityusersid, prs);
                        if (request.attachment != null && request.attachment !== undefined && request.attachment !== "") {
                            request.attachment.map(attach => {
                                attach.documentattachment = {};
                                attach.objectid = intakeservreqcourtorderid;
                                attach.objecttypekey = 'courtorder';
                                attach.insertedby = _securityusersid;
                                attach.updatedby = _securityusersid;
                                attach.servicecaseid = request.servicecaseid;
                                attach.servicerequestid = request.intakeserviceid;
                                attach.documentattachment.attachmentclassificationtypekey = attach.attachmentclassificationtypekey;
                                attach.documentattachment.attachmentclassificationsubtypekey = attach.attachmentclassificationsubtypekey;
                                attach.documentattachment.attachmentdate =attach.documentdate;
                                attach.documentattachment.attachmenttypekey = attach.attachmenttypekey;
                            });
                            return app.models.Documentproperties.addcommonattachment(request.attachment, null, reqctx).then((res)=>{
                                return { code: 200, message: 'success', data: res}
                            }).catch(err=>{
                                LOGGER.error(err)
                            })
                        }
        
                        return Promise.all(prs);
                    })
                    .then(data => {
                        resolve(intakeservreqcourtorderid);
                    })
                    .catch(err => {
                        LOGGER.debug(err);
                        util.logError(err);
                        reject(err);
                    });
                } else {
                    return Intakeservreqcourtorder.updateAll({intakeservreqcourtorderid: hearing.intakeservreqcourtorderid}, {
                        intakeservicerequestpetitionid: request.intakeservicerequestpetitionid,
                        intakeservicerequesthearingid:hearing.intakeservicerequestcourthearingid,
                        intakeserviceid: request.intakeserviceid,
                        servicecaseid: request.servicecaseid,
                        courtorderdate: request.courtorderdate,
                        childpermanencyplankey:request.childpermanencyplankey,
                        hearingoutcometypekey: request.hearingoutcometypekey,
                        remarks: request.remarks,
                        coreceiveddate: request.coreceiveddate,
                        courtorderdelayremoval: request.courtorderdelayremoval,
                        courtorderdelaytimeframe: request.courtorderdelaytimeframe,
                        updatedby: _securityusersid,
                        intakeservicerequestactorid : hearing.intakeservicerequestactorid,
                        removalid : request.removalepisode,
                        county: nullcheck(request.county),
                        clientname: clientname, 
                        dob: dob,
                        personsappeared: nullcheck(request.personsappeared),
                        courtreview: nullcheck(request.courtreview),
                        childsneed : nullcheck(request.childsneed),
                        childneedcantmet : nullcheck(request.childneedcantmet),
                        childpermanencyplan: nullcheck(request.childpermanencyplan),
                        childmosteffplan: nullcheck(request.childmosteffplan),
                        qrtpapproval: nullcheck(request.qrtpapproval),
                        judgedate: nullcheck(request.judgedate),
                        judgename: nullcheck(request.judgename),
                        judgeid: nullcheck(request.judgeid),
                        qrtpapprovaldecision: nullcheck(request.qrtpapprovaldecision),
                        otherpersonsappeared: nullcheck(request.otherpersonsappeared)                    
                    }).then(data =>{
        
                        var sql = 'select * from updateCourtoderdetails($1)';
        return util.executeDBQuery(sql,[request.intakeservreqcourtorderid])
        .then(_data => {
            LOGGER.info(_data);
            return _data;
        })
        .catch(err => {
            LOGGER.error(err);
            return err;
        })				
                    }).then(data => {
                        prs = createIntakeservreqDetails(request, request.intakeservreqcourtorderid, _securityusersid, prs);
                        addDocuments(request, reqctx, _securityusersid);
                        return Promise.all(prs);
                    })
                    .then(data => {
                        resolve('SUCCESS');
                    })
                    .catch(err => {
                        util.logError(err);
                        LOGGER.debug(err);
                        reject(err);
                    });
                }
                }));
            });
            return Promise.all(allPrs).then(data => intakeservreqcourtorderid).catch(err => err);

        /*.then(resp => {
            var ds = app.dataSources.hcuewelfare;
            var status = 15;
            var isservicecase = 0;
            var nofitymsg = 'Court Order Submitted for review';
            if(request.intakeserviceid == null && request.intakeserviceid == undefined){
                request.intakeserviceid = request.servicecaseid?request.servicecaseid:'';
                isservicecase = 1;
            } 
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';            
            return new Promise((resolve, reject) => {
                ds.connector.execute(sql, [intakeservreqcourtorderid, (request && request.securityuserid?request.securityuserid: app.currentUser.securityusersid1), 'CORR', status, comments, '', false, false, false,
                                           nofitymsg,'',request.intakeserviceid,'',isservicecase], (err, data) => {
                    if(err)
                        reject(err);
                    else
                        resolve(data[0].routingintake);
                });
            })
        })*/
        
    }

    function checkDOB(hearing){
        return hearing.clientdetails && hearing.clientdetails?.dob ? hearing.clientdetails?.dob : null;
    }

    function addDocuments(request, reqctx, _securityusersid){
        if (request.attachment != null && request.attachment !== undefined && request.attachment !== "") {
            request.attachment.map(attach => {
                attach.documentattachment = {};
                attach.objectid = request.intakeservreqcourtorderid;
                attach.objecttypekey = 'courtorder';
                attach.insertedby = _securityusersid;
                attach.updatedby = _securityusersid;        //SonarQube fix - removed the self-assignments
                attach.documentattachment.attachmentclassificationtypekey = attach.attachmentclassificationtypekey;
                attach.documentattachment.attachmentclassificationsubtypekey = attach.attachmentclassificationsubtypekey;
                attach.documentattachment.attachmentdate =attach.documentdate;
                attach.documentattachment.attachmenttypekey = attach.attachmenttypekey;
                app.models.Documentproperties.addcommonattachment(request.attachment, null, reqctx);
            });
        }
    }

    function sendQRTPNotification(request, hearing){
        if(request.qrtpapproval === 2){
            //send notification to caseworker and supervisor
            var youthname  = request.clientname;
            var personid  =hearing.personid;
            var subject='QRTP Placement Petition Denied by the Court for the Client ' + youthname + '. Please move the client to non-QRTP Placement within 30 Days.';
            const sql = 'select * from send_qrtppartb_notification($1, $2, $3,$4::uuid,$5)';
            return util.executeDBQuery(sql,['cwadmin',subject,request.servicecaseid,personid,'QRCT01'])
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        }
    }

    function createIntakeservreqDetails(request, intakeservreqcourtorderid, _securityusersid, prs){
        if (Array.isArray(request.hearingoutcomedetails)) {
            request.hearingoutcomedetails.map(hearing => {
                prs.push(app.models.Intakeservreqcohearingoutcome.create({
                    intakeservreqcourtorderid: intakeservreqcourtorderid,
                    hearingoutcometypekey: hearing.hearingoutcometypekey,
                    insertedby: _securityusersid,
                    updatedby: _securityusersid,
                }).catch(err => LOGGER.error(err))
                )
            });
        }

        if (Array.isArray(request.intakeservreqcourtorderdetails)) {
            request.intakeservreqcourtorderdetails.map(checklist => {
                prs.push(app.models.Intakeservreqcourtorderdetails.create({
                    intakeservreqcourtorderid: intakeservreqcourtorderid,
                    checklistid: checklist.checklistid,
                    checklisttypekey: checklist.checklisttypekey,
                    isselected: checklist.isselected,
                    remarks: checklist.remarks,
                    insertedby: _securityusersid,
                    updatedby: _securityusersid,
                }).catch(err => LOGGER.error(err))
                )
            });
        }
        return prs;
    }

    function nullcheck(value){
        return value ? value : null;
    }


    Intakeservreqcourtorder.remoteMethod('add', {
        accepts: [{
            arg: 'data',
            type: 'object',

            http: { source: 'body' }
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        http: {
            'verb': 'post',
            'path': '/add'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });



    Intakeservreqcourtorder.getcourtorder = function (request) {

        const iscaseexpunged  = request.where.iscaseexpunged ?? 0; 
        var sql = 'select * from getcourtorder($1,$2,$3)';
        var params=[request?.where?.intakeserviceid,request?.where?.isExpungementSuperUser, iscaseexpunged];
    
        if (request.where.objecttype === 'servicecase') {
            request.where.intakeserviceid=request.where.objectid;
            sql='select * from getservicecasecourtorder($1)';
            params=[request?.where?.intakeserviceid]; 
        }
    
        return util.executeSecondaryNodeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                return util.logError(err).then(() => {
                    throw err;
                });
            });
    };
    
    Intakeservreqcourtorder.remoteMethod('getcourtorder', {
        accepts: {
        arg: 'filter',
        type: 'Object',
        http: {
            source: 'query'
        },
        required: true
        },
        http: {
        path: '/getcourtorder',
        verb: 'get'
        },
        returns: {
        type: 'Object',
        root: true
        }
    });


    Intakeservreqcourtorder.gethealthcaredecisionmakerinformation = function (request) {

        var sql = 'select * from gethealthcaredecisionmakerinformation($1,$2,$3)';
        var params = [request.where.objecttype,request.where.objectid,request.where.personid];

        return util.executeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Intakeservreqcourtorder.remoteMethod('gethealthcaredecisionmakerinformation', {
        accepts: {
        arg: 'filter',
        type: 'Object',
        http: {
            source: 'body'
        },
        required: true
        },
        http: {
        path: '/gethealthcaredecisionmakerinformation',
        verb: 'post'
        },
        returns: {
        type: 'Object',
        root: true
        }
    });

    Intakeservreqcourtorder.remoteMethod('addhealthcaredecisionmakerinformation', {
        accepts: [{
            arg: 'data',
            type: 'object',

            http: { source: 'body' }
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        http: {
            'verb': 'post',
            'path': '/addhealthcaredecisionmakerinformation'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqcourtorder.addhealthcaredecisionmakerinformation = function (request,reqctx) {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }

        var sql = 'select * from addhealthcaredecisionmakerinformation($1,$2)';
        var params = [request,suserid];

        return util.executeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };
    Intakeservreqcourtorder.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqcourtorder.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqcourtorder.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}