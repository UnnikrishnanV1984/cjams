'use strict';
const LOGGER = require("log4js").getLogger("placement");
const util = require('../utils/utils');
var app = require('../../server/server');
var config = require('../../server/config.json');
const moment = require('moment');
var uuid = require('node-uuid');
const delay = ms => new Promise(resolve => setTimeout(resolve, ms));

const placementrevisionupdatenew = 'select * from placementrevisionupdatenew($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22)';
const placementrevisionupdatesql = 'select * from placementrevisionupdate($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24,$25,$26)';
const routingintakesql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
const sp_placement_validation_updatesql = "select * from sp_placement_validation_update($1,$2,$3,$4)";
const placementluggagenotification ="select * from send_notification($1, $2, $3, $4, $5, $6, $7, $8, $9,$10)";

const placementsuccessfulmsg = 'Placement added Successfully';
const loggermsg = '>>>>sp_placement_validation_update error ';

// The list endpoints wrap their rows with the totalcount that the SQL functions
// carry on every row. Two shapes are in use and both have consumers, so they get
// one helper each rather than being merged: `count` for the placement lists,
// `totalcount` for search/summary.
const withCount = rows => ({
    'data': rows,
    'count': (rows !== null && rows.length > 0) ? rows[0].totalcount : 0
});

const withTotalcount = rows => ({
    totalcount: (rows !== null && rows.length > 0) ? rows[0].totalcount : 0,
    'data': rows
});

// Shared failure path for the read endpoints: log locally, then rethrow so the
// caller still sees a failed request.
const logAndRethrow = err => {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
};

