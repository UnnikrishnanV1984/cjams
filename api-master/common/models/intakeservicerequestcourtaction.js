'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestcourtaction");
const util = require('../utils/utils');
let app = require('../../server/server');
const intakeservicerequestcourtactiontypeupdate = "UPDATE public.Intakeservicerequestcourtactiontype SET activeflag=0 where intakeservicerequestcourtactionid=$1";
const intakeservicerequestcourtordertypeconfigupdate = "UPDATE public.Intakeservicerequestcourtordertypeconfig SET activeflag=0 where intakeservicerequestcourtactionid=$1";
const intakeservicerequestcourtconditiontypeconfigupdate = "UPDATE public.Intakeservicerequestcourtconditiontypeconfig SET activeflag=0 where intakeservicerequestcourtactionid=$1";
const intakeservicereqcourtordertypeconfigupdate = "UPDATE public.Intakeservicerequestcourtordertypeconfig SET activeflag=1 where Intakeservicerequestcourtordertypeconfigid=$1";
module.exports = function(Intakeservicerequestcourtaction) {
    Intakeservicerequestcourtaction.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestcourtaction.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestcourtaction.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    Intakeservicerequestcourtaction.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

   

    Intakeservicerequestcourtaction.remoteMethod('getcourtaction', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    var intakeservreqid;
    Intakeservicerequestcourtaction.add = function (request) {
        if (!util.nullcheck(request.intakeservicerequestid)) {
            return app.models.Intakeservicerequest.find(
                {
                    fields: ['intakeserviceid','intakenumber'],
                    where: { intakenumber: request.intakenumber }
                }).then(data => {
                    var result = [];
                    if (data.length > 0) {
                        var response = [];
                        data.map(x => {
                            intakeservreqid = x.intakeserviceid;
                            if (!util.nullcheck(intakeservreqid)) { /* Add some code here */
                            }
                            else {
                                request.intakeservicerequestid = intakeservreqid;
                                request.insertedon = new Date().toLocaleString();
                                var res = Intakeservicerequestcourtaction.create(request);
                                response.push(res);
                            }
                        });
                        return Promise.all(response).then(function (values) {
                            values.map(x => {
                                result.push(x);
                                request.courtaction.map(typekey => {
                                    app.models.Intakeservicerequestcourtactiontype.create({
                                        intakeservicerequestcourtactionid: result[0].intakeservicerequestcourtactionid,
                                        courtactiontypekey: typekey.courtactiontypekey
                                    });
                                });
                                request.courtorder.map(typekey => {
                                    app.models.Intakeservicerequestcourtordertypeconfig.create({
                                        intakeservicerequestcourtactionid: result[0].intakeservicerequestcourtactionid,
                                        courtordertypekey: typekey.courtordertypekey
                                    });
                                });
                                request.courtcondition.map(typekey => {
                                    app.models.Intakeservicerequestcourtconditiontypeconfig.create({
                                        intakeservicerequestcourtactionid: result[0].intakeservicerequestcourtactionid,
                                        conditiontypekey: typekey.conditiontypekey
                                    });
                                });
                            });
                            return result;
                        });
                    }
                });
        }
        else {
            return Intakeservicerequestcourtaction.find(
                { where: { intakeservicerequestid: request.intakeservicerequestid } }).then(data => {
                    if (data.length == 0) {
                        request.insertedon = new Date().toLocaleString();
                        return Intakeservicerequestcourtaction.create(request).then(res => {

                            request.courtaction.map(typekey => {
                                app.models.Intakeservicerequestcourtactiontype.create({
                                    intakeservicerequestcourtactionid: res.intakeservicerequestcourtactionid,
                                    courtactiontypekey: typekey.courtactiontypekey
                                });
                            });
                            request.courtorder.map(typekey => {
                                app.models.Intakeservicerequestcourtordertypeconfig.create({
                                    intakeservicerequestcourtactionid: res.intakeservicerequestcourtactionid,
                                    courtordertypekey: typekey.courtordertypekey
                                });
                            });
                            request.courtcondition.map(typekey => {
                                app.models.Intakeservicerequestcourtconditiontypeconfig.create({
                                    intakeservicerequestcourtactionid: res.intakeservicerequestcourtactionid,
                                    conditiontypekey: typekey.conditiontypekey
                                });
                            });
                            return res;
                        });
                    }
                    else {
                        request.intakeservicerequestcourtactionid = data[0].intakeservicerequestcourtactionid;
                        request.updatedon = new Date().toLocaleString();
                        return Intakeservicerequestcourtaction.updateAll({ intakeservicerequestcourtactionid: request.intakeservicerequestcourtactionid }, request)
                            .then(res => {
                                return addupdateInatkeservicerequestCourtData(request);
                            });
                    }
                });
        }
    };

    function addupdateInatkeservicerequestCourtData(request) {
        let sql = '';
        sql = "update intakeservicerequestcourtactiontype set activeflag = 0 WHERE intakeservicerequestcourtactionid =$1";
        util.executeDBQuery(sql,[request.intakeservicerequestcourtactionid])
            .then(data => {
                LOGGER.info(data);
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })
        if (request.courtaction != null && request.courtaction != undefined) {
            request.courtaction.map(typekey => {
                app.models.Intakeservicerequestcourtactiontype.create({
                    intakeservicerequestcourtactionid: request.intakeservicerequestcourtactionid,
                    courtactiontypekey: typekey.courtactiontypekey
                });
            });
        }

        sql = "update intakeservicerequestcourtordertypeconfig set activeflag = 0 WHERE intakeservicerequestcourtactionid =$1";
        util.executeDBQuery(sql,[request.intakeservicerequestcourtactionid])
            .then(data => {
                LOGGER.info(data);
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })
        if (request.courtorder != null && request.courtorder != undefined) {
            request.courtorder.map(typekey => {
                app.models.Intakeservicerequestcourtordertypeconfig.create({
                    intakeservicerequestcourtactionid: request.intakeservicerequestcourtactionid,
                    courtordertypekey: typekey.courtordertypekey
                });
            });
        }
        sql = "update intakeservicerequestcourtconditiontypeconfig set activeflag = 0 WHERE intakeservicerequestcourtactionid =$1";
        util.executeDBQuery(sql,[request.intakeservicerequestcourtactionid])
            .then(data => {
                LOGGER.info(data);
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })
        if (request.courtcondition != null && request.courtcondition != undefined) {
            request.courtcondition.map(typekey => {
                app.models.Intakeservicerequestcourtconditiontypeconfig.create({
                    intakeservicerequestcourtactionid: request.intakeservicerequestcourtactionid,
                    conditiontypekey: typekey.conditiontypekey
                });
            });
        }
        return request;
    }

    Intakeservicerequestcourtaction.getcourtaction = (request) =>{
        return app.models.Intakeservicerequestcourtaction.find({
            where:{intakeservicerequestid:request.where.intakeservicerequestid},
            include: [{
                relation: "courtaction",
                scope: {
                   where: {activeflag: 1}
                }},
                {
                    relation: "courtorder",
                    scope: {
                       where: {activeflag: 1}
                    }
                },
                {
                    relation: "courtcondition",
                    scope: {
                       where: {activeflag: 1}
                    }
                }
            ]

        }).then(data =>{
            return data
        })
    }

    Intakeservicerequestcourtaction.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Intakeservicerequestcourtaction.addupdate= function(request) {
        var prs = [];
        request.updatedon= new Date().toLocaleString();
      prs.push(
        app.models.Intakeservicerequestcourtaction.updateAll({intakeservicerequestid:request.intakeservicerequestid,activeflag: 1},request)
      );

      var flatPrs = prs.reduce((a,b) => a.concat(b), []);
        return Promise.all(flatPrs)
        .then(data => data)
        .catch(err =>err);
};

// Gavaskar added for DJS
Intakeservicerequestcourtaction.remoteMethod('createCourt', {
    http: {
      path: '/createCourt',
      verb: 'post',
    },
    accepts: [{arg: 'data', type: 'object',
      http: {source: 'body'}}, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
    returns: {
      type: 'string',
      root: true,
    },
  });

    Intakeservicerequestcourtaction.createCourt = async (court,reqctx) => {
        const _securityusersid = util.getSecurityDetails(court,reqctx).securityuserid;
        const _email = util.getSecurityDetails(request,reqctx).email;

        var requestuserinfo = { 'token': '','email': _email };
        var teamtypekey;
        await util.getuserinfo(requestuserinfo).then(data => {
            teamtypekey = data.teamtypekey;
        });
        let courtObj;

        var prs = [];
        let allegObj;
        var conditionsstatusforevaluation = "";
        var conditionsstatusforpetition = "";
        var eventstatuscode = "";
        


        court.isdispositioncreated = court.createDisposition;

        var conditionsstatusforcourtaction = "Completed";
        if (util.isNullorEmpty(court.conditionsstatusforcourtaction)) { conditionsstatusforcourtaction = court.conditionsstatusforcourtaction; }

        var bCourtActionFlag = false;
        var forwardCourtActionFlag = false;
        var grantedalertFlag = false;
        var deniedalertFlag = false;
        court.intakeservicerequestid = util.emptyUUID;
        if (teamtypekey === 'DJS') {

            if (court.hearingtypekey == "Adjudi" || court.hearingtypekey == "Disp") {


                let intakeservicerequestcourtactionid = court.intakeservicerequestcourtactionid;

                return Intakeservicerequestcourtaction.upsert(court)
                    .then(res => {
                        LOGGER.debug(res)
                        courtObj = JSON.parse(JSON.stringify(res));
                        intakeservicerequestcourtactionid = courtObj.intakeservicerequestcourtactionid;

                        var sqla = intakeservicerequestcourtactiontypeupdate;
                        util.executeDBQuery(sqla,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })

                        var sqlq = intakeservicerequestcourtordertypeconfigupdate;
                        util.executeDBQuery(sqlq,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })

                        var sqle = intakeservicerequestcourtconditiontypeconfigupdate;
                        util.executeDBQuery(sqle,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })

                        court.allegations.forEach(allegation => {
                            var adjudicateddecisiontypekey = allegation.adjudicationdecision;
                            let courtactionallegationconfigid;
                            courtactionallegationconfigid = allegation.courtactionallegationconfigid;
                            LOGGER.debug(courtactionallegationconfigid + "allegation" + allegation + "adjudicationdecision" + adjudicateddecisiontypekey);
                            LOGGER.debug(intakeservicerequestcourtactionid)
                            allegation.adjudicateddecisiontypekey = adjudicateddecisiontypekey;
                            allegation.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
                            LOGGER.debug(allegation.adjudicateddecisiontypekey)
                            return app.models.Courtactionallegationconfig.upsert(allegation)
                                .then(res1 => {
                                    allegObj = JSON.parse(JSON.stringify(res1));
                                    courtactionallegationconfigid = allegObj.courtactionallegationconfigid;
                                    LOGGER.debug("created idconfig" + courtactionallegationconfigid)


                                    const courtAct = checkCourtactionIf(court, allegation, intakeservicerequestcourtactionid, courtactionallegationconfigid, prs);
                                    eventstatuscode = courtAct.eventstatuscode;
                                    conditionsstatusforevaluation = courtAct.conditionsstatusforevaluation;
                                    conditionsstatusforpetition = courtAct.conditionsstatusforpetition;
                                    prs = courtAct.prs;

                                    const courtOrd = checkCourtOrderIf(allegation, intakeservicerequestcourtactionid, courtactionallegationconfigid, conditionsstatusforevaluation, conditionsstatusforpetition, prs);                                    
                                    conditionsstatusforevaluation = courtOrd.conditionsstatusforevaluation; 
                                    conditionsstatusforpetition = courtOrd.conditionsstatusforpetition; 
                                    prs = courtOrd.prs;

                                    prs = addupdateCCCourtActions(allegation,intakeservicerequestcourtactionid,courtactionallegationconfigid,prs);

                                    var flatPrs = prs.reduce((a,b) => a.concat(b),[]);
                                    return Promise.all(flatPrs)
                                })
                                .then(res2 => {
                                        const sql = "update intakeservicerequestpetition set petitionstatustypekey=$2 where intakeservicerequestpetitionid in (select intakeservicerequestpetitionid from Intakeservreqpetitionhearingconfig where intakeservicerequestcourthearingid= $1)";
                                        const qryParams = [court.intakeservicerequestcourthearingid,conditionsstatusforpetition];
                                        return checkandExecute(sql,qryParams,conditionsstatusforpetition, court.createDisposition)

                                })
                                .then(res3 => {
                                        const sql = "Update intakeservicerequestevaluation set complaintstatustypekey = $2 where intakeservicerequestevaluationid in (select intakeservicerequestevaluationid from intakeservreqevalpetitionconfig where intakeservicerequestpetitionid in ( "
                                            + " select intakeservicerequestpetitionid from Intakeservreqpetitionhearingconfig where intakeservicerequestcourthearingid=$1))";
                                        const qryParams = [court.intakeservicerequestcourthearingid,conditionsstatusforevaluation];
                                        return checkandExecute(sql,qryParams,conditionsstatusforevaluation, court.createDisposition)
                                })
                                .then(res4 => {
                                    const sql = "update  intakeservicerequestcourthearing set courthearingstatustypekey=$2 where intakeservicerequestcourthearingid= $1";

                                    return util.executeDBQuery(sql,[court.intakeservicerequestcourthearingid,conditionsstatusforcourtaction])
                                        .then(data => {
                                            LOGGER.info(data);
                                            return data;
                                        })
                                        .catch(err => {
                                            LOGGER.error(err);
                                            return err;
                                        })

                                })
                                .then(res5 => {
                                    const sql = "select * from updatecomplaintbysustain($1,$2,$3)";
                                    const qryParams = [court.intakeservicerequestcourthearingid,allegation.intakeservicerequestevaluationconfigid,allegation.adjudicationdecision];
                                    return checkandExecute(sql,qryParams,true, court.createDisposition)
                                    
                                })
                                .then(res6 => {
                                    const sql = "select * from getfocuspersoncasestatusconfig($1,$2,$3,$4,$5,$6,$7)";
                                    const qryParams = [court.youth.Pid,court.intakeserviceid,court.intakenumber,eventstatuscode,null,null,_securityusersid];
                                    return checkandExecute(sql,qryParams,eventstatuscode, false)
                                })
                        })
                    })
                    .then(res7 => {
                        return checkHearingandCCourt(court, reqctx);
                    })

                    .then(res8 => {
                        return {
                            intakeservicerequestcourtaction: courtObj
                        };
                    })


            } else {
                let intakeservicerequestcourtactionid = court.intakeservicerequestcourtactionid;
                let restiCA = '';
                return Intakeservicerequestcourtaction.upsert(court)
                    .then(res => {
                        courtObj = JSON.parse(JSON.stringify(res));
                        intakeservicerequestcourtactionid = courtObj.intakeservicerequestcourtactionid;
                        var sql = intakeservicerequestcourtactiontypeupdate;
                        util.executeDBQuery(sql,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })

                        var sqlq = intakeservicerequestcourtordertypeconfigupdate;
                        util.executeDBQuery(sqlq,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })

                        var sqle = intakeservicerequestcourtconditiontypeconfigupdate;
                        util.executeDBQuery(sqle,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })

                            const courtAct = checkCourtactionElse(court, intakeservicerequestcourtactionid, conditionsstatusforcourtaction, restiCA, prs);
                                bCourtActionFlag = courtAct.bCourtActionFlag;
                                deniedalertFlag = courtAct.deniedalertFlag;
                                grantedalertFlag = courtAct.grantedalertFlag;
                                conditionsstatusforevaluation = courtAct.conditionsstatusforevaluation;
                                conditionsstatusforpetition = courtAct.conditionsstatusforpetition;
                                conditionsstatusforcourtaction = courtAct.conditionsstatusforcourtaction;
                                restiCA = courtAct.restiCA;
                                prs = courtAct.prs;
                        
                        
                        const condValues = {
                            conditionsstatusforevaluation,
                            conditionsstatusforpetition,
                            conditionsstatusforcourtaction,
                            forwardCourtActionFlag,
                            prs
                        }
                        const respValue = checkCourtOrderElse(court,bCourtActionFlag,restiCA,intakeservicerequestcourtactionid,condValues);
                        conditionsstatusforevaluation = respValue.conditionsstatusforevaluation;
                        conditionsstatusforpetition = respValue.conditionsstatusforpetition;
                        conditionsstatusforcourtaction = respValue.conditionsstatusforcourtaction;
                        forwardCourtActionFlag = respValue.forwardCourtActionFlag;
                        prs = respValue.prs;

                        prs = addupdateCCCourtActions(court,intakeservicerequestcourtactionid,null,prs);

                        var flatPrs = prs.reduce((a,b) => a.concat(b),[]);
                        return Promise.all(flatPrs)

                    })

                    .then(res => {
                        const sql = "update intakeservicerequestpetition set petitionstatustypekey=$2 where intakeservicerequestpetitionid in (select intakeservicerequestpetitionid from Intakeservreqpetitionhearingconfig where intakeservicerequestcourthearingid= $1)";
                        const qryParams = [court.intakeservicerequestcourthearingid,conditionsstatusforpetition];
                        return checkandExecute(sql,qryParams,conditionsstatusforpetition, false);
                    })
                    .then(res => {
                        const sql = "Update intakeservicerequestevaluation set complaintstatustypekey = $2 where intakeservicerequestevaluationid in (select intakeservicerequestevaluationid from intakeservreqevalpetitionconfig where intakeservicerequestpetitionid in ( "
                            + " select intakeservicerequestpetitionid from Intakeservreqpetitionhearingconfig where intakeservicerequestcourthearingid=$1))";
                        const qryParams = [court.intakeservicerequestcourthearingid,conditionsstatusforevaluation];
                        return checkandExecute(sql,qryParams,conditionsstatusforevaluation, false);
                    })
                    .then(res => {
                        const sql = "update  intakeservicerequestcourthearing set courthearingstatustypekey=$2 where intakeservicerequestcourthearingid= $1";
                        const qryParams = [court.intakeservicerequestcourthearingid,conditionsstatusforcourtaction];
                        return checkandExecute(sql,qryParams,conditionsstatusforcourtaction, false);
                    })
                    .then(res => {
                        return callForwardPetition(court, reqctx, forwardCourtActionFlag);

                    }).then(res => {
                        if (grantedalertFlag) {
                            var courtalertObj = {};
                            var securityusersid = _securityusersid;
                            const insertedon = new Date().toLocaleString();
                            var alertnotes = "Peace Order – Granted by Court is set for " + court.youth.fullName + " in " + "Intake " + court.intakenumber;
                            courtalertObj.alerttype = 'POBC';
                            courtalertObj.status = 'Active';
                            courtalertObj.startdatetime = court.courtorderdatetime;
                            courtalertObj.notes = alertnotes;
                            courtalertObj.insertedby = securityusersid;
                            courtalertObj.updatedby = securityusersid;
                            courtalertObj.insertedon = insertedon;
                            courtalertObj.updatedon = insertedon;
                            courtalertObj.personid = court.youth.Pid;
                            courtalertObj.enddatetime = court.expirationdate;
                            courtalertObj.intakenumber = court.intakenumber;
                            var updatenotes = "Peace Order – Request Authorized is set for " + court.youth.fullName + " in " + "Intake " + court.intakenumber;
                            courtalertObj.updatenotes = updatenotes;
                            return Intakeservicerequestcourtaction.courtalert(courtalertObj);
                        }
                        return null;

                    }).then(res => {
                        if (deniedalertFlag) {
                            LOGGER.debug(deniedalertFlag)
                            var courtalertdenyObj = {};

                            var alertnotes = "Peace Order – Request Authorized is set for " + court.youth.fullName + " in " + "Intake " + court.intakenumber;
                            courtalertdenyObj.alerttype = 'POAU';
                            courtalertdenyObj.status = 'Inactive';
                            courtalertdenyObj.notes = alertnotes;
                            courtalertdenyObj.intakenumber = court.intakenumber;

                            LOGGER.debug("before calling function deny")
                            return Intakeservicerequestcourtaction.courtalert(courtalertdenyObj);
                        }
                        return null;

                    })
                    .then(res => {

                        // This block is for sending notification for Restitution Close or Continuance to RC & CW user
                        var restiNotificationSql = 'select * from restinotification($1, $2, $3, $4)';
                        var securityuserid = _securityusersid;
                        const qryParams = [court.intakenumber,restiCA,securityuserid,court.conditiontypedescription];
                        return checkandExecute(restiNotificationSql,qryParams,restiCA, false);
                    })
                    .then(res9 => {
                        return {
                            intakeservicerequestcourtaction: courtObj,
                        };
                    })
            }

        } else {
            return 'This method is only allowed for DJS user';
        }

    };

    function callForwardPetition(court, reqctx, forwardCourtActionFlag){
        if (forwardCourtActionFlag) {
            var forwardpetitioObj = {};
            forwardpetitioObj.saocountyid = court.saocountyid;
            forwardpetitioObj.intakenumber = court.intakenumber;
            forwardpetitioObj.saotransfernotes = court.saotransfernotes;
            forwardpetitioObj.petitionid = court.petitionid;
            forwardpetitioObj.youthname = court.youth;

            return Intakeservicerequestcourtaction.forwardPetition(forwardpetitioObj,reqctx);
        }
        return null;
    }

    function checkHearingandCCourt(court, reqctx){
        if (court.createDisposition) {
            const sql = "select 'Disp' as hearingtypekey,inh.hearingdatetime,inh.associatedattorneys,inh.transfernotes,inh.transferpetitionid,inh.otherhearingtypenotes ,inh.intakeserviceid,inh.intakenumber,'Pending' as courthearingstatustypekey, "
                + " (select json_agg(x) from (select inc.intakeservicerequestpetitionid from intakeservreqpetitionhearingconfig inc "
                + " where inc.intakeservicerequestcourthearingid=$1 and inc.activeflag=1) as x) as petitions "
                + " from intakeservicerequestcourthearing inh where intakeservicerequestcourthearingid=$1";
            return util.executeDBQuery(sql,[court.intakeservicerequestcourthearingid])
                .then(data => {
                    LOGGER.info(data);
                    return data;
                })
                .then(res => {
                    var hearingObj = {};
                    var hearingres = {};
                    hearingObj = JSON.parse(JSON.stringify(res));
                    return app.models.Intakeservicerequestcourthearing.createHearing(hearingObj[0])
                        .then(res10 => {
                            court.Intakeservicerequestcourtactionid = null;
                            hearingres = JSON.parse(JSON.stringify(res10));
                            court.intakeservicerequestcourthearingid = hearingres.intakeservicerequestcourthearing.intakeservicerequestcourthearingid;
                            court.createDisposition = false;
                            court.conditionsstatusforcourtaction = 'Pending';
                            court.hearingtypekey = 'Disp';
                            court.isdraftdisp = true;
                            checkCourtAllegations(court);
                            return app.models.Intakeservicerequestcourtaction.createCourt(court,reqctx)

                        })
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
        }
    }

    function checkCourtAllegations(court) {
        court.allegations.forEach(allegation => {
            if (allegation != null) {
                allegation.courtactionallegationconfigid = null;
                if (allegation.courtaction != null && allegation.courtaction.length > 0) {
                    allegation.courtaction.forEach(courtact => {
                            courtact.Intakeservicerequestcourtactiontypeid = null;
                        })
                }
                if (allegation.courtorder != null && allegation.courtorder.length > 0) {
                    allegation.courtorder.forEach(courtord => {
                            courtord.intakeservreqcourtorderid = null;
                        })
                }
                if (allegation.courtcondition != null && allegation.courtcondition.length > 0) {
                    allegation.courtcondition.forEach(courtcond => {
                            courtcond.intakeservicerequestcourtconditiontypeconfigid = null;
                        })
                }
            }
        })
    }

    function checkCourtactionIf(court, allegation, intakeservicerequestcourtactionid, courtactionallegationconfigid, prs){
        
        let isdraftdispval = false;
        if (util.isNullorEmpty(court.isdraftdisp)) { isdraftdispval = court.isdraftdisp; }

        let eventstatuscode = '';
        let conditionsstatusforevaluation = "";
        let conditionsstatusforpetition = "";

        prs.push(allegation.courtaction.map(courtactions => {

            courtactions.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            courtactions.courtactionallegationconfigid = courtactionallegationconfigid;
            if (courtactions.courtactiontypekey === 'AdjudiNI' && allegation.adjudicationdecision === 'NS') {
                conditionsstatusforevaluation = 'CHC';
                conditionsstatusforpetition = 'CMP';
            }
            if (courtactions.description.toLowerCase() == 'continuance') {
                conditionsstatusforevaluation = 'HS';
                conditionsstatusforpetition = 'SCH';
            }
            eventstatuscode = getEventCode(court, courtactions, eventstatuscode, isdraftdispval);

            return addUpdateIntakeservicerequestcourtactiontype(courtactions, null);

        }))

        return {
            eventstatuscode,
            conditionsstatusforevaluation,
            conditionsstatusforpetition,
            prs
        };
    }

    function getEventCode(court, courtactions, eventstatuscode, isdraftdispval){
        let eventintakeserviceid = null;
        if (court.hearingtypekey == "Adjudi") {
            if (courtactions.courtactiontypekey == 'AdjudiDismiss' || courtactions.courtactiontypekey == 'AdjudiNI' || courtactions.courtactiontypekey == 'AdjudiNP') {

                eventstatuscode = 'CRTACTNDNI';
            }

            if (courtactions.courtactiontypekey == 'AdjudiInvolved') {
                eventstatuscode = 'CRTACTNDI';
                eventintakeserviceid = court.intakeserviceid;
            }
                
        }
        if (court.hearingtypekey == "Disp") {
            if (courtactions.courtactiontypekey == 'DispCommit') {
                eventstatuscode = 'CRTACTDCDS';
                eventintakeserviceid = court.intakeserviceid;
            }
            else if (courtactions.courtactiontypekey == 'DispCS') {
                eventstatuscode = 'CRTACTDCTS';
                eventintakeserviceid = court.intakeserviceid;
            }
            else //if(courtactions.courtactiontypekey !=null && courtactions.courtactiontypekey !=undefined && courtactions.courtactiontypekey !='')
            {
                if (isdraftdispval === false) { 
                    eventstatuscode = 'CRTACTDNCS'; 
                }
            }

        }
        LOGGER.info(eventintakeserviceid)
        return eventstatuscode;
    }

    function checkCourtactionElse(court, intakeservicerequestcourtactionid, conditionsstatusforcourtaction, restiCA, prs){
        let bCourtActionFlag = false;
        let deniedalertFlag = false;
        let grantedalertFlag = false;
        let conditionsstatusforevaluation = "";
        let conditionsstatusforpetition = "";

        prs.push(court.courtaction.map(courtactions => {

            courtactions.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            courtactions.Intakeservicerequestcourtactiontypeid = courtactions.Intakeservicerequestcourtactiontype
            if (courtactions.courtactiontypekey === 'AdjudiNI') { bCourtActionFlag = true; }
            if (courtactions.courtactiontypekey === 'DBC') {
                deniedalertFlag = true;
            }
            if (courtactions.courtactiontypekey === 'GBC') {
                grantedalertFlag = true;
            }
            if (courtactions.description.toLowerCase() == 'continuance') {
                conditionsstatusforevaluation = 'HS';
                conditionsstatusforpetition = 'SCH';
                conditionsstatusforcourtaction = 'Completed';
            }
            const cond = checkCourtActionConditions(court, courtactions, conditionsstatusforevaluation, conditionsstatusforpetition, restiCA);
            conditionsstatusforevaluation = cond.conditionsstatusforevaluation; 
            conditionsstatusforpetition = cond.conditionsstatusforpetition; 
            restiCA = cond.restiCA;

            if (court.hearingtypekey == "Waiver" && courtactions.courtactiontypekey === 'WaiverWTAG') {
                    conditionsstatusforevaluation = 'CAS';
                    conditionsstatusforpetition = 'SCH';
            }
            return addUpdateIntakeservicerequestcourtactiontype(courtactions, intakeservicerequestcourtactionid);
        }))

        return {
            bCourtActionFlag,
            deniedalertFlag,
            grantedalertFlag,
            conditionsstatusforevaluation,
            conditionsstatusforpetition,
            conditionsstatusforcourtaction,
            restiCA,
            prs
        }
    }

    function checkCourtActionConditions(court, courtactions, conditionsstatusforevaluation, conditionsstatusforpetition, restiCA){
        if (court.hearingtypekey == "Resti") {
            if (courtactions.courtactiontypekey === 'RestiOrder' || courtactions.courtactiontypekey === 'RestiOJS') {
                conditionsstatusforevaluation = 'RCAS';
                conditionsstatusforpetition = 'SCH';
            }

            // Assign the court action to restiCA variable for tracking any one of the court actions is Continuous or Not Ordered
            if (courtactions.courtactiontypekey === 'RestiNO') {
                restiCA = 'RestiNO';
            }
            if (courtactions.courtactiontypekey === 'RestiContin' && restiCA === '') {
                restiCA = 'RestiContin';
            }
        }
        return {
            conditionsstatusforevaluation, 
            conditionsstatusforpetition, 
            restiCA
        }
    }

    function addUpdateIntakeservicerequestcourtactiontype(courtactions, intakeservicerequestcourtactionid){
        if (courtactions.Intakeservicerequestcourtactiontypeid !== undefined && courtactions.Intakeservicerequestcourtactiontypeid !== null) {
            var sql = "UPDATE public.Intakeservicerequestcourtactiontype SET activeflag=1,intakeservicerequestcourtactionid=$1 where Intakeservicerequestcourtactiontypeid=$2";

            util.executeDBQuery(sql,[intakeservicerequestcourtactionid, courtactions.Intakeservicerequestcourtactiontypeid])
                .then(data => {
                    LOGGER.info(data);
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
        } else {
            LOGGER.debug("creating court action type")
            return app.models.Intakeservicerequestcourtactiontype.create(courtactions);

        }
    }

    function checkCourtOrderIf(allegation, intakeservicerequestcourtactionid, courtactionallegationconfigid, conditionsstatusforevaluation, conditionsstatusforpetition, prs){
        prs.push(allegation.courtorder.map(courtorders => {
            courtorders.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            courtorders.courtactionallegationconfigid = courtactionallegationconfigid;
            if (courtorders.courtordertypekey == 'CLD' || bIntakeClose) {
                conditionsstatusforevaluation = 'CHC';
                conditionsstatusforpetition = 'CMP';
            }

            return addUpdateIntakeservicerequestcourtordertypeconfig(courtorders);
        }));
        return {
            conditionsstatusforevaluation, 
            conditionsstatusforpetition, 
            prs
        }
    }

    function checkCourtOrderElse(court,bCourtActionFlag,restiCA,intakeservicerequestcourtactionid,condValue) {
        let bIntakeClose = false;
        let restiCO = '';
        let { conditionsstatusforevaluation,
            conditionsstatusforpetition,
            conditionsstatusforcourtaction,
            forwardCourtActionFlag,
            prs } = condValue;


        prs.push(court.courtorder.map(courtorders => {
            courtorders.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;

            if (bCourtActionFlag && courtorders.courtordertypekey === 'DSMD') { bIntakeClose = true; }
            if (courtorders.courtordertypekey == 'CLD' || bIntakeClose) {
                conditionsstatusforevaluation = 'CHC';
                conditionsstatusforpetition = 'CMP';
                conditionsstatusforcourtaction = 'Completed';
            }

            if (courtorders.courtordertypekey == 'TROJ') {
                forwardCourtActionFlag = true;
            }

            // If Court action is "Not ordered" with court order is "Termination of Jurisdiction" make the petition and hearing as schduled
            if (courtorders.courtordertypekey == 'TOJ' && restiCA == 'RestiNO') {
                restiCO = 'RestiNO';
                conditionsstatusforevaluation = 'CHC'; // Complaint Status Type
                conditionsstatusforpetition = 'CLS'; // Petition Status Type
                conditionsstatusforcourtaction = 'Completed'; // Hearing Status Type
            }
            // If Court action is "Continuous" with court order is "Judgment of Restitution" make the petition and hearing as closed
            if (courtorders.courtordertypekey == 'JOR' && restiCA == 'RestiContin' && restiCO === '') {
                restiCO = 'RestiContin';
                conditionsstatusforevaluation = 'CHCT'; // Complaint Status Type
                conditionsstatusforpetition = 'SCH'; // Petition Status Type
                conditionsstatusforcourtaction = 'Pending'; // Hearing Status Type
            }

            return addUpdateIntakeservicerequestcourtordertypeconfig(courtorders);

        }));

        return {
            conditionsstatusforevaluation,
            conditionsstatusforpetition,
            conditionsstatusforcourtaction,
            forwardCourtActionFlag,
            prs
        };
    }

    function addUpdateIntakeservicerequestcourtordertypeconfig(courtorders){
        if (courtorders.Intakeservicerequestcourtordertypeconfigid !== undefined && courtorders.Intakeservicerequestcourtordertypeconfigid !== null) {
            var sql = intakeservicereqcourtordertypeconfigupdate;

            util.executeDBQuery(sql,[courtorders.Intakeservicerequestcourtordertypeconfigid])
                .then(data => {
                    LOGGER.info(data);
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
        } else {
            return app.models.Intakeservicerequestcourtordertypeconfig.create(courtorders);
        }
    }

    function addupdateCCCourtActions(court, intakeservicerequestcourtactionid, courtactionallegationconfigid, prs){
        prs.push(court.courtcondition.map(courtcondition => {
            courtcondition.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            // check based on hearingtype=Adju
            courtcondition.courtactionallegationconfigid = courtactionallegationconfigid;
            const conditiontypedescription = courtactionallegationconfigid ? courtcondition.conditiontypedescription : null;

            if (courtcondition.Intakeservicerequestcourtconditiontypeconfigid !== undefined && courtcondition.Intakeservicerequestcourtconditiontypeconfigid !== null) {
                var sql = "UPDATE public.Intakeservicerequestcourtconditiontypeconfig SET activeflag=1,conditiontypedescription=$1 where Intakeservicerequestcourtconditiontypeconfigid=$2";

                util.executeDBQuery(sql,[conditiontypedescription, courtcondition.Intakeservicerequestcourtconditiontypeconfigid])
                    .then(data => {
                        LOGGER.info(data);
                    })
                    .catch(err => {
                        LOGGER.error('>>>>ERROR:', err);
                        throw err;
                    });
            } else {
                LOGGER.debug("creating court condition type config" + courtcondition)
                return app.models.Intakeservicerequestcourtconditiontypeconfig.create(courtcondition);
            }
        }));
       
        return prs;
    }

    function checkandExecute(sql, qryParams, condition1, condition2){
        if (condition1 !== "" && !condition2) {
            return util.executeDBQuery(sql, qryParams)
                .then(data => data)
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
        }
        return null;
    }

  //forward petition sprint 5 changes

  Intakeservicerequestcourtaction.remoteMethod('forwardPetition', {
    accepts : [{
    arg : 'filter',
    type : 'Object',
    http : {
    source : 'query'
    },
    required : true
    }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
    http : {
    path: '/forwardPetition',
    verb : 'get'
    },
    returns : {
    type : 'Object',
    root : true
    }
    });
    
    Intakeservicerequestcourtaction.forwardPetition = async function (request,reqctx) {
        const _securityusersid = util.getSecurityDetails(request,reqctx).securityuserid;
        const _email = util.getSecurityDetails(request,reqctx).email;
        var requestuserinfo = { 'token': '','email': _email };
        var teamcounty;
        await util.getuserinfo(requestuserinfo).then(data => {
            teamcounty = data.countyid;
        });
        var sql1 = "update intakedastatus set saocountyid=$1,saotransfernotes=$3 where intakenumber=$2"
        return util.executeDBQuery(sql1,[request.saocountyid,request.intakenumber,request.saotransfernotes])
            .then(data => {
                return data;
            })
            .then(res => {
                var sql = "update intakeservicerequestpetition set petitionstatustypekey='PEFW',updatedon=now(),updatedby=$2 where intakenumber=$1"
                return util.executeDBQuery(sql,[request.intakenumber,_securityusersid])
                    .then(data => {
                        return data;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    })
            }).then(res => {
                var sql = "update Intakeservreqevalpetitionconfig set forwardcomplaintstatustypekey='PEFW',updatedon=now(),updatedby=$2 where intakeservicerequestpetitionid in ( "
                    + " select INP.intakeservicerequestpetitionid from intakeservicerequestpetition INP  "
                    + " where INP.intakenumber=$1 and INP.activeflag=1)"
                return util.executeDBQuery(sql,[request.intakenumber,_securityusersid])
                    .then(data => {
                        LOGGER.info(data);
                        return data;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    })
            }).then(res => {
                var sql = "update intakeservicerequestevaluation set complaintstatustypekey='SAOPF' where intakenumber=$1"
                return util.executeDBQuery(sql,[request.intakenumber])
                    .then(data => {
                        LOGGER.info(data);
                        return data;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    })
            })
            .then(res => {
                var sql = "select countyid,countyname from county where countyid=$1"
                return util.executeDBQuery(sql,[teamcounty])
                    .then(data => {
                        LOGGER.info(data);
                        return data;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    })
            })
            .then(res => {
                var sql = "select mu.securityusersid from team t join teammember tm on tm.teamid=t.teamid and tm.activeflag=1 join teammemberassignment tma on tma.teammemberid=tm.teammemberid and tma.activeflag=1 join muser mu on mu.securityusersid = tma.securityusersid and mu.activeflag=1 "
                    + " join rolemapping rm on rm.principalid::int=mu.id and rm.activeflag=1 join role r on r.id = rm.roleid :: int "
                    + " where t.countyid=$1 and r.roletypekey='JSCLW'";
                return util.executeDBQuery(sql,[request.saocountyid])
                    .then(data => {
                        data.push({ "securityusersid": _securityusersid })
                        if (data.length > 0) {
                            data.forEach(musers => {
                                var countyval = "";
                                if (res) {
                                    var courtObj = JSON.parse(JSON.stringify(res));
                                    countyval = courtObj[0].countyname;
                                }
                                var youth = "";
                                if (request.youthname != null) {
                                    youth = request.youthname.fullName
                                }

                                var nofiticationJson = {};
                                nofiticationJson.securityusersid = musers.securityusersid;
                                nofiticationJson.usernotificationtypekey = "System";
                                nofiticationJson.objectid = request.intakenumber;
                                nofiticationJson.subject = 'Transfer Petition "' + request.petitionid + '" (Intake# "' + request.intakenumber + '") – from  "' + countyval + '"';
                                nofiticationJson.priorityleveltypekey = "High";
                                nofiticationJson.body = 'Petition "' + request.petitionid + '" of "' + youth + '" has been transferred from "' + countyval + '"';
                                app.models.Usernotification.Add(nofiticationJson,reqctx);
                          })
                            return data;
                        }
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        throw err;
                    })
            }).then(res => {
                return res;
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            });
    }

    Intakeservicerequestcourtaction.remoteMethod('courtalert', {
        http: {
                path: '/courtalert',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Intakeservicerequestcourtaction.courtalert = function(request){
      
       if (request.alerttype=='POBC'){
    
        
         
     app.models.Personalert.create(request)
        .catch(err => util.logError(err));

        const insertedon = new Date().toLocaleString();
       LOGGER.debug(insertedon + "insertedon");
        return app.models.Personalert.updateAll(
            {notes: request.updatenotes},
            {
                enddatetime:insertedon,
                activeflag: 0,
                status: 'Inactive',
                
            }
        )
    }else{
        var notes = request.notes;
        var status='Inactive';
        const insertedon = new Date().toLocaleString();
         app.models.Personalert.updateAll(
            {notes: notes},
            {
                enddatetime:insertedon,
                activeflag: 0,
                status: status
            }
        )
        .catch(err => util.logError(err));
        
        LOGGER.debug(request.intakenumber);
       return app.models.Intakeservicerequestevaluation.updateAll(
            {intakenumber: request.intakenumber},
            {
                complaintstatustypekey:'CHC'
            }
        )
        .catch(err => util.logError(err));


    }
}

    Intakeservicerequestcourtaction.remoteMethod('savedraftcourt', {
        http: {
                path: '/savedraftcourt',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},
            {  arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}}],
        returns: {
            type : 'string',
            root : true
        }
    });

   //save draft 

    Intakeservicerequestcourtaction.savedraftcourt = async (court,reqctx) => {
        const _email = util.getSecurityDetails(court,reqctx).email;

        var requestuserinfo = { 'token': '','email': _email };
        var teamtypekey;
        await util.getuserinfo(requestuserinfo).then(data => {
            teamtypekey = data.teamtypekey;
        });
        LOGGER.debug(teamtypekey);
        let courtObj;
        var prs = [];
        court.isdispositioncreated = court.createDisposition;

        court.intakeservicerequestid = util.emptyUUID;
        if (teamtypekey === 'DJS') {

            if (court.hearingtypekey == "Adjudi" || court.hearingtypekey == "Disp") {

                let intakeservicerequestcourtactionid = court.intakeservicerequestcourtactionid;

                return Intakeservicerequestcourtaction.upsert(court)
                    .then(res => {
                        LOGGER.debug(res)
                        courtObj = JSON.parse(JSON.stringify(res));
                        intakeservicerequestcourtactionid = courtObj.intakeservicerequestcourtactionid;
                        var sql = intakeservicerequestcourtactiontypeupdate;

                        util.executeDBQuery(sql,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            })

                        var sqlq = intakeservicerequestcourtordertypeconfigupdate;
                        util.executeDBQuery(sqlq,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            })

                        var sqle = intakeservicerequestcourtconditiontypeconfigupdate;
                        util.executeDBQuery(sqle,[intakeservicerequestcourtactionid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            })

                        return addupdateCourtallegations(court,intakeservicerequestcourtactionid);

                    }).then(res11 => {
                        return { intakeservicerequestcourtaction: courtObj };
                    })

            } else {
                let intakeservicerequestcourtactionid = court.intakeservicerequestcourtactionid;
                return Intakeservicerequestcourtaction.upsert(court)
                    .then(res => {
                        courtObj = JSON.parse(JSON.stringify(res));
                        intakeservicerequestcourtactionid = courtObj.intakeservicerequestcourtactionid;
                        var sql = intakeservicerequestcourtactiontypeupdate;
                        util.executeDBQuery(sql,[intakeservicerequestcourtactionid])
                        .then(data => {
                            LOGGER.info(data);
                        })
                        .catch(err => {
                            LOGGER.error('>>>>ERROR:', err);
                            throw err;
                        })

                        var sqlq = intakeservicerequestcourtordertypeconfigupdate;
                        util.executeDBQuery(sqlq,[intakeservicerequestcourtactionid])
                        .then(data => {
                            LOGGER.info(data);
                        })
                        .catch(err => {
                            LOGGER.error('>>>>ERROR:', err);
                            throw err;
                        })

                        var sqle = intakeservicerequestcourtconditiontypeconfigupdate;
                        util.executeDBQuery(sqle,[intakeservicerequestcourtactionid])
                        .then(data => {
                            LOGGER.info(data);
                        })
                        .catch(err => {
                            LOGGER.error('>>>>ERROR:', err);
                            throw err;
                        })

                        prs = addupdateCourtActions(court,intakeservicerequestcourtactionid,prs);

                        var flatPrs = prs.reduce((a,b) => a.concat(b),[]);
                        return Promise.all(flatPrs)


                    }).then(res12 => {
                        return { intakeservicerequestcourtaction: courtObj };
                    })
            }

        } else {
            return 'This method is only allowed for DJS user';
        }

    };

    function addupdateCourtActions(court,intakeservicerequestcourtactionid,prs) {
        prs.push(court.courtaction.map(courtactions => {
            // LOGGER.debug(intakeservicerequestcourtactionid+courtactionallegationconfigid+ "last")  
            courtactions.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            courtactions.Intakeservicerequestcourtactiontypeid = courtactions.Intakeservicerequestcourtactiontype;

            if (courtactions.Intakeservicerequestcourtactiontypeid !== undefined && courtactions.Intakeservicerequestcourtactiontypeid !== null) {
                var sql = "UPDATE public.Intakeservicerequestcourtactiontype SET activeflag=1,intakeservicerequestcourtactionid=$1 where Intakeservicerequestcourtactiontypeid=$2";
                util.executeDBQuery(sql,[intakeservicerequestcourtactionid,courtactions.Intakeservicerequestcourtactiontypeid])
                .then(data => {
                    LOGGER.info(data);
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
            } else {
                return app.models.Intakeservicerequestcourtactiontype.create(courtactions);

            }

        }))
        prs.push(court.courtorder.map(courtorders => {
            courtorders.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            if (courtorders.Intakeservicerequestcourtordertypeconfigid !== undefined && courtorders.Intakeservicerequestcourtordertypeconfigid !== null) {
                var sql = intakeservicereqcourtordertypeconfigupdate;
                util.executeDBQuery(sql,[courtorders.Intakeservicerequestcourtordertypeconfigid])
                .then(data => {
                    LOGGER.info(data);
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                })
            } else {
                return app.models.Intakeservicerequestcourtordertypeconfig.create(courtorders);
            }

        }));
        prs.push(court.courtcondition.map(courtcondition => {
            courtcondition.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            if (courtcondition.Intakeservicerequestcourtconditiontypeconfigid !== undefined && courtcondition.Intakeservicerequestcourtconditiontypeconfigid !== null) {
                var sql = "UPDATE public.Intakeservicerequestcourtconditiontypeconfig SET activeflag=1 where Intakeservicerequestcourtconditiontypeconfigid=$1";
                util.executeDBQuery(sql,[courtcondition.Intakeservicerequestcourtconditiontypeconfigid])
                .then(data => {
                    LOGGER.info(data);
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
            } else {
                return app.models.Intakeservicerequestcourtconditiontypeconfig.create(courtcondition);
            }
        }));
        return prs;
    }

    function addupdateCourtallegations(court,intakeservicerequestcourtactionid) {
        let allegObj;
        const prs = [];

        court.allegations.forEach(allegation => {
            var adjudicateddecisiontypekey = allegation.adjudicationdecision;
            let courtactionallegationconfigid;
            courtactionallegationconfigid = allegation.courtactionallegationconfigid;
           
            LOGGER.debug(courtactionallegationconfigid + "allegation" + allegation + "adjudicationdecision" + adjudicateddecisiontypekey);
            LOGGER.debug(intakeservicerequestcourtactionid)
            allegation.adjudicateddecisiontypekey = adjudicateddecisiontypekey;
            allegation.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
            LOGGER.debug(allegation.adjudicateddecisiontypekey)
            return app.models.Courtactionallegationconfig.upsert(allegation)
                .then(res => {
                    allegObj = JSON.parse(JSON.stringify(res));
                    courtactionallegationconfigid = allegObj.courtactionallegationconfigid;
                    LOGGER.debug("created idconfig" + courtactionallegationconfigid)

                    //  }

                    prs.push(allegation.courtaction.map(courtactions => {

                        LOGGER.debug(intakeservicerequestcourtactionid + courtactionallegationconfigid + "last")
                        courtactions.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
                        courtactions.courtactionallegationconfigid = courtactionallegationconfigid;
                      
                        if (util.isNullorEmpty(courtactions.Intakeservicerequestcourtactiontypeid)) {
                            var sql = "UPDATE public.Intakeservicerequestcourtactiontype SET activeflag=1 where Intakeservicerequestcourtactiontypeid=$1";
                            util.executeDBQuery(sql,[courtactions.Intakeservicerequestcourtactiontypeid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })
                        } else {
                            LOGGER.debug("creating court action type")
                            return app.models.Intakeservicerequestcourtactiontype.create(courtactions);

                        }

                    }))
                    prs.push(allegation.courtorder.map(courtorders => {
                        courtorders.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
                        courtorders.courtactionallegationconfigid = courtactionallegationconfigid;
                        if (util.isNullorEmpty(courtorders.Intakeservicerequestcourtordertypeconfigid)) {
                            var sql = intakeservicereqcourtordertypeconfigupdate;
                            util.executeDBQuery(sql,[courtorders.Intakeservicerequestcourtordertypeconfigid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })
                        } else {
                            LOGGER.debug("creating courtordertypeconfig" + courtorders)
                            return app.models.Intakeservicerequestcourtordertypeconfig.create(courtorders);
                        }

                    }));
                    prs.push(allegation.courtcondition.map(courtcondition => {
                        courtcondition.intakeservicerequestcourtactionid = intakeservicerequestcourtactionid;
                        courtcondition.courtactionallegationconfigid = courtactionallegationconfigid;

                        if (util.isNullorEmpty(courtcondition.Intakeservicerequestcourtconditiontypeconfigid)) {
                            var sql = "UPDATE public.Intakeservicerequestcourtconditiontypeconfig SET activeflag=1,conditiontypedescription=$1 where Intakeservicerequestcourtconditiontypeconfigid=$2";
                            util.executeDBQuery(sql,[courtcondition.conditiontypedescription,courtcondition.Intakeservicerequestcourtconditiontypeconfigid])
                            .then(data => {
                                LOGGER.info(data);
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })
                        } else {
                            LOGGER.debug("creating court condition type config" + courtcondition)
                            return app.models.Intakeservicerequestcourtconditiontypeconfig.create(courtcondition);
                        }
                    }));

                    var flatPrs = prs.reduce((a,b) => a.concat(b),[]);
                    return Promise.all(flatPrs)
                })
        })
    }
}