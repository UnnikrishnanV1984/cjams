'use strict';
const errorUtils = require('../../server/utils/error-utils');
const app = require('../../server/server');
const hash = require('object-hash');
const moment = require('moment');
const _ = require('lodash');
const R = require('ramda');
const axios = require('axios');
const { v4: uuidv4 } = require('uuid');
const pdf = require('../models/pdf');
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("title-ive-foster-care");
const delay = ms => new Promise(resolve => setTimeout(resolve, ms));

var typeoflapsescheck = null;
const dtformat = 'MM/DD/YYYY';
const dtformat1 = 'YYYY-MM-DD';
const placementreimbursiblepath = "placementInfo.0.placement.0.isplacementreimbursible";
const livingarrangementtypepath = "placementInfo.0.placement.0.livingarrangementtype";
const startdtpath = 'periodsInfo.start_dt';
const kindoflapsespath = "placementInfo.0.kindoflapses";
const sheltercare = 'Shelter Care';
const lapsesinplacementpath = "placementInfo.0.islapsesinplacement";
const typeoflapsespath = "placementInfo.0.typeoflapses";
const childbeeninfostercarefor12monthsormorepath = 'periodsInfo.hasthechildbeeninfostercarefor12monthsormore';
const courtstatus = 'Court Status';
const spivefcauditperiodssql = 'select * from sp_ive_fc_audit_periods(\'';
const invalidinputmsg = 'sent invalid inputs';
const jsoncontenttype = 'application/json';
const eligibilityworksheetdesc = 'Get eligibilty worksheet data';
const silahm = 'SILA home/Apartment';
let dummyEvent = [];
let securityuseriddetails;

let reviewperiodstartdate; 
let reviewperiodenddate; 


// Every worksheet-section loader below returns its rows untouched, or an empty
// object when the query found nothing. Shared so the identical block is not
// repeated per section.
const rowsOrEmpty = data => (data?.length > 0) ? data : {};

// Shared failure path for those loaders: log locally, then rethrow so the caller
// still sees a failed request.
const logAndRethrow = err => {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
};