module.exports = function(Placement) {    
   
    /**Placement add */
    Placement.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} , {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Placement.add = function(request, reqctx) {
        let _securityusersid = undefined;
if(reqctx?.req?.headers?.securityusersid){
 _securityusersid = reqctx.req.headers.securityusersid;
}
        LOGGER.debug(request);

        var insertedby = request.securityuserid ? request.securityuserid : _securityusersid;
        var updatedby = insertedby;
        var sql = "insert into placement (providerid,intakeserviceid,intakeservicerequestactorid,remarks, leastrestrictiveplacement,"+
          " startdatetime,enddatetime,statustypekey,updatedby,insertedby, otherpublicagency) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10, $11, $12)"
        return util.executeDBQuery(sql,[request.providerid,request.intakeserviceid,request.intakeservicerequestactorid,request.remarks, request.leastrestrictiveplacement,
        request.startdatetime,request.enddatetime,request.statustypekey,updatedby,insertedby, request.transferagency ,request.otherpublicagency ])
        .then(data => {
            LOGGER.debug(data);
            var sql1 = placementrevisionupdatesql;
            return util.executeDBQuery(sql1, [request.placementid,request.startdate,request.starttime,request.voidreasontypekey,request.voidremarks,request.enddate,
                    request.endtime,request.exittypekey,request.remarks,request.exitreasontypekey,0,insertedby,null, null, false, request.transferagency ,
                    request.otherpublicagency, request.leastrestrictiveplacement,request.placementluggage,request.plluggagepurchased,request.plluggagecomments,request.placementdisposableortrashbag,request.exitluggage, request.exitluggageprovided ,request.exitluggagecomments,request.exitdisposableortrashbag])
            .then(data1 => data1[0].placementrevisionupdate)
            .then(data2 =>placementsuccessfulmsg)
            .then( async res =>{
                return res;
             }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Placement.remoteMethod('exitplacement', {
        http: {
            path: '/exitplacement',
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
    });

    async function getPersonData(placementid) {
        const personLookupSql = `
                    SELECT p.personid, (p.firstname || ' ' || p.lastname) as youthname 
                    FROM placement pl 
                    JOIN person p ON pl.personid = p.personid 
                    WHERE pl.placementid = $1`;

        const personData = await util.executeDBQuery(personLookupSql, [placementid]);
        if (personData && personData.length > 0) {
            return personData[0];
        }
        return null;
    }

    async function checkTransitionPlan(actualPersonId) {
        const checkSql = `
                        SELECT clientid FROM cjams.youthtransitionplan 
                        WHERE clientid = $1 
                        AND (
                            COALESCE(lower(newfcgschecklistjson->>'trustChecked'), 'false') = 'true'
                            OR COALESCE(lower(newfcgschecklistjson->>'ableChecked'), 'false') = 'true'
                        )`;

        const results = await util.executeDBQuery(checkSql, [actualPersonId]);
        return (results && results.length > 0);
    }

    async function getUserData(v_securityusersid) {
        const userSql = 'select up.fullname as v_workername, up.supervisorid as v_supervisor from userprofile up where up.securityusersid = $1';
        const userData = await util.executeDBQuery(userSql, [v_securityusersid]);

        if (userData && userData.length > 0) {
            return userData[0];
        }
        return null;
    }

    async function handleTransitionPlanNotification(request) {
        const exitTypes = ['CIP', 'CIPS', 'PLCC'];
        if (!exitTypes.includes(request.exittypekey)) {
            return;
        }

        const personData = await getPersonData(request.placementid);
        if (!personData) {
            return;
        }

        const actualPersonId = personData.personid;
        const youthName = personData.youthname;

        const results = await checkTransitionPlan(actualPersonId);
        if (!results) {
            return;
        }

        const userData = await getUserData(request.v_securityusersid);
        if (!userData) {
            return;
        }

        const casePrefix = request.casenumber ? `Case ${request.casenumber} ` : '';
        const notifyMsg = `${casePrefix} Youth (${youthName}) Exited Foster care. Please update if the TRUST or ABLE Account transition into an Adult Service account.
.`;
        const sqlNotify = placementluggagenotification;

        await util.executeDBQuery(sqlNotify, [userData.v_supervisor, request.v_securityusersid, userData.v_supervisor, 'System', 'High', notifyMsg, notifyMsg, request.servicecaseid, false, request.placementid]);

        await util.executeDBQuery(sqlNotify, [request.v_securityusersid, request.v_securityusersid, request.v_securityusersid, 'System', 'High', notifyMsg, notifyMsg, request.servicecaseid, false, request.placementid]);
    }

Placement.exitplacement = function (request) {

        request.placement_id = request.placementid;
        request.entry_dt = request.startdate;
        request.entry_tm = request.starttime;
        request.exit_type_cd = request.exittypekey;
        request.exit_reason_cd = request.exitreasontypekey;
        request.exit_explanation_tx = request.remarks;
        request.exit_leastrestrictiveplacement = request.leastrestrictiveplacement;
        request.exit_dt = request.enddate;
        request.exit_tm = request.endtime;
        request.delete_sw = 'N';

                    var status = 15;
                    var nofitymsg = 'Placement Exit Submitted for review';
                    var sql = routingintakesql;
                    return util.executeDBQuery(sql, [request.placementid, request.v_securityusersid, 'PLTR', status, '', '', false, false, false, nofitymsg, nofitymsg,
                                                   request.servicecaseid, '', 1])
                    .then(data => data[0].routingintake)
                .then(data => {
                    var sql1 = placementrevisionupdatesql;
                    return util.executeDBQuery(sql1, [request.placementid,request.startdate,
                            request.starttime,request.voidreasontypekey,request.voidremarks,
                            request.enddate,request.endtime,request.exittypekey,request.remarks,
                            request.exitreasontypekey,0,request.v_securityusersid,null,request.justification,
                            request.ischangepreadoptive, request.transferagency ,request.otherpublicagency, request.leastrestrictiveplacement,request.placementluggage,request.plluggagepurchased,request.plluggagecomments,request.placementdisposableortrashbag,request.exitluggage, request.exitluggageprovided ,request.exitluggagecomments,request.exitdisposableortrashbag])
                    .then(data2 => data2[0].placementrevisionupdate);
        })
        .then(async () => {
            await handleTransitionPlanNotification(request);
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

    /** update placement table if exit */
    Placement.remoteMethod('updateplacement', {
        http: {
            path: '/updateplacement',
            verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });
   
    Placement.updateplacement = (request) => {
       
        return Placement.updateAll(
            {
                placementid: request.placementid
            },
            {  
                placementadmissionclassificationkey:request.placementadmissionclassificationkey,
                placementadmissiontypekey:request.placementadmissiontypekey,
                parentorg:request.parentorg,
                addate:request.addate,
                adtime:request.adtime,
                releasedate:request.releasedate,
                detainer:request.detainer,
                placementadmissionauthorizationtypekey:request.placementadmissionauthorizationtypekey,
                placementprimaryadmissionreasontypekey:request.placementprimaryadmissionreasontypekey,
                placementprimaryapprovedalttypekey:request.placementprimaryapprovedalttypekey,
                county:request.county,
                jlocation:request.jlocation,
                jcounty:request.jcounty,
                fieldworker:request.fieldworker,
                certifiedad:request.certifiedad,
                resourceworker:request.resourceworker,
                exitreasontypekey:request.exitreasontypekey,
                enddatetime:request.enddatetime,
                cop:request.cop
            }).then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    /**Placement list */
    Placement.remoteMethod('list', {
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

    Placement.list =(request)=> {
        var page = request.page;
        var intakeserviceid = request.where.intakeserviceid;
        var intakenumber = request.where.intakenumber;
        var limit = request.limit;
        var sql = 'select * from getplacementlist($1, $2, $3, $4)';

        return util.executeDBQuery(sql, [intakeserviceid, page, limit, intakenumber])
        .then(withCount)
        .catch(logAndRethrow);
    };

    Placement.getplacementbyservicecase = (request) => {
        var page = request.page;
        var servicecaseid = request.where.servicecaseid;
        var limit = request.limit;
        var sql = 'select * from getplacementbyservicecase($1, $2, $3)';
        return util.executeSecondaryNodeDBQuery(sql, [servicecaseid, page, limit])
        .then(withCount)
        .catch(logAndRethrow);
    };


    Placement.remoteMethod('getplacementbyservicecase', {
        http: {
            path: '/getplacementbyservicecase',
            verb: 'get'
        },
        accepts: [
            {
                arg: 'filter',
                type: 'object',
                http: { source: 'query' }
            }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Placement.remoteMethod('admissionclassification', {
        http: {
            path: '/admissionclassification',
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

    Placement.admissionclassification = function(request){
        var sql = "select placementadmissionclassificationid,placementadmissionclassificationkey,description from placementadmissionclassificationtype"
        return util.executeDBQuery(sql, [])
        .then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Placement.remoteMethod('admissiontype', {
        http: {
            path: '/admissiontype',
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

    Placement.admissiontype = function(request){
        var sql = "select PlacementAdmissionTypeid,PlacementAdmissionTypekey,description from PlacementAdmissionType"
        return util.executeDBQuery(sql, [])
        .then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Placement.remoteMethod('admissionauthorization', {
        http: {
            path: '/admissionauthorization',
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

    Placement.admissionauthorization = function(request){
        var sql = "select PlacementAdmissionAuthorizationTypeid,PlacementAdmissionAuthorizationTypekey,description from PlacementAdmissionAuthorizationType"
        return util.executeDBQuery(sql, [])
        .then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Placement.remoteMethod('admissionreason', {
        http: {
            path: '/admissionreason',
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

    Placement.admissionreason = function(request){
        var sql = "select PlacementPrimaryAdmissionReasonTypeid,PlacementPrimaryAdmissionReasonTypekey,description from PlacementPrimaryAdmissionReasonType"
        return util.executeDBQuery(sql, [])
        .then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Placement.remoteMethod('primaryapproved', {
        http: {
            path: '/primaryapproved',
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

    Placement.primaryapproved = function(request){
        var sql = "select PlacementPrimaryApprovedAltTypeid,PlacementPrimaryApprovedAltTypekey,description from PlacementPrimaryApprovedAltType"
        return util.executeDBQuery(sql, [])
        .then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Placement.remoteMethod('jurisdictionlocation', {
        http: {
            path: '/jurisdictionlocation',
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

    Placement.jurisdictionlocation = function(request){
        var sql = "select placementjurisdictionlocationid,placementjurisdictionlocationkey,description from placementjurisdictionlocation"
        return util.executeDBQuery(sql, [])
        .then(res =>{
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Placement.remoteMethod('addjs', {
        http: {
                path: '/addjs',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],  
        returns: {
            type : 'string',
            root : true
        }
    });

    Placement.addintakeplacement = (request, reqctx) => {
        let _securityusersid = undefined;
if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
 _securityusersid = reqctx.req.headers.securityusersid;
}

        var securityuserid = (request && request.securityuserid?request.securityuserid: _securityusersid);

        var sql = 'select * from addintakeplacement($1, $2, $3)';
        return util.executeDBQuery(sql, [request.intakenumber, JSON.stringify(request), securityuserid])
        .then(data => {
            LOGGER.debug(data);
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Placement.remoteMethod('addintakeplacement', {
        http: {
                path: '/addintakeplacement',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} , {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],  
        returns: {
            type : 'string',
            root : true
        }
    });

    Placement.addjs = function(request){
        const intakeserviceid = request.intakeserviceid;

        const insertedon = new Date().toLocaleString();
        var sql = "select intakeservicerequestactorid from intakeservicerequestactor where intakeserviceid=$1 and intakeservicerequestpersontypekey='Youth'"
        return util.executeDBQuery(sql,[intakeserviceid])
        .then(res =>{
            var intakeactorid = res;
            var intakeservicerequestactorid= intakeactorid[0].intakeservicerequestactorid;

            var sql1 = "insert into placement (providerid,intakeserviceid,intakeservicerequestactorid,remarks,placementadmissionclassificationkey,"+
            " placementadmissiontypekey,parentorg,addate,adtime,releasedate,detainer,startdatetime,placementadmissionauthorizationtypekey,"+
            "placementprimaryadmissionreasontypekey,placementprimaryapprovedalttypekey,county,jlocation,jcounty,fieldworker,updatedby," +
            "certifiedad,resourceworker,istempplacement) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23)"

            return util.executeDBQuery(sql1,[request.providerid,request.intakeserviceid,intakeservicerequestactorid,request.remarks,
            request.placementadmissionclassificationkey,request.PlacementAdmissionTypekey,request.parentorg,request.addate,request.adtime,
            request.releasedate,request.detainer,insertedon,request.PlacementAdmissionAuthorizationTypekey,request.PlacementPrimaryAdmissionReasonTypekey,
        request.PlacementPrimaryApprovedAltTypekey,request.county,request.jlocation,request.jcounty,request.fieldworker,'d5732f72-8145-4555-aed9-e5a024103e60',
        request.certifiedAd,request.resourceworker,request.istempplacement])
                .then(rs =>{
                LOGGER.debug(rs);
                var placementadmissionclassificationkey = request.placementadmissionclassificationkey;
                var _intakeserviceid = request.intakeserviceid;
                var providername = request.providername;
                var releasedate = request.releasedate;
                if (placementadmissionclassificationkey === 'RES'){

                var sql2 = "select * from sendrestitutionnotification($1,$2,$3,$4)"

                util.executeDBQuery(sql2,[placementadmissionclassificationkey,_intakeserviceid,providername,releasedate]);
                return rs;

            }

                })

        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Placement.remoteMethod('search', {
        http: {
            path: '/search',
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

    Placement.search =(request)=> {
        var placementid= request.where.placementid;
        LOGGER.debug(placementid+"My idddd");
        var sql = 'select * from placementedit($1)';

        return util.executeDBQuery(sql, [placementid])
        .then(withTotalcount)
        .catch(logAndRethrow);
    };

    Placement.remoteMethod('placementsummary', {
        http: {
            path: '/placementsummary',
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

    Placement.placementsummary =(request)=> {
        var personid= request.where.personid;

        const limit = request.limit;
            const skip = request.page;
            var status = request.status
            var personsearch= request.where.personsearch;
            LOGGER.debug(status)

        var sql = 'select * from getplacementsummary($1,$2,$3,$4,$5)';

        return util.executeDBQuery(sql, [personid,skip,limit,status,personsearch])
        .then(withTotalcount)
        .catch(logAndRethrow);

    };

    Placement.remoteMethod('placementresidential', {
        http: {
            path: '/placementresidential',
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

    Placement.placementresidential =(request)=> {
        var sql = 'select * from getresidentialstatus($1)';

        return util.executeDBQuery(sql, [request.where.personid])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    Placement.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},
                    {arg: 'req', type: 'object',
            http: { source: 'req'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Placement.addupdate = (request, req, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;
        if(request.placementtypekey !== undefined && request.placementtypekey !== null
            && request.placementtypekey === 'LA' ) {
            return Placement.livingarrangementaddupdate(request, _securityusersid)
            .then(data => {
                const livingdetails = data;
                var sql1 = placementrevisionupdatesql;
                const placeId = checkLivingPlacementId(request, data);
                return util.executeDBQuery(sql1,[placeId,request.startdate,request.starttime,request.voidreasontypekey,request.voidremarks,request.enddate,request.endtime,request.exittypekey,request.remarks,request.exitreasontypekey,0,request.v_securityusersid,null,request.justification,request.ischangepreadoptive,request.transferagency ,request.otherpublicagency, request.leastrestrictiveplacement, request.livingarrangementluggage,request.laluggagepurchased,request.laluggagecomments,request.ladisposableortrashbag,request.exitluggage, request.exitluggageprovided ,request.exitluggagecomments,request.exitdisposableortrashbag])
                .then(data1 => {
                    const resp = {};
                    resp.msgStatus = 'Success';
                    resp.code = 200;
                    resp.message = placementsuccessfulmsg;
                    return request.health ?  livingdetails : resp;
                }).then(async resp => {
                    const hospResp =  await save_la_hospitalization(request, resp);
                    LOGGER.info(hospResp);
                    return hospResp;
                })
                .then(data2 => data2)
                .catch(err => {
                    LOGGER.error(err);
                    var errMsg = {};
                    errMsg.message = err;
                    errMsg.code = 400;
                    errMsg.msgStatus = 'ERROR';
                    return errMsg;
                })
            })
        } else {
            let vstate;
            return Placement.placementaddupdate(request, _securityusersid)
                .then(data => {
                    vstate = data.vstate;
                    if (data.error) {
                        var err = new Error(data.error);
                        err.message = data.error;
                        err.code = 400;
                        err.msgStatus = 'ERROR';
                        err.vstate = data.vstate;
                        return err;
                    }
                    // status1 = 15
                    const plid = checkPlacementId(data, request);
                    return util.executeDBQuery(placementrevisionupdatenew,  [plid, request.startdate, request.starttime, request.voidreasontypekey, request.voidremarks, request.enddate, 
                        request.endtime, request.exittypekey, request.remarks, request.exitreasontypekey, 0, request.v_securityusersid, null, 
                                          request.leastrestrictiveplacement,request.placementluggage,request.plluggagepurchased,request.plluggagecomments,request.placementdisposableortrashbag,request.exitluggage, request.exitluggageprovided ,request.exitluggagecomments,request.exitdisposableortrashbag])
                    .then(data1 => {
                        return data1[0].placementrevisionupdatenew;
                    })
                    .catch(err1 => {
                        LOGGER.error(err1);
                        return err1;
                    })
                })
                .then(data1 => {
                    if (data1.msgStatus === 'ERROR'){
                        return data1;
                    }
                    const resp = {};
                    resp.msgStatus = data1;
                    resp.vstate = vstate;
                    resp.message = placementsuccessfulmsg;
                    return resp;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

        }
    }

    function save_la_hospitalization(request, resp){
        if(request && request.health) {
            let livingid = resp.livingid;
            let placementid = resp.placementid;
            if (!placementid) {
                livingid = request.livingid;
                placementid = request.placementid;
            }
            var sql = 'select * from save_la_hospitalization($1, $2, $3, $4, $5, $6, $7)';
            return util.executeDBQuery(sql, [request.personid, request.health, null, livingid, placementid, request.v_securityusersid, request.health.isnew])
                .then(() => {
                    const res = {};
                    res.msgStatus = 'Success';
                    res.code = 200;
                    res.message = placementsuccessfulmsg;
                    return res;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        } else {
            return resp;
        }
    }

    function checkLivingPlacementId(request, data){
        return request.placementid ? request.placementid : data.placementid;
    }

    function checkPlacementId(data, request){
        if (data.placementid === null || data.placementid === undefined) {
            data.placementid = request.placementid;
        }
        return data.placementid;
    }

    Placement.livingarrangementaddupdate = (request, _securityusersid) => {
        if (request.placementid !== undefined && request.placementid !== null) {
            return Placement.livingarrangementupdate(request);
        } else {
            return Placement.livingarrangementadd(request, _securityusersid);
        }
    }

    Placement.livingarrangementadd = function (request,_securityusersid) {
        var responseJson = {};
        var v_placementid;
        const vsecurityusersid = _securityusersid;
        return Placement.create({
            servicecaseid: request.servicecaseid,
            intakeservreqchildremovalid: request.intakeservreqchildremovalid,
            intakeservicerequestactorid: request.intakeservicerequestactorid,
            remarks: request.remarks,
            leastrestrictiveplacement: request.leastrestrictiveplacement,
            personid: request.personid,
            startdatetime: request.startdate,
            placementtypekey: request.placementtypekey,
            insertedby: vsecurityusersid,
            updatedby: vsecurityusersid,
            //    isplacedoutside:request.isplacedoutside,
            ischildplacedoutside: request.ischildplacedoutside,
            primaryrelationship: request.primaryrelationship
        }).then(resp => {
            v_placementid = resp.placementid;
            return app.models.Livingarrangement.create({
                placementid: v_placementid,
                livingarrangementtypekey: request.livingarrangementtypekey,
                personid: request.personid,
                livingstartdate: request.startdate,
                livingenddate: request.enddate,
                caregiverclientid: request.caregiverclientid,
                partnerid: request.partnerid,
                primarycaregiver: request.primarycaregiver,
                secondarycaregiver: request.secondarycaregiver,
                primaryrelationship: request.primaryrelationship,
                homephone: request.contactphone,
                workphone: request.workphone,
                streetname: request.add1,
                streettext: request.add2,
                cityname: request.cityname,
                countytypekey: request.countytypekey,
                statetypekey: request.statetypekey,
                zip5no: request.zipcode,
                country: request.country,
                whereabouts: request.whereabouts,
                tribalservicearea: request.tribalservicearea,
                runawayreported: request.runawayreported && request.runawayreported === 'YES' ? true : false,
                runawayreportnumber: request.runawayreportnumber ? request.runawayreportnumber.substring(0,50) : null,
                insertedby: vsecurityusersid,
                updatedby: vsecurityusersid,
                fostercarehome: request.fostercarehome,
                fostercarenonfoster: request.fostercarenonfoster,
                hotelorother: request.hotelorother,
                agency1to1: request.agency1to1,
                agency1to1desc: request.agency1to1desc,
                agency1to1explaination: request.agency1to1explaination,
                dailyrate: request.dailyrate,
                ratetype: request.ratetype,
                agency1to1rate: request.agency1to1rate,
                fostercomments: request.fostercomments,
                laluggagecomments: request.laluggagecomments,
                ladisposableortrashbag:request.ladisposableortrashbag,               
                livingarrangementluggage: laluggageCheck(request.livingarrangementluggage),
                laluggagepurchased: laluggageCheck(request.laluggagepurchased)
            })
        }).then(resp => {
            responseJson = resp;
            var status = 15;
            if (request && request.personid) {
                util.auditLogSingleSave(request.personid,'LEAVINGP',request);
            }
            var nofitymsg = 'Living Arrangement Submitted for review';
            var sql = routingintakesql;
            return util.executeDBQuery(sql,[resp.placementid,request.v_securityusersid,'PLTR',status,'','',false,false,false,nofitymsg,nofitymsg,
            request.servicecaseid,'',1])
                .then(data3 => {
                    return data3[0].routingintake;
                })
                .then((res) => {
                    if (request.livingarrangementluggage === false && request.laluggagepurchased === false) {
                        const sql2 = 'select up.fullname as v_workername,up.supervisorid as v_supervisor from userprofile up where up.securityusersid = $1'
                        return util.executeDBQuery(sql2,[request.v_securityusersid])
                        .then(data => {
                            const luggagemessage = data[0].v_workername + ' has entered a Child into a Placement or Living Arrangement without luggage for a child in Case  ' + request.casenumber + '. Please follow up with the Worker to ensure compliance';
                                const sql1 = placementluggagenotification;
                                return util.executeDBQuery(sql1,[data[0].v_supervisor,request.v_securityusersid,data[0].v_supervisor,'System','High',luggagemessage,luggagemessage,request.servicecaseid,false,request.placementid])
                                .then(_data => {
                                    return _data[0].send_notification;
                                })
                                .catch(err => {
                                    LOGGER.error(err);
                                    return err;
                                })
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            return err;
                        })
                    }
                })
                .catch(err1 => {
                    LOGGER.error(err1);
                    return err1;
                })
        }).then(data => {
            return responseJson;
        }).catch(err => {
            LOGGER.error(err);
            return err;
        });
    }

    function laluggageCheck(value){
        const falseCase = value === 'NO' || value === false ? false : null;
        return (value === 'YES' || value === true) ? true : falseCase;
    }

    Placement.livingarrangementupdate = function(request) {
       
        const tosecurityuserid = (request.isSupervisor) ? request.v_securityusersid : '';

        if (util.isNullorEmpty(request.placementid)) {
            return Placement.updateAll(
                {placementid:request.placementid},
                {
                servicecaseid:request.servicecaseid,
                intakeservreqchildremovalid:request.intakeservreqchildremovalid,
                intakeservicerequestactorid:request.intakeservicerequestactorid,
                personid:request.personid,
                remarks:request.remarks,
                leastrestrictiveplacement:request.leastrestrictiveplacement,
                startdatetime:request.startdate,
                placementtypekey:request.placementtypekey,
                insertedby:request.v_securityusersid,
            //   isplacedoutside:request.isplacedoutside,
                ischildplacedoutside:request.ischildplacedoutside,
                justification: request.justification,
                primaryrelationship:request.primaryrelationship                
            }).then(record => {
                var sql = ` select livingid from livingarrangement where placementid = $1 ORDER BY insertedon desc limit 1; `
                return util.executeDBQuery(sql, [request.placementid])
                .then(data => {
                    return data;
                })
                .catch(err => {
                    LOGGER.error(err)
                })

            }).then(livingdata => {

                var sql = `     with updated as (
                                    update livingarrangement set activeflag = 0, updatedby = $16, updatedon = now() where placementid = $1
                                    RETURNING *
                                )
                                update livingarrangement
                                set livingenddate = $2, caregiverclientid = $3, partnerid = $4,
                                    primarycaregiver = $5, secondarycaregiver = $6, primaryrelationship = $7, homephone = $8, workphone = $9, streetname  = $10,
                                    streettext = $11, cityname = $12, countytypekey = $13, statetypekey = $14, zip5no = $15, insertedby = $16, activeflag = 1,
                                    livingarrangementtypekey = $17, livingstartdate = $18, updatedby = $19, personid = $20, country = $21, whereabouts = $22,
                                    tribalservicearea =$23, updatedon = now() ,fostercarenonfoster=$24,fostercomments =$25,livingarrangementluggage = $26,laluggagepurchased = $27,laluggagecomments =$28,ladisposableortrashbag=$29,
                                    hotelorother = $30,agency1to1 = $31,
                                    agency1to1desc = $32, agency1to1explaination = $33, dailyrate = $34, ratetype = $35, agency1to1rate = $36
                                where livingid in (select livingid from livingarrangement where placementid = $1 ORDER BY insertedon desc limit 1); `

                if(livingdata === null || livingdata.length === 0) {
                    sql = `  insert into livingarrangement(placementid,
                                    livingenddate,
                                    caregiverclientid,
                                    partnerid,
                                    primarycaregiver,
                                    secondarycaregiver,
                                    primaryrelationship,
                                    homephone,
                                    workphone,
                                    streetname,
                                    streettext,
                                    cityname,
                                    countytypekey,
                                    statetypekey,
                                    zip5no,
                                    insertedby,
                                    activeflag,
                                    livingarrangementtypekey,
                                    livingstartdate,
                                    updatedby,
                                    updatedon,
                                    personid,
                                    country,
                                    whereabouts,
                                    tribalservicearea,
                                    fostercarenonfoster,
                                    fostercomments,
                                    hotelorother,agency1to1, agency1to1desc, agency1to1explaination, dailyrate, ratetype, agency1to1rate
                                ) values($1, $2,  $3,  $4,
                                    $5,  $6,  $7,  $8,  $9,   $10,
                                    $11,  $12,  $13,  $14,  $15,  $16, 1,
                                    $17,  $18, $19, now(), $20, $21, $22, $23,$24,$25, $26, $27, $28, $29, $30, $31, $32)  `
                }

                return util.executeDBQuery(sql, [request.placementid,
                    request.enddate,
                    request.caregiverclientid,
                    request.partnerid,
                    request.primarycaregiver,
                    request.secondarycaregiver,
                    request.primaryrelationship,
                    request.contactphone,
                    request.workphone,
                    request.add1,
                    request.add2,
                    request.cityname,
                    request.countytypekey,
                    request.statetypekey,
                    request.zipcode,
                    request.v_securityusersid,
                    request.livingarrangementtypekey,
                    request.startdate,
                    request.v_securityusersid,
                    request.personid,
                    request.country,
                    request.whereabouts,
                    request.tribalservicearea,
                    request.fostercarenonfoster,
                    request.fostercomments,
                    request.livingarrangementluggage,
                    request.laluggagepurchased,
                    request.laluggagecomments,
                    request.ladisposableortrashbag,
                    request.hotelorother,    
                    request.agency1to1, 
                    request.agency1to1desc, 
                    request.agency1to1explaination,     
                    request.dailyrate,
                    request.ratetype,
                    request.agency1to1rate          
                ])
                .then(data => {
                    return data;
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
               
            }).then(resp => {
                var status = 15;
                var nofitymsg = 'Living Arrangement Submitted for review';
                var sql = routingintakesql;
                if(request && request.personid){
                util.auditLogSingleSave(request.personid,'LEAVINGP',request);
                }
                return util.executeDBQuery(sql, [request.placementid, request.v_securityusersid, 'PLTR', status, '', tosecurityuserid,
                false, false, false, nofitymsg,nofitymsg,request.servicecaseid,'',1])
                .then(data => {
                    return data[0].routingintake;
                })
                .then((res)=>{
                    if(request.livingarrangementluggage === false && request.laluggagepurchased === false){
                      const sql2='select up.fullname as v_workername,up.supervisorid as v_supervisor from userprofile up where up.securityusersid = $1'  
                   
                      return util.executeDBQuery(sql2,[request.v_securityusersid])
                        .then(data => {
                            const sql1 = placementluggagenotification ;
                            const luggagemessage =  data[0].v_workername + ' has entered a Child into a Placement or Living Arrangement without luggage for a child in Case  ' + request.casenumber +'. Please follow up with the Worker to ensure compliance';
                            return util.executeDBQuery(sql1, [data[0].v_supervisor ,request.v_securityusersid,data[0].v_supervisor,'System', 'High',luggagemessage,luggagemessage,request.servicecaseid,false,request.placementid])
                            .then(_data => {
                                return _data[0].send_notification;
                            })
                            .catch(_err => {
                                LOGGER.error(_err);
                                return _err;
                            })
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            return err;
                        })
                    } 
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
            }).then(data => {
                return "Living Arrangement Updated Successfully";
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
    }
   
    Placement.placementaddupdate = (request, _securityusersid) => {

        if (request.placementid !== undefined && request.placementid !== null) {
            return Placement.placementupdate(request, _securityusersid).then(data =>{
                if (request.activereviewcheck === 'firstreview'){
                    Placement.releaseLock(request.providerid,request.contractprogramid,data.vstate);
                }
                return data;
            });
        } else {
            return Placement.placementadd(request, _securityusersid).then(data1 =>{
                if (request.activereviewcheck === 'firstreview'){
                    Placement.releaseLock(request.providerid,request.contractprogramid,data1.vstate);
                }
                return data1;
            });
        }



    }

    Placement.placementadd = async function(request, _securityusersid) {
        var responseJson = {};
        var type = "publicprov";
        var vstate = {};
   
        if (request.contractprogramid != null && request.contractprogramid != undefined) { type = 'privateprov'; } 
               

    vstate = await Placement.acquireRowLock(request.providerid,request.contractprogramid, 0, type);
         
             
        if (!vstate.isLocked) {
            return checkIsLocked(responseJson, vstate)
        }

        return Placement.create({
            altproviderid:request.providerid,
            intakeserviceid:request.intakeserviceid,
            intakeservicerequestactorid:request.intakeservicerequestactorid,
            remarks:request.remarks,
            leastrestrictiveplacement: request.leastrestrictiveplacement,
            startdatetime:request.startdate,
            personid:request.personid,
            enddatetime:request.enddate,
            endtime:request.endtime,
            justification:request.justification,
            placementtypekey:request.placementtypekey,
            service_id:request.service_id,
            servicecaseid:request.servicecaseid,
            intakeservreqchildremovalid:request.intakeservreqchildremovalid,
            ratestructureid:request.ratestructureid,
            starttime:request.starttime,
            providersentdate:request.providersentdate,
            providerdesc:request.providerdesc,
            responseacceptedkey:request.responseacceptedkey,
            rejectreasonkey:request.rejectreasonkey,
            isssaapproval:request.isssaapproval,
            ifcapprovaldate:request.ifcapprovaldate,
            insertedby: _securityusersid,
            updatedby: _securityusersid,
            providerorganizationid: request.providerorganizationid,
            contractprogramid: request.contractprogramid,
        //   isplacedoutside: request.isplacedoutside,
            ischildplacedoutside:request.ischildplacedoutside,
            primaryrelationship: request.primaryrelationship,
            exitreasontypekey: request.exitreasontypekey,
            exittypekey: request.exittypekey,
            placementluggage:request.placementluggage,
            plluggagepurchased:request.plluggagepurchased,
            plluggagecomments:request.plluggagecomments,
            placementdisposableortrashbag:request.placementdisposableortrashbag,
            exitluggage:request.exitluggage,
            exitluggageprovided:request.exitluggageprovided ,
            exitluggagecomments:request.exitluggagecomments,
            exitdisposableortrashbag:request.exitdisposableortrashbag
        })
        .then( (resp) => {
            responseJson  = resp;
            responseJson.vstate = vstate;
            if(request.responseacceptedkey==='4612'){
                
                // Out of Sequence Send for Approval change
                // if(request.enddate == null || request.enddate == undefined) {
                    
                    updatecontactprogram(vstate, _securityusersid, request)
               // }

                var status = 15;
                var nofitymsg = 'Provider placement submitted for review';
                var sql = routingintakesql;
                if(request && request.personid){
                    util.auditLogSingleSave(request.personid,'PLACEMENT',request);
                }

                return util.executeDBQuery(sql, [resp.placementid, request.v_securityusersid, 'PLTR', status, '', '', false, false, false,
                nofitymsg,nofitymsg,request.servicecaseid,'',1])
                .then(data => {
                    return data[0].routingintake;
                })
                .then((res)=>{
                    if(request.placementluggage === false && request.plluggagepurchased === false){
                        const sql2='select up.fullname as v_workername,up.supervisorid as v_supervisor from userprofile up where up.securityusersid = $1'  
                     
                        return util.executeDBQuery(sql2,[request.v_securityusersid])
                        .then(data => {
                            const luggagemessage =  data[0].v_workername + ' has entered a Child into a Placement or Living Arrangement without luggage for a child in Case  ' + request.casenumber +'. Please follow up with the Worker to ensure compliance';
                              const sql1 = placementluggagenotification ;
                              return util.executeDBQuery(sql1, [data[0].v_supervisor ,request.v_securityusersid,data[0].v_supervisor,'System', 'High',luggagemessage,luggagemessage,request.servicecaseid,false,request.placementid])
                                .then(_data => {
                                    return _data[0].send_notification;
                                })
                                .catch(_err => {
                                    LOGGER.error(_err);
                                    return _err;
                                })
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            return err;
                        })
                    } 
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
            }
        })
        .then(data => { return responseJson;})
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    function checkIsLocked(responseJson, vstate) {
        if (vstate.vacancyno === 0) { 
            responseJson.error = "Provider has no Vacancy"; 
        }
        if (vstate.vacancyno > 0) { 
            responseJson.error = "Something went wrong! Please retry"; 
        }
        if (vstate.error) { 
            responseJson.error = vstate.error; 
        }
        responseJson.vstate = vstate;
        return responseJson;
    }

    function updatecontactprogram(vstate, _securityusersid, request){
        let sql2 = '';
        let params = [];
        if (vstate.isLocked) {
            const updatedby = _securityusersid;
            sql2 = `UPDATE tb_provider set vacancy_no = (vacancy_no - 1), update_ts = now(), update_user_id = $1, row_lock=null where provider_id = $2 AND row_lock=$3`;
            params = [updatedby, request.providerid, vstate.myTime];

            if (request.contractprogramid !== undefined && request.contractprogramid !== null) {
                sql2 = `UPDATE tb_contract_program set vacancy_no = (vacancy_no - 1), update_ts = now(), update_user_id = $1, row_lock=null where program_id = $2 AND row_lock=$3`;
                params = [updatedby, request.contractprogramid, vstate.myTime];
            }

            util.executeDBQuery(sql2, params)
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
        }
        if(request && request.personid){
            util.auditLogSingleSave(request.personid,'PLACEMENT',request);
        }
    }
                    

    Placement.acquireRowLock=(providerid,programid, attempt,type)=>{
        return new Promise((resolve) => {
            Placement.tryLock(providerid,programid,type)
            .then(async(vstate)=>{
                if (vstate.isLocked || vstate.vacancyno===0) {resolve(vstate); return;}
                while (!vstate.isLocked && attempt<3) {
                    await delay(2000);
                    attempt++;
                    vstate = await Placement.tryLock(providerid,programid,type);
                    if (vstate.isLocked || (!vstate.isLocked && attempt===3)) {resolve(vstate); return;}
                }
            })
            .catch((err)=> {
                LOGGER.error(err);
            });
        });
    }

    Placement.tryLock=(providerid,programid,type)=>{
        return new Promise((resolve, reject) => {
            var sql = 'select * from cjams.sp_provider_vacancy_check($1,$2)';
            util.executeDBQuery(sql, [providerid, programid])
            .then(d => {
                const vstate = {isLocked: false, vacancyno: 0,myTime :null};
                vstate.vacancyno = (d.length>0 && d[0].as_vacancy_no)? Number(d[0].as_vacancy_no): 0;
                if(d.length>0 && vstate.vacancyno>=1) {
                    const myTime =  uuid();
                    vstate.myTime = myTime;                
                    var sql1 = "";
                    
                    vstate.isPublic  = checkisPublic(type);

                    if (vstate.isPublic)
                     {
                         sql1 = `UPDATE prov.tb_provider SET row_lock=$1 WHERE row_lock IS NULL AND vacancy_no>0 AND provider_id=$2`;

                         util.executeDBQuery(sql1, [myTime, providerid])
                        .then(d1 => {
                            vstate.updatelock = d1;
                            findTbProvider(providerid,myTime,vstate).then(s=>{
                                resolve(s);
                            })
                        })
                        .catch(err => {
                            vstate.updateError = err;
                            vstate.isLocked = false;
                            resolve(vstate);
                        })
                     }
                    else {
                        sql1 = `UPDATE prov.tb_contract_program SET row_lock=$1 WHERE row_lock IS NULL AND vacancy_no>0 AND program_id=$2`;
                        util.executeDBQuery(sql1, [myTime, programid])
                        .then(d1 => {
                            findProvidercontractprogram(programid, myTime, vstate).then(s=>{
                                resolve(s);
                            })
                            
                        })
                        .catch(err1 => {
                            vstate.updateError = err1;
                            vstate.isLocked = false;
                            resolve(vstate);
                        })
                    }
                } else {
                    vstate.error = d[0].as_mess;
                    resolve(vstate);
                }
            })
            .catch(err => {
                LOGGER.error(err);
                reject(err);
            })
        });
    }

    function checkisPublic(type) {
        return (type === 'publicprov') ? true : false;
    }

    function findProvidercontractprogram(programid,myTime,vstate) {
        return new Promise((resolve,reject) => {
            app.models.Providercontractprogram.find({ where: { 'program_id': programid,'row_lock': myTime } })
                .then(d3 => {
                    vstate.foundlock = d3;
                    if (d3.length > 0) {
                        vstate.isLocked = true;
                        vstate.myTime = myTime;
                        resolve(vstate);
                    } else {
                        vstate.isLocked = false;
                        resolve(vstate);
                    }
                })
                .catch(err => {
                    vstate.isLocked = false;
                    resolve(vstate);
                });
        });
    }

    function findTbProvider(providerid,myTime,vstate) {
        return new Promise((resolve,reject) => {
            app.models.Tb_provider.find({ where: { 'provider_id': providerid,'row_lock': myTime } })
                .then(d2 => {
                    vstate.foundlock = d2;
                    if (d2.length > 0) {
                        vstate.isLocked = true;
                        vstate.myTime = myTime;
                        resolve(vstate);
                    } else {
                        vstate.isLocked = false;
                        resolve(vstate);
                    }
                })
                .catch(err => {
                    vstate.isLocked = false;
                    resolve(vstate);
                });
        })
    }

    Placement.releaseLock=(providerid, programid, vstate)=> {
        let sql2 = `UPDATE tb_contract_program SET row_lock = null where program_id = $1 AND row_lock=$2`;
        let params = [programid, vstate.myTime];

        if (programid == null) {
            sql2 = `UPDATE tb_provider SET row_lock=null where provider_id = $1 AND row_lock=$2`;
            params = [providerid, vstate.myTime];
        }

        return util.executeDBQuery(sql2, params)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }


    Placement.placementupdate=async function(request, _securityusersid) {
        var responseJson = {};
        var type = "publicprov";
        var vstate = {};

            if (request.activereviewcheck === 'firstreview') {
                if (request.contractprogramid != null && request.contractprogramid != undefined) { type = 'privateprov'; } 
                vstate = await Placement.acquireRowLock(request.providerid, request.contractprogramid, 0, type);


                if (!vstate.isLocked) {

                    if (vstate.vacancyno === 0) { responseJson.error = "Provider has no Vacancy"; }
                    if (vstate.vacancyno > 0) { responseJson.error = "Something went wrong! Please retry"; }
                    if (vstate.error) { responseJson.error = vstate.error; } 
                    responseJson.vstate = vstate;
                    return responseJson;

                }

            }

        return Placement.updateAll(
            {   placementid:request.placementid },
            {
                altproviderid:request.providerid,
                intakeserviceid:request.intakeserviceid,
                intakeservicerequestactorid:request.intakeservicerequestactorid,
                remarks:request.remarks,
                leastrestrictiveplacement: request.leastrestrictiveplacement,
                startdatetime:request.startdate,
                personid:request.personid,
                enddatetime:request.enddate,
                service_id:request.service_id,
                servicecaseid:request.servicecaseid,
                intakeservreqchildremovalid:request.intakeservreqchildremovalid,
                ratestructureid:request.ratestructureid,
                starttime:request.starttime,
                endtime:request.endtime,
                justification:request.justification,
                providersentdate:request.providersentdate,
                providerdesc:request.providerdesc,
                responseacceptedkey:request.responseacceptedkey,
                rejectreasonkey:request.rejectreasonkey,
                isssaapproval:request.isssaapproval,
                ifcapprovaldate:request.ifcapprovaldate,
                updatedby:request.v_securityusersid,
                providerorganizationid: request.providerorganizationid,
                contractprogramid: request.contractprogramid,
            //   isplacedoutside:request.isplacedoutside,
                ischildplacedoutside:request.ischildplacedoutside,
                primaryrelationship: request.primaryrelationship,
                placementluggage:request.placementluggage,
                plluggagepurchased:request.plluggagepurchased,
                plluggagecomments:request.plluggagecomments,
                placementdisposableortrashbag:request.placementdisposableortrashbag,
                exitluggage:request.exitluggage,
                exitluggageprovided:request.exitluggageprovided ,
                exitluggagecomments:request.exitluggagecomments,
                exitdisposableortrashbag:request.exitdisposableortrashbag
        })
        .then( (resp) => {
            responseJson  = resp;
            responseJson.vstate = vstate;
            return updateTBProvider(request, vstate, _securityusersid);

        })

            .then(data => { return responseJson;})
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    function updateTBProvider(request, vstate, _securityusersid){
        let nofitymsg = '';
        let sql = '';
        if(request.responseacceptedkey==='4612'){
            if (request.activereviewcheck === 'firstreview') {
               // if (request.enddate == null || request.enddate == undefined) {
                    //let vstate = await Placement.acquireRowLock(request.providerid, 0);

                    if (vstate.isLocked) {
                        const updatedby = _securityusersid;
                        let sql2 = `UPDATE tb_provider set vacancy_no = (vacancy_no - 1), update_ts = now(), update_user_id = $1, row_lock=null where provider_id = $2 AND vacancy_no>0 AND row_lock=$3`;
                        let params = [updatedby, request.providerid, vstate.myTime];             

                        if (request.contractprogramid !== undefined && request.contractprogramid !== null) {
                            sql2 = `UPDATE tb_contract_program set vacancy_no = (vacancy_no - 1), update_ts = now(), update_user_id = $1, row_lock=null where program_id = $2 AND vacancy_no>0 AND row_lock=$3`;
                            params = [updatedby, request.contractprogramid, vstate.myTime];
                        } 
                        util.executeDBQuery(sql2, params)
                        .then(data => {
                            LOGGER.info(data);
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            return err;
                        })
                    }
                //}

            }

                var status = 15;
                saveAuditLog(request);
                nofitymsg = 'Provider placement submitted for review';
                sql = routingintakesql;

                return util.executeDBQuery(sql, [request.placementid, request.v_securityusersid, 'PLTR', status, '', '', false, false, false, nofitymsg,nofitymsg,request.servicecaseid,'',1])
                .then(data => {
                    return data[0].routingintake;
                })
                .then((res)=>{
                    if(request.placementluggage === false && request.plluggagepurchased === false){
                        const sql2='select up.fullname as v_workername,up.supervisorid as v_supervisor from userprofile up where up.securityusersid = $1'  
                     
                        return util.executeDBQuery(sql2,[request.v_securityusersid])
                        .then(data => {
                            const sql1 = placementluggagenotification ;
                            const luggagemessage =  data[0].v_workername + ' has entered a Child into a Placement or Living Arrangement without luggage for a child in Case  ' + request.casenumber +'. Please follow up with the Worker to ensure compliance';
                              return util.executeDBQuery(sql1, [data[0].v_supervisor ,request.v_securityusersid,data[0].v_supervisor,'System', 'High',luggagemessage,luggagemessage,request.servicecaseid,false,request.placementid])
                                .then(_data => {
                                    return _data[0].send_notification;
                                })
                                .catch(err => {
                                    LOGGER.error(err);
                                    return err;
                                })
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            return err;
                        })
                    } 
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
            }
            nofitymsg = 'Provider placement submitted for review';
            sql = routingintakesql;
            return util.executeDBQuery(sql, [request.placementid, request.v_securityusersid, 'PLTR', status, '', '', false, false, false, nofitymsg,nofitymsg,request.servicecaseid,'',1])
            .then(data => {
                return data[0].routingintake;
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })
        }

        function saveAuditLog(request){
            if(request && request.personid){
                util.auditLogSingleSave(request.personid,'PLACEMENT',request);
            }
        }
    

    Placement.remoteMethod('voidplacementadd', {
        http: {
                path: '/voidplacementadd',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Placement.voidplacementadd=(request)=>{

            var status = 15;
            var nofitymsg = 'Void placement submitted for review';
            var comments = 'Void placement submitted for review';
            var sql = routingintakesql;
            return util.executeDBQuery(sql, [request.placementid, request.v_securityusersid, 'PLTR', status, comments, '', false, false, false, nofitymsg,nofitymsg,request.servicecaseid,'',1])
            .then(data => data[0].routingintake)
            .then(data => {
                // status1 = 15
                return util.executeDBQuery(placementrevisionupdatenew,  [request.placementid,null,null,request.voidreasontypekey,request.voidremarks,null,null,null,null,null,request.isvoided,
                        request.v_securityusersid,request.voiddate,request.leastrestrictiveplacement,request.placementluggage,request.plluggagepurchased,request.plluggagecomments,request.placementdisposableortrashbag,request.exitluggage, request.exitluggageprovided ,request.exitluggagecomments,request.exitdisposableortrashbag])
                    .then(data1 => data1[0].placementrevisionupdatenew);
        //   })
        })
        // .then( async res =>{
        //     //@Simar - Making the chessie placement update call
        //     LOGGER.debug("CHESSIE - REQUEST", res);
        //     request.placementtype = 'VOID';
        //     let resp = await Placement.updateProviderPlacementChessie(request);
        //  })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
       
    Placement.remoteMethod('placementAutoValidation', {
        http: {
                path: '/placementAutoValidation',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Placement.placementAutoValidation = (request) => {
        LOGGER.debug('>>>>Placement.placementAutoValidation initiated'+JSON.stringify(request));
        var neworupdate = '';
        var qry = 'SELECT * FROM checkplacementvalidation($1,$2)';
        var isbefore = request.isbefore;
        return util.executeDBQuery(qry, [request.placementid,request.fromscreen])
        .then(data => {
            return data[0].checkplacementvalidation;
        })
        .then(data => {
            LOGGER.debug('>>>>checkplacementvalidation completed '+data);
            // pv-- From placement validation screen
            neworupdate = request.fromscreen === 'pv' ? 'Y' : data; 
            if (neworupdate != 'P' && neworupdate == 'Y' && isbefore && request.placementid != null && request.placementid != undefined && request.startdate != null && request.startdate != undefined) {
                neworupdate = 'N';
                LOGGER.debug('>>>>neworupdate=N,isbefore = true>>>> sp_placement_validation_update started.');
            }else if (neworupdate === 'P'  && isbefore === false && request.placementid != null && request.placementid != undefined && request.startdate != null && request.startdate != undefined) {
                LOGGER.debug('>>>>neworupdate=P,isbefore = false>>>> sp_placement_validation_update started.');
            }else if (neworupdate === 'Y'  && isbefore === false && request.placementid != null && request.placementid != undefined && request.startdate != null && request.startdate != undefined) {
                LOGGER.debug('>>>>neworupdate=Y,isbefore = false>>>> sp_placement_validation_update started.');
            }else {
                return data;
            }
            return util.executeDBQuery(sp_placement_validation_updatesql, [request.placementid, request.startdate, request.enddate, neworupdate])
            .then(data1 => {
                return data1;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
        })
        .then(data => {
            if (data[0].as_auto_valid_success_sw && data[0].as_auto_valid_success_sw === 'N') {
                
             return app.models.Tb_placement_auto_validation_log.find({
                 where: {    placement_id: request.placementid,
                             activeflag: 1
                         },
                 fields: ['placement_auto_validation_log_id', 'insert_updt_sw', 'placement_id',
                     'validation_start_dt', 'validation_end_dt', 'auto_valid_sw', 'error_reasons'],
                 order: 'placement_id'
             })
         }
         })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    // new method added for placement table change - may05 2019  - starts

    Placement.placementexit = function (request, reqctx) {
        let _securityusersid = undefined;
if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
 _securityusersid = reqctx.req.headers.securityusersid;
}  
        const currentDate = new Date().toLocaleString();

        return app.models.placmentrevision.create({
            placementid: request.placement_id,
            entrydate: request.entry_dt,
            entrytime: request.entry_tm,
            exittypetypkey: request.exit_type_cd,
            exitreasontypkey: request.exit_reason_cd,
            exitexplanation: request.exit_explanation_tx,
            exitdate: request.exit_dt,
            exittime: request.exit_tm,
            deletesw: request.delete_sw,
            insertedon: currentDate,
            insertedby: (request && request.securityuserid ? request.securityuserid : _securityusersid),
            updatedby: (request && request.securityuserid ? request.securityuserid : _securityusersid),
            updatedon: currentDate,
        }).then(resp => {
            var status = 15;
            var nofitymsg = 'Placement Exit for Review';
            var comments = 'Placement Exit for Review'
            var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
            return util.executeDBQuery(sql, [request.placement_id, (request && request.securityuserid?request.securityuserid: _securityusersid), 'PLTR', status, comments, '', false, false, false, nofitymsg, '', request.intakeserviceid])
                .then(data => data[0].routingintake);
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Placement.remoteMethod('placementexit', {
        http: {
        path: '/placementexit',
        verb: 'post'
        },
        accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
        }, {
arg: 'reqctx',
type: 'object',
http: {source: 'context'}
 }],
        returns: {
        type: 'string',
        root: true
        }
    });

    // new method added for placement table change - may05 2019  - ends

    Placement.remoteMethod('placementvalidation', {
        http: {
            path: '/placementvalidation',
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

    Placement.placementvalidation =(request)=> {
   

        var sql = 'select * from getplacementvalidations($1)';

        return util.executeDBQuery(sql, [request.where.personid])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    /**
     * API calls for CHESSIE Data Sync
     */
    module.exports.callupdatechessie = (request) => {
        return Promise.resolve('success')
    }

      Placement.getplacementbyperson = (request) => {
        var personid = request.where.personid || null;
        var cjamspid =request.where.cjamspid || null;
        var sql = 'select * from getplacementbyperson($1,$2)';

        return util.executeSecondaryNodeDBQuery(sql, [personid, cjamspid])
            .then(data => {
                return data[0].getplacementbyperson;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Placement.remoteMethod('getplacementbyperson', {
        http: {
            path: '/getplacementbyperson',
            verb: 'get'
        },
        accepts: [
            {
                arg: 'filter',
                type: 'object',
                http: { source: 'query' }
            }],
        returns: {
            type: 'object',
            root: true
        }
    });


    Placement.remoteMethod('fprimcountry', {
        http: {
            path: '/fprimcountry',
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

    Placement.fprimcountry =(request)=> {
        var casenumber= request.where.casenumber;
        var sql = 'select * from f_prim_county($1::bigint, \'NULL\'::character varying)';

        return util.executeDBQuery(sql, [casenumber])
        .then(data => {
            var result;
            result = {
                'data' : data
            };
            return result;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Placement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Placement.observe('access', (ctx, next) => util.access(ctx, next));
    Placement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}