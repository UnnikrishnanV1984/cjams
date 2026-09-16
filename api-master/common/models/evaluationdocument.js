'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const pdf = require('../models/pdf');
const Caseplanlegacy = require('../models/caseplanlegacy');
const LOGGER = require("log4js").getLogger("evaluationdocument");


module.exports = function (Evaluationdocument) {

    Evaluationdocument.list = request => {
        let intakenumber = "";

        if (request.where) {
            intakenumber = request.where.intakenumber;
        }
        const skip = (request.page - 1) * request.limit;
        const limit = request.limit;

        const sql = "select * from listintakedocs($1, $2, $3)";

        return util.executeSecondaryNodeDBQuery(sql, [intakenumber, skip, limit]).then(resp => {
                const data = JSON.parse(JSON.stringify(resp));
                let totalCount = 0;
                if (data.length > 0){
                    totalCount = data[0].totalcount;}
                data.forEach(x => delete x.totalcount);
                return {
                    totalcount: totalCount,
                    data: data
                };
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Evaluationdocument.listhistory = request => {
        let intakedocid = util.emptyUUID;

        if (request.where) {
            intakedocid = request.where.evaluationdocumentid;
        }

        const skip = (request.page - 1) * request.limit;
        const limit = request.limit;

        const sql = "select * from listintakedochistory($1, $2, $3)";

        return util.executeSecondaryNodeDBQuery(sql, [intakedocid, skip, limit]).then(resp => {
                const data = JSON.parse(JSON.stringify(resp));
                let totalCount = 0;
                if (data.length > 0) {
                    totalCount = data[0].totalcount;
                    data.forEach(x => delete x.totalcount);
                }
                return {
                    totalcount: totalCount,
                    data: data
                };
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Evaluationdocument.add = data => {
        const intakeDoc = data;
        return Evaluationdocument.findOne({
                where: {
                    and: [{
                        intakeservicerequestevaluationid: data.intakeservicerequestevaluationid
                    }, {
                        documenttemplatekey: data.documenttemplatekey
                    }, {
                        or: [{
                            intakenumber: data.intakenumber
                        }, {
                            intakeserviceid: data.intakeserviceid
                        }]
                    }]
                },
                order: 'versionno desc',
                fields: 'versionno'
            })
            .then(_data => {
                let versionno = 1;

                if (_data && _data.versionno)
                    {versionno = parseInt(_data.versionno) + 1;}

                intakeDoc.versionno = versionno;

                return Evaluationdocument.create(intakeDoc);
            })
            .then(_data => _data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    //list remote method
    Evaluationdocument.remoteMethod('list', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/list',
            verb: 'get'
        },
        returns: {
            type: 'string',
            root: true
        }
    });

    //list history remote method
    Evaluationdocument.remoteMethod('listhistory', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/listhistory',
            verb: 'get'
        },
        returns: {
            type: 'string',
            root: true
        }
    });

    //add document
    Evaluationdocument.remoteMethod(
        'add', {
            http: {
                path: '/add',
                verb: 'post'
            },
            accepts: [{
                    arg: 'data',
                    type: 'Object',
                    http: {
                        source: 'body'
                    }
                }

            ],
            returns: {
                arg: 'data',
                type: 'Object'
            }
        });

    Evaluationdocument.generateintakedocument = async  (request, response, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        let prs = [];
        prs = request.where.documenttemplatekey.map( async (docukey) => {
            request.documntkey = docukey;
            switch (docukey.toLowerCase()) {
                case 'compnotif':
                    return pdf.CompNotif(request,reqctx);
                case 'intakeinfaction':
                    return pdf.IntakeInfAction(request,reqctx);
                case 'victimimpact':
                    return pdf.VictimImpact(request,reqctx);
                case 'consentinfsupervision':
                    return pdf.ConsentInformalAdjustmentSupervision(request,reqctx);
                case 'consentinfadjust':
                    return pdf.ConsentInformalAdjustment(request,reqctx);
                case 'officevisit':
                    return pdf.OfficeVisit(request,reqctx);
                case 'orientalform':
                    return pdf.OrientalForm(request,reqctx);
                case 'intakeds':
                    return pdf.IntakeDS(request,reqctx);
                case 'recordreview':
                    return pdf.IntakeRecordReview(request);
                case 'detentionauth':
                    return pdf.DetentionShelterAuth(request);
                case 'intakeappealcins':
                    return pdf.IntakeDecisionAppealCins(request,reqctx);
                case 'intakeappeal':
                    return pdf.IntakeDecisionAppeal(request,reqctx);
                case 'courtmemo':
                    return pdf.CourtMemorandum(request,reqctx);
                case 'noticepreintake':
                    return pdf.NoticePreIntake(request,reqctx);
                case 'offhistory':
                    return pdf.OffenseHistory(request,reqctx);
                case 'felonymemo':
                    return pdf.FelonyMemo(request,reqctx);

                //sprint-2 changes 
                case 'authinformation':
                    return pdf.authInformation(request);
                case 'eduservicerecord':
                    return pdf.eduservicerecord(request);
                case 'ackletter':
                    return pdf.AckLetter(request);
                case 'intakeprocessform':
                    return pdf.intakeProcessForm(request);
                case 'ihasmonthlyreport':
                    return pdf.IhasMonthlyReport(request,reqctx);
                case 'paymentauthorization':
                    return pdf.paymentauthorization(request);
                case 'appointletter':
                    return pdf.AppointLetter(request,reqctx);
                case 'purchaseauthorization':
                    return pdf.Purchaseauthorization(request,response);
                case 'servicepurchaseauthorizations':
                    return pdf.servicepurchaseauthorizations(request,response);
                case 'cfebedretainerpayment':
                    return pdf.cfePaymentReport(request,response);
                case 'medsubabuse':
                    return pdf.MedicalSubstanceAbuse(request);
                case 'victimconsentis':
                    return pdf.victimConsentInformalSupervision(request,reqctx);
                case 'child116report':
                    return pdf.child116report(request,response);
                
            }
         
            switch(docukey.toLowerCase()) {
                case 'child111report':
                    return pdf.child111report(request,response);
                case 'child113report':
                    return pdf.child113report(request,response);
                case 'child114report':
                    return pdf.child114report(request,response);
                case 'child115report':
                    return pdf.child115report(request,response);
                case 'child117report':
                    return pdf.child117report(request,response);
                case 'cinaform':
                    return pdf.cinaForm(request,response);
                case 'cdprelimconsent':
                    return pdf.cdprelimconsent(request,reqctx);
                case 'medicalconsentform':
                    return pdf.medicalconsentform(request);
                case 'nightintake':
                    return pdf.nightintake(request,reqctx);
                case 'cdprogram':
                    return pdf.cdprogram(request,reqctx);
                case 'cdteleconsentagree':
                    return pdf.cdteleconsentagree(request,reqctx);
                case 'fsyouthfacesheet':
                    return pdf.fsyouthfacesheet(request,reqctx);
                case 'paidmemo':
                    return pdf.paidsatisfiedmemo(request,reqctx);
                case 'noticesatisfaction':
                    return pdf.noticesatisfaction(request,reqctx);
                case 'appendixg':
                    return pdf.appendixg(request,reqctx);
                case 'rstninput':
                    return pdf.appendixb(request);
                case 'appendixd':
                    return pdf.appendixd(request,reqctx);
                case 'appendixe':
                    return pdf.appendixe(request,reqctx);
                case 'appendixf':
                    return pdf.appendixf(request,reqctx);
                case 'appendixh':
                    return pdf.appendixh(request,reqctx);
                case 'appendixi':
                    return pdf.appendixi(request,reqctx);
                case 'appendixj':
                    return pdf.appendixj(request,reqctx);
                case 'appendixl':
                    return pdf.appendixl(request,reqctx);
                case 'appendixn':
                    return pdf.appendixn(request,reqctx);
                case 'appendixo':
                    return pdf.appendixo(request,reqctx);
                case 'appendixp':
                    return pdf.appendixp(request,reqctx);
            }

            switch(docukey.toLowerCase()) {
                case 'form1080a':
                    return pdf.form1080aDocument(request, response);
                case 'form1080b':
                    LOGGER.info('>>> RESPONSE - Form-1080-b');
                    return pdf.form1080bDocument(request,response);
                case 'form1080c':
                    LOGGER.info('>>> RESPONSE - Form-1080-b');
                    return pdf.form1080cDocument(request, response);
            }

            switch(docukey.toLowerCase()) {  // NOSONAR
                case 'res_pmt_slip':
                    return pdf.res_pmt_slip(request);
                case 'appendixk':
                    return pdf.appendixk(request,reqctx);
                case 'appendixm':
                    return pdf.appendixm(request,reqctx);
                case 'lettervictimcc':
                    return pdf.lettervictimcc(request,reqctx);
                case 'rstnguide':
                    return pdf.guidetorestitution(request,reqctx);
                case 'appendixs':
                    return pdf.appendixs(request,reqctx);
                case 'inhome':
                    return pdf.servicePlanPDF(request);
                case 'caseplansocialhistory':
                    return pdf.caseplansocialhistory(request,response);
                case 'overpaymentnotice':
                    return pdf.overpaymentnotice(request,response,_securityusersid);
                case 'contactpdf':
                    return pdf.contactpdf(request,response);
                case 'caseplan1':
                    return Caseplanlegacy.caseplan1pdf(request,response);
                case 'caseplan3appla':
                    return Caseplanlegacy.getcaseplan3appla(request,response);
                case 'caseplan4ilp':
                    return Caseplanlegacy.getcaseplan4ilp(request,response);
                case 'caseplan3agreement':
                    return Caseplanlegacy.getcaseplan3agreement(request,response);
                case 'agreement':
                    return pdf.ihs_agreement(request,response);
                case 'caseplan2':
                    return Caseplanlegacy.caseplan2pdf(request,response);
                case 'ytp':
                    return pdf.getYTPpdf(request,response);
                case 'intakereport':
                    return pdf.intakereport(request,response);
                case 'assessment':
                    return pdf.assessment(request,response);
                case 'ivefostercarepdf':
                    return pdf.ivefostercarePDF(request,response);
                case 'canssummarysheet':
                    return pdf.canssummarysheet(request, response);
                    case 'cansfsummarysheet':
                        return pdf.cansfsummarysheet(request, response);
                case 'adoptionacaform':
                    return pdf.adoptionacaformPDF(request,response);
                case 'gapeligibilityform':
                    return pdf.gapeligibilityformPDF(request,response);
                case 'adoptioneligibilityform':
                    return pdf.adoptioneligibilityformPDF(request,response);
                case 'iveapprovalsection':
                    return pdf.iveapprovallistformPDF(request,response,_securityusersid);
                case 'serviceintendedaction':
                    return pdf.ihs_serviceintendedaction(request,response);
                case 'safecareplan':
                    LOGGER.info('>>> RESPONSE - POSC Print 370');
                    return pdf.safecareplan(request,response);
                case 'courtqrtp':
                    return pdf.courtqrtp(request,response);
                case 'qrtpdocument':
                    LOGGER.info('>>> RESPONSE - POSC Print 370');
                    return pdf.qrtpdocument(request,response);
                case 'personhealthreport':
                    const examinationHealth = await pdf.examinationhealth(request, response);
                    const birthNeonatalInformation = await pdf.birthNeonatalInformation(request, response);
                    const reproductiveHealth = await pdf.reproductiveHealth(request, response);
                    const personHospitalization = await pdf.personHospitalization(request, response);
                    const immunizationData = await pdf.immunizationData(request, response);
                    const behavirolHealthData = await pdf.behavirolHealthData(request, response);
                    const disabilities = await pdf.disabilitiesReport(request, response);
                   const combinedreportsummary = await pdf.combinedreport(request, {
                       examinationHealth,
                       birthNeonatalInformation,
                       reproductiveHealth,
                       personHospitalization,
                       immunizationData,
                       behavirolHealthData,
                       disabilities,
                   }, response);
                    return { combinedreportsummary };
            }
            
        })
        return Promise.all(prs)
            .then(result => {
                return result;
            })
          .catch(err => {
            LOGGER.error('<< POSC SAFECAREPLAN Error Line 1 >>', err);
              return err
          });

    };

    Evaluationdocument.remoteMethod('generateintakedocument', {

        http: {
            path: '/generateintakedocument',
            verb: 'post'
        },
        accepts: [{
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body'
                }
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res'
                }
            }, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }

        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    })



    Evaluationdocument.getpetitiondetailsbycomplaint = request => {
        var intakedevalid = '';
        if (request.where) {
            intakedevalid = request.where.intakeservicerequestevaluationid;
        }
        const sql = "select * from getpetitiondetailsbycomplaint($1)";
        return util.executeSecondaryNodeDBQuery(sql, [intakedevalid]).then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Evaluationdocument.remoteMethod(
        'getpetitiondetailsbycomplaint', {
            http: {
                path: '/getpetitiondetailsbycomplaint',
                verb: 'post'
            },
            accepts: [{
                    arg: 'data',
                    type: 'Object',
                    http: {
                        source: 'body'
                    }
                }

            ],
            returns: {
                arg: 'data',
                type: 'Object'
            }
        });

    Evaluationdocument.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Evaluationdocument.observe('access', (ctx, next) => util.access(ctx, next));
    Evaluationdocument.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}