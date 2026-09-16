'use strict';
const errorUtils = require('../../server/utils/error-utils');
var app = require('../../server/server');
const hash = require('object-hash');
const moment = require('moment');
const _ = require('lodash');
const R = require('ramda');
const axios = require('axios');
const { v4: uuidv4 } = require('uuid');
const pdf = require('../models/pdf');
const spiveadoptionauditsql = 'select * from sp_ive_adoption_audit(\'';
const jsoncontenttype = 'application/json';
const util = require('../utils/utils');
const LOGGER = require('log4js').getLogger("utils");

module.exports = function (IVEADOPTION) {

  const getAdoptionACAWorksheetInfo = (clientId, removalId, ds, result) => {
    const res = result;
    const sql = `select * from sp_adoption_aca_info($1, $2)`;
    return util.executeDBQuery(sql, [clientId, removalId])
      .then(data => {
        if (data !== null && typeof data !== 'undefined' && data.length > 0) {
          res.adoptionAcaInfo = data;
        }
        return res;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  const getAdoptionEligibilityWorksheetInfo = (clientId, removalId, ds, result) => {
      const res = result;
      res.adoptionEligibilityInfo = [];
      const sql = `select * from sp_adoption_eligibility_worksheet_info($1, $2)`;

      return util.executeDBQuery(sql, [clientId, removalId])
            .then(data => {
               if (data !== null && typeof data !== 'undefined' && data.length > 0) {
                 res.adoptionEligibilityInfo = data;
               }
               return res;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
      });
  };

  const getAdoptionapplicabilityauditinfo = (clientId, ds, result) => {
    const res = result;
      res.adoptionApplicabilityauditInfo = [];
      const sql = `select * from tb_ive_adoption_audit tiaa where tiaa.category = 'A' and tiaa.cjamspid = $1 order by  tiaa.insertedon desc limit 1`;

    return util.executeSecondaryNodeDBQuery(sql, [clientId])
            .then(data => {
               if (data !== null && typeof data !== 'undefined' && data.length > 0) {
                 res.adoptionApplicabilityauditInfo = data;
               }
               return res;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
      });
  };

  IVEADOPTION.adoptionEligibilityWorksheet = (clientId, removalId) => {
    try {
      const ds = app.dataSources.hcuewelfare;
     return getAdoptionEligibilityWorksheetInfo(clientId, removalId, ds, {})
    .then((result) => {
      return result;
    })
    .catch((err) => {
      throw err;
    });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  IVEADOPTION.adoptionAcaWorksheet = (clientId, removalId) => {
    try {
      const ds = app.dataSources.hcuewelfare;
     return getAdoptionACAWorksheetInfo(clientId, removalId, ds, {})
      .then((result) => {
        return result;
      })
      .catch((err) => {
        throw err;
      });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };
   
  IVEADOPTION.updatestatus = request => {
    const sql = `update adoptionapplicabilityinfo set ivestatus = $1 where clientid = $2 and removalid = $3`;
    return util.executeDBQuery(sql, [request.ivestatus, request.clientId, request.removalId])
      .then(resp => resp)
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  IVEADOPTION.adoptionApplicabilityDecision = (clientId, removalId) => {
    try {   //NOSONAR
      const ds = app.dataSources.hcuewelfare;
      return getAdoptionapplicabilityauditinfo(clientId, ds, {})
      .then((result) => {
        return result;
      })
      .catch((err) => {
        throw err;
      });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  IVEADOPTION.adoptionApplicability = (data, reqctx) => {
    let suserid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
        suserid = reqctx.req.headers.securityusersid;
    } 
    try {
        if (!data || !data.clientId) {
            throw new Error('sent invalid inputs');
        }

        Object.keys(data).forEach((key) => (data[key] === null || data[key] === '') && delete data[key]);

        data.securityusersid = (data && data.securityuserid ? data.securityuserid : suserid);
        let result = '';

        const finalData = JSON.stringify(data);

        // FIX: Use Parameterized Query with $1 for PostgreSQL
        const sql = 'SELECT * FROM adoptionapplicabilityinfo($1)';
        const params = [finalData];

        return util.executeDBQuery(sql, params)
            .then(data1 => {
                if (data1 !== null && typeof data1 !== 'undefined' && data1.length > 0) {
                    result = { data : data1 };
                } else {
                    result = { 'data': [] };
                }
                return result;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    } catch (e) {
        throw errorUtils.formatExceptionError(e);
    }
};

  IVEADOPTION.gatAdoptionAuditMessagesByAuditId = (eligibilityperiodid) => {
    try {
      let sql = '';
      let result = '';

      sql = `select m.cjamspid, m.severity, m.message, a.pagesnapshot from tb_adoptionaudit_messages m join tb_ive_adoption_audit a on m.adoptionauditid = a.adoptionauditid\
              join tb_eligibility_period tep on tep.eligibility_period_id = a.eligibility_period_id where tep.eligibility_period_id = ${eligibilityperiodid}`;
      return util.executeDBQuery(sql, [])
        .then(data => {
          if (data !== null && typeof data !== 'undefined' && data.length > 0) {
            result = { data };
          } else {
            result = { 'data': [] };
          }
          return result;
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };



  IVEADOPTION.saveadoptioninitialdata = (data) => {
    try {
        if (!data || !data.clientId) {
            throw new Error('sent invalid inputs');
        }

        Object.keys(data).forEach((key) => (data[key] === null || data[key] === '') && delete data[key]);

        let result = '';

        const jsonPayloadone = JSON.stringify(data);

        // FIX: Removed manual escaping and used $1 for PostgreSQL parameterized query
        const sql = 'SELECT * FROM saveadoptioninitailinfo($1)';
        const params = [jsonPayloadone];

        return util.executeDBQuery(sql, params)
            .then(data2 => {
                if (data2 !== null && typeof data2 !== 'undefined' && data2.length > 0) {
                    result = { data : data2 };
                } else {
                    result = { 'data': [] };
                }
                return result;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    } catch (e) {
        throw errorUtils.formatExceptionError(e);
    }
};


  const processApplicability = (payload, transactionid, cjamsPid, removalid, approvalid, pagesnapshot) => {
    return new Promise(async (resolve, reject) => {
      try {
        const options = {
          method: 'POST',
          uri: `${app.get('CORTICONAPI')}/axis/corticon/execute`,
          body: payload.payload,
          json: true,
        };
        const resp = await axios.post(options.uri, options.body, {headers: {
                    'Content-Type': 'application/json'
                }});
        const corticonRes = resp.data;
        if(corticonRes && corticonRes.Messages && corticonRes.Messages.Message && corticonRes.Messages.Message.length > 0){
          corticonRes.Messages.Message.forEach((msg) => {
            msg.text = _.replace(msg.text,new RegExp("'s","g"),"s")
          });
        }
        const corticon = corticonRes.Objects[0];
        
        var finalresult = getfinalResult(corticon);

        const jsonPayload = {
          transactionid,
          category: 'A',
          cjamsPid,
          removalid,
          approvalid,
          adoptionauditmessages: adoptionAuditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
          dateofbirth: R.pathOr(null, ['person', 'DateOfBirth'], corticon),
          childremovaldate: R.pathOr(null, ['person', 'Child_Removal_Date'], corticon),
          removalcourtorderdate: R.pathOr(null, ['person', 'Removal_Court_Order_Date'], corticon),
          childexpectedadoptiveproviderid: R.pathOr(null, ['person', 'ChildExpectedAdoptiveProviderID'], corticon),
          childhasemotionaldisturbance: R.pathOr(null, ['person', 'ChildHasEmotionalDisturbance'], corticon),
          childhashighriskofdisability: R.pathOr(null, ['person', 'ChildHasHighRiskOfDisability'], corticon),
          childhasphysicalmentalemotionaldisability: R.pathOr(null, ['person', 'ChildHasPhysicalMentalEmotionalDisability'], corticon),
          childmeetsssimedicaldisabledeligreqts: R.pathOr(null, ['person', 'ChildMeetsSSIMedicalDisabledEligReqts'], corticon),
          childpreviousadoptionivestatus: R.pathOr(null, ['person', 'ChildPreviousAdoptionIVEStatus'], corticon),
          childpreviousadoptiveparentdeathdate: R.pathOr(null, ['person', 'ChildPreviousAdoptiveParentDeathDate'], corticon),
          childpreviousadoptiveparenttprdate: R.pathOr(null, ['person', 'ChildPreviousAdoptiveParentTPRDate'], corticon),
          childpreviouslyadopted: R.pathOr(null, ['person', 'ChildPreviouslyAdopted'], corticon),
          childraceethnicity: R.pathOr(null, ['person', 'ChildRaceEthnicity'], corticon),
          childphysicaladdress: R.pathOr(null, ['person', 'ChildPhysicalAddress'], corticon),
          startdateofreceivingssi: R.pathOr(null, ['person', 'StartDateOfReceivingSSI'], corticon),
          voluntaryrelinquishment: R.pathOr(null, ['person', 'VoluntaryRelinquishment'], corticon),
          childadoptionunsuccessfuleffortstoplace: R.pathOr(null, ['person', 'ChildAdoptionUnsuccessfulEffortsToPlace'], corticon),
          childcanreturntohome: R.pathOr(null, ['person', 'ChildCanReturnToHome'], corticon),
          childcurrentivefostercareeligibilitystatus: R.pathOr(null, ['person', 'ChildCurrentIVEFosterCareEligibilityStatus'], corticon),
          childexpectedadoptiondate: R.pathOr(null, ['person', 'ChildExpectedAdoptionDate'], corticon),
          childhasbeenincare60months: R.pathOr(null, ['person', 'ChildHasBeenInCare60Months'], corticon),
          childhasfosterparentemotionalties: R.pathOr(null, ['person', 'ChildHasFosterParentEmotionalTies'], corticon),
          childreceivingssiatremoval: R.pathOr(null, ['person', 'ChildReceivingSSIAtRemoval'], corticon),
          childmeetsssimedicaldisabilityreqts: R.pathOr(null, ['person', 'ChildMeetsSSIMedicalDisabilityReqts'], corticon),
          childisssieligible: R.pathOr(null, ['person', 'ChildIsSSIEligible'], corticon),
          childnotreturnhomeexplanation: R.pathOr(null, ['person', 'ChildNotReturnHomeExplanation'], corticon),
          adoptionapplicable: R.pathOr(null, ['status', 'AdoptionApplicable'], corticon),
          adoptionnonapplicable: R.pathOr(null, ['status', 'AdoptionNonApplicable'], corticon),
          adoptiondataincomplete: R.pathOr(null, ['status', 'AdoptionDataIncomplete'], corticon),
          nonapplsplneedscriteriainsecic12aorband3aorb: R.pathOr(null, ['status', 'NonApplicable_DoesTheChildMeetTheSpecialNeedsCriteriaInSection_I_C1_2_AorB_AND_3_AorB'], corticon),
          nonappltitleivestandardsofsecid1prioradptionaorbor2ivefcorssiaorb: R.pathOr(null, ['status', 'NonApplicable_DoesChildMeetTheTitleIV_EStandardsOfSection_I_D1_Prior_Adoption_AorB_OR_2_IV_E_Foster_CareOrSSI_AorB'], corticon),
          appchildmeetchildstatuscriteriaofsectionia12or3: R.pathOr(null, ['status', 'Applicable_DoesTheChildMeetAnyOfTheChildStatusCriteriaOfSection_I_A1_2or3'], corticon),
          appthespecialneedscriteriainsecic12aorband3aorb: R.pathOr(null, ['status', 'Applicable_DoesTheChildMeetTheSpecialNeedsCriteriaInSection_I_C1_2_AorB_AND_3_AorB'], corticon),
          nonappplacementormedicalcriteriaofsecib12or3: R.pathOr(null, ['status', 'NonApplicable_DoesTheChildMeetPlacementOrMedicalCriteriaOfSection_I_B1_2or3'], corticon),
          appplacementormedicalcriteriaofsectionib12or3: R.pathOr(null, ['status', 'Applicable_DoesTheChildMeetPlacementOrMedicalCriteriaOfSection_I_B1_2or3'], corticon),
          haschildbeenassessedtonotbeanappchild: R.pathOr(null, ['status', 'HasChildBeenAssessedToNOTBeAnApplicableChild'], corticon),
          applicableandnonapplicable: R.pathOr(null, ['status', 'ApplicableAndNonApplicable'], corticon),
          neitheranappnornonappchildfortitleivepurposes: R.pathOr(null, ['status', 'NeitherAnApplicableNorNonApplicableChildForTitleIV_EPurposes'], corticon),
          finalresult: finalresult,
          inputjson: JSON.stringify(payload.payload),
          outputjson: JSON.stringify(corticonRes),
          pagesnapshot: JSON.stringify(pagesnapshot),
        };

        const person_adoptionminorparentdetails = [];
        R.forEach((obj) => {
          person_adoptionminorparentdetails.push({
            minorparentremovaldate: R.pathOr(null, ['MinorParentRemovalDate'], obj),
            minorparentname: R.pathOr(null, ['MinorParentName'], obj),
            minorparentcurrentplacementtype: R.pathOr(null, ['MinorParentCurrentPlacementType'], obj),
            minorparentdateofbirth: R.pathOr(null, ['MinorParentDateOfBirth'], obj),
            minorparentremovalcourtorderdate: R.pathOr(null, ['MinorParentRemovalCourtOrderDate'], obj),
            minorparentphysicaladdress: R.pathOr(null, ['MinorParentPhysicalAddress'], obj),
          });
        }, R.pathOr([], ['person', 'parentDetails'], corticon));

        const person_adoptionsiblingdetails = [];
        R.forEach((obj) => {
          person_adoptionsiblingdetails.push({
            siblingadoptiondecreedate: R.pathOr(null, ['SiblingAdoptionDecreeDate'], obj),
            siblingadoptionapplicable: R.pathOr(null, ['SiblingAdoptionApplicable'], obj),
            siblingapplicablechildassessmentdate: R.pathOr(null, ['SiblingApplicableChildAssessmentDate'], obj),
            siblingadoptiveproviderid: R.pathOr(null, ['SiblingAdoptiveProviderID'], obj),
            siblingname: R.pathOr(null, ['SiblingName'], obj),
          });
        }, R.pathOr([], ['person', 'siblingDetails'], corticon));

        jsonPayload.person_adoptionsiblingdetails = person_adoptionsiblingdetails;
        jsonPayload.person_adoptionminorparentdetails = person_adoptionminorparentdetails;
        let sql = '';
        let result = '';
        var jsonPayloadone = JSON.stringify(jsonPayload);
        var finaljsonpayload = jsonPayloadone.replace(/'/g, "''");
        sql = spiveadoptionauditsql + finaljsonpayload + '\')';
        return util.executeDBQuery(sql, [])
          .then(data => {
            if (data !== null && typeof data !== 'undefined' && data.length > 0) {
              result = { data };
            } else {
              result = { 'data': [] };
            }
            return resolve(result);
          })
          .catch(err => reject(err));
      } catch (error) {
        return reject(error);
      }
    });
  };

  function getfinalResult(corticon) {
    const adoptionapplicable = R.pathOr(null,['status','AdoptionApplicable'],corticon);
    const adoptionnonapplicable = R.pathOr(null,['status','AdoptionNonApplicable'],corticon);
    const adoptiondataincomplete = R.pathOr(null,['status','AdoptionDataIncomplete'],corticon);
    let finalresult = '';

    if (adoptiondataincomplete === 'YES') {
      finalresult = 'Incomplete Data';
    } else {
      if (adoptionapplicable === 'YES' && adoptionnonapplicable === 'YES') {
        finalresult = 'Adoption Applicable and NonApplicable';
      } else if (adoptionapplicable === 'NO' && adoptionnonapplicable === 'NO') {
        finalresult = 'Neither Applicable or NonApplicable';
      } else if (adoptionapplicable === 'YES') {
        finalresult = 'Applicable';
      } else if (adoptionnonapplicable === 'YES') {
        finalresult = 'NonApplicable';
      } else {
        finalresult = 'Error';
      }
    }
    return finalresult;
  }

  const processReDetermination = (payload, transactionid, cjamsPid, removalid, pagesnapshot) => {
    return new Promise(async (resolve, reject) => {
      try {
        const keymap = new Map(
          [
            ['Disability', 'disability'],
            ['MissingInfo', 'missinginfo'],
            ['EAdoption', 'eadoption'],
            ['Final', 'finalresult'],
          ]
        );
        const options = {
          method: 'POST',
          uri: `${app.get('CORTICONAPI')}/axis/corticon/execute`,
          body: payload.payload,
          json: true,
        };
        const resp = await axios.post(options.uri, options.body, {headers: {
                    'Content-Type': 'application/json'
                }});
        const corticonRes = resp.data;
        if(corticonRes && corticonRes.Messages && corticonRes.Messages.Message && corticonRes.Messages.Message.length > 0){
          corticonRes.Messages.Message.forEach((msg) => {
            msg.text = _.replace(msg.text,new RegExp("'s","g"),"s")
          });
        }
        const corticon = corticonRes.Objects[0];
        const jsonPayload = {
          transactionid,
          category: 'R',
          cjamsPid,
          removalid,
          adoptionauditmessages: adoptionAuditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
          childmeetcontinueeligibilitycriteria: R.pathOr(null, ['ChildMeetContinueEligibilityCriteria'], corticon),
          adoptionfinalizationdate: R.pathOr(null, ['AdoptionFinalizationDate'], corticon),
          dateofbirth: R.pathOr(null, ['person', 'DateOfBirth'], corticon),
          childdisabilityevaluationdocumentiondate: R.pathOr(null, ['person', 'ChildDisabilityEvaluationDocumentionDate'], corticon),
          startdateofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'StartDateOfSecondaryEducationOrEquivalentProgram'], corticon),
          nameofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'NameOfpostSecondaryOrVocationalEducation'], corticon),
          countyofjurisdiction_ldss: R.pathOr(null, ['person', 'CountyOfJurisdiction_LDSS'], corticon),
          gender: R.pathOr(null, ['person', 'Gender'], corticon),
          nameofpromotetoemploymentprogram: R.pathOr(null, ['person', 'NameOfPromoteToEmploymentProgram'], corticon),
          childname: R.pathOr(null, ['person', 'Name'], corticon),
          childdisabilitytype: R.pathOr(null, ['person', 'ChildDisabilityType'], corticon),
          startdateofpromotetoemploymentprogram: R.pathOr(null, ['person', 'StartDateOfPromoteToEmploymentProgram'], corticon),
          hourspermonthemployed: R.pathOr(null, ['person', 'HoursPerMonthEmployed'], corticon),
          startdateofemployment: R.pathOr(null, ['person', 'StartDateOfEmployment'], corticon),
          childdisabilitystartdate: R.pathOr(null, ['person', 'ChildDisabilityStartDate'], corticon),
          startdateofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'StartDateOfpostSecondaryOrVocationalEducation'], corticon),
          nameofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'NameOfSecondaryEducationOrEquivalentProgram'], corticon),
          nameofemployer: R.pathOr(null, ['person', 'NameOfEmployer'], corticon),
          isdocumentedphysicalandmentaldisability: R.pathOr(null, ['IsDocumentedPhysicalAndMentalDisability'], corticon),
          adoptionassistance: R.pathOr(null, ['status', 'AdoptionAssistance'], corticon),
          extadoption: R.pathOr(null, ['status', 'EXTAdoption'], corticon),
          inputjson: JSON.stringify(payload.payload),
          outputjson: JSON.stringify(corticonRes),
          pagesnapshot: JSON.stringify(pagesnapshot),
        };

        R.forEach((obj) => {
          const key = keymap.get(obj.Step);
          if (key) {
            jsonPayload[key] = R.path(['ReasonCode'], obj);
          }
        }, R.pathOr([], ['reason'], corticon));

        let sql = '';
        let result = '';

        var jsonPayloadone = JSON.stringify(jsonPayload);
        var finaljsonpayload = jsonPayloadone.replace(/'/g, "''");
        sql = spiveadoptionauditsql + finaljsonpayload + '\')';
        return util.executeDBQuery(sql, [])
          .then(data => {
            if (data !== null && typeof data !== 'undefined' && data.length > 0) {
              result = {
                data,
              };
            } else {
              result = {
                'data': [],
              };
            }
            return resolve(result);
          })
          .catch(err => reject(err));
      } catch (error) {
        return reject(error);
      }
    });
  };

  const processInitialDetermination = (payload, transactionid, cjamsPid, removalid, pagesnapshot) => {
    return new Promise(async (resolve, reject) => {
      try {
        const keymap = new Map(
          [
            ['ChildApplicabilityStatus', 'childapplicabilitystatus'],
            ['AdoptionAssistanceAgreement', 'adoptionassistanceagreement'],
            ['ChildSpecialNeedsDifficultToPlace', 'childspecialneedsdifficulttoplace'],
            ['ChildSpecialNeedsEffortsToPlaceWithoutAssistance', 'childspecialneedseffortstoplacewithoutassistance'],
            ['ChildSpecialNeedsCannotShouldNotReturnToParents', 'childspecialneedscannotshouldnotreturntoparents'],
            ['USCitizen_QualifiedAlien', 'uscitizenqualifiedalien'],
            ['Age', 'age'],
            ['ChildPreviousAdoption', 'childpreviousadoption'],
            ['SSI', 'ssi'],
            ['MinorParent', 'minorparent'],
            ['ChildPlacement', 'childplacement'],
            ['ChildRemovedFromSpecifiedRelative', 'childremovedfromspecifiedrelativeresult'],
            ['ChildDeprivedOfParentalSupport', 'childdeprivedofparentalsupportresult'],
            ['RemovalHouseholdIncomeAndAssets', 'removalhouseholdincomeandassets'],
            ['Final', 'finalresult'],
          ]
        );
        const options = {
          method: 'POST',
          uri: `${app.get('CORTICONAPI')}/axis/corticon/execute`,
          body: payload.payload,
          json: true,
        };
        const resp = await axios.post(options.uri, options.body, {headers: {
                    'Content-Type': 'application/json'
                }});
        const corticonRes = resp.data;
        if(corticonRes && corticonRes.Messages && corticonRes.Messages.Message && corticonRes.Messages.Message.length > 0){
          corticonRes.Messages.Message.forEach((msg) => {
            msg.text = _.replace(msg.text,new RegExp("'s","g"),"s")
          });
        }
        const corticon = corticonRes.Objects[0];
        const jsonPayload = {
          transactionid,
          cjamsPid,
          removalid,
          category: 'I',
          adoptionauditmessages: adoptionAuditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
          dateandtimeofdocumentationforeffortstoplacewithoutsubsidy: R.pathOr(null, ['DateAndTimeOfDocumentationForEffortsToPlaceWithoutSubsidy'], corticon),
          adoptionassistancefutureneedsagreementdateadoptiveparents2: R.pathOr(null, ['AdoptionAssistanceAgreement_FutureNeedsAgreement_Date_AdoptiveParents_2'], corticon),
          adoptionassistancefutureneedsagreementdateadoptiveparents1: R.pathOr(null, ['AdoptionAssistanceAgreement_FutureNeedsAgreement_Date_AdoptiveParents_1'], corticon),
          adoptionassistanceagreementfutureneedsagreementdateagency: R.pathOr(null, ['AdoptionAssistanceAgreement_FutureNeedsAgreement_Date_Agency'], corticon),
          adoptionfinalizationdate: R.pathOr(null, ['AdoptionFinalizationDate'], corticon),
          childapplicableassessmentdate: R.pathOr(null, ['ChildApplicableAssessmentDate'], corticon),
          adoptionpetitionfileddate: R.pathOr(null, ['AdoptionPetitionFiledDate'], corticon),
          dateandtimeofdocumentationforexceptiongrantedinchildsbestinterests: R.pathOr(null, ['DateAndTimeOfDocumentationForExceptionGrantedInChildsBestInterests'], corticon),
          adoptionassistancestartdate: R.pathOr(null, ['AdoptionAssistanceStartDate'], corticon),
          tprgrantedtobothparent: R.pathOr(null, ['TPRGrantedtoBothParent'], corticon),
          anotherreasonforchildnotreturninghome: R.pathOr(null, ['AnotherReasonForChildNotReturningHome'], corticon),
          isreasonforexceptionrecorded: R.pathOr(null, ['IsReasonForExceptionRecorded'], corticon),
          qualifiedalien: R.pathOr(null, ['QualifiedAlien'], corticon),
          reasonfornotgrantingtprforparent: R.pathOr(null, ['ReasonForNotGrantingTPRForParent'], corticon),
          uscitizen: R.pathOr(null, ['USCitizen'], corticon),
          clientid: R.pathOr(null, ['applicantInformation', 'ClientID'], corticon),
          childhasfosterparentemotionalties: R.pathOr(null, ['person', 'ChildHasFosterParentEmotionalTies'], corticon),
          incomeandassetsmetafdcstandards: R.pathOr(null, ['person', 'IncomeAndAssetsMetAFDCStandards'], corticon),
          childadoptionunsuccessfuleffortstoplace: R.pathOr(null, ['person', 'ChildAdoptionUnsuccessfulEffortsToPlace'], corticon),
          childraceethnicity: R.pathOr(null, ['person', 'ChildRaceEthnicity'], corticon),
          gender: R.pathOr(null, ['person', 'Gender'], corticon),
          childhashighriskofdisability: R.pathOr(null, ['person', 'ChildHasHighRiskOfDisability'], corticon),
          childname: R.pathOr(null, ['person', 'Name'], corticon),
          childremovaldate: R.pathOr(null, ['person', 'Child_Removal_Date'], corticon),
          childremovedfromspecifiedrelative: R.pathOr(null, ['person', 'ChildRemovedFromSpecifiedRelative'], corticon),
          childdeprivedOfparentalsupport: R.pathOr(null, ['person', 'ChildDeprivedOfParentalSupport'], corticon),
          childcanreturntohome: R.pathOr(null, ['person', 'ChildCanReturnToHome'], corticon),
          childexpectedadoptiveproviderid: R.pathOr(null, ['person', 'ChildExpectedAdoptiveProviderID'], corticon),
          childhasemotionaldisturbance: R.pathOr(null, ['person', 'ChildHasEmotionalDisturbance'], corticon),
          childcurrentivefostercareeligibilitystatus: R.pathOr(null, ['person', 'ChildCurrentIVEFosterCareEligibilityStatus'], corticon),
          dateofbirth: R.pathOr(null, ['person', 'DateOfBirth'], corticon),
          removalcourtorderdate: R.pathOr(null, ['person', 'Removal_Court_Order_Date'], corticon),
          childpreviousadoptiveparenttprdate: R.pathOr(null, ['person', 'ChildPreviousAdoptiveParentTPRDate'], corticon),
          childphysicaladdress: R.pathOr(null, ['person', 'ChildPhysicalAddress'], corticon),
          childmeetsssimedicaldisabledeligreqts: R.pathOr(null, ['person', 'ChildMeetsSSIMedicalDisabledEligReqts'], corticon),
          voluntaryrelinquishment: R.pathOr(null, ['person', 'VoluntaryRelinquishment'], corticon),
          childssieligibilitystatusonorbeforedateofadoption: R.pathOr(null, ['person', 'ChildSSIEligibilityStatusOnOrBeforeDateOfAdoption'], corticon),
          childpreviousadoptiveparentdeathdate: R.pathOr(null, ['person', 'ChildPreviousAdoptiveParentDeathDate'], corticon),
          childhasphysicalmentalemotionaldisability: R.pathOr(null, ['person', 'ChildHasPhysicalMentalEmotionalDisability'], corticon),
          countyofjurisdictionldss: R.pathOr(null, ['person', 'CountyOfJurisdiction_LDSS'], corticon),
          startdateofreceivingssi: R.pathOr(null, ['person', 'StartDateOfReceivingSSI'], corticon),
          childpreviousadoptionivestatus: R.pathOr(null, ['person', 'ChildPreviousAdoptionIVEStatus'], corticon),
          childexpectedadoptiondate: R.pathOr(null, ['person', 'ChildExpectedAdoptionDate'], corticon),
          childreceivingssiatremoval: R.pathOr(null, ['person', 'ChildReceivingSSIAtRemoval'], corticon),
          childpreviouslyadopted: R.pathOr(null, ['person', 'ChildPreviouslyAdopted'], corticon),
          dideffortstoplacechildweremade: R.pathOr(null, ['DidEffortsToPlaceChildWereMade'], corticon),
          singleparentadoptioncheck: R.pathOr(null, ['SingleParentAdoptionCheck'], corticon),
          dateoftprofparent_2: R.pathOr(null, ['DateOfTPROfParent_2'], corticon),
          dateoftprofparent_1: R.pathOr(null, ['DateOfTPROfParent_1'], corticon),
          adoptionassistance: R.pathOr(null, ['status', 'AdoptionAssistance'], corticon),
          adoptionapplicable: R.pathOr(null, ['status', 'AdoptionApplicable'], corticon),
          adoptionnonapplicable: R.pathOr(null, ['status', 'AdoptionNonApplicable'], corticon),
          inputjson: JSON.stringify(payload.payload),
          outputjson: JSON.stringify(corticonRes),
          pagesnapshot: JSON.stringify(pagesnapshot),
        };

        const person_adoptionminorparentdetails = [];
        R.forEach((obj) => {
          person_adoptionminorparentdetails.push({
            minorparentremovaldate: R.pathOr(null, ['MinorParentRemovalDate'], obj),
            minorparentname: R.pathOr(null, ['MinorParentName'], obj),
            minorparentcurrentplacementtype: R.pathOr(null, ['MinorParentCurrentPlacementType'], obj),
            minorparentdateofbirth: R.pathOr(null, ['MinorParentDateOfBirth'], obj),
            minorparentremovalcourtorderdate: R.pathOr(null, ['MinorParentRemovalCourtOrderDate'], obj),
            minorparentiveeligibilityforfostercarestatus: R.pathOr(null, ['MinorParentIVEEligibilityForFosterCareStatus'], obj),
            minorparentiveeligibilityforfostercarestartdate: R.pathOr(null, ['MinorParentIVEEligibilityForFosterCareStartDate'], obj),
            dateoflatestpaymentofminorparentiveeligibilityforfostercare: R.pathOr(null, ['DateOfLatestPaymentOfMinorParentIVEEligibilityForFosterCare'], obj),
            minorparentphysicaladdress: R.pathOr(null, ['MinorParentPhysicalAddress'], obj),
          });
        }, R.pathOr([], ['person', 'parentDetails'], corticon));

        const person_adoptionsiblingdetails = [];
        R.forEach((obj2) => {
          person_adoptionsiblingdetails.push({
            siblingadoptiondecreedate: R.pathOr(null, ['SiblingAdoptionDecreeDate'], obj2),
            siblingadoptionapplicable: R.pathOr(null, ['SiblingAdoptionApplicable'], obj2),
            siblingapplicablechildassessmentdate: R.pathOr(null, ['SiblingApplicableChildAssessmentDate'], obj2),
            siblingadoptiveproviderid: R.pathOr(null, ['SiblingAdoptiveProviderID'], obj2),
            siblingname: R.pathOr(null, ['SiblingName'], obj2),
          });
        }, R.pathOr([], ['person', 'siblingDetails'], corticon));

        R.forEach((obj1) => {
          const key = keymap.get(obj1.Step);
          if (key) {
            jsonPayload[key] = R.path(['ReasonCode'], obj1);
          }
        }, R.pathOr([], ['reason'], corticon));
        jsonPayload.person_adoptionsiblingdetails = person_adoptionsiblingdetails;
        jsonPayload.person_adoptionminorparentdetails = person_adoptionminorparentdetails;
        let sql = '';
        let result = '';

        var jsonPayloadone = JSON.stringify(jsonPayload);
        var finaljsonpayload = jsonPayloadone.replace(/'/g, "''");
        sql = spiveadoptionauditsql + finaljsonpayload + '\')';
        return util.executeDBQuery(sql, [])
          .then(spiveadoptionauditdata => {
            if (spiveadoptionauditdata !== null && typeof spiveadoptionauditdata !== 'undefined' && spiveadoptionauditdata.length > 0) {
              result = {
                'data': spiveadoptionauditdata,
              };
            } else {
              result = {
                'data': [],
              };
            }
            return resolve(result);
          })
          .catch(err => reject(err));
      } catch (error) {
        return reject(error);
      }
    });
  };

  
  const adoptionAuditMessages = (messages) => {
    const result = [];
    R.forEach((msg) => {
      result.push({
        severity: msg.severity,
        message: msg.text,
      });
    }, messages);

    return result;
  };
  
  IVEADOPTION.adoptionAudit = (data) => {
    try {
      if (data && data.cjamsPid && data.removalid && (data.initialDetermination || data.reDetermination || data.applicability)) {
        const processJobsArray = [];
        const transactionid = uuidv4();
        let removalIDforAdoption;
        
        if (data.removalid == 'null') {
          removalIDforAdoption = null;
        } else {
          removalIDforAdoption = data.removalid;
        }

        if (data.initialDetermination) {
          processJobsArray.push(processInitialDetermination(data.initialDetermination, transactionid, data.cjamsPid, removalIDforAdoption, data.pagesnapshot));
        }
        
        if (data.reDetermination) {
          processJobsArray.push(processReDetermination(data.reDetermination, transactionid, data.cjamsPid, removalIDforAdoption, data.pagesnapshot));
        }

        if (data.applicability) {
          processJobsArray.push(processApplicability(data.applicability, transactionid, data.cjamsPid, data.removalid, data.approvalid, data.pagesnapshot));
        }

        return Promise.all(processJobsArray)
          .then((result) => {
            return result;
          })
          .catch((err) => {
            throw err;
          });
      } else {
        throw new Error('Invalid payload');
      }
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  IVEADOPTION.adoptionHistory = (clientId) => {
    try {
      let sql = '';
      let result = '';
      sql = `select tce.client_id as clientid, tce.adoption_id, p.dob as dateofbirth , CONCAT(p.firstname, ' ', p.middlename, ' ', p.lastname)::VARCHAR as childname, ac.adoptioncaseid as adoptioncaseid,ac.startdate as adoptionstartdt,
      p.gendertypekey as removalage,tce.start_dt, tce.end_dt, tce.case_id as casenumber, p.personid,
      (select isrcr.removalid from intakeservreqchildremoval isrcr 
        join intakeservicerequestactor iat on iat.intakeservicerequestactorid = apl.intakeservicerequestactorid and iat.activeflag = 1
        where isrcr.personid = iat.personid 
        --and isrcr.removalexitreason in ('AF','ADPFIN','ADPL') 
        and isrcr.activeflag = 1 order by isrcr.updatedon desc limit 1),
       aca.parent1providerid, aca.parent1providername, aca.parent2providername ,
      (select c.countyname  from caseassignment ca join county c on c.countyid = ca.toldssid and c.activeflag =1
       where ca.objectid = ac.adoptioncaseid and ca.enddate is null order by ca.insertedon desc limit 1) ::character varying as childjurisdiction,
       (select r.tosecurityusersid from routing r where r.activeflag=1 AND r.eventcode='ABLR' and r.toroleid in ('IVESP','IVEEA') AND 
        r.routingstatustypeid::text = '67' and r.objectid :: character varying = adbl.adoptionbreakthelinkid :: character varying order by r.insertedon desc limit 1) as iveadoptionassigneduser  
      from tb_client_eligibility tce INNER JOIN person p ON p.cjamspid=tce.client_id AND p.activeflag=1 
      LEFT JOIN adoptionplanning apl on apl.alternateid = tce.adoption_id and apl.activeflag = 1
      LEFT JOIN adoptionbreakthelink adbl on apl.adoptionplanningid = adbl.adoptionplanningid and adbl.activeflag = 1
      INNER JOIN adoptioncase ac on ac.adoptioncasenumber = tce.case_id::character varying and ac.activeflag = 1
      INNER JOIN adoptioncaseagreement aca on aca.adoptioncaseid = ac.adoptioncaseid and aca.activeflag = 1
      LEFT JOIN servicecase sc on sc.servicecaseid = apl.servicecaseid and sc.activeflag = 1
      where tce.eligibility_type_cd = '2934' and tce.client_id::int = $1`;
      return util.executeDBQuery(sql, [clientId])
        .then(data => {
          if (data !== null && typeof data !== 'undefined' && data.length > 0) {
            result = {
              data,
            };
          } else {
            result = {
              'data': [],
            };
          }
          return result.data;
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  IVEADOPTION.remoteMethod('updatestatus', {
    http: {
      path: '/updatestatus',
      verb: 'post'
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    }],
    returns: {
      type: 'string',
      root: true
    }
  });

  
  IVEADOPTION.remoteMethod(
    'adoptionAcaWorksheet', {
      description: 'Get adoption eligibilty worksheet by client id',
      accepts: [{
        arg: 'clientId',
        type: 'number',
        http: {
          source: 'path',
        },
        required: true,
      }, {
        arg: 'removalId',
        type: 'number',
        http: {
          source: 'path',
        },
        required: true,
      }],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/adoption/adoption-aca-worksheet/:clientId/:removalId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  
IVEADOPTION.remoteMethod(
  'saveadoptioninitialdata', {
    description: 'Adoption Applicability API',
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
      path: '/adoption/saveadoptiondata',
      verb: 'post',
      status: 200,
      errorStatus: 400,
      contentType: jsoncontenttype,
    },
  }
);





  IVEADOPTION.remoteMethod(
    'adoptionEligibilityWorksheet', {
      description: 'Get adoption eligibilty worksheet by client id',
      accepts: [{
        arg: 'clientId',
        type: 'number',
        http: {
          source: 'path',
        },
        required: true,
      }, {
        arg: 'removalId',
        type: 'number',
        http: {
          source: 'path',
        },
        required: true,
      }],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/adoption/adoption-eligibility-worksheet/:clientId/:removalId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEADOPTION.remoteMethod(
    'adoptionApplicabilityDecision', {
      description: 'Get adoption applicability decision by client id',
      accepts: [{
        arg: 'clientId',
        type: 'number',
        http: {
          source: 'path',
        },
        required: true,
      }, {
        arg: 'removalId',
        type: 'number',
        http: {
          source: 'path',
        },
        required: true,
      }],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/adoption/adoption-applicability-decision/:clientId/:removalId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEADOPTION.remoteMethod(
    'adoptionApplicability', {
      description: 'Adoption Applicability API',
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body',
        },
        required: true,
      },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/adoption/adoption-applicability',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEADOPTION.remoteMethod(
    'gatAdoptionAuditMessagesByAuditId', {
      description: 'Get Adoption Audit Messages By Audit Id API',
      accepts: [{
        arg: 'adoptionAuditId',
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
        path: '/adoption/audit-messages/:adoptionAuditId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEADOPTION.remoteMethod(
    'adoptionAudit', {
      description: 'Adoption Audits API',
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
        path: '/adoption/audit',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEADOPTION.remoteMethod(
    'adoptionHistory', {
      description: 'Get gap History by client id',
      accepts: [{
        arg: 'clientId',
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
        path: '/adoption/adoption-history/:clientId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

}
