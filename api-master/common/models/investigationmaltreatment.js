'use strict';
const LOGGER = require("log4js").getLogger("investigationmaltreatment");
const util = require('../utils/utils');
var app = require('../../server/server');
const moment = require('moment');

module.exports = function(Investigationmaltreatment) {


    Investigationmaltreatment.othercharactersticsadd =(request,id,maltreatment_id, _securityusersid )=>{
        const prs =[];

         /*Request collection assigned to variable to perform DML*/
        var  maltreators=request.maltreators;
        var areaofinjurys = request.areaofinjury;
        var maltreatmentcharacterstics= request.maltreatmentcharacterstics;
        var injurycharactertics= request.injurycharactertics;
        var jurisdictionusers = request.jurisdictionuser;
        var providermaltreatments = request.providermaltreatment;
        var indicators = request.indicator;

        if(Array.isArray(maltreators)){
            maltreators.forEach(maltreator =>{
                prs.push(
                    app.models.Investigationallegationmaltreators.create({
                    investigationallegationid:id,
                    intakeservicerequestactorid:maltreator.maltreatoractorid,
                    othermaltreator:maltreator.othermaltreator,
                    insertedby: _securityusersid,
                    updatedby: _securityusersid
                    })
                )
            });
        }
        if(Array.isArray(areaofinjurys)){
            areaofinjurys.forEach(areaofinjury =>{
                prs.push(
                    app.models.Investigationallegationinjury.create({
                    investigationallegationid:id,
                    injurytypekey:areaofinjury.injurytypekey,
                    insertedby: _securityusersid,
                    updatedby: _securityusersid
                    })
                )
            });
        }

        if(Array.isArray(maltreatmentcharacterstics)){
            maltreatmentcharacterstics.forEach(maltreatmentcharacterstic =>{
                prs.push(
                    app.models.Investigationallegationcharacterstics.create({
                    investigationallegationid:id,
                    maltreatmentcharactersticstypekey:maltreatmentcharacterstic.maltreatmentcharactersticstypekey,
                    insertedby: _securityusersid,
                    updatedby: _securityusersid
                    })
                )
            });
        }

        if(Array.isArray(injurycharactertics)){
            injurycharactertics.forEach(injurycharactertic =>{
                prs.push(
                    app.models.Investigationallegationinjurycharacterstics.create({
                    investigationallegationid:id ,
                    injurycharactersticstypekey:injurycharactertic.injurycharactersticstypekey,
                    insertedby: _securityusersid,
                    updatedby: _securityusersid
                    })
                )
            });
        }

        if(Array.isArray(jurisdictionusers)){
            jurisdictionusers.forEach(jurisdictionuser =>{
                prs.push(
                    app.models.Maltreatmentjurisdictionuser.create({
                        roletypekey:jurisdictionuser.role,
                        username:jurisdictionuser.name,
                        maltreatmentid:maltreatment_id,
                        insertedby: _securityusersid,
                        updatedby: _securityusersid
                      })
                    )
            })
         }

         if(Array.isArray(providermaltreatments)){
            providermaltreatments.forEach(providermaltreatment =>{
                prs.push(
                    app.models.Allegationprovidermaltreatment.create({
                        investigationallegationid:id,
                        providermaltreatmenttypekey:providermaltreatment.providermaltreatmenttypekey,
                        insertedby: _securityusersid,
                        updatedby: _securityusersid
                      })
                    )
            })
         }

         if(Array.isArray(indicators)){
            indicators.forEach(indicator =>{
                prs.push(
                    app.models.Investigationallegationindicator.create({
                    investigationallegationid:id,                   
                    indicatorid:indicator.indicatorid,                   
                    insertedby: _securityusersid,
                    updatedby: _securityusersid
                    })
                )
            });
        }

        return Promise.all(prs);
    }


    Investigationmaltreatment.addupdate =(request, reqctx)=>{
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
      var investigationmaltreatmentactorid = null;
      var maltreatment_id = null;
      var responseJson = {};

     if((request.maltreatmentid === undefined || request.maltreatmentid === null)
    && (request.investigationallegationid ===undefined || request.investigationallegationid === null))
    {
        return  Investigationmaltreatment.create({
            investigationid:request.investigationid,
            householdkey:request.householdkey,
            isjurisdiction:request.isjurisdiction,
            countyid:request.countyid,
            enddate:request.enddate,
            isapproximatedate:request.isapproximatedate,
            timeofincidence:request.timeofincidence,
            incidentlocationtypekey:request.incidentlocationtypekey,
            providername:request.providername,
            providerid:request.providerid,
            providerphonenumber:request.providerphone,
            notapplicablecomments : request.notapplicablecomments,
            isnotapplicable : request.isnotapplicable,
            insertedby: _securityusersid,
            updatedby: _securityusersid,
            isreported:false
            }).then(data=>{
                 maltreatment_id = data.maltreatmentid;

                 Investigationmaltreatment.createAuditlog(request.objectid, request.objectype,request.securityuserid, _securityusersid);

                return app.models.Investigationmaltreatmentactor.create({
                  maltreatmentid:maltreatment_id,
                  intakeservicerequestactorid:request.intakeservicerequestactorid,
                  insertedby: _securityusersid,
                  updatedby: _securityusersid
                 }).then(mal => {
                  investigationmaltreatmentactorid = mal.investigationmaltreatmentactorid;
                 })
              }).then(resp =>{

               return app.models.Investigationallegation.create({
                investigationid:request.investigationid,
                investigationmaltreatmentactorid: investigationmaltreatmentactorid,
                allegationid:request.allegationid,
                maltreatmentid:maltreatment_id,
                name:request.allegationname,
                comments:request.comments,
                sextrafficking:request.sextrafficking,
                injurycomments:request.injurycomments,
                incidentdate:request.incidentdate,
                enddate:request.enddate,
                isapproximatedate:request.isapproximatedate,
                timeofincidence:request.timeofincidence,                
                incidentlocationtypekey:request.incidentlocationtypekey,
                isproviderinvolved:request.isproviderinvolved,
                insertedby: _securityusersid,
                updatedby: _securityusersid,
                investigationallegationstatus:request.investigationalegationstatuskey,
                outcome:request.outcome,
                relationshiptypekey:request.relationshiptypekey,
                ischildfatality: request.ischildfatality,
                fatalitycomments: request.fatalitycomments
               
               })
            }).then(result =>{
                responseJson  = result;
                var investigationallegid = result.investigationallegationid;
             return Investigationmaltreatment.othercharactersticsadd(request, investigationallegid,maltreatment_id, _securityusersid)
            }).then(resp => {
                if(request.providerCheckBoxChange) {
                    var securityusersid = _securityusersid;
                    var sql = "INSERT INTO improviderswitchinfo (objectid, objecttype,requestedby, insertedby, updatedby , activeflag, oldproviderid, newproviderid, providerchange ,reasonchange , explainreason, explainreasonlist)"+
                        " values ($1,$2,$3,$4,$5,$6,$7,$8, $9, $10, $11, $12)";
                    return util.executeDBQuery(sql,[maltreatment_id, 'Maltreatment',securityusersid,securityusersid, securityusersid, 1, request.providerid ,request.providerid, request.providerchange, request.reasonchange, request.explainReason, request.explainReasonList])
                    .then(res => {
                        return responseJson;
                    })
                    .catch(err => {
                        LOGGER.error(err)
                    })
                }
                else {
                    return responseJson;
                }
            }).then(resp => {
                var securityusersid = _securityusersid;
                var sql = "update intakeservicerequestsdm set linkschidresid=$1, updatedby = $2, updatedon = now() where  intakeservicerequestsdmid= $3";
                return util.executeDBQuery(sql,[request.linkschidresid, securityusersid, request.intakesdmid])
                .then(res => {
                    return res
                })
                .catch(err => {
                    LOGGER.error(err)
                })
            }).catch(err => util.logError(err));
        }
        else
        {
           return updateMaltreatment(request, _securityusersid);
        }
    }

    function updateMaltreatment(request, _securityusersid){
      var responseJson = {};
      var investigationmaltreatmentactorid = null;
      var investigationallegationid = null;
        return  Investigationmaltreatment.updateAll(
            { maltreatmentid:request.maltreatmentid},
            {
                householdkey:request.householdkey,
                isjurisdiction:request.isjurisdiction,
                countyid:request.countyid,
                enddate:request.enddate,
                isapproximatedate:request.isapproximatedate,
                timeofincidence:request.timeofincidence,
                incidentlocationtypekey:request.incidentlocationtypekey,
                providername:request.providername,
                providerid:request.providerid,
                providerphonenumber:request.providerphone,
                notapplicablecomments : request.notapplicablecomments,
                isnotapplicable : request.isnotapplicable,
                updatedby:_securityusersid}
            ).then(data =>{

             return app.models.Investigationmaltreatmentactor.find({
                where:{and:[{maltreatmentid:request.maltreatmentid},
                  {intakeservicerequestactorid:request.intakeservicerequestactorid}]}
              }).then(ima_res => {

                if(ima_res.length  === 0){
                  return app.models.Investigationmaltreatmentactor.create({
                    maltreatmentid:request.maltreatmentid,
                    intakeservicerequestactorid:request.intakeservicerequestactorid,
                    insertedby:_securityusersid,
                    updatedby:_securityusersid
                   }).then( result =>{
                     investigationmaltreatmentactorid = result.investigationmaltreatmentactorid
                    })
                }else {
                  investigationmaltreatmentactorid = ima_res[0].__data.investigationmaltreatmentactorid;
                }
              })
          }).then(resp =>{

                return app.models.Investigationallegation.updateAll(
                    { investigationallegationid:request.investigationallegationid},
                    { investigationid:request.investigationid,
                        investigationmaltreatmentactorid: investigationmaltreatmentactorid,
                        allegationid:request.allegationid,
                        maltreatmentid:request.maltreatmentid,
                        name:request.allegationname,
                        comments:request.comments,
                        injurycomments:request.injurycomments,
                        incidentdate:request.incidentdate,
                        sextrafficking:request.sextrafficking,
                        enddate:request.enddate,
                        isapproximatedate:request.isapproximatedate,
                        timeofincidence:request.timeofincidence,
                        incidentlocationtypekey:request.incidentlocationtypekey,
                        isproviderinvolved:request.isproviderinvolved,
                        insertedby: _securityusersid,
                        updatedby: _securityusersid,
                        investigationallegationstatus:request.investigationalegationstatuskey,
                        outcome:request.outcome,
                       relationshiptypekey:request.relationshiptypekey,
                        ischildfatality: request.ischildfatality,
                        fatalitycomments: request.fatalitycomments
                    })
                 
          
        }).then(res =>{

                if(request.investigationallegationid !=null || res.investigationallegationid ===undefined ){
                    investigationallegationid = request.investigationallegationid;
                }
                else{
                    investigationallegationid = res.investigationallegationid;
                }

                var sql = 'select * from updateallegation($1,$2)';
                return util.executeDBQuery(sql,[investigationallegationid,request.maltreatmentid])
                .then(data => {
                    return data;
                })
                .catch(err => {
                    LOGGER.error(err)
                })
            }).then(result =>{
                var sql = "update allegationprovidermaltreatment set activeflag = 0, updatedby = $1, updatedon = now() where investigationallegationid = $2";
                var securityusersid = _securityusersid;
                return util.executeDBQuery(sql,[securityusersid, investigationallegationid])
                .then(res => {
                    return result;
                })
                .catch(err => {
                    LOGGER.error(err)
                })
            }).then(result =>{
                responseJson  = result;
                return Investigationmaltreatment.othercharactersticsadd(request, investigationallegationid,request.maltreatmentid, _securityusersid)
            }).then(resp => {
                if(request.providerCheckBoxChange) {
                    var sql = "INSERT INTO improviderswitchinfo (objectid, objecttype,requestedby, insertedby, updatedby , activeflag, oldproviderid, newproviderid, providerchange ,reasonchange , explainreason, explainreasonlist)"+
                    " values ($1,$2,$3,$4,$5,$6,$7,$8, $9, $10, $11, $12)";
                    var securityusersid = _securityusersid;
                    return util.executeDBQuery(sql,[request.maltreatmentid, 'Provider',securityusersid,securityusersid, securityusersid, 1, request.oldprovider ,request.providerid, request.providerCheckBoxChange, request.reasonchange, request.explainReason, request.explainReasonList])
                    .then(res => {
                        return responseJson;
                    })
                    .catch(err => {
                        LOGGER.error(err)
                    })
              } else {
                return responseJson;
              }
            }).then(resp => {
                var sql = "update intakeservicerequestsdm set linkschidresid=$1, updatedby = $2, updatedon = now() where  intakeservicerequestsdmid= $3";
                var securityusersid = _securityusersid;
                return util.executeDBQuery(sql,[request.linkschidresid, securityusersid, request.intakesdmid])
                .then(res => {
                    return res;
                })
                .catch(err => {
                    LOGGER.error(err)
                })
            }).catch(err => util.logError(err));
    }

    // Investigation Started Audit Log
    Investigationmaltreatment.createAuditlog = function (objectid, objectype,suserid, _securityusersid) {
        app.models.Auditlog.create({
            logtypekey:'IN002',
            intakeserviceid:null,
            servicerequestnumber:null, 
            referenceid:null, 
            description:'Investigation Started', 
            isnew :false,
            isedit:true,
            isdelete:true,
            insertedby:(suserid?suserid: _securityusersid),
            updatedby:(suserid ?suserid: _securityusersid),
            insertedon:new Date(),
            updatedon:new Date(),
            metadata:null,
            ipaddress:null,
            old_id:null,
            modifieddata:null,
            objectid:objectid,
            objecttype: objectype
        }).catch(err => LOGGER.error(err));
    };

    Investigationmaltreatment.remoteMethod(
        'addupdate',
                {
                  http: {
                          path: '/addupdate',
                          verb: 'post'
                  },
                 accepts : [ {arg : 'data',type : 'object',
                         http : {source : 'body'}}, {
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

    Investigationmaltreatment.remoteMethod('addfindings',
        {
            http:
            {
                path: '/addfindings',
                verb: 'post'
            },
            accepts : [
                {
                    arg : 'data',
                    type : 'object',
                    http : {
                        source : 'body'
                        }}, {
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
    Investigationmaltreatment.updateinvestigationfindings=(investigationallegationid)=>{
    var sql = 'select * from updateinvestigationfinding($1)';

    return util.executeDBQuery(sql,[investigationallegationid])
        .then(data => data)
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        })
    }
    Investigationmaltreatment.addfindings = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
        let prs = [];
        var allegedpersons = request.allegedperson;
        const commentaudit = request.commentAuditTrail;
        /* update investigation details into investigation table*/
        return app.models.Investigation.updateAll(
            {
                investigationid: request.investigationid
            },
            {
                investigationsummary: request.summary,
                jointinvestigation: request.jointinvestigation,
                updatedby:_securityusersid,
                fatalitycommentaudittrail: JSON.stringify(commentaudit)
            }
        ).then(resp => {
             /* update remarks into maltreatment   table*/
            LOGGER.debug(request.remarks +"request.remarks");
            if (request.maltreatmentid) {
                return Investigationmaltreatment.updateAll(
                {
                    maltreatmentid: request.maltreatmentid
                },
                {
                    notes: request.remarks,
                    updatedby:_securityusersid
                })
            }
        }).then(response => {
            /*Person loop*/
            if(Array.isArray(allegedpersons)) {
                allegedpersons.forEach(allegedperson => {


                /* inactive the existing findings*/
              return  Investigationmaltreatment.updateinvestigationfindings(allegedperson.investigationallegationid).then((data)=>{
                //   LOGGER.debug("DATA After ((((((((((((((((((((")

                
                addAttchments(allegedperson, _securityusersid);

                return app.models.Investigationallegation.updateAll(
                    {investigationallegationid: allegedperson.investigationallegationid},
                    {ischildfatality: allegedperson.ischildfatality,
                    fatalitycomments: allegedperson.fatalitycomments,
                    victim_explanation: allegedperson.victim_explanation,
                    sibling_explanation: allegedperson.sibling_explanation,
                    guardian_explanation: allegedperson.guardian_explanation,
                    maltreator_explanation: allegedperson.maltreator_explanation,
                    med_assessmnts: allegedperson.med_assessmnts,
                    expert_assessmnts: allegedperson.expert_assessmnts,
                    collateral_interviews: allegedperson.collateral_interviews,
                    law_enforcement_inv:allegedperson.law_enforcement_inv,
                    criminal_history_inv: allegedperson.criminal_history_inv,
                    home_conditions: allegedperson.home_conditions}
                )
              }).then( rr => {

                        /* Insert the maltreatment findings basedon on investigationallegationid*/
                    if(allegedperson.investigationfindings !== null ){
                            app.models.Investigationallegation.updateAll(
                                {investigationallegationid: allegedperson.investigationallegationid},
                                {
                                    ischildfatality: allegedperson.ischildfatality,
                                    fatalitycomments: allegedperson.fatalitycomments
                                }
                            );
                        prs = createInvestigationfinding(allegedperson, request, _securityusersid, prs)
                    }
                })});
                    return Promise.all(prs);
                }
            }).then(data =>"Success")
              .catch(err =>  LOGGER.error(err));
}

    function createInvestigationfinding(allegedperson,request,_securityusersid, prs) {
        if (Array.isArray(allegedperson.investigationfindings) && allegedperson.investigationfindings.length > 0) {
            for (const element of allegedperson.investigationfindings) {
                const assessors = element.findingassesors
                prs.push(
                    app.models.Investigationfinding.create({
                        investigationfindingtypekey: element.investigationfindingtypekey,
                        investigationallegationid: allegedperson.investigationallegationid,
                        personid: allegedperson.personid,
                        findingcomments: element.findingcomments,
                        isharm: element.isharm,
                        isharmsubstantial: element.isharmsubstantial,
                        harmdesc: element.harmdesc,
                        intentionalinjurydesc: element.intentionalinjurydesc,
                        omissiondesc: element.omissiondesc,
                        victim_explanation: request.victim_explanation,
                        sibling_explanation: request.sibling_explanation,
                        guardian_explanation: request.guardian_explanation,
                        maltreator_explanation: request.maltreator_explanation,
                        med_assessmnts: request.med_assessmnts,
                        expert_assessmnts: request.expert_assessmnts,
                        collateral_interviews: request.collateral_interviews,
                        criminal_history_inv: request.criminal_history_inv,
                        home_conditions: request.home_conditions,
                        insertedby: _securityusersid,
                        updatedby: _securityusersid
                    }).then(res => {
                        var resp = JSON.parse(JSON.stringify(res))
                        if (resp !== null && util.isNullorEmpty(assessors)) {
                            return assessors.map(ele => {
                                app.models.Investigationfindingassessors.create({
                                    investigationfindingid: resp.investigationfindingid,
                                    securityusersid: ele.securityusersid,
                                    professiontypekey: ele.professiontypekey,
                                    isassessor: ele.isassessor,
                                    firstname: ele.firstname,
                                    lastname: ele.lastname,
                                    comments: ele.comments,
                                    insertedby: _securityusersid,
                                    updatedby: _securityusersid
                                })
                            })
                        }
                    })
                )
            }
        }
        return prs;
    }

function addAttchments(allegedperson, _securityusersid){
    if (util.isNullorEmpty(allegedperson.expert_assessmnts_attachment) && Array.isArray(allegedperson.expert_assessmnts_attachment)) {
        allegedperson.expert_assessmnts_attachment.map(attach => {
            attach.objectid = allegedperson.investigationallegationid;
            attach.objecttypekey = 'InvsFindPhysican';
            attach.insertedby = _securityusersid;
            attach.updatedby = _securityusersid;
            app.models.Documentproperties.addattchment(attach);
        })
    }
    if (util.isNullorEmpty(allegedperson.med_assessmnts_attachment) && Array.isArray(allegedperson.med_assessmnts_attachment)) {
        allegedperson.med_assessmnts_attachment.map(attach => {
            attach.objectid = allegedperson.investigationallegationid;
            attach.objecttypekey = 'InvestigationFindingMed';
            attach.insertedby = _securityusersid;
            attach.updatedby = _securityusersid;
            app.models.Documentproperties.addattchment(attach);
        })
    }
    if (util.isNullorEmpty(allegedperson.law_enforcement_attachment) && Array.isArray(allegedperson.law_enforcement_attachment)) {
        allegedperson.law_enforcement_attachment.map(attach => {
            attach.objectid = allegedperson.investigationallegationid;
            attach.objecttypekey = 'InvsFindlawEnforcement';
            attach.insertedby = _securityusersid;
            attach.updatedby = _securityusersid; 
            app.models.Documentproperties.addattchment(attach);
        })
    }
}


	Investigationmaltreatment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationmaltreatment.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationmaltreatment.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