module.exports = function (TitleIVEFC) {

    TitleIVEFC.getFcPeriods = (clientId, removalId) => {
        try {
            let sql = '';
            let result = '';

            sql = 'select * from sp_fc_worksheet_periods_info($1, $2)';
            return util.executeDBQuery(sql, [clientId, removalId]).then(data => {
                if (data?.length > 0) {
                    result = {
                        data,
                    };
                } else {
                    result = {
                        'data': [],
                    };
                }
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    const getSummaryInfo = (clientId, ds) => {
        const sql = 'select * from sp_fc_worksheet_summary_info($1)';
        return util.executeDBQuery(sql, [clientId]).then(rowsOrEmpty).catch(logAndRethrow);
    };

    const getGenaralInfo = (clientId, ds) => {
        const sql = 'select * from sp_fc_worksheet_general_info($1)';
        return util.executeDBQuery(sql, [clientId]).then(rowsOrEmpty).catch(logAndRethrow);
    };

    const getMultipleCourtInfo = (clientId, removalId, periodtype, periodStartDt, periodEndDt, initialstartdate, ds) => {
        let sql;
        let params;
        sql = 'select * from sp_fc_worksheet_multiple_court_info($1, $2, $3, $4, $5)';
        if (periodtype === '18BDAY' && initialstartdate) {
            params = [clientId, removalId, periodtype, initialstartdate, periodStartDt];
        } else {
            params = [clientId, removalId, periodtype, periodStartDt, periodEndDt];
        }
        return util.executeDBQuery(sql, params).then(rowsOrEmpty).catch(logAndRethrow);
    };

    const getRemovalInfo = (clientId, removalId, ds) => {
        const sql = 'select * from sp_fc_worksheet_removal_info($1, $2)';
        return util.executeDBQuery(sql, [clientId, removalId]).then(rowsOrEmpty).catch(logAndRethrow);
    };

    const getIncomeInfo = (clientId, removalId, ds) => {
     const sql = 'SELECT * FROM iveincomesumary where clientid = $1 and removalid = $2';

        return util.executeSecondaryNodeDBQuery(sql,[clientId, removalId])
        .then(rowsOrEmpty)
        .catch(logAndRethrow);
    };

    const getHouseHoldInfo = (clientId, removalId, ds) => {
        const sql = `select * from getfinanceincomebycase($1,$2)`;
        return util.executeSecondaryNodeDBQuery(sql,[removalId,clientId])
        .then(rowsOrEmpty)
        .catch(logAndRethrow);
    };
    const getHouseHoldInfoRules = (clientId, removalId, ds) => {
        const sql = 'select * from gethouseholdinfoincome($1,$2)';
        return util.executeSecondaryNodeDBQuery(sql,[removalId, clientId])
        .then(rowsOrEmpty)
        .catch(logAndRethrow);
    };


    const getSpecifiedRelativeInfo = (clientId, removalId, ds) => {
     const sql = `SELECT * FROM specifiedrelative where toclientid = $1 and removalid = $2`;

        return util.executeSecondaryNodeDBQuery(sql,[clientId,removalId])
        .then(rowsOrEmpty)
        .catch(logAndRethrow);
    };


    const getDeprivationInfo = (clientId, removalId, ds) => {
     const sql = `SELECT * FROM ivepersondeprivation where clientid = $1 and removalid = $2`;

        return util.executeSecondaryNodeDBQuery(sql,[clientId,removalId])
        .then(rowsOrEmpty)
        .catch(logAndRethrow);
    };


    const getInitialCriteriaInfo = (clientId, ds) => {
        const sql = `select * from sp_fc_worksheet_initial_criteria_info($1)`;
        return util.executeDBQuery(sql, [clientId]).then(rowsOrEmpty).catch(logAndRethrow);
    };

    const getRedetCriteriaInfo = (clientId, ds) => {
        const sql = `select * from sp_fc_worksheet_redet_criteria_info($1)`;
        return util.executeDBQuery(sql, [clientId]).then(rowsOrEmpty).catch(logAndRethrow);
    };

    const getEighteenCriteriaInfo = (clientId, ds) => {
        const sql = `select * from sp_fc_worksheet_eighteen_criteria_info($1)`;
        return util.executeDBQuery(sql, [clientId]).then(rowsOrEmpty).catch(logAndRethrow);
    };

    const getSSISSACriteriaInfo = (clientId, removalId, detPeriodType, ds) => {
     const sql = `select * from sp_fc_worksheet_ssi_ssa_criteria_info($1, $2, $3)`;

        return util.executeSecondaryNodeDBQuery(sql, [clientId, removalId, detPeriodType])
        .then(rowsOrEmpty)
        .catch(logAndRethrow);
    };

    const getPlacementInfo = (clientId, removalId, sqnm_sw, startDate, endDate, ds) => {
        let sql;
        let params;
        if(sqnm_sw === 'I') {
            endDate = moment(startDate).add(60, 'days').format(dtformat);
        }
        if (endDate === null) {
             if (sqnm_sw === '18BDAY') {
                sql = `select * from sp_fc_worksheet_placement($1, $2, $3::date, $4::date, $5)`;
                params = [clientId, removalId, startDate, startDate, sqnm_sw];
             } else {
                 sql = `select * from sp_fc_worksheet_placement($1, $2, $3::date, $4::date, $5)`;
                 params = [clientId, removalId, startDate, null, sqnm_sw];
             }
        } else {
            sql = `select * from sp_fc_worksheet_placement($1, $2, $3::date, $4::date, $5)`;
            params = [clientId, removalId, startDate, endDate, sqnm_sw];
        }
        return util.executeDBQuery(sql, params)
        .then(data => {
            if (data?.length > 0) {
                if(data[0].typeoflapses === 'Temporary') {
                    typeoflapsescheck = data[0].typeoflapses;
                }
                return data;
            } else {
                return {};
            }
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        })
    };

    const getPeriodsInfo = (clientId, removalId) => {
        return TitleIVEFC.getFcPeriods(clientId, removalId).then(periods => {
            return _.groupBy(periods.data, 'sqnm_sw');
        }).catch(() => {
            return {};
        });
    };

    const getEventsInfo = (periodsInfoData, detPeriodType, reviewPeriodEnd) => {
        const eventsData = [];
        for (const key in periodsInfoData) {
            if (keycheck(key, detPeriodType)) {
               const spiltkey = key.split('E')[0];
                if (spiltkey === detPeriodType && (periodsInfoData[key][0].start_dt <= periodsInfoData[key][0].end_dt || periodsInfoData[key].end_dt == null)) { 
                   if ((periodsInfoData[key][0].end_dt == null && periodsInfoData[key][0].isplacementreimbursible) || (periodsInfoData[key][0].end_dt == null && typeoflapsescheck === 'Temporary')) {
                        periodsInfoData[key][0].end_dt = reviewPeriodEnd
                   }
                    eventsData.push(periodsInfoData[key]);
               }
            }
        }
        return eventsData;
    };

    function keycheck(key, detPeriodType){
        return key !== detPeriodType && key.indexOf(detPeriodType) === 0;
    }

    TitleIVEFC.eligibilityWorksheet = (data) => {
        const ds = app.dataSources.hcuewelfare;
        const clientId = _.get(data, 'clientId');
        const removalId = _.get(data, 'removalId');
        const detPeriodType = _.get(data, 'detPeriodType');

        return getPeriodsInfo(clientId, removalId).then((periodsInfoData) => {
            const periodsData = _.get(periodsInfoData, detPeriodType);
            const periodsInfo = _.head(periodsData);
            const reviewPeriodEnd = _.get(periodsInfo, 'end_dt') ? periodsInfo.end_dt : null;
            const eventsInfo = getEventsInfo(periodsInfoData, detPeriodType, reviewPeriodEnd);
            _.get(periodsInfo, 'intakeservreqcourtorderid');
            const sqnmSw = _.get(periodsInfo, 'sqnm_sw');
            const placementStartDt = _.get(periodsInfo, 'start_dt') ? moment(periodsInfo.start_dt).format(dtformat1) : null;
            const placementEndDt = _.get(periodsInfo, 'end_dt') ? moment(periodsInfo.end_dt).format(dtformat1) : null;

            let initialstartdate = null;
            if(periodsInfoData && periodsInfoData.I && periodsInfoData.I.length && sqnmSw === '18BDAY') {
                initialstartdate =  moment(periodsInfoData.I[0].start_dt).format(dtformat1);
            }
            const getSummaryInfoPromise = getSummaryInfo(clientId, ds);
            const getGenaralInfoPromise = getGenaralInfo(clientId, ds);
            const getRemovalInfoPromise = getRemovalInfo(clientId, removalId, ds);
            const getIncomeInfoPromise = getIncomeInfo(clientId, removalId, ds);
            const getHouseHoldInfoPromise = getHouseHoldInfo(clientId, removalId, ds);
            const getSpecifiedRelativeInfoPromise = getSpecifiedRelativeInfo(clientId, removalId, ds);
            const getDeprivationInfoPromise = getDeprivationInfo(clientId, removalId, ds);
            const getInitialCriteriaInfoPromise = getInitialCriteriaInfo(clientId, ds);
            const getRedetCriteriaInfoPromise = getRedetCriteriaInfo(clientId, ds);
            const getEighteenCriteriaInfoPromise = getEighteenCriteriaInfo(clientId, ds);
            const getSSISSACriteriaInfoPromise = getSSISSACriteriaInfo(clientId, removalId, detPeriodType, ds);
            const getPlacementInfoPromise = getPlacementInfo(clientId, removalId, sqnmSw, placementStartDt, placementEndDt, ds);
            const getHouseHoldInRule = getHouseHoldInfoRules(clientId, removalId, ds);
            const getMultipleCourtInfoPromise = getMultipleCourtInfo(clientId, removalId, sqnmSw, placementStartDt, placementEndDt, initialstartdate, ds);

            return Promise.all([
                getGenaralInfoPromise,
                getSummaryInfoPromise,
               getRemovalInfoPromise,
                getIncomeInfoPromise,
                getHouseHoldInfoPromise,
                getSpecifiedRelativeInfoPromise,
                getDeprivationInfoPromise,
                getInitialCriteriaInfoPromise,
                getRedetCriteriaInfoPromise,
                getEighteenCriteriaInfoPromise,
                getSSISSACriteriaInfoPromise,
                getPlacementInfoPromise,
                getHouseHoldInRule,
                getMultipleCourtInfoPromise
            ]).then((data1) => {
                const generalInfo = data1[0]; // getGenaralInfoPromise
                const summaryInfo = data1[1]; // getSummaryInfoPromise
                const removalInfo = data1[2]; // getRemovalInfoPromise
                const incomeInfo = data1[3]; // getIncomeInfoPromise
                const householdInfo = data1[4]; // getHouseHoldInfoPromise
                const specifiedRelativeInfo = data1[5]; // getSpecifiedRelativeInfoPromise
                const deprivationInfo = data1[6]; // getDeprivationInfoPromise
                const initialCriteriaInfo = data1[7]; // getInitialCriteriaInfoPromise
                const redetCriteriaInfo = data1[8]; // getRedetCriteriaInfoPromise
                const eighteenCriteriaInfo = data1[9]; // getEighteenCriteriaInfoPromise
                const ssissaCriteriaInfo = data1[10]; // getSSISSACriteriaInfoPromise,
                const placementInfo = data1[11]; // getPlacementInfo
                const getHouseHoldInRule1 = data1[12];
                const MultipleCourtInfo = data1[13];// getMultipleCourtInfoPromise
                const flatJson = Object.assign(
                    {},
                    { periodsInfo },
                    { eventsInfo },
                    _.get(generalInfo, '0'),
                    _.get(summaryInfo, '0'),
                    _.get(removalInfo, '0'),
                    _.get(incomeInfo, '0'),
                    { specifiedRelativeInfo },
                    { deprivationInfo },
                    _.get(redetCriteriaInfo, '0'),
                    _.get(eighteenCriteriaInfo, '0'),
                    _.get(ssissaCriteriaInfo, '0'),
                    { placementInfo },
                    { householdInfo },
                    { getHouseHoldInRule : getHouseHoldInRule1 },
                    _.get(MultipleCourtInfo, '0')
                );

                return {
                    generalInfo,
                    summaryInfo,
                    removalInfo,
                    incomeInfo,
                    householdInfo,
                    specifiedRelativeInfo,
                    deprivationInfo,
                    initialCriteriaInfo,
                    redetCriteriaInfo,
                    eighteenCriteriaInfo,
                    ssissaCriteriaInfo,
                    placementInfo,
                    getHouseHoldInRule : getHouseHoldInRule1,
                    MultipleCourtInfo,
                    data: flatJson,
                };
            })
                .catch((e) => {
                    throw errorUtils.formatExceptionError(e);
                });
        });
    };

    const auditMessages = (messages) => {
        const result = [];
        R.forEach((msg) => {
            result.push({ severity: msg.severity, message: msg.text });
        }, messages);
        return result;
    };

    // Get worksheet data
    function getWorksheetData(data) {
        return TitleIVEFC.eligibilityWorksheet(data);
    }

    function dateCheck(data, prop){
        return _.has(data, prop) ? dateConversion(_.get(data, prop)) : null
    }

    function isYes(data, prop) {
        let status;
        let dataValue = _.get(data, prop);
        dataValue = (dataValue !== '' && dataValue !== undefined && dataValue !== null) ? dataValue.toString().toUpperCase() : null;
        if (dataValue) {
            switch (dataValue) {
                case 1:
                case '1':
                case 'Y':
                case 'YES':
                    status = "YES";
                    break;
                case 0:
                case '0':
                case 'N':
                case 'NO':
                    status = "NO";
                    break;
                case 2:
                case '2':
                    status = "NA";
                    break;
                default:
                    status = "NO";
                    break;
            }
        }
        return status;
    }

    // Prepare Foster Care Initial Determination(FCID) data for Corticon API
    function prepareFCIDCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo) {
        // Household

        let householdmember = [];
        if (_.has(worksheetData, "getHouseHoldInRule") && _.isArray(worksheetData.getHouseHoldInRule)) { // getHouseHoldInRule
            householdmember = getPFCIDhousehold(worksheetData,householdmember);
        }//getHouseHoldInRule

        // Specified Relative
        const specifiedrelativevar = getFCIDspecifiedrelativevar(worksheetData);

        // Placement and living arrangement
        const placementAndLivingArrangement = getFCIDplacementAndLivingArrangement(worksheetData);

        // Deprivation information
        const deprivationvar = getFCIDdeprivationInfo(worksheetData);
        
        let ctwdecisionforcortion = null;
        if (_.has(worksheetData, "ctwdecision")) {
            ctwdecisionforcortion = isYes(worksheetData, "ctwdecision");
        }
        
        const eduData = setEduAndEmpData(educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo);
        educationDetailsInfo = eduData.educationDetailsInfo; 
        employmentDetailsInfo = eduData.employmentDetailsInfo; 
        employmentBarrierInfo = eduData.employmentBarrierInfo;
        disablityInfo = setdisablityData(disablityInfo);

        // Corticon Data
        return {
            'name': 'FosterCare',
            '__metadataRoot': {},
            'Objects': [{
                'GrossIncome185PctForAU': _.get(worksheetData, "grossincome185pcunitno"),
                'ReasonForExit': _.has(worksheetData, 'reasonforexitcode')  ?  _.get(worksheetData, "reasonforexitcode") : _.get(worksheetData, "reasonforexit"),
                'QualifiedAlienStaus': _.get(worksheetData, "qualifiedalienstaus"),
                'PreviousFosterCareEpisodeExist': _.get(worksheetData, "previousfostercareepisodeexist"),
                'AlienRegistrationNumber': _.get(worksheetData, "alienregistrationnumber"),
                'NoOfMembersInAU': _.get(worksheetData, "assistanceunitno"),
                'QualifiedAlien': _.get(worksheetData, "qualifiedalien"),
                'USCitizen': _.get(worksheetData, "uscitizen"),
                'person': {
                    'educationDetails': educationDetailsInfo,
                    'employmentDetails': employmentDetailsInfo,
                    'childDisabilityDetails': disablityInfo,
                    'removesBarriersDetails': employmentBarrierInfo,
                    'ChildDisabilityEvaluationDocumentionDate': dateCheck(worksheetData, 'childdisabilityevaluationdocumentiondate'),
                    'IsDJSOrDSSChild': _.get(worksheetData, "isdjsordsschild") ? _.replace(worksheetData.isdjsordsschild, 'DHS', 'DSSChild') : null,
                    'DateOf2ndParentSignatureOnVPA': dateCheck(worksheetData, "dateof2ndparentsignatureonvpa"),
                    'RelationshipIDOfPersonFromWhomChildWasPhysicallyRemoved': _.get(worksheetData, "relationshipidofpersonfromwhomchildwasphysicallyremoved"),
                    'IsSafeHavenBaby': _.get(worksheetData, "issafehavenbaby"),
                    'DateOfFindingCTWDecision': dateCheck(worksheetData, "dateoffindingctwdecision"),
                    'ClientIDWhoSignedVPA': checkClientwhosignedVPA(worksheetData),
                    'ChildDisabilityType': _.get(worksheetData, "childdisabilitytype"),
                    'ChildPhysicalAddressAfterRemoval': _.has(worksheetData, "childphysicaladdressafterremoval") && _.get(worksheetData, "childphysicaladdressafterremoval") != null? _.get(worksheetData, "childphysicaladdressafterremoval").trim() : null,
                    'NameOfSubjectCTWFinding': nullPropCheck(worksheetData, "nameofsubjectctwfinding"),
                    'DateOf1stParentSignatureOnVPA': dateCheck(worksheetData, "dateof1stparentsignatureonvpa"),
                    'IsPlacementReimbursable': _.has(worksheetData, placementreimbursiblepath) ? isYes(worksheetData, placementreimbursiblepath) : null,
                    'ClientIDOfPersonFromWhomChildWasPhysicallyRemoved': _.get(worksheetData, "clientidofpersonfromwhomchildwasphysicallyremoved") ? worksheetData.clientidofpersonfromwhomchildwasphysicallyremoved.toString() : null,
                    'StartDateOfEmployment': dateCheck(worksheetData, "startdateofemployment"),
                    'DateOfYouthSignatureOnVPA': dateCheck(worksheetData, "dateofyouthsignatureonvpa"),
                    'DateOfBirth': dateCheck(worksheetData, "dateofbirth"),
                    'ClientIDOfSubjectCTWFinding': nullPropCheck(worksheetData, "clientidofsubjectctwfinding"),
                    'IsLivingArrangementSameAsPlacement': checklivingarrangementtypepath(worksheetData),
                    'TypeOfVPA': _.get(worksheetData, "typeofvpa"),
                    'IsSignedByJudge': (_.has(worksheetData, "issignedbyjudge") && worksheetData.issignedbyjudge !== null) ? _.toUpper(worksheetData.issignedbyjudge) : null,
                    'CourtOrderDelayTimeFrame': nullPropCheck(worksheetData, "courtorderdelaytimedays"),
                    'ReasonableEffortsNotNecessaryDueToEmergentCircumstances': _.get(worksheetData, "reasonableeffortsnotnecessaryduetoemergentcircumstances") ? isYes(worksheetData, "reasonableeffortsnotnecessaryduetoemergentcircumstances") : null,
                    'MandatoryNoteOnMissing2ndParentSignatureOnVPA': _.get(worksheetData, "mandatorynoteonmissing2ndparentsignatureonvpa"),
                    'DateOfGuardianSignatureOnVPA': dateCheck(worksheetData, "dateofguardiansignatureonvpa"),
                    'DateOfCourtHearing': dateCheck(worksheetData, "dateofcourthearing"),
                    'TypeOfRemoval': _.get(worksheetData, "typeofremoval"),
                    'ChildPhysicalRemovalDate': dateCheck(worksheetData, "childphysicalremovaldate"),
                    'CTWDecision': ctwdecisionforcortion,
                    'DateOfLDSSSignatureOnVPA': dateCheck(worksheetData, "dateofldsssignatureonvpa"),
                    'DateOfNextHearing': dateCheck(worksheetData, "dateofnexthearing"),
                    'RelationshipOfSubjectCTWFinding': nullPropCheck(worksheetData, "relationshipofsubjectctwfinding"),
                    'specifiedRelative': specifiedrelativevar,
                    'DateOfReasonableEffortsCourtHearing': dateCheck(worksheetData, "dateofreasonableeffortscourthearing"),
                    '__metadata': {
                        '#type': 'Person',
                        '#id': 'Person_id_1',
                    },
                    'CourtOrderDelayRemoval': (_.has(worksheetData, "courtorderdelayremoval") && worksheetData.courtorderdelayremoval !== null) ? _.toUpper(worksheetData.courtorderdelayremoval) : null,
                    'ReasonableEffortsMade': _.has(worksheetData, "reasonableeffortsmade") ? isYes(worksheetData, "reasonableeffortsmade") : null,
                    'DateOfChildPlacement': dateCheck(worksheetData, "dateofchildplacement"),
                    'IsIVEAgencyResponsibleForPlacementAndCare': nullPropCheck(worksheetData, "isiveagencyresponsibleforplacementandcare"),
                    'ChildReceivingSSIOrSSADuringReviewPeriod': isYes(worksheetData, 'childreceivingssiorssa'),
                    'TypeOfBenefit': nullPropCheck(worksheetData, "typeofbenefit"),
                    'AmountOfBenefit': _.get(worksheetData, 'amountofbenefit'),
                    'placementAndLivingArrangement': placementAndLivingArrangement,
                },
                "dateCalculations": {
                    "__metadata": {
                        "#type": "DateCalculations",
                        "#id": "DateCalculations_id_1"
                    }
                },
                'JudgeName': nullPropCheck(worksheetData, "magistrateorjudgename"),
                'IsTheAgencyTheRepresentativePayee': isYes(worksheetData, 'agencyrepresentativeflag'),
                'DoesAgencyHasMedicalDocsToStateIncapabilityOfChild': isYes(worksheetData, 'doesagencyhasmedicaldocstostateincapabilityofchild'),
                'DateOfMedicalDetermination': dateCheck(worksheetData, "dateofmedicaldetermination"),
                'ReasonForWhyTheAgencyISNOTTheRepresentativePayee': _.get(worksheetData, 'noteforagencynotaspayee'),
                'representativepayee': nullPropCheck(worksheetData, 'representativepayee'),
                'HasAgencyApplyToBecomeRepresentativePayee': isYes(worksheetData, 'hasagencyapplytobecomerepresentativepayee'),
                'DateOfApplicationToBecomeRepresentativePayee': dateCheck(worksheetData, "dateofapplicationtobecomerepresentativepayee"),
                'HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE': isYes(worksheetData, 'suspendssipaymentflag'),
                'DateOfRequestToSuspendTheSSIPaymentAndClaimIVE': dateCheck(worksheetData, "dateofrequesttosuspendthessipaymentandclaimive"),
                'ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE': _.get(worksheetData, 'notefornotsuspendingssi'),
                'AssetAllowance': _.get(worksheetData, "assetsallowance"),
                'householdMember': householdmember,
                'deprivation':deprivationvar,
                'StandardOfNeedForNotInAU': _.get(worksheetData, "notinstandardunitno"),
                'AssetsMarketValue': _.get(worksheetData, "assetsmarketvalue"),
                'TotalChildCareCost': _.get(worksheetData, "childcarecost"),
                'FosterCareReviewPeriodStartDate': dateCheck(worksheetData, startdtpath),
                'NoOfMembersNotInAU': _.get(worksheetData, "notinassistanceunitno"),
                '__metadata': {
                    '#type': 'Application',
                    '#id': 'Application_id_1',
                },
                'StandardOfNeedForAU': _.get(worksheetData, "standardunitno"),
                'ExitCareDateFromPreviousFosterCareEpisode': dateCheck(worksheetData, "exitcaredatefrompreviousfostercareepisode"),
                'status': {
                    'FosterCareEligibilityStatus': null,
                    '__metadata': {
                        '#type': 'Status',
                        '#id': 'Status_id_1',
                    },
                },
            }],
        };
    }

    function getFCIDdeprivationInfo(worksheetData){
        const deprivationvar = [];
        if(_.has(worksheetData, "deprivationInfo") && _.isArray(worksheetData.deprivationInfo)){
            worksheetData.deprivationInfo.forEach((data, index) => {
                deprivationvar.push({
                    ParentID:_.get(data, "parentid"),
                    DeprivationFactor: _.get(data, "deprivationtype"),
                    ChildDeprivedOfParentalSupport: _.get(data, "childdeprivedofparentalsupport"),
                    DateOfParentDeath: dateCheck(data, "dateofparentdeath"),
                    IncarcerationDate: dateCheck(data, "dateofincarceration"),
                    ReasonForAbsence: _.get(data, "reasonforabsence"),
                    '__metadata': {
                        '#type': 'Deprivation',
                    },
                });
            })
        }
        return deprivationvar;
    }

    function getFCIDspecifiedrelativevar(worksheetData){
        const specifiedrelativevar = [];
        if (_.has(worksheetData, "specifiedRelativeInfo") && _.isArray(worksheetData.specifiedRelativeInfo)) {
            worksheetData.specifiedRelativeInfo.forEach((data, index) => {
                specifiedrelativevar.push({
                    SpecifiedRelativeDateChildLastLivedWith: dateCheck(data, "specifiedrelativedatechildlastlivedwith"),
                    SpecifiedRelativePhysicalAddress: _.has(data, "specifiedrelativephysicaladdress" ) ? _.get(data, "specifiedrelativephysicaladdress").trim() : null,
                    SpecifiedRelativeName: _.get(data, "specifiedrelativename"),
                    SpecifiedRelativeClientID: _.get(data, "specifiedrelativeclientid"),
                    SpecifiedRelativeRelationshipID: _.get(data, "specifiedrelativerelationshipid"),
                    '__metadata': {
                        '#type': 'SpecifiedRelative',
                    },
                });
            });
        } else {
            specifiedrelativevar.push({
                SpecifiedRelativeDateChildLastLivedWith:  null,
                SpecifiedRelativePhysicalAddress: null,
                SpecifiedRelativeName: null,
                SpecifiedRelativeClientID: null,
                SpecifiedRelativeRelationshipID: null,
                '__metadata': {
                    '#type': 'SpecifiedRelative',
                },
            });
        }
        return specifiedrelativevar;
    }

    function checkClientwhosignedVPA(worksheetData){
        let findId;
        if(_.get(worksheetData, "typeofvpa") === 'EA-VPA' ){
            findId = worksheetData.client_id;
        }else if(_.get(worksheetData, "clientidwhosignedvpa")){
            findId = worksheetData.clientidwhosignedvpa.toString();
        }else if(_.get(worksheetData, "guardianid")){
            findId = worksheetData.guardianid.toString();
        }else{
            findId = null;
        }
        return findId;
    }


    function getFCIDplacementAndLivingArrangement(worksheetData){
        const placementAndLivingArrangement = [];
        var worksheetRemovalDate = null;
        if (_.has(worksheetData, "placementInfo") && _.isArray(worksheetData.placementInfo)) {
            worksheetRemovalDate = moment(worksheetData.periodsInfo.start_dt).format(dtformat1)  + 'T00:00:00';
            worksheetData.placementInfo.forEach((data, index) => {
                var obj;
                if (data.placement && data.placement.length && data.placement.length > 1) {
                    obj = checkFCIDPlacement(data, worksheetRemovalDate);
                } else {
                   obj = arrayIndexCheck(data.placement,0);
                }
                placementAndLivingArrangement.push(formatFCIDPlacementData(obj));
            });
        }
        return placementAndLivingArrangement;
    }

    function checklivingarrangementtypepath(worksheetData){
        let typepath;
        if(_.has(worksheetData, livingarrangementtypepath)){
            if(_.get(worksheetData, livingarrangementtypepath) === "PLTR"){
               typepath = "YES";
            }else if(_.get(worksheetData, livingarrangementtypepath) === "LA"){
                typepath = "NO";
            }else{
                typepath = null;
            }
        }else{
            typepath = null;
        }
        return typepath;
    }

    function getLivingArrangement(obj1){
        let arrangementCheck;
        if(_.has(obj1, "livingarrangementtype")){
            if(_.get(obj1, "livingarrangementtype") === "PLTR"){
                arrangementCheck = "YES";
            }else if(_.get(obj1, "livingarrangementtype") === "LA"){
                arrangementCheck = "NO";
            }else{
                arrangementCheck = null;
            }
        }else{
            arrangementCheck = null;
        }
        return arrangementCheck;
    }

    function getChildPlacementDate(obj2){
        let placementDate = null;
        if(_.has(obj2, "livingarrangementtype")){
            placementDate = (_.get(obj2, "livingarrangementtype") === "PLTR") ? (dateCheck(obj2, "start_dt")) : null;
        }
        return placementDate;
    }

    function getEndDateOfLiving(obj3){
        let livingarrangementdate = null;
        if(_.has(obj3, "livingarrangementtype")){
            livingarrangementdate = (_.get(obj3, "livingarrangementtype") === "LA") ? (dateCheck(obj3, "end_dt")) : null;
        }
        return livingarrangementdate;
    }

    function getDateofLivingArrangement(obj4){
        let arrangementdate = null;
        if(_.has(obj4, "livingarrangementtype")){
           arrangementdate = ( _.get(obj4, "livingarrangementtype") === "LA" ) ? (dateCheck(obj4, "start_dt")) : null;
        }
        return arrangementdate;
    }

    function formatFCIDPlacementData(obj){
        return {
            DateOfLivingArrangement: getDateofLivingArrangement(obj),
            IsLivingArrangementSameAsPlacement: getLivingArrangement(obj),
            DateOfChildPlacement: getChildPlacementDate(obj), 
            IsPlacementReimbursable: _.has(obj, "isplacementreimbursible") ? isYes(obj, "isplacementreimbursible") : null,
            '__metadata': {
                '#type': 'PlacementAndLivingArrangement',
            },
            EndDateOfLivingArrangement: getEndDateOfLiving(obj)
        }
    }
 
    function checkFCIDPlacement(data, worksheetRemovalDate) {
        let obj = null;
        var placementStartDateCheck;
        var placementsAndLivingCheck = data.placement;
        placementsAndLivingCheck = _.sortBy(placementsAndLivingCheck,'livingarrangementtype');
        var sortedPlacementDetails = placementsAndLivingCheck;

        placementStartDateCheck = placementsAndLivingCheck.filter(item => item.start_dt == worksheetRemovalDate);

        placementStartDateCheck = _.sortBy(placementStartDateCheck,'livingarrangementtype');

        var placementStartDtSorted = placementStartDateCheck.reverse();

        if (placementStartDtSorted && placementStartDtSorted.length > 0) {
            placementStartDtSorted.forEach((plc,index) => {
                if (obj == null && (plc.livingarrangementtype === 'PLTR' || plc.livingarrangementtype === 'LA')) {
                    obj = arrayIndexCheck(placementStartDtSorted,index);
                    return true;
                }
            })
        } else {
            obj = checkFCIDsortedPlacementDetails(sortedPlacementDetails, worksheetRemovalDate);
        }
        return obj;
    }

    function checkFCIDsortedPlacementDetails(sortedPlacementDetails1, worksheetRemovalDate){
        var obj1=null;
        sortedPlacementDetails1.forEach((plc,index) => {
            if ((obj1 == null && plc.livingarrangementtype === 'PLTR' && (plc.start_dt >= worksheetRemovalDate || plc.end_dt <= worksheetRemovalDate)) || 
                (obj1 == null && plc.livingarrangementtype === 'LA' && (plc.start_dt >= worksheetRemovalDate || plc.end_dt <= worksheetRemovalDate
                || (plc.start_dt && plc.end_dt && worksheetRemovalDate && worksheetRemovalDate >= plc.start_dt && worksheetRemovalDate <= plc.end_dt)))) {
                obj1 = arrayIndexCheck(sortedPlacementDetails1,index);
                return true;
            }
        })
        return obj1;
    }

    function arrayIndexCheck(arr, index){
        return arr && arr.length>0 ? arr[index] : null;
    }

    function getPFCIDhousehold(worksheetData,householdmember) {
        worksheetData.getHouseHoldInRule.forEach((householdObject,index) => { // Start For Each 
          const unearnedIncomevar = [];
          // Un Earned Income 
          if (_.isArray(householdObject.unearnedincome)) {
            householdObject.unearnedincome.forEach((obj,index1) => {
              unearnedIncomevar.push({
                StartDate: dateCheck(obj,"startdate"),
                IncomeID: _.get(obj,"unearnedIncomeAmount"),
                EndDate: dateCheck(obj,"enddate"),
                IncomeDataSource: _.get(obj,"incomedatasource"),
                IncomeSourceType: _.get(obj,"incomesourcetype"),
                IncomeVerification: nullPropCheck2(obj,"incomeverification"),
                Exempts: checkDisregardIncome(householdObject, obj),
                IncomeAmount: _.get(obj,"incomeamount"),
                IncomeType: _.get(obj,"incometype"),
                '__metadata': {
                  '#type': 'UnearnedIncome',
                },
              });
            });
          }
          // Un Earned Income 
          const earnIncome = [];
          // Earned Income 
          if (_.isArray(householdObject.earnedincome)) {
            householdObject.earnedincome.forEach((obj,index1) => {
              earnIncome.push({
                StartDate: dateCheck(obj,"startdate"),
                IncomeID: _.get(obj,"unearnedIncomeAmount"),
                EndDate: dateCheck(obj,"enddate"),
                IncomeDataSource: _.get(obj,"incomedatasource"),
                IncomeSourceType: _.get(obj,"incomesourcetype"),
                IncomeVerification: nullPropCheck2(obj,"incomeverification"),
                Exempts: checkDisregardIncome(householdObject, obj),
                IncomeAmount: _.get(obj,"incomeamount"),
                IncomeType: _.get(obj,"incometype"),
                '__metadata': {
                  '#type': 'EarnedIncome',
                },
              });
            });
          }
          // Un Earned Income 
          // supportExpense
          const supportExpense = [];
          if (_.isArray(householdObject.supportexpense)) {
            householdObject.supportexpense.forEach((obj,index1) => {
              supportExpense.push({
                SupportExpenseAmount: _.get(obj,"supportexpenseamount"),
                '__metadata': {
                  '#type': 'SupportExpense',
                },
              });
            });
          }
          const assset = [];
          if (_.isArray(householdObject.asset)) {
            householdObject.asset.forEach((obj,index1) => {
              assset.push({
                Disregard: isYes(obj,"disregard"),
                AssetBeneficiary: _.get(obj,"assetbeneficiary"),
                AssetType: _.get(obj,"assettype"),
                AssetVerification: _.get(obj,"assetverification"),
                AssetEndDate: dateCheck(obj,"assetenddate"),
                AssetsMarketValue: _.get(obj,"assetsmarketvalue"),
                AssetStartDate: dateCheck(obj,"assetstartdate"),
                AmountOwed: _.get(obj,"amountowed"),
                '__metadata': {
                  '#type': 'Asset',
                },
              });
            });
          }
          // supportExpense
      
          householdmember.push(
            {
              ClientID: _.get(householdObject,"involvedclientid") ? _.get(householdObject,"involvedclientid").toString() : null,
              NameOfHouseholdMember: _.get(householdObject,"nameofhouseholdmember") ? _.get(householdObject,"nameofhouseholdmember").toString() : null,
              firstname: _.get(householdObject,"firstname"),
              lastname: _.get(householdObject,"lastname"),
              IsIncomeDeemed: null, //_.get(householdObject,"isincomedeemed") === true ? null : null,
              InAU: _.get(householdObject,"inau"),
              Relationship: _.get(householdObject,"involvedclientid") == _.get(worksheetData,'client_id') ? 'SELF' : _.get(householdObject,"relationshiptypekey"),
              isUsCitizen: isYes(householdObject,"citizenalenageflag"),
              alienStatus: _.get(householdObject,"alienstatustypekey"),
              DisregardIncomeAndAsset: _.get(householdObject,"disregardearnedincome"),
              unearnedIncome: unearnedIncomevar,
              earnedIncome: earnIncome,
              supportExpense: supportExpense,
              asset: assset,
              '__metadata': {
                '#type': 'HouseholdMember',
              }
            }
          );
      
        }); // end For Each 
        return householdmember;
      }

      function checkDisregardIncome(householdObject, obj){
        let disregardIncomecheck = true;
        if (householdObject.disregardearnedincome === 'YES') {
          disregardIncomecheck = false;
        }
        return disregardIncomecheck ? (isYes(obj,"incomedisregard")) : 'YES';
      }
      
      function nullPropCheck2(data, prop){
        return _.get(data, prop) === '' ? null : _.get(data, prop);
      }

      function nullPropCheck(data, prop){
        return _.has(data, prop) ? _.get(data, prop) : null;
      }

    // Prepare Foster Care Re Determination(FCRD) data for Corticon API
    function prepareFCRDCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo, initialeligibiltystatus, annual21Bday) {

        const placementAndLivingArrangement = getFCRDplacementAndLivingArrangement(worksheetData);
        // FC ReDet events
        const fcRedetEvents = getFCRDEvents(worksheetData, placementAndLivingArrangement);

        const eduData = setEduAndEmpData(educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo);
        educationDetailsInfo = eduData.educationDetailsInfo; 
        employmentDetailsInfo = eduData.employmentDetailsInfo; 
        employmentBarrierInfo = eduData.employmentBarrierInfo;
        let filterEmploymentBarrierInfo = [];
        const filterdisablityInfo = disablityInfo && disablityInfo.length ? disablityInfo.filter(item => item.startdate != null) : null;
        disablityInfo = setdisablityData(filterdisablityInfo);

        educationDetailsInfo = eduandEmpReviewPeriodCheck(educationDetailsInfo);
        employmentDetailsInfo = eduandEmpReviewPeriodCheck(employmentDetailsInfo);
        filterEmploymentBarrierInfo = empBariorCheck(employmentBarrierInfo, filterEmploymentBarrierInfo);

        let typeofcourthearingcheck;
        if(_.get(worksheetData, 'typeofcourthearing') === sheltercare){
             typeofcourthearingcheck = 'ShelterCare';
        } else  if (_.get(worksheetData, 'typeofcourthearing') === ""){
            typeofcourthearingcheck = null;
        } else {
            typeofcourthearingcheck = _.get(worksheetData, 'typeofcourthearing');
        }  
        
        let ctwdecisionforcortion = null;
        if (_.has(worksheetData, "ctwdecision")) {
            ctwdecisionforcortion = isYes(worksheetData, "ctwdecision");
        }

        return {
            'name': 'Annual_21BDAY_FC_Redet',
            '__metadataRoot': { '#locale': '' },
            'Objects': [{
                'reason': {
                    '__metadata': {
                        '#type': 'Reason',
                        '#id': 'Reason_id_1',
                    },
                },
                'IsTheAgencyTheRepresentativePayee': isYes(worksheetData, 'agencyrepresentativeflag'),
                'ReasonForWhyTheAgencyISNOTTheRepresentativePayee': _.get(worksheetData, 'noteforagencynotaspayee'),
                'representativepayee': nullPropCheck(worksheetData, 'representativepayee'),
                'HasAgencyApplyToBecomeRepresentativePayee': isYes(worksheetData, 'hasagencyapplytobecomerepresentativepayee'),
                'DateOfApplicationToBecomeRepresentativePayee': dateCheck(worksheetData, "dateofapplicationtobecomerepresentativepayee"),
                'DateOfRequestToSuspendTheSSIPaymentAndClaimIVE': dateCheck(worksheetData, "dateofrequesttosuspendthessipaymentandclaimive"),
                'HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE': isYes(worksheetData, 'suspendssipaymentflag'),
                'ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE': _.get(worksheetData, 'notefornotsuspendingssi'),
                'DateOfCourtHearing': dateConversion(worksheetData.dateofcourthearing),
                'FosterCareReviewPeriodEndDate': dateCheck(worksheetData, 'periodsInfo.end_dt'),
                'TypeOfCourtHearing': typeofcourthearingcheck,
                'REFPPNotDue': null, // Corticon response
                'FosterCareReviewPeriodStartDate': dateCheck(worksheetData, startdtpath),
                'DateOfSubsequentFindingOfBestInterest': dateCheck(worksheetData, 'dateofsubsequentfindingofbestinterest'),
                'IsThereValidSILAAgreement': _.get(worksheetData, 'issillaagreementvalid'),
                'applicantInformation': {
                    'ClientID': _.get(worksheetData, 'client_id'),
                    '__metadata': {
                        '#type': 'ApplicantInformation',
                        '#id': 'ApplicantInformation_id_1',
                    },
                },
                'FosterCareRedeterminationStage': annual21Bday ? '21BDAY' : _.get(worksheetData, 'periodsInfo.sqnm_sw'),
                'DateOfCurrentJudicialFindingOfREFPP': dateCheck(worksheetData, 'dateofjudicialfindingofrefpp'),
                'FosterCarePermanencyPlan': _.get(worksheetData, 'fostercarepermanencyplan'),
                'FosterCareRedeterminationCompletionDate': moment().format(dtformat),
                '__metadata': {
                    '#type': 'Application',
                    '#id': 'Application_id_1',
                },
                'DateOfCurrentJudicialFindingOfBestInterest': dateCheck(worksheetData, 'dateofcurrentjudicialfindingofbestinterest'),
                'DateOfJudicialFindingOfREFPP': dateCheck(worksheetData, 'dateofjudicialfindingofrefpp'),
                'fosterCareEvents': fcRedetEvents,
                'DateOfValidSILAAgreement': dateCheck(worksheetData, 'silaagreementdate'),
                "HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency": nullPropCheck(worksheetData, lapsesinplacementpath),
                'DateOfSubsequentJudicialFindingOfREFPP': dateCheck(worksheetData, "dateofsubsequentjudicialfindingofrefpp"),   //_.has(worksheetData, 'periodsInfo.dateofsubsequentjudicialfindingofrefpp') ? dateConversion(worksheetData.periodsInfo.dateofsubsequentjudicialfindingofrefpp) : null,
                "TypeOfLapses": nullPropCheck(worksheetData, typeoflapsespath),
                'DateOfPreviousJudicialFindingOfREFPP': dateCheck(worksheetData, 'dateofpreviousjudicialfindingofrefpp'),
                'person': {
                    'educationDetails': educationDetailsInfo,
                    'employmentDetails': employmentDetailsInfo,
                    'childDisabilityDetails': disablityInfo,
                    'removesBarriersDetails':  filterEmploymentBarrierInfo,
                    'DateOfBirth': dateCheck(worksheetData, 'dateofbirth'),
                    'DateOfPreviousBestInterestFinding': dateCheck(worksheetData, 'dateofpreviousbestinterestfinding'),
                    'ChildFosterCareEntryDate': _.get(worksheetData, 'childphysicalremovaldate') ? moment(worksheetData.childphysicalremovaldate).add(60, 'days').format(dtformat) : null,
                    'TypeOfRemoval': _.get(worksheetData, 'typeofremoval'),
                    'ChildPhysicalRemovalDate': dateCheck(worksheetData, 'childphysicalremovaldate'),
                    'IsSignedByJudge': (_.has(worksheetData, "issignedbyjudge") && worksheetData.issignedbyjudge !== null) ? _.toUpper(worksheetData.issignedbyjudge) : null,
                    'NameOfProgramOrActivityThatPromotesOrRemovesBarriersToEmployment': _.get(worksheetData, 'nameofpromotetoemploymentprogram'),
                    'ChildBeenInFosterCare12MonthOrMore': _.get(worksheetData, childbeeninfostercarefor12monthsormorepath),
                    'DateOfBestInterestFinding': dateCheck(worksheetData, 'dateofcurrentjudicialfindingofbestinterest'),
                    'placementAndLivingArrangement': placementAndLivingArrangement,
                    '__metadata': {
                        '#type': 'Person',
                        '#id': 'Person_id_1',
                    },
                    'ChildReceivingSSIOrSSADuringReviewPeriod': isYes(worksheetData, 'childreceivingssiorssa'),
                    'TypeOfBenefit': nullPropCheck(worksheetData, "typeofbenefit"),
                    'AmountOfBenefit': _.get(worksheetData, 'amountofbenefit'),
                    'TypeOfVPA': _.get(worksheetData, "typeofvpa"),
                    'CTWDecision': ctwdecisionforcortion,
                    'NameOfSubjectCTWFinding': _.has(worksheetData, "nameofsubjectctwfinding") ? worksheetData.nameofsubjectctwfinding : null,
                    'ClientIDOfSubjectCTWFinding': _.has(worksheetData, "clientidofsubjectctwfinding") ? worksheetData.clientidofsubjectctwfinding : null,
                    'RelationshipOfSubjectCTWFinding': _.has(worksheetData, "relationshipofsubjectctwfinding") ? worksheetData.relationshipofsubjectctwfinding : null,
                    'DateOfFindingCTWDecision': dateCheck(worksheetData, "dateoffindingctwdecision"),
                    'DateOfReasonableEffortsCourtHearing': dateCheck(worksheetData, "dateofreasonableeffortscourthearing"),
                    'ReasonableEffortsMade': isYes(worksheetData, "reasonableeffortsmade"),
                    'ReasonableEffortsNotNecessaryDueToEmergentCircumstances': isYes(worksheetData, "reasonableeffortsnotnecessaryduetoemergentcircumstances")
                },
                "dateCalculations": {
                    "__metadata": {
                        "#type": "DateCalculations",
                        "#id": "DateCalculations_id_1"
                    }
                },
                'IsIVEAgencyResponsibleForPlacementAndCare': _.get(worksheetData, 'isiveagencyresponsibleforplacementandcare'),
                'JudgeName': _.get(worksheetData, 'magistrateorjudgename'),
                'DateAgencyLostLegalResponsibility': dateCheck(worksheetData, 'dateagencylostlegalresponsibility'),
                'status': {
                    'FosterCareEligibilityStatus': checkValue(initialeligibiltystatus),
                    'FosterCareRedeterminationEligibilityStatus': null,
                    '__metadata': {
                        '#type': 'Status',
                        '#id': 'Status_id_1',
                    },
                },
            }],
        };
    
    }

    function eduandEmpReviewPeriodCheck(data){
        if(data && data.length) {
            data.forEach(element =>{ 
                if ((reviewperiodenddate  && new Date(element.startdate) > new Date(reviewperiodenddate)) || (reviewperiodstartdate && element.enddate && new Date(reviewperiodstartdate) > new Date(element.enddate))) { 
                    data.splice(data.indexOf(element), 1);
                 }
             });
        }
        return data;
    }

    function empBariorCheck(employmentBarrierInfo, filterEmploymentBarrierInfo){
        if(employmentBarrierInfo && employmentBarrierInfo.length) {
            employmentBarrierInfo.forEach(element =>{ 
                if ((element.promotedemploymentprogramstartdate && moment(element.promotedemploymentprogramstartdate).format(dtformat1) >= moment(reviewperiodstartdate).format(dtformat1) && moment(element.promotedemploymentprogramstartdate).format(dtformat1) <= moment(reviewperiodenddate).format(dtformat1)) ||
                    (element.promotedemploymentprogramenddate && moment(element.promotedemploymentprogramenddate).format(dtformat1) >= moment(reviewperiodstartdate).format(dtformat1) && moment(element.promotedemploymentprogramenddate).format(dtformat1) <= moment(reviewperiodenddate).format(dtformat1)) ||
                    (moment(element.promotedemploymentprogramstartdate).format(dtformat1) <= moment(reviewperiodstartdate).format(dtformat1) && element.promotedemploymentprogramenddate == null)) {
                        filterEmploymentBarrierInfo.push(element);
                }
            });

        }
        return filterEmploymentBarrierInfo;
    }

    function bypassDummyEvent(eventsData, startDt, endDt) {
        dummyEvent = [];
        eventsData.forEach(event => {
            if (event.EventReason == 'CT' && event.EventStartDate == moment(startDt).format('MM/DD/YYYY') && event.EventEndDate == moment(endDt).format('MM/DD/YYYY')) {
                dummyEvent.push(event);
                eventsData = eventsData.filter(E => E != event);
            }
        });
        return eventsData;
    }

    function getFCRDEvents(worksheetData, placementAndLivingArrangement){
        return ((worksheetData4) => {
            let eventsData = [];
            let fostercareSilaevents = [];
            let fostercareSingleSilaevent = [];
            if (_.has(worksheetData4, "eventsInfo") && _.isArray(worksheetData4.eventsInfo)) {
                let eventLength = worksheetData4.eventsInfo.length;
                worksheetData4.eventsInfo.forEach((event, index) => {
                    let eventDetails = _.head(event);
                    let eventstagespilt = null;
                    let existingEventStage = null;
                    eventstagespilt = checkEventsplit(eventDetails);
                    const fcrdData = getFCRDDetails(worksheetData4,eventDetails, existingEventStage, eventstagespilt, eventLength, fostercareSingleSilaevent, fostercareSilaevents)
                    eventstagespilt = fcrdData.eventstagespilt;
                    eventDetails = fcrdData.eventDetails;
                    eventLength = fcrdData.eventLength;
                    fostercareSingleSilaevent = fcrdData.fostercareSingleSilaevent;
                    fostercareSilaevents = fcrdData.fostercareSilaevents;
                    

                    eventsData = getFCRDEventData(eventDetails, worksheetData4, eventstagespilt, eventsData);
                });
            }
            if(fostercareSingleSilaevent && fostercareSingleSilaevent.length) {
                fostercareSingleSilaevent.forEach((fostercareSingleSilaevnt, index) => {
                    eventsData.push(fostercareSingleSilaevnt);
                 });
            }
            if(fostercareSilaevents && fostercareSilaevents.length) {
                 if(placementAndLivingArrangement[0].IsPlacementReimbursable !==  fostercareSilaevents[0].IsPlacementReimbursable) {
                    placementAndLivingArrangement[0].IsPlacementReimbursable = fostercareSilaevents[0].IsPlacementReimbursable;
                 }
                 fostercareSilaevents.forEach((fostercareSilaevent, index) => {
                    eventsData.push(fostercareSilaevent);
                });
            }
    
            return bypassDummyEvent(eventsData, worksheetData4.periodsInfo.start_dt,worksheetData4.periodsInfo.end_dt);
        })(worksheetData);
    }

    function checkEventsplit(eventDetails){
        let eventstagespilt = null;
        if(eventDetails.sqnm_sw) {
            eventstagespilt = eventDetails.sqnm_sw.split('E')[1] ? eventDetails.sqnm_sw.split('E')[1] : eventDetails.sqnm_sw;
        }
        return eventstagespilt;
    }

    function getFCRDDetails(worksheetData,eventDetails, existingEventStage, eventstagespilt, eventLength, fostercareSingleSilaevent, fostercareSilaevents) {
        if (worksheetData.placementInfo && worksheetData.placementInfo.length && worksheetData.placementInfo[0].silaplacementchange && worksheetData.placementInfo[0].silaplacementchange.length) {
            let silaEventDetails = null;
            if (eventDetails.silaplacementid) {
                const silaplacementchange = worksheetData.placementInfo[0].silaplacementchange.filter(silaplcchange => silaplcchange.placementid == eventDetails.silaplacementid);
                silaEventDetails = silaplacementchange && silaplacementchange.length > 0 ? silaplacementchange[0] : null
            } else {
                silaEventDetails = worksheetData.placementInfo[0].silaplacementchange[0];
            }

            if (silaEventDetails && (eventDetails.silaplacementdetails == 'SHA' || (silaEventDetails.placement_type == silahm && worksheetData.placementInfo[0].placement && worksheetData.placementInfo[0].placement.length == 0))) {
                const evtDate = checksilaEvtDate(silaEventDetails,eventDetails,worksheetData,existingEventStage);
                silaEventDetails = evtDate.silaEventDetails;
                eventDetails = evtDate.eventDetails;
                existingEventStage = evtDate.existingEventStage;

                const silaSingleEvt = getFCRDsilaSingleEvent(silaEventDetails,worksheetData,eventDetails,eventstagespilt,fostercareSingleSilaevent,eventLength,existingEventStage)
                eventLength = silaSingleEvt.eventLength;
                fostercareSingleSilaevent = silaSingleEvt.fostercareSingleSilaevent;
                existingEventStage = silaSingleEvt.existingEventStage;

                const silaEvt = getFCRDSilaEvent(silaEventDetails,worksheetData,eventDetails,eventstagespilt,fostercareSilaevents,eventLength)
                eventLength = silaEvt.eventLength;
                fostercareSilaevents = silaEvt.fostercareSilaevents;
            }

        }
        return {
            existingEventStage,
            eventstagespilt,
            eventDetails,
            eventLength,
            fostercareSingleSilaevent,
            fostercareSilaevents
        }
    }

    function checksilaEvtDate(silaEventDetails,eventDetails,worksheetData,existingEventStage) {
        if (silaEventDetails.effectivedate && new Date(silaEventDetails.effectivedate).getMonth() !== new Date(silaEventDetails.start_dt).getMonth() && moment(silaEventDetails.effectivedate).subtract(1,'months').endOf('month') >= new Date(eventDetails.start_dt) && eventDetails.cmpnt == 'PC') {
            eventDetails.end_dt = moment(silaEventDetails.effectivedate).subtract(1,'months').endOf('month').format(dtformat);
        }
        if (!silaEventDetails.end_dt || (new Date(silaEventDetails.end_dt) > worksheetData.periodsInfo.end_dt)) {
            silaEventDetails.end_dt = worksheetData.periodsInfo.end_dt
        }

        if (silaEventDetails.effectivedate && (new Date(silaEventDetails.effectivedate).getMonth() == new Date(silaEventDetails.start_dt).getMonth() || new Date(silaEventDetails.effectivedate).getMonth() == new Date(eventDetails.start_dt).getMonth()) && eventDetails.cmpnt == 'PC') {
            existingEventStage = 'E' + eventstagespilt;
            eventDetails = null;
        } else {
            existingEventStage = null;
        }
        return {
            silaEventDetails,
            eventDetails,
            existingEventStage
        }
    }

    function getFCRDEventData(eventDetails, worksheetData, eventstagespilt, eventsData){
        if(eventDetails) { 
            eventsData.push({
             'EventReason': _.get(eventDetails, "cmpnt"),
             'IsLivingArrangementSameAsPlacement': isYes(eventDetails, "isthelivingarrangementsameasplacement"),
             "KindOfLapses": nullPropCheck(worksheetData, kindoflapsespath),
             'EventStage': eventstagespilt ? 'E' + eventstagespilt : null,
             'IsPlacementReimbursable': isYes(eventDetails, "isplacementreimbursible"),
             'EventEndDate': dateCheck(eventDetails, "end_dt"),
             'IsReasonableEffortsFindingTimely': _.get(eventDetails, "isreasonableeffortsfindingtimely"),
             'EventStartDate': dateCheck(eventDetails, "start_dt"),
             'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': _.get(eventDetails, "isthereanyreasonableeffortsfindingduringreviewperiod"),
             'IsThereAnyBestInterestFindingDuringReviewPeriod': _.get(eventDetails, "isthereanybestinterestfindingduringreviewperiod"),
             'IsBestInterestFindingTimely': _.get(eventDetails, "isbestinterestfindingtimely"),
             'silaPlacementType': nullPropCheck(eventDetails, "silaplacementdetails"),
             '__metadata': {
                 '#type': 'FosterCareEvents',
             },
         });
         }
         return eventsData;
    }

    function getFCRDsilaSingleEvent(silaEventDetails,worksheetData,eventDetails,eventstagespilt,fostercareSingleSilaevent,eventLength, existingEventStage) {
        if (silaEventDetails.placement_type == silahm && worksheetData.placementInfo[0].placement && worksheetData.placementInfo[0].placement.length == 0) {
            // If SILA start date is before the Review start date OR is same as Review start date Consider SILA start start as Review start date
            if (new Date(silaEventDetails.start_dt) <= worksheetData.periodsInfo.start_dt && fostercareSingleSilaevent && fostercareSingleSilaevent.length == 0 && new Date(silaEventDetails.effectivedate).getMonth() !== new Date(worksheetData.periodsInfo.start_dt).getMonth() && new Date(silaEventDetails.effectivedate).getMonth() !== new Date(silaEventDetails.start_dt).getMonth()) {
                fostercareSingleSilaevent.push({
                    'EventReason': 'PC',
                    'IsLivingArrangementSameAsPlacement': silaEventDetails.isplacementreimbursible,
                    "KindOfLapses": null,
                    'EventStage': eventstagespilt ? 'E' + (eventLength + 1) : null,
                    'IsPlacementReimbursable': 'NO',
                    'EventEndDate': moment(silaEventDetails.effectivedate).subtract(1,'months').endOf('month').format(dtformat),
                    'IsReasonableEffortsFindingTimely': null,
                    'EventStartDate': moment(worksheetData.periodsInfo.start_dt).format(dtformat),
                    'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
                    'IsThereAnyBestInterestFindingDuringReviewPeriod': null,
                    'IsBestInterestFindingTimely': null,
                    'silaPlacementType': nullPropCheck(eventDetails,"silaplacementdetails"),
                    '__metadata': {
                        '#type': 'FosterCareEvents',
                    },
                });
                eventLength = eventLength + 1;
                existingEventStage = null;
            }
        }
        return {
            eventLength,
            fostercareSingleSilaevent,
            existingEventStage
        }
    }

    function getFCRDSilaEvent(silaEventDetails, worksheetData, eventDetails, eventstagespilt, fostercareSilaevents, eventLength){
        if((silaEventDetails.placement_type == silahm && worksheetData.placementInfo[0].placement && worksheetData.placementInfo[0].placement.length == 0)) {                               
            if(fostercareSilaevents && fostercareSilaevents.length == 0) {
                fostercareSilaevents.push({
                    'EventReason': 'PC',
                    'IsLivingArrangementSameAsPlacement': silaEventDetails.isplacementreimbursible,
                    "KindOfLapses":  null,
                    'EventStage': eventstagespilt ? 'E' + (eventLength + 1) : null,
                    'IsPlacementReimbursable': checkValue(silaEventDetails.isplacementreimbursible),
                    'EventEndDate': moment(silaEventDetails.end_dt).format(dtformat),
                    'IsReasonableEffortsFindingTimely': null,
                    'EventStartDate': checkFCRDsilaStDt(silaEventDetails, worksheetData),
                    'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
                    'IsThereAnyBestInterestFindingDuringReviewPeriod': null,
                    'IsBestInterestFindingTimely': null,
                    'silaPlacementType': nullPropCheck(eventDetails, "silaplacementdetails"),
                    '__metadata': {
                        '#type': 'FosterCareEvents',
                    },
                });
                eventLength = eventLength + 1;
            }
        }else {                             
            fostercareSilaevents.push({
                'EventReason': 'PC',
                'IsLivingArrangementSameAsPlacement': silaEventDetails.isplacementreimbursible,
                "KindOfLapses":  null,
                'EventStage': eventstagespilt ? 'E' + (eventLength + 1) : null,
                'IsPlacementReimbursable': checkValue(silaEventDetails.isplacementreimbursible),
                'EventEndDate': moment(silaEventDetails.end_dt).format(dtformat),
                'IsReasonableEffortsFindingTimely': null,
                'EventStartDate': checkFCRDsilaStDt(silaEventDetails, worksheetData),
                'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
                'IsThereAnyBestInterestFindingDuringReviewPeriod': null,
                'IsBestInterestFindingTimely': null,
                'silaPlacementType': nullPropCheck(eventDetails, "silaplacementdetails"),
                '__metadata': {
                    '#type': 'FosterCareEvents',
                },
            });
            eventLength = eventLength + 1;
        }
        return {
            eventLength,
            fostercareSilaevents
        }
    }

    function checkFCRDsilaStDt(silaEventDetails, worksheetData){
        if(moment(silaEventDetails.effectivedate).startOf('month').isBefore(moment(worksheetData.periodsInfo.start_dt))){
         return moment(worksheetData.periodsInfo.start_dt).format(dtformat);
        }
        if( (moment(silaEventDetails.effectivedate).startOf('month').isBefore(moment(silaEventDetails.start_dt)))) { 
          return  moment(silaEventDetails.start_dt).format(dtformat) 
        } 
         return moment(silaEventDetails.effectivedate).startOf('month').format(dtformat);
    }

    function getFCRDplacementAndLivingArrangement(worksheetData){
        let placementAndLivingArrangement = []
        if (_.has(worksheetData, "placementInfo") && _.isArray(worksheetData.placementInfo)) {
            worksheetData.placementInfo.forEach((data, index) => {
                var obj;
                if (_.isArray(data.placement)) {
                  // To take the last record in placement list
                  //CDM-24453 , CDM-24452 ,CDM-24799, CDM-24733 , CDM-24348, CDM-24275,CDM-24211
                  // When we have multiple placement Events then need to pass the last event details related to placement  
                  if (data.placement.length <= 1) {
                      // CDM-35704 To sent the last/latest event details
                    const eventlist = _.sortBy( data.placement, 'EventStage' ).reverse();
                    obj = eventlist.pop();
                    placementAndLivingArrangement.push({
                        IsPlacementReimbursable: isYes(obj, "isplacementreimbursible"),
                        '__metadata': {
                            '#type': 'PlacementAndLivingArrangement',
                        },
                    });
                  } else {
                    placementAndLivingArrangement = getFCRDpleventsData(worksheetData,obj,placementAndLivingArrangement,data);
                  }
                } 
            });
        }
        return placementAndLivingArrangement;
    }

    function getFCRDpleventsData(worksheetData,obj,placementAndLivingArrangement, data) {
        const eventsData = [];
        if (_.isArray(worksheetData.eventsInfo)) {
            worksheetData.eventsInfo.forEach((event,index) => {
                const eventDetails = _.head(event);
                let eventstagespilt = null;
                if (eventDetails.sqnm_sw) {
                    eventstagespilt = eventDetails.sqnm_sw.split('E')[1] ? eventDetails.sqnm_sw.split('E')[1] : eventDetails.sqnm_sw;
                }
                eventsData.push({
                    'EventReason': _.get(eventDetails,"cmpnt"),
                    'IsLivingArrangementSameAsPlacement': isYes(eventDetails,"isthelivingarrangementsameasplacement"),
                    'EventStage': eventstagespilt ? 'E' + eventstagespilt : null,
                    'IsPlacementReimbursable': isYes(eventDetails,"isplacementreimbursible"),
                });
            });
        }

        const placementEvent = eventsData.filter(item => item.EventReason === 'PC');
        if (placementEvent && placementEvent.length) {
            // CDM-35704 To sent the last/latest event details
            placementEvent.forEach((obj2) => {
                obj2.latestEvent = Number(obj2.EventStage.slice(1));
            })
            // CDM-37035
            const eventlist = _.sortBy(placementEvent,'latestEvent').reverse();
            placementAndLivingArrangement.push({
                IsPlacementReimbursable: checkValue(eventlist[0].IsPlacementReimbursable),
                '__metadata': {
                    '#type': 'PlacementAndLivingArrangement',
                },
            });

        } else {
            obj = data?.placement.pop();
            placementAndLivingArrangement.push({
                IsPlacementReimbursable: isYes(obj,"isplacementreimbursible"),
                '__metadata': {
                    '#type': 'PlacementAndLivingArrangement',
                },
            });
        }
        return placementAndLivingArrangement;
    }

    function checkValue(value){
        return value ? value : null;
    }

    // Prepare Foster Care VPA R1(FCRD) data for Corticon API
    function prepareFCVPAR1DCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo, initialeligibiltystatus) {

        const placementAndLivingArrangement = []
        if (_.has(worksheetData, "placementInfo") && _.isArray(worksheetData.placementInfo)) {
            worksheetData.placementInfo.forEach((data, index) => {
                var obj;
                if (_.isArray(data.placement)) {
                    placementAndLivingArrangement.push({
                        IsPlacementReimbursable: isYes(obj, "isplacementreimbursible"),
                        '__metadata': {
                            '#type': 'PlacementAndLivingArrangement',
                        },
                    });
                } 
            });
        }

        // FC ReDet events
        const fcRedetEvents = getFCVPAEvents(worksheetData, placementAndLivingArrangement);
        const eduData = setEduAndEmpData(educationDetailsInfo,employmentDetailsInfo,employmentBarrierInfo);
            educationDetailsInfo = eduData.educationDetailsInfo;
            employmentDetailsInfo = eduData.employmentDetailsInfo;
            employmentBarrierInfo = eduData.employmentBarrierInfo;
            disablityInfo = setdisablityData(disablityInfo);


        let typeofcourthearingcheck;
        if(_.get(worksheetData, 'typeofcourthearing') === sheltercare){
             typeofcourthearingcheck = 'ShelterCare';
        } else  if (_.get(worksheetData, 'typeofcourthearing') === ""){
            typeofcourthearingcheck = null;
        } else {
            typeofcourthearingcheck = _.get(worksheetData, 'typeofcourthearing');
        }  
        
        let ctwdecisionforcortion = null;
        if (_.has(worksheetData, "ctwdecision")) {
            ctwdecisionforcortion = isYes(worksheetData, "ctwdecision");
        }

        return {
            'name': 'EAVPA_R1_FC_Redet',
            '__metadataRoot': { '#locale': '' },
            'Objects': [{
                'reason': {
                    '__metadata': {
                        '#type': 'Reason',
                        '#id': 'Reason_id_1',
                    },
                },
                'IsTheAgencyTheRepresentativePayee': isYes(worksheetData, 'agencyrepresentativeflag'),
                'ReasonForWhyTheAgencyISNOTTheRepresentativePayee': _.get(worksheetData, 'noteforagencynotaspayee'),
                'representativepayee': nullPropCheck(worksheetData, 'representativepayee'),
                'HasAgencyApplyToBecomeRepresentativePayee': isYes(worksheetData, 'hasagencyapplytobecomerepresentativepayee'),
                'DateOfApplicationToBecomeRepresentativePayee': dateCheck(worksheetData, "dateofapplicationtobecomerepresentativepayee"),
                'DateOfRequestToSuspendTheSSIPaymentAndClaimIVE': dateCheck(worksheetData, "dateofrequesttosuspendthessipaymentandclaimive"),
                'HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE': isYes(worksheetData, 'suspendssipaymentflag'),
                'ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE': _.get(worksheetData, 'notefornotsuspendingssi'),
                'DateOfCourtHearing': dateCheck(worksheetData, 'dateofcourthearing'),
                'FosterCareReviewPeriodEndDate': dateCheck(worksheetData, 'periodsInfo.end_dt'),
                'TypeOfCourtHearing': typeofcourthearingcheck,
                'REFPPNotDue': null, // Corticon response
                'FosterCareReviewPeriodStartDate': dateCheck(worksheetData, startdtpath),
                'DateOfSubsequentFindingOfBestInterest': dateCheck(worksheetData, 'dateofsubsequentfindingofbestinterest'),
                'IsThereValidSILAAgreement': _.get(worksheetData, 'issillaagreementvalid'),
                'applicantInformation': {
                    'ClientID': _.get(worksheetData, 'client_id'),
                    '__metadata': {
                        '#type': 'ApplicantInformation',
                        '#id': 'ApplicantInformation_id_1',
                    },
                },
                'FosterCareRedeterminationStage': _.get(worksheetData, 'periodsInfo.sqnm_sw'),
                'DateOfCurrentJudicialFindingOfREFPP': dateCheck(worksheetData, 'dateofjudicialfindingofrefpp'),
                'FosterCarePermanencyPlan': _.get(worksheetData, 'fostercarepermanencyplan'),
                'FosterCareRedeterminationCompletionDate': moment().format(dtformat),
                '__metadata': {
                    '#type': 'Application',
                    '#id': 'Application_id_1',
                },
                'DateOfCurrentJudicialFindingOfBestInterest': dateCheck(worksheetData, 'dateofcurrentjudicialfindingofbestinterest'),
                'DateOfJudicialFindingOfREFPP': dateCheck(worksheetData, 'dateofjudicialfindingofrefpp'),
                'fosterCareEvents': fcRedetEvents,
                'DateOfValidSILAAgreement': dateCheck(worksheetData, 'silaagreementdate'),
                "HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency": nullPropCheck(worksheetData, lapsesinplacementpath),
                'DateOfSubsequentJudicialFindingOfREFPP': dateCheck(worksheetData, "dateofsubsequentjudicialfindingofrefpp"),   //_.has(worksheetData, 'periodsInfo.dateofsubsequentjudicialfindingofrefpp') ? dateConversion(worksheetData.periodsInfo.dateofsubsequentjudicialfindingofrefpp) : null,
                "TypeOfLapses": nullPropCheck(worksheetData, typeoflapsespath),
                'DateOfPreviousJudicialFindingOfREFPP': dateCheck(worksheetData, 'dateofpreviousjudicialfindingofrefpp'),
                'person': {
                    'educationDetails': educationDetailsInfo,
                    'employmentDetails': employmentDetailsInfo,
                    'childDisabilityDetails': disablityInfo,
                    'removesBarriersDetails': employmentBarrierInfo,
                     "eAVPAR1Details": [
                        {
                          "__metadata": {
                            "#type": "EAVPAR1Details",
                            "#id": "EAVPAR1Details_id_1"
                          }
                        }
                       ],
                    'DateOfBirth': dateCheck(worksheetData, 'dateofbirth'),
                    'DateOfPreviousBestInterestFinding': dateCheck(worksheetData, 'dateofpreviousbestinterestfinding'),
                    'ChildFosterCareEntryDate': _.get(worksheetData, 'childphysicalremovaldate') ? moment(worksheetData.childphysicalremovaldate).add(60, 'days').format(dtformat) : null,
                    'TypeOfRemoval': _.get(worksheetData, 'typeofremoval'),
                    'ChildPhysicalRemovalDate': dateCheck(worksheetData, 'childphysicalremovaldate'),
                    'IsSignedByJudge': (_.has(worksheetData, "issignedbyjudge") && worksheetData.issignedbyjudge !== null) ? _.toUpper(worksheetData.issignedbyjudge) : null,
                    'NameOfProgramOrActivityThatPromotesOrRemovesBarriersToEmployment': _.get(worksheetData, 'nameofpromotetoemploymentprogram'),
                    'ChildBeenInFosterCare12MonthOrMore': _.get(worksheetData, childbeeninfostercarefor12monthsormorepath),
                    'DateOfBestInterestFinding': dateCheck(worksheetData, 'dateofcurrentjudicialfindingofbestinterest'),
                    'placementAndLivingArrangement': placementAndLivingArrangement,
                    '__metadata': {
                        '#type': 'Person',
                        '#id': 'Person_id_1',
                    },
                    'ChildReceivingSSIOrSSADuringReviewPeriod': isYes(worksheetData, 'childreceivingssiorssa'),
                    'TypeOfBenefit': (_.has(worksheetData, "typeofbenefit") && worksheetData.typeofbenefit) ? _.get(worksheetData, 'typeofbenefit') : null,
                    'AmountOfBenefit': _.get(worksheetData, 'amountofbenefit'),
                    'TypeOfVPA': _.get(worksheetData, "typeofvpa"),
                    'CTWDecision': ctwdecisionforcortion,
                    'NameOfSubjectCTWFinding': nullPropCheck(worksheetData, "nameofsubjectctwfinding"),
                    'ClientIDOfSubjectCTWFinding': nullPropCheck(worksheetData, "clientidofsubjectctwfinding"),
                    'RelationshipOfSubjectCTWFinding': nullPropCheck(worksheetData, "relationshipofsubjectctwfinding"),
                    'DateOfFindingCTWDecision': dateCheck(worksheetData, "dateoffindingctwdecision"),
                    'DateOfReasonableEffortsCourtHearing': dateCheck(worksheetData, "dateofreasonableeffortscourthearing"),
                    'ReasonableEffortsMade': isYes(worksheetData, "reasonableeffortsmade"),
                    'ReasonableEffortsNotNecessaryDueToEmergentCircumstances': isYes(worksheetData, "reasonableeffortsnotnecessaryduetoemergentcircumstances")
                },
                "dateCalculations": {
                    "__metadata": {
                        "#type": "DateCalculations",
                        "#id": "DateCalculations_id_1"
                    }
                },
                'IsIVEAgencyResponsibleForPlacementAndCare': _.get(worksheetData, 'isiveagencyresponsibleforplacementandcare'),
                'JudgeName': _.get(worksheetData, 'magistrateorjudgename'),
                'DateAgencyLostLegalResponsibility': dateCheck(worksheetData, 'dateagencylostlegalresponsibility'),
                'status': { 
                    'FosterCareEligibilityStatus': initialeligibiltystatus,
                    'FosterCareRedeterminationEligibilityStatus': null,
                    '__metadata': {
                        '#type': 'Status',
                        '#id': 'Status_id_1',
                    },
                },
            }],
        };
    }

    function getFCVPAEvents(worksheetData, placementAndLivingArrangement) {
        return ((worksheetData3) => {
            let eventsData = [];
            let fostercareSilaevents = [];
            let fostercareSingleSilaevent = [];
            if (_.has(worksheetData3,"eventsInfo") && _.isArray(worksheetData3.eventsInfo)) {
                let eventLength = worksheetData3.eventsInfo.length;
                worksheetData3.eventsInfo.forEach((event,index) => {
                    let eventDetails = _.head(event);
                    let eventstagespilt = null;
                    let existingEventStage = checkEventsplit(eventDetails);

                    const fcvpaData = getFCVPADetails(worksheetData3,eventDetails, existingEventStage, eventstagespilt, eventLength, fostercareSingleSilaevent, fostercareSilaevents)
                    eventstagespilt = fcvpaData.existingEventStage;
                    eventDetails = fcvpaData.eventDetails;
                    eventLength = fcvpaData.eventLength;
                    fostercareSingleSilaevent = fcvpaData.fostercareSingleSilaevent;
                    fostercareSilaevents = fcvpaData.fostercareSilaevents;
                    
                    eventsData = getFCVPAEventData(eventDetails, worksheetData3, eventstagespilt, eventsData);
                    
                });
            }
            if (fostercareSingleSilaevent && fostercareSingleSilaevent.length) {
                fostercareSingleSilaevent.forEach((fostercareSingleSilaevnt,index) => {
                    eventsData.push(fostercareSingleSilaevnt);
                });
            }
            if (fostercareSilaevents && fostercareSilaevents.length) {
                if (placementAndLivingArrangement[0].IsPlacementReimbursable !== fostercareSilaevents[0].IsPlacementReimbursable) {
                    placementAndLivingArrangement[0].IsPlacementReimbursable = fostercareSilaevents[0].IsPlacementReimbursable;
                }
                fostercareSilaevents.forEach((fostercareSilaevent,index) => {
                    eventsData.push(fostercareSilaevent);
                });
            }
            return eventsData;
        })(worksheetData);
    }

    function getFCVPADetails(worksheetData,eventDetails, existingEventStage, eventstagespilt, eventLength, fostercareSingleSilaevent, fostercareSilaevents){
        if (worksheetData.placementInfo && worksheetData.placementInfo.length && worksheetData.placementInfo[0].silaplacementchange && worksheetData.placementInfo[0].silaplacementchange.length) {
            let silaEventDetails = null;
            if (eventDetails.silaplacementid) {
                const silaplacementchange = worksheetData.placementInfo[0].silaplacementchange.filter(silaplcchange => silaplcchange.placementid == eventDetails.silaplacementid);
                silaEventDetails = silaplacementchange && silaplacementchange.length > 0 ? silaplacementchange[0] : null
            } else {
                silaEventDetails = worksheetData.placementInfo[0].silaplacementchange[0];
            }

            if (silaEventDetails && (eventDetails.silaplacementdetails == 'SHA' || (silaEventDetails.placement_type == silahm && worksheetData.placementInfo[0].placement && worksheetData.placementInfo[0].placement.length == 0))) {
                
                const evtDate = checksilaEvtDate(silaEventDetails,eventDetails,worksheetData,existingEventStage);
                silaEventDetails = evtDate.silaEventDetails;
                eventDetails = evtDate.eventDetails;
                existingEventStage = evtDate.existingEventStage;
                
                const silaSingleEvt = getFCVPAsilaSingleEvt(silaEventDetails,worksheetData,eventDetails,eventstagespilt,fostercareSingleSilaevent,eventLength,existingEventStage)
                eventLength = silaSingleEvt.eventLength;
                fostercareSingleSilaevent = silaSingleEvt.fostercareSingleSilaevent;
                existingEventStage = silaSingleEvt.existingEventStage;
                
                const silaEvt = getFCVPASilaevent(silaEventDetails, worksheetData, eventDetails, eventstagespilt, fostercareSilaevents, eventLength);
                eventLength = silaEvt.eventLength;
                fostercareSilaevents = silaEvt.fostercareSilaevents;   
            }
        }
        return {
            existingEventStage,
            eventstagespilt,
            eventDetails,
            eventLength,
            fostercareSingleSilaevent,
            fostercareSilaevents
        }
    }

    

    function getFCVPAsilaSingleEvt(silaEventDetails, worksheetData, eventDetails, eventstagespilt, fostercareSingleSilaevent, eventLength, existingEventStage){
        if (silaEventDetails.placement_type == silahm && worksheetData.placementInfo[0].placement && worksheetData.placementInfo[0].placement.length == 0) {
            // If SILA start date is before the Review start date OR is same as Review start date Consider SILA start start as Review start date
            if (new Date(silaEventDetails.start_dt) <= worksheetData.periodsInfo.start_dt && fostercareSingleSilaevent && fostercareSingleSilaevent.length == 0 && new Date(silaEventDetails.effectivedate).getMonth() !== new Date(worksheetData.periodsInfo.start_dt).getMonth() && new Date(silaEventDetails.effectivedate).getMonth() !== new Date(silaEventDetails.start_dt).getMonth()) {
                fostercareSingleSilaevent.push({
                    'EventReason': 'PC',
                    'IsLivingArrangementSameAsPlacement': silaEventDetails.isplacementreimbursible,
                    "KindOfLapses": null,
                    'EventStage': eventstagespilt ? 'E' + (eventLength + 1) : null,
                    'IsPlacementReimbursable': 'NO',
                    'EventEndDate': moment(silaEventDetails.effectivedate).subtract(1,'months').endOf('month').format(dtformat),
                    'IsReasonableEffortsFindingTimely': null,
                    'EventStartDate': moment(worksheetData.periodsInfo.start_dt).format(dtformat),
                    'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
                    'IsThereAnyBestInterestFindingDuringReviewPeriod': null,
                    'IsBestInterestFindingTimely': null,
                    'silaPlacementType': _.get(eventDetails,"silaplacementdetails") ? _.get(eventDetails,"silaplacementdetails") : null,
                    '__metadata': {
                        '#type': 'FosterCareEvents',
                    },
                });
                eventLength = eventLength + 1;
                existingEventStage = null;
            }
        }
        return {
            eventLength,
            existingEventStage,
            fostercareSingleSilaevent
        }
    }

    function getFCVPASilaevent(silaEventDetails, worksheetData, eventDetails, eventstagespilt, fostercareSilaevents, eventLength){
        if ((silaEventDetails.placement_type == silahm && worksheetData.placementInfo[0].placement && worksheetData.placementInfo[0].placement.length == 0)) {
            if (fostercareSilaevents && fostercareSilaevents.length == 0) {
                fostercareSilaevents.push({
                    'EventReason': 'PC',
                    'IsLivingArrangementSameAsPlacement': silaEventDetails.isplacementreimbursible,
                    "KindOfLapses": null,
                    'EventStage': eventstagespilt ? 'E' + (eventLength + 1) : null,
                    'IsPlacementReimbursable': checkValue(silaEventDetails.isplacementreimbursible),
                    'EventEndDate': moment(silaEventDetails.end_dt).format(dtformat),
                    'IsReasonableEffortsFindingTimely': null,
                    'EventStartDate': checkFCVPAEvtStDt(silaEventDetails, worksheetData),
                    'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
                    'IsThereAnyBestInterestFindingDuringReviewPeriod': null,
                    'IsBestInterestFindingTimely': null,
                    'silaPlacementType': nullPropCheck(eventDetails,"silaplacementdetails"),
                    '__metadata': {
                        '#type': 'FosterCareEvents',
                    },
                });
                eventLength = eventLength + 1;
            }
        } else {
            fostercareSilaevents.push({
                'EventReason': 'PC',
                'IsLivingArrangementSameAsPlacement': silaEventDetails.isplacementreimbursible,
                "KindOfLapses": null,
                'EventStage': eventstagespilt ? 'E' + (eventLength + 1) : null,
                'IsPlacementReimbursable': checkValue(silaEventDetails.isplacementreimbursible),
                'EventEndDate': moment(silaEventDetails.end_dt).format(dtformat),
                'IsReasonableEffortsFindingTimely': null,
                'EventStartDate': checkFCVPAEvtStDt(silaEventDetails, worksheetData),
                'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': null,
                'IsThereAnyBestInterestFindingDuringReviewPeriod': null,
                'IsBestInterestFindingTimely': null,
                'silaPlacementType': nullPropCheck(eventDetails,"silaplacementdetails"),
                '__metadata': {
                    '#type': 'FosterCareEvents',
                },
            });
            eventLength = eventLength + 1;
        }
        return {
            eventLength,
            fostercareSilaevents
        }
    }

    function checkFCVPAEvtStDt(silaEventDetails, worksheetData){
        let eventTime;

        if(moment(silaEventDetails.effectivedate).startOf('month').isBefore(moment(worksheetData.periodsInfo.start_dt))){

            eventTime = moment(worksheetData.periodsInfo.start_dt).format(dtformat);

        }else if(moment(silaEventDetails.effectivedate).startOf('month').isBefore(moment(silaEventDetails.start_dt))) {

           eventTime=  moment(silaEventDetails.start_dt).format(dtformat);

        }else{
            eventTime = moment(silaEventDetails.effectivedate).startOf('month').format(dtformat);
        }
        return eventTime;
    }

    function isPlacementReimbursable(eventDetails){
        let isplacement = null;
        if(_.get(eventDetails,"isplacementreimbursible")){
           isplacement = (_.get(eventDetails,"isplacementreimbursible") == "Y") ? "YES" : "NO";
        }
        return isplacement;
    }

    function getFCVPAEventData(eventDetails, worksheetData, eventstagespilt, eventsData){
        if (eventDetails) {
            eventsData.push({
                'EventReason': _.get(eventDetails,"cmpnt"),
                'IsLivingArrangementSameAsPlacement': isYes(eventDetails,"isthelivingarrangementsameasplacement"),
                "KindOfLapses": nullPropCheck(worksheetData,kindoflapsespath),
                'EventStage': eventstagespilt ? 'E' + eventstagespilt : null,
                'IsPlacementReimbursable': isPlacementReimbursable(eventDetails),
                'EventEndDate': _.has(eventDetails,"end_dt") ? dateConversion(eventDetails.end_dt) : null,
                'IsReasonableEffortsFindingTimely': _.get(eventDetails,"isreasonableeffortsfindingtimely"),
                'EventStartDate': _.has(eventDetails,"start_dt") ? dateConversion(eventDetails.start_dt) : null,
                'IsThereAnyReasonableEffortsFindingDuringReviewPeriod': _.get(eventDetails,"isthereanyreasonableeffortsfindingduringreviewperiod"),
                'IsThereAnyBestInterestFindingDuringReviewPeriod': _.get(eventDetails,"isthereanybestinterestfindingduringreviewperiod"),
                'IsBestInterestFindingTimely': _.get(eventDetails,"isbestinterestfindingtimely"),
                'silaPlacementType': _.get(eventDetails,"silaplacementdetails") ? _.get(eventDetails,"silaplacementdetails") : null,
                '__metadata': {
                    '#type': 'FosterCareEvents',
                },
            });
        }
        return eventsData;
    }

    function dateConversion(date) {
        if (date === undefined || date === null || date === '') {
            return null;
        }
        const mydate = new Date(date);
        return moment(mydate).format(dtformat);
    }


    // Prepare Foster Care 18BDay Determination(FC18) data for Corticon API
    function prepareFC18BDayCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo ) {
        const eduData = setEduAndEmpData(educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo);
        educationDetailsInfo = eduData.educationDetailsInfo; 
        employmentDetailsInfo = eduData.employmentDetailsInfo; 
        employmentBarrierInfo = eduData.employmentBarrierInfo;
        disablityInfo = setdisablityData(disablityInfo);

        const placementAndLivingArrangement = [];

        if(worksheetData.placementInfo && worksheetData.placementInfo.length && worksheetData.placementInfo[0].silaplacementchange && worksheetData.placementInfo[0].silaplacementchange.length
            && worksheetData.placementInfo[0].silaplacementchange[0].placement_type == silahm && new Date(worksheetData.placementInfo[0].silaplacementchange[0].effectivedate) <= worksheetData.periodsInfo.start_dt) {
            placementAndLivingArrangement.push({
                'IsPlacementReimbursable': _.has(worksheetData, "placementInfo.0.silaplacementchange.0.isplacementreimbursible") ? isYes(worksheetData, "placementInfo.0.silaplacementchange.0.isplacementreimbursible") : null,
                "__metadata": {
                    "#type": "PlacementAndLivingArrangement",
                    "#id": "PlacementAndLivingArrangement_id_1"
                }
            });
        } else {
            placementAndLivingArrangement.push({
                'IsPlacementReimbursable': _.has(worksheetData, placementreimbursiblepath) ? isYes(worksheetData, placementreimbursiblepath) : null,
                "__metadata": {
                    "#type": "PlacementAndLivingArrangement",
                    "#id": "PlacementAndLivingArrangement_id_1"
                }
            });
        }

        let typeofcourthearingcheck;
        if(_.get(worksheetData, 'typeofcourthearing') === sheltercare){
             typeofcourthearingcheck = 'ShelterCare';
        } else  if (_.get(worksheetData, 'typeofcourthearing') === ""){
            typeofcourthearingcheck = null;
        } else {
            typeofcourthearingcheck = _.get(worksheetData, 'typeofcourthearing');
        }       
        

        return {
            'name': '18BDAY_FC_Redet',

            '__metadataRoot': {},
            'Objects': [{
                'reason': {
                    'Step': null,
                    '__metadata': {
                        '#type': 'Reason',
                        '#id': 'Reason_id_1',
                    },
                    'ReasonCode': null,
                },
                'IsTheAgencyTheRepresentativePayee': isYes(worksheetData, 'agencyrepresentativeflag'),
                'ReasonForWhyTheAgencyISNOTTheRepresentativePayee': _.get(worksheetData, 'noteforagencynotaspayee'),
                'representativepayee': _.has(worksheetData, 'representativepayee') ? _.get(worksheetData, 'representativepayee') : null,
                'HasAgencyApplyToBecomeRepresentativePayee': isYes(worksheetData, 'hasagencyapplytobecomerepresentativepayee'),
                'DateOfApplicationToBecomeRepresentativePayee': dateCheck(worksheetData, "dateofapplicationtobecomerepresentativepayee"),
                'DateOfRequestToSuspendTheSSIPaymentAndClaimIVE': dateCheck(worksheetData, "dateofrequesttosuspendthessipaymentandclaimive"),
                'HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE': isYes(worksheetData, 'suspendssipaymentflag'),
                'ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE': _.get(worksheetData, 'notefornotsuspendingssi'),
                'DateOfValidSILAAgreement': dateCheck(worksheetData, 'silaagreementdate'),
                'TypeOfCourtHearing': typeofcourthearingcheck,
                'IsThereValidSILAAgreement': _.get(worksheetData, 'issillaagreementvalid'),
                'applicantInformation': {
                    'ClientID': _.get(worksheetData, 'client_id'),
                    '__metadata': {
                        '#type': 'ApplicantInformation',
                        '#id': 'ApplicantInformation_id_1',
                    },
                },
                'person': {
                    'educationDetails': educationDetailsInfo,
                    'employmentDetails': employmentDetailsInfo,
                    'childDisabilityDetails': disablityInfo,
                    'removesBarriersDetails': employmentBarrierInfo,
                    'DateOfBirth': dateCheck(worksheetData, "dateofbirth"),
                    'TypeOfRemoval': _.get(worksheetData, 'typeofremoval'),
                    'ChildBeenInFosterCare12MonthOrMore': _.get(worksheetData, childbeeninfostercarefor12monthsormorepath),
                    'placementAndLivingArrangement': placementAndLivingArrangement,
                    '__metadata': {
                        '#type': 'Person',
                        '#id': 'Person_id_1',
                    },
                    'ChildReceivingSSIOrSSADuringReviewPeriod': isYes(worksheetData, 'childreceivingssiorssa'),
                    'TypeOfBenefit': (_.has(worksheetData, "typeofbenefit") && worksheetData.typeofbenefit) ? _.get(worksheetData, 'typeofbenefit') : null,
                    'AmountOfBenefit': _.get(worksheetData, 'amountofbenefit'),
                },
                'FosterCareRedeterminationStage': '18BDAY',
                'IsIVEAgencyResponsibleForPlacementAndCare': _.get(worksheetData, 'isiveagencyresponsibleforplacementandcare'),
                'FosterCareRedeterminationCompletionDate': moment().format(dtformat),
                '__metadata': {
                    '#type': 'Application',
                    '#id': 'Application_id_1',
                },
                'DateAgencyLostLegalResponsibility': _.get(worksheetData, 'dateagencylostlegalresponsibility'),
                'status': {
                    'FosterCareRedeterminationEligibilityStatus': null,
                    '__metadata': {
                        '#type': 'Status',
                        '#id': 'Status_id_1',
                    },
                },
            }],
        };
    }

    function setEduAndEmpData(educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo){
        if (_.isArray(educationDetailsInfo)) {
            const edumetadata = {"__metadata": {
                "#type": "EducationDetails"
              }};
            
            const edueventreason = {"YouthEventReason": "ED"};
            
            if (educationDetailsInfo.length > 0 ) {
                educationDetailsInfo.forEach((obj) => {
                Object.assign(obj, edueventreason, edumetadata)
            });
            } else {
                educationDetailsInfo = null
            }
        }
        
        if (_.isArray(employmentDetailsInfo)) {
            const empmetadata = {"__metadata": {
                "#type": "EmploymentDetails"
              }};
            const empeventreason = {"YouthEventReason": "EM"};
            if (employmentDetailsInfo.length > 0) {
                employmentDetailsInfo.forEach((obj) => {
                    Object.assign(obj, empeventreason, empmetadata)  
                });
            } else {
                employmentDetailsInfo = null
            }
        }

        if (_.isArray(employmentBarrierInfo)) {
            const empbarriermetadata = {"__metadata": {
                "#type": "RemovesBarriersDetails"
              }};
             
            const empbarriereventreason =   {"YouthEventReason": "RB"};

            if (employmentBarrierInfo.length > 0 ) {
                employmentBarrierInfo.forEach((obj) => {
                Object.assign(obj,empbarriereventreason, empbarriermetadata)
            });
            } else {
                employmentBarrierInfo = null
            }
        }

        return {
            educationDetailsInfo, 
            employmentDetailsInfo, 
            employmentBarrierInfo
        }
    }

    function setdisablityData(disablityInfo){
        if (_.isArray(disablityInfo)) {
            const disablitymetadata =  {"__metadata": {
                "#type": "ChildDisabilityDetails"
              }};
            const disablityeventreason =  {"YouthEventReason": "CD"}; 
            if (disablityInfo.length > 0) {
                disablityInfo.forEach((obj) => {
                    Object.assign(obj, disablityeventreason, disablitymetadata)  
                });
            } else {
                disablityInfo = null
            }
        }
        return disablityInfo;
    }

    // Based on period type, call respective logging function
    function logCorticonData(periodType, rawInput, rawOutput, options, worksheetData) {
        const regexRD = /^[R]\d+$/gm;
        if (periodType === 'I') {
            if (worksheetData && worksheetData.eventsInfo && worksheetData.eventsInfo.length) {
                const formatedEvnts = [];
                worksheetData.eventsInfo.forEach((evnt) => {
                    if (evnt && evnt[0]) {
                        formatedEvnts.push({
                            EventStage: evnt[0].sqnm_sw.replace('I', ''),
                            EventReason: evnt[0].cmpnt,
                            EventEndDate: evnt[0].end_dt,
                            EventStartDate: evnt[0].start_dt,
                            EventStatus: evnt[0].eligibilitystatus,
                            eventKeyId: evnt[0].key_id,
                        });
                    }
                });      
                rawInput.Objects[0].fosterCareEvents = formatedEvnts;
                rawOutput.Objects[0].fosterCareEvents = formatedEvnts;
            }
        }
        const corticonRes = Object.assign({}, rawOutput, options, {
            inputjson: JSON.stringify(rawInput),
            outputjson: JSON.stringify(rawOutput),
        });
        if (periodType === 'I') {
            // Initial Determination(FCID) data
            return logFCIDCorticonData(corticonRes, worksheetData);
        } else if (periodType === '18BDAY') {
            // 18BDay Determination(FC18) data
            return logFC18BDayCorticonData(corticonRes, worksheetData);
        } else if (regexRD.exec(periodType) !== null) {
            // Foster Care Re Determination(FCRD) data
            return logFCRDCorticonData(corticonRes, worksheetData);
        }
    }

    // Save the ID data to the database
    function logFCIDCorticonData(corticonRes, worksheetData) {
        return new Promise((resolve, reject) => {
            const corticon = corticonRes?.Objects?.[0];
            let inputjson= JSON.parse(_.has(corticonRes, 'inputjson') ? corticonRes.inputjson : null);
            inputjson.worksheetData = worksheetData;

            const jsonPayload = {
                transactionid: corticonRes.transactionid,
                cjamspid: corticonRes.cjamspid,
                removalid: corticonRes.removalid,
                hashkey: corticonRes.hashkey,
                sqnm_sw: R.pathOr(null, ['sqnm_sw'], corticonRes),
                start_dt: R.pathOr(null, ['start_dt'], corticonRes),
                end_dt: R.pathOr(null, ['end_dt'], corticonRes),
                auditmessages: auditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
                deprivationfactor: R.pathOr(null, ['DeprivationFactor'], corticon),
                grossincome185pctforau: R.pathOr(null, ['GrossIncome185PctForAU'], corticon),
                reasonforabsence: R.pathOr(null, ['ReasonForAbsence'], corticon),
                alienregistrationnumber: R.pathOr(null, ['AlienRegistrationNumber'], corticon),
                dateofparentdeath: R.pathOr(null, ['DateOfParentDeath'], corticon),
                uscitizen: R.pathOr(null, ['USCitizen'], corticon),
                standardofneedfornotinau: R.pathOr(null, ['StandardOfNeedForNotInAU'], corticon),
                totalchildcarecost: R.pathOr(null, ['TotalChildCareCost'], corticon),
                incarcerationdate: R.pathOr(null, ['IncarcerationDate'], corticon),
                exitcaredatefrompreviousfostercareepisode: R.pathOr(null, ['ExitCareDateFromPreviousFosterCareEpisode'], corticon),
                reasonforexit: R.pathOr(null, ['ReasonForExit'], corticon),
                qualifiedalienstaus: R.pathOr(null, ['QualifiedAlienStaus'], corticon),
                previousfostercareepisodeexist: R.pathOr(null, ['PreviousFosterCareEpisodeExist'], corticon),
                noofmembersinau: R.pathOr(null, ['NoOfMembersInAU'], corticon),
                qualifiedalien: R.pathOr(null, ['QualifiedAlien'], corticon),
                dateoflivingarrangement: R.pathOr(null, ['person', 'DateOfLivingArrangement'], corticon),
                childdisabilityevaluationdocumentiondate: R.pathOr(null, ['person', 'ChildDisabilityEvaluationDocumentionDate'], corticon),
                startdateofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'StartDateOfSecondaryEducationOrEquivalentProgram'], corticon),
                isdjsordsschild: R.pathOr(null, ['person', 'IsDJSOrDSSChild'], corticon),
                dateofcourthearing: R.pathOr(null, ['person', 'DateOfCourtHearing'], corticon),
                dateof2ndparentsignatureonvpa: R.pathOr(null, ['person', 'DateOf2ndParentSignatureOnVPA'], corticon),
                relationshipidofpersonfromwhomchildwasphysicallyremoved: R.pathOr(null, ['person', 'RelationshipIDOfPersonFromWhomChildWasPhysicallyRemoved'], corticon),
                typeofremoval: R.pathOr(null, ['person', 'TypeOfRemoval'], corticon),
                childphysicalremovaldate: R.pathOr(null, ['person', 'ChildPhysicalRemovalDate'], corticon),
                ctwdecision: R.pathOr(null, ['person', 'CTWDecision'], corticon),
                dateofchildsignatureonvpa: R.pathOr(null, ['person', 'DateOfChildSignatureOnVPA'], corticon),
                dateofldsssignatureonvpa: R.pathOr(null, ['person', 'DateOfLDSSSignatureOnVPA'], corticon),
                issafehavenbaby: R.pathOr(null, ['person', 'IsSafeHavenBaby'], corticon),
                dateoffindingctwdecision: R.pathOr(null, ['person', 'DateOfFindingCTWDecision'], corticon),
                nameofpromotetoemploymentprogram: R.pathOr(null, ['person', 'NameOfPromoteToEmploymentProgram'], corticon),
                dateofnexthearing: R.pathOr(null, ['person', 'DateOfNextHearing'], corticon),
                clientidwhosignedvpa: R.pathOr(null, ['person', 'ClientIDWhoSignedVPA'], corticon),
                childdisabilitytype: R.pathOr(null, ['person', 'ChildDisabilityType'], corticon),
                childphysicaladdressafterremoval: R.pathOr(null, ['person', 'ChildPhysicalAddressAfterRemoval'], corticon),
                nameofsubjectctwfinding: R.pathOr(null, ['person', 'NameOfSubjectCTWFinding'], corticon),
                dateof1stparentsignatureonvpa: R.pathOr(null, ['person', 'DateOf1stParentSignatureOnVPA'], corticon),
                clientidofpersonfromwhomchildwasphysicallyremoved: R.pathOr(null, ['person', 'ClientIDOfPersonFromWhomChildWasPhysicallyRemoved'], corticon),
                childdeprivedofparentalsupport: R.pathOr(null, ['person', 'ChildDeprivedOfParentalSupport'], corticon),
                relationshipofsubjectctwfinding: R.pathOr(null, ['person', 'RelationshipOfSubjectCTWFinding'], corticon),
                specifiedrelativedatechildlastlivedwith: R.pathOr(null, ['person', 'specifiedRelative', 0, 'SpecifiedRelativeDateChildLastLivedWith'], corticon),
                specifiedrelativephysicaladdress: R.pathOr(null, ['person', 'specifiedRelative', 0, 'SpecifiedRelativePhysicalAddress'], corticon),
                specifiedrelativename: R.pathOr(null, ['person', 'specifiedRelative', 0, 'SpecifiedRelativeName'], corticon),
                specifiedrelativeclientid: R.pathOr(null, ['person', 'specifiedRelative', 0, 'SpecifiedRelativeClientID'], corticon),
                specifiedrelativerelationshipid: R.pathOr(null, ['person', 'specifiedRelative', 0, 'SpecifiedRelativeRelationshipID'], corticon),
                dateofreasonableeffortscourthearing: R.pathOr(null, ['person', 'DateOfReasonableEffortsCourtHearing'], corticon),
                startdateofemployment: R.pathOr(null, ['person', 'StartDateOfEmployment'], corticon),
                childdisabilitystartdate: R.pathOr(null, ['person', 'ChildDisabilityStartDate'], corticon),
                nameofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'NameOfSecondaryEducationOrEquivalentProgram'], corticon),
                dateofbirth: R.pathOr(null, ['person', 'DateOfBirth'], corticon),
                clientidofsubjectctwfinding: R.pathOr(null, ['person', 'ClientIDOfSubjectCTWFinding'], corticon),
                nameofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'NameOfpostSecondaryOrVocationalEducation'], corticon),
                typeofvpa: R.pathOr(null, ['person', 'TypeOfVPA'], corticon),
                issignedbyjudge: R.pathOr(null, ['person', 'IsSignedByJudge'], corticon),
                courtorderdelayremoval: R.pathOr(null, ['person', 'CourtOrderDelayRemoval'], corticon),
                courtorderdelaytimeframe: R.pathOr(null, ['person', 'CourtOrderDelayTimeFrame'], corticon),
                reasonableeffortsnotnecessaryduetoemergentcircumstances: R.pathOr(null, ['person', 'ReasonableEffortsNotNecessaryDueToEmergentCircumstances'], corticon),
                reasonableeffortsmade: R.pathOr(null, ['person', 'ReasonableEffortsMade'], corticon),
                dateofchildplacement: R.pathOr(null, ['person', 'DateOfChildPlacement'], corticon),
                isiveagencyresponsibleforplacementandcare: R.pathOr(null, ['person', 'IsIVEAgencyResponsibleForPlacementAndCare'], corticon),
                magistrateorjudgename: R.pathOr(null, ['person', 'MagistrateOrJudgeName'], corticon),
                mandatorynoteonmissing2ndparentsignatureonvpa: R.pathOr(null, ['person', 'MandatoryNoteOnMissing2ndParentSignatureOnVPA'], corticon),
                startdateofpromotetoemploymentprogram: R.pathOr(null, ['person', 'StartDateOfPromoteToEmploymentProgram'], corticon),
                hourspermonthemployed: R.pathOr(null, ['person', 'HoursPerMonthEmployed'], corticon),
                startdateofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'StartDateOfpostSecondaryOrVocationalEducation'], corticon),
                dateofguardiansignatureonvpa: R.pathOr(null, ['person', 'DateOfGuardianSignatureOnVPA'], corticon),
                nameofemployer: R.pathOr(null, ['person', 'NameOfEmployer'], corticon),
                assetallowance: R.pathOr(null, ['AssetAllowance'], corticon),
                assetsmarketvalue: R.pathOr(null, ['AssetsMarketValue'], corticon),
                noofmembersnotinau: R.pathOr(null, ['NoOfMembersNotInAU'], corticon),
                standardofneedforau: R.pathOr(null, ['StandardOfNeedForAU'], corticon),
                eligibleplacement: R.pathOr(null, ['EligiblePlacement'], corticon),
                fostercareeligibilitystatus: R.pathOr(null, ['status', 'FosterCareEligibilityStatus'], corticon),
                inputjson: inputjson,
                outputjson: _.has(corticonRes, 'outputjson') ? corticonRes.outputjson : null,
                wasthechildremovedfromspecifiedrelative: _.get(corticon, 'status.WasTheChildRemovedFromSpecifiedRelative'),
                vparemovaldate: _.get(corticon, 'status.ChildRemovalDate'),
                courtorderremovaldate: _.get(corticon, 'status.RemovalCourtOrderDate'),
            };
            const fostercareevents = [];
            R.forEach((obj) => {
                fostercareevents.push({
                    eventreason: R.pathOr(null, ['EventReason'], obj),
                    islivingarrangementsameasplacement: R.pathOr(null, ['IsLivingArrangementSameAsPlacement'], obj),
                    havetherebeenanylapsesinplacementandcareresponsibilitytoiveagency: R.pathOr(null, ['HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency'], obj),
                    eventstatus: R.pathOr(null, ['EventStatus'], obj),
                    typeoflapses: R.pathOr(null, ['TypeOfLapses'], obj),
                    eventstage: R.pathOr(null, ['EventStage'], obj),
                    eventenddate: R.pathOr(null, ['EventEndDate'], obj),
                    eventstartdate: R.pathOr(null, ['EventStartDate'], obj),
                    isthereanyreasonableeffortsfindingduringreviewperiod: R.pathOr(null, ['IsThereAnyReasonableEffortsFindingDuringReviewPeriod'], obj),
                    fostercareredeterminationeligibilitystatuswitheventchange: R.pathOr(null, ['FosterCareRedeterminationEligibilityStatusWithEventChange'], obj),
                });
            }, R.pathOr([], ['fosterCareEvents'], corticon));

            jsonPayload.fostercareevents = fostercareevents;

            const householdmember = [];
            R.forEach((obj) => {
                householdmember.push({
                    unearnedincometype: R.pathOr(null, ['unearnedIncome', 0, 'UnearnedIncomeType'], obj),
                    unearnedincomeamount: R.pathOr(null, ['unearnedIncome', 0, 'UnearnedIncomeAmount'], obj),
                    isincomedeemed: R.pathOr(null, ['IsIncomeDeemed'], obj),
                    supportexpenseamount: R.pathOr(null, ['supportExpense', 0, 'SupportExpenseAmount'], obj),
                    clientid: R.pathOr(null, ['ClientID'], obj),
                    nameofhouseholdmember: R.pathOr(null, ['NameOfHouseholdMember'], obj),
                    inau: R.pathOr(null, ['InAU'], obj),
                    earnedincomeamount: R.pathOr(null, ['earnedIncome', 0, 'EarnedIncomeAmount'], obj),
                });
            }, R.pathOr([], ['householdMember'], corticon));

            const keymap = new Map(
                [
                    [courtstatus, 'courtstatus'],
                    ['Removal Home', 'removalhome'],
                    ['Citizenship', 'citizenship'],
                    ['Age', 'age'],
                    ['Deprivation', 'deprivation'],
                    ['Assets', 'assets'],
                    ['Income', 'income'],
                    ['Placement', 'placement'],
                    ['Removal Type', 'removaltype'],
                    ['Demographic', 'demographic'],
                    ['Final', 'finalresult'],
                ]
            );

            R.forEach((obj) => {
                const key = keymap.get(obj.Step);
                if (key) {
                    jsonPayload[key] = R.path(['ReasonCode'], obj);
                }
            }, R.pathOr([], ['reason'], corticon));
            jsonPayload.householdmember = householdmember;

            let result = '';
            jsonPayload.userid = securityuseriddetails;
            // eslint-disable-next-line no-console
            let jsonPayloadone = JSON.stringify(jsonPayload);
            let finaljsonpayload = jsonPayloadone.replace(/'/g, "''");

            const sql = `${spivefcauditperiodssql} ${finaljsonpayload}\')`;

            return util.executeDBQuery(sql, []).then(dataa1 => {
                if (dataa1?.length > 0) {
                    result = { 'data': dataa1 };
                } else {
                    result = { 'data': [] };
                }
                return resolve(result);
            }).catch(err => reject(err));
        });
    }

    // Save the RD data to the database
    function logFCRDCorticonData(corticonRes, worksheetData) {
        return new Promise((resolve, reject) => {
            const keymap = new Map(
                [
                    ['Initialize', 'initialize'],
                    ['CourtOrderedRemovals', 'courtorderedremovals'],
                    ['ChildBeenInFosterCare12MonthOrMore', 'childbeeninfostercare12monthormorereason'],
                    ['JudicialDeterminationOfREFPP-First Re-determination', 'judicialdeterminationofrefppfirstredetermination'],
                    ['ReceiptOfOtherBenefitsMet', 'receiptofotherbenefitsmet'],
                    ['Removal Home', 'removalhome'],
                    ['Placement', 'placement'],
                    ['Age', 'age'],
                    [courtstatus, 'courtstatus'],
                    ['Demographic', 'demographic'],
                    ['Final', 'finalresult'],
                ]
            );
            const corticon = corticonRes?.Objects?.[0];
            let inputjson= JSON.parse(jsonValue(corticonRes, 'inputjson'));
            inputjson.worksheetData = worksheetData;
            const jsonPayload = {
                transactionid: corticonRes.transactionid,
                cjamspid: corticonRes.cjamspid,
                removalid: corticonRes.removalid,
                hashkey: corticonRes.hashkey,
                sqnm_sw: R.pathOr(null, ['sqnm_sw'], corticonRes),
                start_dt: R.pathOr(null, ['start_dt'], corticonRes),
                end_dt: R.pathOr(null, ['end_dt'], corticonRes),
                auditmessages: auditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
                auditstatus: R.pathOr(null, ['status'], corticon),
                dateofcourthearing: R.pathOr(null, ['DateOfCourtHearing'], corticon),
                fostercarereviewperiodenddate: R.pathOr(null, ['FosterCareReviewPeriodEndDate'], corticon),
                hastheagencyoptedtosuspendthessipaymentandclaimive: R.pathOr(null, ['HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE'], corticon),
                typeofcourthearing: R.pathOr(null, ['TypeOfCourtHearing'], corticon),
                refppnotdue: R.pathOr(null, ['REFPPNotDue'], corticon),
                fostercarereviewperiodstartdate: R.pathOr(null, ['FosterCareReviewPeriodStartDate'], corticon),
                dateofsubsequentfindingofbestinterest: R.pathOr(null, ['DateOfSubsequentFindingOfBestInterest'], corticon),
                isplacementeligible: R.pathOr(null, ['IsPlacementEligible'], corticon),
                istherevalidsilaagreement: R.pathOr(null, ['IsThereValidSILAAgreement'], corticon),
                childclientid: R.pathOr(null, ['applicantInformation', 'ClientID'], corticon),
                fostercareredeterminationstage: R.pathOr(null, ['FosterCareRedeterminationStage'], corticon),
                dateofcurrentjudicialfindingofrefpp: R.pathOr(null, ['DateOfCurrentJudicialFindingOfREFPP'], corticon),
                fostercarepermanencyplan: R.pathOr(null, ['FosterCarePermanencyPlan'], corticon),
                fostercareredeterminationcompletiondate: R.pathOr(null, ['FosterCareRedeterminationCompletionDate'], corticon),
                issignedbyjudge: R.pathOr(null, ['SignedByJudge'], corticon),
                dateofcurrentjudicialfindingofbestinterest: R.pathOr(null, ['DateOfCurrentJudicialFindingOfBestInterest'], corticon),
                istheagencytherepresentativepayee: R.pathOr(null, ['IsTheAgencyTheRepresentativePayee'], corticon),
                dateofjudicialfindingofrefpp: R.pathOr(null, ['DateOfJudicialFindingOfREFPP'], corticon),
                reasonforwhytheagencyisnottherepresentativepayee: R.pathOr(null, ['ReasonForWhyTheAgencyISNOTTheRepresentativePayee'], corticon),
                dateofvalidsilaagreement: R.pathOr(null, ['DateOfValidSILAAgreement'], corticon),
                reasonfornotoptedtosuspendthessipaymentandclaimive: R.pathOr(null, ['ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE'], corticon),
                dateofsubsequentjudicialfindingofrefpp: R.pathOr(null, ['DateOfSubsequentJudicialFindingOfREFPP'], corticon),
                dateofpreviousjudicialfindingofrefpp: R.pathOr(null, ['DateOfPreviousJudicialFindingOfREFPP'], corticon),
                isiveagencyresponsibleforplacementandcare: R.pathOr(null, ['IsIVEAgencyResponsibleForPlacementAndCare'], corticon),
                magistrateorjudgename: R.pathOr(null, ['JudgeName'], corticon),
                dateagencylostlegalresponsibility: R.pathOr(null, ['DateAgencyLostLegalResponsibility'], corticon),
                dateofbirth: R.pathOr(null, ['person', 'DateOfBirth'], corticon),
                childdisabilityevaluationdocumentiondate: R.pathOr(null, ['person', 'ChildDisabilityEvaluationDocumentionDate'], corticon),
                dateofpreviousbestinterestfinding: R.pathOr(null, ['person', 'DateOfPreviousBestInterestFinding'], corticon),
                startdateofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'StartDateOfSecondaryEducationOrEquivalentProgram'], corticon),
                childfostercareentrydate: R.pathOr(null, ['person', 'ChildFosterCareEntryDate'], corticon),
                typeofbenefit: R.pathOr(null, ['person', 'TypeOfBenefit'], corticon),
                typeofremoval: R.pathOr(null, ['person', 'TypeOfRemoval'], corticon),
                nameofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'NameOfpostSecondaryOrVocationalEducation'], corticon),
                childphysicalremovaldate: R.pathOr(null, ['person', 'ChildPhysicalRemovalDate'], corticon),
                childreceivingssiorssaduringreviewperiod: R.pathOr(null, ['person', 'ChildReceivingSSIOrSSADuringReviewPeriod'], corticon),
                nameofpromotetoemploymentprogram: R.pathOr(null, ['person', 'NameOfPromoteToEmploymentProgram'], corticon),
                childdisabilitytype: R.pathOr(null, ['person', 'ChildDisabilityType'], corticon),
                amountofbenefit: R.pathOr(null, ['person', 'AmountOfBenefit'], corticon),
                childbeeninfostercare12monthormore: R.pathOr(null, ['person', 'ChildBeenInFosterCare12MonthOrMore'], corticon),
                dateofbestinterestfinding: R.pathOr(null, ['person', 'DateOfBestInterestFinding'], corticon),
                startdateofpromotetoemploymentprogram: R.pathOr(null, ['person', 'StartDateOfPromoteToEmploymentProgram'], corticon),
                hourspermonthemployed: R.pathOr(null, ['person', 'HoursPerMonthEmployed'], corticon),
                startdateofemployment: R.pathOr(null, ['person', 'StartDateOfEmployment'], corticon),
                childdisabilitystartdate: R.pathOr(null, ['person', 'ChildDisabilityStartDate'], corticon),
                nameofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'NameOfSecondaryEducationOrEquivalentProgram'], corticon),
                nameofemployer: R.pathOr(null, ['person', 'NameOfEmployer'], corticon),
                fostercareredeterminationeligibilitystatus: R.pathOr(null, ['status', 'FosterCareRedeterminationEligibilityStatus'], corticon),
                inputjson: inputjson,
                outputjson:jsonValue(corticonRes, 'outputjson'),
                beyondr1eligibility: R.pathOr(null, ['BeyondR1Eligibility'], corticon),
            };
            const fostercareevents = [];
            R.forEach((obj6) => {
                fostercareevents.push({
                    eventreason: R.pathOr(null, ['EventReason'], obj6),
                    islivingarrangementsameasplacement: R.pathOr(null, ['IsLivingArrangementSameAsPlacement'], obj6),
                    havetherebeenanylapsesinplacementandcareresponsibilitytoiveagency: R.pathOr(null, ['HaveThereBeenAnyLapsesInPlacementAndCareResponsibilityToIVEAgency'], obj6),
                    eventstatus: R.pathOr(null, ['EventStatus'], obj6),
                    typeoflapses: R.pathOr(null, ['TypeOfLapses'], obj6),
                    eventstage: R.pathOr(null, ['EventStage'], obj6),
                    eventenddate: R.pathOr(null, ['EventEndDate'], obj6),
                    eventstartdate: R.pathOr(null, ['EventStartDate'], obj6),
                    isthereanyreasonableeffortsfindingduringreviewperiod: R.pathOr(null, ['IsThereAnyReasonableEffortsFindingDuringReviewPeriod'], obj6),
                    fostercareredeterminationeligibilitystatuswitheventchange: R.pathOr(null, ['FosterCareRedeterminationEligibilityStatusWithEventChange'], obj6)
                });
            }, R.pathOr([], ['fosterCareEvents'], corticon));          

            let indexofyouthevents = 1;

            const fostercareyouthevents = [];
            R.forEach((obj5) => {
                fostercareyouthevents.push({
                    eventreason: R.pathOr(null, ['YouthEventReason'], obj5),
                    eventstatus: R.pathOr(null, ['YouthEventStatus'], obj5),
                    eventenddate: R.pathOr(null, ['YouthEventEndDate'], obj5),
                    eventstartdate: R.pathOr(null, ['YouthEventStartDate'], obj5)
                });
            }, R.pathOr([], ['youthEvents'], corticon.status));


            if (fostercareyouthevents.length > 0) {
                fostercareyouthevents.sort(function(a, b) {
                    return new Date(a.eventstartdate) - new Date(b.eventstartdate);
                 });

                fostercareyouthevents.forEach((obj) =>{
                    Object.assign(obj, {"eventstage": `Y${indexofyouthevents++}`});
                });

                fostercareyouthevents.reverse();  // SonarQube fix removed the unwanted assignment 

                fostercareyouthevents.forEach((obj) =>{
                    fostercareevents.push(obj);
                });
            }

           jsonPayload.fostercareevents = fostercareevents;
           jsonPayload.fostercareredeterminationeligibilitystatuswitheventchange = R.pathOr(null, ['status', 'FosterCareRedeterminationEligibilityStatusWithEventChange'], corticon);

            R.forEach((obj3) => {
                const key = keymap.get(obj3.Step);
                if (key) {
                    jsonPayload[key] = R.path(['ReasonCode'], obj3);
                }
            }, R.pathOr([], ['reason'], corticon));

            if(dummyEvent.length > 0){
                fostercareevents.push({
                    eventreason: dummyEvent[0].EventReason,
                    islivingarrangementsameasplacement:dummyEvent[0].IsLivingArrangementSameAsPlacement,
                    eventstage: dummyEvent[0].EventStage,
                    eventenddate: dummyEvent[0].EventEndDate,
                    eventstartdate: dummyEvent[0].EventStartDate,
                    eventstatus: findCodeStatus(jsonPayload)
                });
            }
            if (jsonPayload['childreceivingssiorssaduringreviewperiod'] == 'YES' &&
                jsonPayload['hastheagencyoptedtosuspendthessipaymentandclaimive'] != 'YES' &&
                jsonPayload['typeofbenefit'] != 'SSA') {
                let eventstage = characterStartCheck(fostercareevents);
                
                jsonPayload.fostercareevents.push({
                    eventreason: 'DM',
                    eventstage: `E${eventstage + 1}`,
                    eventenddate: jsonPayload.end_dt,
                    eventstartdate: jsonPayload.start_dt,
                    eventstatus: 'Eligible Non-Reimbursable'
                })
            }

            let result = '';
            jsonPayload.userid = securityuseriddetails;
            // eslint-disable-next-line no-console
            let jsonPayloadone = JSON.stringify(jsonPayload);
            let finaljsonpayload = jsonPayloadone.replace(/'/g, "''");

            const sql = `${spivefcauditperiodssql} ${finaljsonpayload}\')`;

            return util.executeDBQuery(sql, []).then(data => {
                if (data?.length > 0) {
                    result = { data };
                } else {
                    result = { 'data': [] };
                }
                return resolve(result);
            }).catch(err => reject(err));
        });
    }

    function jsonValue(corticonRes, key){
        let json;
        if(_.has(corticonRes, key)){
            json = corticonRes[key]
        }else{
               json = null;
        }  
        return json;  
    }
    function findCodeStatus(jsonPayload) {
        
        if(jsonPayload.dateofjudicialfindingofrefpp) {
            jsonPayload.dateofjudicialfindingofrefpp =  new Date(jsonPayload.dateofjudicialfindingofrefpp);
        }
        
        const currentreffdate =jsonPayload.dateofjudicialfindingofrefpp ?  moment(jsonPayload.dateofjudicialfindingofrefpp).format('YYYY-MM-DD') : null; 
        const reviewperiodstartdt = moment(jsonPayload.start_dt).format('YYYY-MM-DD');
        const startdate_r1 = moment(jsonPayload.start_dt).add(3, 'month').format('YYYY-MM-DD');

        const startdate_r2 = moment(startdate_r1).endOf('month').format("YYYY-MM-DD");
            
        if((jsonPayload['courtstatus'] == 'CRITERIA_FAILED' || jsonPayload['courtstatus'] == undefined) && jsonPayload.dateofpreviousjudicialfindingofrefpp && jsonPayload.start_dt) {

            const start_date = moment(jsonPayload.start_dt).subtract(1, 'year').format('YYYY-MM-DD');
            const previousreffdate = moment(jsonPayload.dateofpreviousjudicialfindingofrefpp).format('YYYY-MM-DD'); 
           
            return (previousreffdate > start_date && previousreffdate < reviewperiodstartdt) ? 'Eligible Reimbursable' : 'Eligible Non-Reimbursable';
            
        } else if(jsonPayload.sqnm_sw == 'R1' && jsonPayload.dateofpreviousjudicialfindingofrefpp == null) {
            return 'Eligible Reimbursable';
        } else if(jsonPayload.sqnm_sw == 'R2' && currentreffdate && currentreffdate > reviewperiodstartdt && currentreffdate < startdate_r2) {
            return 'Eligible Reimbursable';
        } else {
           return (jsonPayload['courtstatus'] == 'CRITERIA_PASSED' ? 'Eligible Reimbursable' : 'Eligible Non-Reimbursable');
        }
    }
    function characterStartCheck(fostercareevents){
        let eventstage = 0;
        fostercareevents.forEach(e => {
            if (e.eventstage.startsWith("E")) {
                eventstage++;
            }
        })
        return eventstage;
    }

    // Save the 18BDay data to the database
    function logFC18BDayCorticonData(corticonRes, worksheetData) {
        return new Promise((resolve, reject) => {
            const keymap = new Map(
                [
                    ['Initialize', 'initialize'],
                    ['SILAAgreementMet', 'silaagreementmet'],
                    ['Youth18to21EligibilityCriteriaMet', 'youth18to21eligibilitycriteriamet'],
                    ['CourtOrderedRemovals', 'courtorderedremovals'],
                    ['ReceiptOfOtherBenefitsMet', 'receiptofotherbenefitsmet'],
                    ['Demographic', 'demographic'],
                    [courtstatus, 'courtstatus'],
                    ['Placement', 'placement'],
                    ['Final', 'finalresult'],
                ]
            );
            const corticon = corticonRes?.Objects?.[0];
            let inputjson= JSON.parse(jsonValue(corticonRes, 'inputjson'));
            inputjson.worksheetData = worksheetData;
            const jsonPayload = {
                transactionid: corticonRes.transactionid,
                cjamspid: corticonRes.cjamspid,
                removalid: corticonRes.removalid,
                hashkey: corticonRes.hashkey,
                sqnm_sw: R.pathOr(null, ['sqnm_sw'], corticonRes),
                start_dt: R.pathOr(null, ['start_dt'], corticonRes),
                end_dt: R.pathOr(null, ['end_dt'], corticonRes),
                auditmessages: auditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
                auditstatus: R.pathOr(null, ['status'], corticon),
                reasonforwhytheagencyisnottherepresentativepayee: R.pathOr(null, ['ReasonForWhyTheAgencyISNOTTheRepresentativePayee'], corticon),
                dateofvalidsilaagreement: R.pathOr(null, ['DateOfValidSILAAgreement'], corticon),
                hastheagencyoptedtosuspendthessipaymentandclaimive: R.pathOr(null, ['HasTheAgencyOptedToSuspendTheSSIPaymentAndClaimIVE'], corticon),
                typeofcourthearing: R.pathOr(null, ['TypeOfCourtHearing'], corticon),
                reasonfornotoptedtosuspendthessipaymentandclaimive: R.pathOr(null, ['ReasonForNOTOptedToSuspendTheSSIPAymentAndClaimIVE'], corticon),
                isplacementeligible: R.pathOr(null, ['IsPlacementEligible'], corticon),
                istherevalidsilaagreement: R.pathOr(null, ['IsThereValidSILAAgreement'], corticon),
                childclientid: R.pathOr(null, ['applicantInformation', 'ClientID'], corticon),
                dateofbirth: R.pathOr(null, ['person', 'DateOfBirth'], corticon),
                childdisabilityevaluationdocumentiondate: R.pathOr(null, ['person', 'ChildDisabilityEvaluationDocumentionDate'], corticon),
                startdateofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'StartDateOfSecondaryEducationOrEquivalentProgram'], corticon),
                typeofbenefit: R.pathOr(null, ['person', 'TypeOfBenefit'], corticon),
                typeofremoval: R.pathOr(null, ['person', 'TypeOfRemoval'], corticon),
                nameofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'NameOfpostSecondaryOrVocationalEducation'], corticon),
                childreceivingssiorssaduringreviewperiod: R.pathOr(null, ['person', 'ChildReceivingSSIOrSSADuringReviewPeriod'], corticon),
                nameofpromotetoemploymentprogram: R.pathOr(null, ['person', 'NameOfPromoteToEmploymentProgram'], corticon),
                childdisabilitytype: R.pathOr(null, ['person', 'ChildDisabilityType'], corticon),
                amountofbenefit: R.pathOr(null, ['person', 'AmountOfBenefit'], corticon),
                startdateofpromotetoemploymentprogram: R.pathOr(null, ['person', 'StartDateOfPromoteToEmploymentProgram'], corticon),
                hourspermonthemployed: R.pathOr(null, ['person', 'HoursPerMonthEmployed'], corticon),
                startdateofemployment: R.pathOr(null, ['person', 'StartDateOfEmployment'], corticon),
                childdisabilitystartdate: R.pathOr(null, ['person', 'ChildDisabilityStartDate'], corticon),
                startdateofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'StartDateOfpostSecondaryOrVocationalEducation'], corticon),
                nameofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'NameOfSecondaryEducationOrEquivalentProgram'], corticon),
                nameofemployer: R.pathOr(null, ['person', 'NameOfEmployer'], corticon),
                fostercareredeterminationstage: R.pathOr(null, ['FosterCareRedeterminationStage'], corticon),
                isiveagencyresponsibleforplacementandcare: R.pathOr(null, ['IsIVEAgencyResponsibleForPlacementAndCare'], corticon),
                fostercareredeterminationcompletiondate: R.pathOr(null, ['FosterCareRedeterminationCompletionDate'], corticon),
                istheagencytherepresentativepayee: R.pathOr(null, ['IsTheAgencyTheRepresentativePayee'], corticon),
                dateagencylostlegalresponsibility: R.pathOr(null, ['DateAgencyLostLegalResponsibility'], corticon),
                fostercareredeterminationeligibilitystatus: R.pathOr(null, ['status'], corticon) ? R.pathOr(null, ['status'], corticon).FosterCareRedeterminationEligibilityStatus : null,
                inputjson: inputjson,
                outputjson: jsonValue(corticonRes, 'outputjson')
            };

            const fostercareevents = [];
            
            jsonPayload.fostercareevents = fostercareevents;

            R.forEach((obj7) => {
                const key = keymap.get(obj7.Step);
                if (key) {
                    jsonPayload[key] = R.path(['ReasonCode'], obj7);
                }
            }, R.pathOr([], ['reason'], corticon));

            let result = '';
            jsonPayload.userid = securityuseriddetails;
            // eslint-disable-next-line no-console
            let jsonPayloadone = JSON.stringify(jsonPayload);
            let finaljsonpayload = jsonPayloadone.replace(/'/g, "''");

            const sql = `${spivefcauditperiodssql} ${finaljsonpayload}\')`;

            return util.executeDBQuery(sql, []).then(data => {
                if (data?.length > 0) {
                    result = { data : data };
                } else {
                    result = { 'data': [] };
                }
                return resolve(result);
            }).catch(err => reject(err));
        });
    }

    // Perform call the Corticon API
    function executeCorticon(data) {
        return new Promise((resolve, reject)=>{
            const options = {
                method: 'POST',
                uri: `${app.get('CORTICONAPI')}/axis/corticon/execute`,
                body: data,
                json: true,
            };
            return axios.post(options.uri, options.body,
                {headers: {
                    'Content-Type': 'application/json'
                }}
            )
            .then((res) => {
                resolve(res.data); 
            })
            .catch((err) => {
                if (err.response) {
                    reject({
                        statusCode: err.response.status,
                        body: err.response.statusText 
                    });
                }
                reject(err);
            });

        })
    }

    // Call Period based on the period type
    function callPeriod(periodType, worksheetData, childinfo , initialeligibiltystatus, annual21Bday) {
        const {  educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo } = childinfo;
        return new Promise((resolve, reject) => {
            const regexRD = /^[R]\d+$/gm;

            reviewperiodstartdate = dateConversion(worksheetData.periodsInfo.start_dt);
            reviewperiodenddate = dateConversion(worksheetData.periodsInfo.end_dt); 

            if (periodType === 'I') {
                // Prepare Foster Care Initial Determination(FCID) data
                resolve(prepareFCIDCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo));
            } else if (periodType === '18BDAY') {
                // Prepare Foster Care Initial Determination(FC18) data
                resolve(prepareFC18BDayCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo)); 
            } else if (regexRD.exec(periodType) !== null) {
                if (worksheetData.typeofremoval === 'Voluntary_Placement_Agreement' && worksheetData.typeofvpa === 'EA-VPA' && worksheetData.detperiodtype === 'R1'){
                // Prepate Foster Care EAVPA R1 (FCVPAR1) Data    
                if(worksheetData.periodsInfo.sqnm_sw == 'R1' && initialeligibiltystatus == 'Ineligible') {
                    initialeligibiltystatus = 'Ineligible'
                } else {
                    initialeligibiltystatus = null;
                }
                resolve(prepareFCVPAR1DCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo, initialeligibiltystatus)); /*, initialeligibiltystatus);*/
            }  else {
                // Prepare Foster Care Re Determination(FCRD) data
                resolve(prepareFCRDCorticonData(worksheetData, educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo, initialeligibiltystatus, annual21Bday));
                }
            }
        });
    }

    TitleIVEFC.fcAuditPeriods = (data) => {
        const clientId = data.clientId;
        let removalId = data.removalId;
        const educationDetailsInfo = data.educationinformation;
        const employmentDetailsInfo = data.employmentinformation;
        const employmentBarrierInfo = data.employmentbarrierinfomation;
        const disablityInfo = data.disablityinformation;
        const initialeligibiltystatus = data.initialEligibleStatus;
        const annual21Bday = data.annual21Bday;
        
        return (async () => {
            for (const [i, period] of data.selectedPeriods.entries()) {
                try {
                    let worksheetData;
                    // eslint-disable-next-line one-var
                    let validationResult;
                    // eslint-disable-next-line one-var
                    let corticonRes;
                    

                    const detPeriodType = period.sqnm_sw;
                    var securityuserid = getfcAuditRemovalid(data).securityuserid;
                    removalId = getfcAuditRemovalid(data).removalId;
                    securityuseriddetails =  getfcAuditRemovalid(data).securityuserid;

                    var endDate =  (period.end_dt ? moment(period.end_dt).format(dtformat) : '');  
                    
                    await getWorksheetData({ clientId,removalId,detPeriodType }).then((tempData) => {
                        worksheetData = tempData.data;
                    }).catch((error) => {
                        data.selectedPeriods[i].result = { status: 'error',msg: 'failed to fetch worksheet data',info: error };
                        throw error;
                    })
                    await delay(1000);
                    const childinfo={ educationDetailsInfo, employmentDetailsInfo, employmentBarrierInfo, disablityInfo };
                    await callPeriod(period.sqnm_sw, worksheetData, childinfo , initialeligibiltystatus, annual21Bday).then((data1)=>{
                        validationResult = data1;
                    }).catch((error) => {
                        data.selectedPeriods[i].result = { status: 'error', msg: 'failed to prepare data', info: error };
                        throw error;
                    })
                    await delay(1000);
                    await executeCorticon(validationResult).then((cortdata)=>{
                        corticonRes = cortdata;
                    }).catch((error) => {
                        data.selectedPeriods[i].result = { status: 'error', msg: 'corticon error', info: error };
                        throw error;
                    })
                    await delay(1000);
                    try {
                        const options = {
                            transactionid: uuidv4(),
                            cjamspid: clientId,
                            removalid: removalId,
                            sqnm_sw: period.sqnm_sw,
                            start_dt: period.start_dt,
                            end_dt: period.end_dt,
                            hashkey: hash(validationResult),
                        };
                        const res = await logCorticonData(period.sqnm_sw, validationResult, corticonRes, options, worksheetData);
                        data.selectedPeriods[i].result = { status: 'success', msg: 'success', info: res };
                        if((res.data[0].v_fostercareredeterminationeligibilitystatus == 'Ineligible')  && res.data[0].v_end_dt !== null && worksheetData.dateagencylostlegalresponsibility !== null) {
                            var sql = 'select * from send_notification_for_ineligibility_determination($1,$2,$3,$4,$5,$6)';
                
                            return util.executeDBQuery(sql, [worksheetData.casenumber, worksheetData.clientid, securityuserid, endDate, worksheetData.childname, removalId])
                            .then(data1 => {
                                LOGGER.info(data1);
                                return data1;
                            })
                            .catch(err => {
                                LOGGER.error('>>>>ERROR:', err);
                                throw err;
                            })
                        }                       
                    } catch (error) {
                        data.selectedPeriods[i].result = { status: 'error', msg: 'failed to log data to the table', info: error };
                    }
                } catch (error) {
                    data.selectedPeriods[i].result = { status: 'error', msg: 'unknown error occured', info: error };
                }
            }
        })().then(() => {
            return data;
        })
            .catch((err) => {
                throw err;
            });
    };

    function getfcAuditRemovalid(data) {
        return {
            securityuserid: (data && data.securityuserid ? data.securityuserid : ''),
            removalId: (data && data.removalId ? data.removalId : '')
        }
    }

    const getAuditPeriodsInfo = (clientId, removalId, ds) => {
        const sql = `select * from sp_ive_fc_getauditperiodsinfo($1, $2)`;

        return util.executeSecondaryNodeDBQuery(sql, [clientId, removalId])
        .then(rowsOrEmpty)
        .catch(logAndRethrow);
    };


    TitleIVEFC.getFcEligibilityDetails = (clientId, removalId) => {
        try {
            const ds = app.dataSources.hcuewelfare;
            let result = '';
            let summaryinfo = '';

            return Promise.all([getSummaryInfo(clientId, ds), getAuditPeriodsInfo(clientId, removalId, ds)])
                .then((arrData) => {
                    summaryinfo = arrData[0];
                    const data = arrData[1];
                    const perioddata = [];
                  if (data && data.length && Array.isArray(data)){    
                    data.forEach((obj) => {
                        perioddata.push(obj.period);
                    });
                    let periods = [];
                    let uSet = new Set(perioddata);
                    periods = [...uSet];
                    const eligibilityDetailsfunc = function (eligibilityDetails) {
                        return _.groupBy(eligibilityDetails, function (eligibilityDetail) {
                            let key = 'F.';
                            _.forEach(periods, function (period) {
                                if (eligibilityDetail.period === period) {
                                    key = period;
                                    return false;
                                }
                            });
                            return key;
                        });
                    };
                    result = eligibilityDetailsfunc(data);
                }
                    return { history: result, summaryInfo: summaryinfo };
                })
                .catch((err) => {
                    throw errorUtils.formatExceptionError(err);
                });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.postFcDeterminationByTransactionId = (id) => {
        try {
            let sql = '';
            let result = '';
            sql = `select * from sp_ive_eligibility_details_info('${id}')`;
            return util.executeDBQuery(sql, []).then(data => {
                result = {
                    'message': 'Eligibility status updated successfully',
                };
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.getReportpdf = (request, res) => {
        return new Promise((resolve, reject) => {
            let pdfRes = pdf.ivefostercarePDF(request);
            resolve(pdfRes);
        });
    };

    TitleIVEFC.updatePlacements = (data) => {
        try {
            let result = '';
            return util.executeDBQuery(`SELECT * FROM sp_ive_eligibility_worksheet_placements($1)`, [JSON.stringify(data)]).then(data3 => {
                result = { 'message': 'Placements Updated successfully' };
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.updateJudicial = (data) => {
        try {
            let result = '';
            const jsonPayloadone = JSON.stringify(data);

            // FIX: Removed manual escaping and used $1 for PostgreSQL parameterized query
            const sql = 'SELECT * FROM sp_ive_eligibility_worksheet_judicial_info($1)';
            const params = [jsonPayloadone];

            return util.executeDBQuery(sql, params).then(data4 => {
                result = { 'message': 'Judicial Updated successfully' };
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.updateWorksheetIncome = (data) => {
        try {
            if (!data || !data.clientId) {
                throw new Error(invalidinputmsg);
            }

            const jsonPayload = JSON.stringify(data);

            // Use a placeholder ($1 or ?) instead of concatenating the string
            const query = 'SELECT * FROM sp_ive_eligibility_worksheet_income_info($1)';
            const params = [jsonPayload];

            // Pass the params array as the second argument
            return util.executeDBQuery(query, params).then(data5 => {
                let result = { data: [] };
                if (data5 && data5.length > 0) {
                    result.data = data5;
                }

                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.updateWorksheetRemoval = (data) => {
        try {
            if (!data || !data.clientId) {
                throw new Error(invalidinputmsg);
            }

            const jsonPayload = JSON.stringify(data);

            // Use a placeholder ($1 or ?) instead of concatenating the string
            const query = 'SELECT * FROM sp_ive_eligibility_worksheet_removal_update($1)';
            const params = [jsonPayload];

            // Pass the params array as the second argument
            return util.executeDBQuery(query, params).then(data6 => {
                return { message: 'Removal Updated successfully' };
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.updateWorksheetDeprivation = (data) => {
        try {
            let noClientId = false;
            data.forEach((item) => {
                if (!item.clientId) {
                    noClientId = true;
                }
            });
            if (!data || noClientId) {
                throw new Error(invalidinputmsg);
            }
            let result = '';
            const sql = 'SELECT * FROM sp_ive_eligibility_worksheet_deprivation_info($1)';
            return util.executeDBQuery(sql, [JSON.stringify(data)]).then(data7 => {
                if (data7 !== null && typeof data7 !== 'undefined' && data7.length > 0) {
                    result = { data : data7 };
                } else {
                    result = { 'data': [] };
                }
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.deleteWorksheetDeprivation = (data) => {
        try {
            let result = '';
            const sql = 'DELETE FROM ivepersondeprivation WHERE ivepersondeprivationid = $1'
            return util.executeDBQuery(sql, [data.ivepersondeprivationid]).then(data8 => {
                if (data8 !== null && typeof data8 !== 'undefined' && data8.length > 0) {
                    result = { data : data8 };
                }
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    // createWorksheetIncomeType
    TitleIVEFC.createWorksheetIncomeType = (data) => {
        try {
            if (!data || data.incomeType.length <= 0) {
                throw new Error(invalidinputmsg);
            }
            let result = '';

            let jsonPayloadone = JSON.stringify(data);
            let finaljsonpayload = jsonPayloadone.replace(/'/g, "''");

            const sql = 'SELECT * FROM sp_ive_eligibility_worksheet_income_type_create(\'' + finaljsonpayload + '\')';

            return util.executeDBQuery(sql, []).then(data15 => {
                if (data15 !== null && typeof data15 !== 'undefined' && data15.length > 0) {
                    result = { data : data15 };
                } else {
                    result = { 'data': [] };
                }
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.updateWorksheetSpecifiedRelative = (data) => {
        try {
            // FIX: Added Array.isArray check to prevent app crashes if data is not an array
            if (!data || !Array.isArray(data)) {
                throw new Error(invalidinputmsg);
            }

            let noClientId = false;
            data.forEach((item1) => {
                if (!item1.clientId) {
                    noClientId = true;
                }
            });

            if (noClientId) {
                throw new Error(invalidinputmsg);
            }

            let result = '';

            // Stringify the data to pass as a single JSON parameter
            let jsonPayload = JSON.stringify(data);

            // FIX: Replaced concatenation and manual escaping with a parameterized query ($1)
            // You may need to add a cast like $1::json or $1::jsonb if your stored proc strictly requires it
            const sql = 'SELECT * FROM sp_ive_eligibility_worksheet_specified_relative_info($1)';
            const params = [jsonPayload];

            return util.executeDBQuery(sql, params).then(data9 => {
                if (data9 !== null && typeof data9 !== 'undefined' && data9.length > 0) {
                    result = { data : data9 };
                } else {
                    result = { 'data': [] };
                }
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

   TitleIVEFC.updateWorksheetSSISSA = (data) => {
        try {
            if (!data && !data.clientId && !data.removalid) {
                throw new Error(invalidinputmsg);
            }
            let result = '';

            // FIX: Replaced string interpolation with a parameterized query
            const sql = 'SELECT * FROM sp_ive_eligibility_worksheet_ssi_ssa_info($1)';
            const params = [JSON.stringify(data)];

            // FIX: Passed the params array to the execute function
            return util.executeDBQuery(sql, params).then(data10 => {
                result = { 'message': 'SSI SSA Updated successfully' };
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };

    TitleIVEFC.getlegalinfo = (data) => {
        try {
            if (!data && !data.courtorderid && !data.courtlanguagetype) {
                throw new Error(invalidinputmsg);
            }
            let result = '';
            const reviewperiodstartdt = data.reviewperiodstartdt ? data.reviewperiodstartdt : null;

            // FIX: Replaced interpolated variables with PostgreSQL parameter placeholders ($1, $2, etc.)
            const sql = `SELECT * FROM sp_fc_get_court_info($1::VARCHAR, $2::VARCHAR, $3, $4, $5::VARCHAR, $6::date)`;

            // FIX: Mapped the inputs to a parameter array in the exact order of the placeholders
            const params = [
                data.courtorderid,
                data.courtlanguagetype,
                data.clientid,
                data.removalid,
                data.sqnm_sw,
                reviewperiodstartdt
            ];

            // FIX: Passed the params array to the connector's execute function
            return util.executeDBQuery(sql, params).then(data11 => {
                if (data11 !== null && typeof data11 !== 'undefined' && data11.length > 0) {
                    result = { data: data11 };
                } else {
                    result = { 'data': [] };
                }
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    }

    TitleIVEFC.getsignatureinfo = (data) => {
        try {
            if (!data && !data.eligibilityperiodid) {
                throw new Error(invalidinputmsg);
            }
            let result = '';
            const sql = 'select tifa.supervisorsignature,tifa.specialistsignature,tifa.supervisorname,tifa.specialistname,tifa.supervisorsubmissiondate,tifa.specialistsubmissiondate from tb_ive_fostercare_audit tifa where eligibility_period_id=$1';

            return util.executeDBQuery(sql, [data.eligibilityperiodid]).then(data12 => {
                if (data12 !== null && typeof data12 !== 'undefined' && data12.length > 0) {
                    result = { data : data12 };
                } else {
                    result = { 'data': [] };
                }
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    }

    TitleIVEFC.updateIVESignature = (data) => {
        try {
            let result = '';
            const id =  data.periodid;
            let username;
            let usersignature;
            let usersignaturedate;
            let userid =  data.securityuserid;
            let userrole = data && data.roletype ? data.roletype : null;
            
            let sql = 'select * from sp_ive_eligibility_signature_update($1,$2,$3,$4,$5,$6)';
            if (data && (data.roletype === 'IVESV' || data.roletype === 'IVEQA' || data.roletype === 'IVEADMIN')) {
                username = data.supervisorname;
                usersignature = data.supervisorsign;
                usersignaturedate = data.supervisorsigndt;
            } else if (data && data.roletype === 'IVESP' || data && data.roletype === 'IVEEA') {
                username = data.specalistname;
                usersignature = data.specalistsign;
                usersignaturedate = data.specalistsigndt;
            }  
            return util.executeDBQuery(sql, [userrole, username, usersignature, usersignaturedate, userid, id]).then(data13 => {
                result = { 'message': 'Signature Updated successfully' };
                return result;
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } catch (e) {
            throw errorUtils.formatExceptionError(e);
        }
    };


    TitleIVEFC.remoteMethod(
        'getFcPeriods', {
            description: 'Foster Care Periods API',
            accepts: [{
                arg: 'clientId',
                type: 'number',
                http: {
                    source: 'path',
                },
                required: true,
            },
            {
                arg: 'removalId',
                type: 'number',
                http: {
                    source: 'path',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'any',
                root: true,
            },
            http: {
                path: '/fc/get-periods/:clientId/:removalId',
                verb: 'get',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'eligibilityWorksheet', {
            description: eligibilityworksheetdesc,
            accepts: [{
                arg: 'body',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/eligibility-worksheet',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'fcAuditPeriods', {
            description: 'Foster Care Audit Periods API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/audit-periods/',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'getFcEligibilityDetails', {
            description: 'Get foster care eligibility history data',
            accepts: [{
                arg: 'clientId',
                type: 'number',
                http: {
                    source: 'path',
                },
                required: true,
            },
            {
                arg: 'removalId',
                type: 'number',
                http: {
                    source: 'path',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'any',
                root: true,
            },
            http: {
                path: '/fc/eligibility-history/:clientId/:removalId',
                verb: 'get',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'postFcDeterminationByTransactionId', {
            description: 'Post Foster Care Determination By Transaction Id API',
            accepts: [{
                arg: 'id',
                type: 'string',
                http: {
                    source: 'path',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'any',
                root: true,
            },
            http: {
                path: '/fc/determination-transaction-id/:id',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'getReportpdf', {
            description: 'Get pdf reports',
            http: {
                path: '/fc/worksheet/getreportpdf',
                verb: 'post',
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
            accepts: [{
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body',
                },
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res',
                },
            },
            ],
            returns: {
                arg: 'data',
                type: 'Object',
            },
        });

    TitleIVEFC.remoteMethod(
        'updatePlacements', {
            description: 'Update Placements API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/placements',
                verb: 'put',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'updateIVESignature', {
            description: 'Update Signature API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/ivesignature',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'updateJudicial', {
            description: 'Update Judicial API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/judicial',
                verb: 'put',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'updateWorksheetIncome', {
            description: 'Update Worksheet Income API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/income',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'updateWorksheetRemoval', {
            description: 'Update Worksheet Removal API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/updateRemoval',
                verb: 'put',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'updateWorksheetDeprivation', {
            description: 'Update Worksheet Deprivation API',
            accepts: [{
                arg: 'data',
                type: 'array',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/deprivation',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'deleteWorksheetDeprivation', {
            description: 'Delete Worksheet Deprivation API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/deprivation/delete',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'createWorksheetIncomeType', {
            description: 'Create Worksheet Income Type API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/income-type/create',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'updateWorksheetSpecifiedRelative', {
            description: 'Update Worksheet Specified Relative API',
            accepts: [{
                arg: 'data',
                type: 'array',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/specified-relative',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'updateWorksheetSSISSA', {
            description: 'Update Worksheet SSI SSA API',
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/worksheet/ssissa',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'getlegalinfo', {
            description: eligibilityworksheetdesc,
            accepts: [{
                arg: 'body',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/getlegalinfo',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    TitleIVEFC.remoteMethod(
        'getsignatureinfo', {
            description: eligibilityworksheetdesc,
            accepts: [{
                arg: 'body',
                type: 'object',
                http: {
                    source: 'body',
                },
                required: true,
            }],
            returns: {
                arg: 'result',
                type: 'object',
                root: true,
            },
            http: {
                path: '/fc/getivesignature',
                verb: 'post',
                status: 200,
                errorStatus: 400,
                contentType: jsoncontenttype,
            },
        }
    );

    
};