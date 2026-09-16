'use strict';
const errorUtils = require('../../server/utils/error-utils');
var app = require('../../server/server');
const R = require('ramda');
const axios = require('axios');
const { v4: uuidv4 } = require('uuid');
const invalidinputmsg = 'sent invalid inputs';
const jsoncontenttype = 'application/json';
const util = require('../utils/utils');
const LOGGER = require('log4js').getLogger("utils");

module.exports = function (IVEGAP) {

  const getDemographicsInfo = (clientId, removalId, ds) => {
      const res = {};
      res.demographicsInfo = [];
      const sql = `select * from sp_gap_worksheet_demographics_info($1, $2)`;

      return util.executeDBQuery(sql, [clientId, removalId])
        .then(data => {
            if (data !== null && typeof data !== 'undefined' && data.length > 0) {
                res.demographicsInfo = data;
            } 
            return res;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
  };


  const getMinorParentSiblingInfo = (clientId, removalId , ds, result) => {
      const res = result;
      res.minorParentSiblingInfo = [];
      const sql = `select * from sp_get_minor_parent_siblings($1)`;
      return util.executeSecondaryNodeDBQuery(sql, [clientId])
        .then(data => {
            if (data !== null && typeof data !== 'undefined' && data.length > 0) {
                res.minorParentSiblingInfo = data;
            } 
            return res;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
  };

  IVEGAP.gapEligibilityWorksheet = (clientId, removalId) => {
    try {
      const ds = app.dataSources.hcuewelfare;

      return getDemographicsInfo(clientId, removalId, ds)
        .then((result) => {
          return getMinorParentSiblingInfo(clientId, removalId, ds, result);
        })
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

  const gapAuditMessages = (messages) => {
    const result = [];
    R.forEach((msg) => {
      result.push({severity: msg.severity, message: msg.text});
    }, messages);

    return result;
  };

  const processInitialDetermination = (payload, transactionid, cjamsPid, removalid, pagesnapshot, guardiansubsidyid) => {
    return new Promise(async (resolve, reject) => {
      try {
        const keymap = new Map(
          [
            ['MissingInfo', 'missinginfo'],
            ['GAPV', 'gapv'],
            ['GR', 'gr'],
            ['SA', 'sa'],
            ['HHCheck', 'hhcheck'],
            ['HHDetails', 'hhdetails'],
            ['4EReimb', 'ivereimb'],
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
        const corticon = corticonRes.Objects[0];
        const jsonPayload = {
          transactionid,
          cjamsPid,
          category: 'I',
          removalid,
          guardiansubsidyid: guardiansubsidyid,
          gapauditmessages: gapAuditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
          childsecondguardianattachment: R.pathOr(null, ['secondGuardian', 'Child_Second_Guardian_Attachment'], corticon),
          sg_numberofadditionalhouseholdmembers: R.pathOr(null, ['secondGuardian', 'SecondGuardianNumberOfAdditionalHouseholdMembers'], corticon),
          sg_nationalandstatecriminalhistorybackgroundcheck: R.pathOr(null, ['secondGuardian', 'SG_National_and_state_criminal_history_background_check'], corticon),
          sg_childabuseandmaltreatmentdatabasecheck: R.pathOr(null, ['secondGuardian', 'SG_Child_abuse_and_maltreatment_data_base_check'], corticon),
          sg_relationshipid: R.pathOr(null, ['secondGuardian', 'SecondGuardianRelationshipID'], corticon),
          sg_agreementsigneddate: R.pathOr(null, ['secondGuardian', 'SecondaryGuardianshipAgreementSignedDate'], corticon),
          sg_dateofnationalandstatecriminalhistorybackgroundcheck: R.pathOr(null, ['secondGuardian', 'SG_DateOf_National_and_state_criminal_history_background_check'], corticon),
          livingwithprimaryguardian: R.pathOr(null, ['secondGuardian', 'LivingWithPrimaryGuardian'], corticon),
          sg_dateofchildabuseandmaltreatmentdatabasecheck: R.pathOr(null, ['secondGuardian', 'SG_Date_Of_Child_abuse_and_maltreatment_data_base_check'], corticon),
          sg_applicablechildwelfareagenciesinthepreviousstates: R.pathOr(null, ['secondGuardian', 'SG_Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information'], corticon),
          childsecondguardianid: R.pathOr(null, ['secondGuardian', 'ChildSecondGuardianID'], corticon),
          sg_outofstatewithinpast5years: R.pathOr(null, ['secondGuardian', 'SG_Out_of_state_within_past_5_years_of_the_application_for_GAP'], corticon),
          sg_dateofchildabuseandmaltreatmentdatabasecheckoutofstate: R.pathOr(null, ['secondGuardian', 'SG_Date_Of_Child_abuse_and_maltreatment_data_base_check_OutOfState'], corticon),
          guardianshipapplicationdate: R.pathOr(null, ['GuardianshipApplicationDate'], corticon),
          guardianshipagreementsigneddate: R.pathOr(null, ['GuardianshipAgreementSignedDate'], corticon),
          relationshipid: R.pathOr(null, ['applicantInformation', 'RelationshipID'], corticon),
          guardiancommitmentforpermanentchildcare: R.pathOr(null, ['applicantInformation', 'Guardian_Commitment_For_Permanent_Child_Care'], corticon),
          clientid: R.pathOr(null, ['applicantInformation', 'ClientID'], corticon),
          dateofbirth: R.pathOr(null, ['person', 'DateOfBirth'], corticon),
          removalcourtorderdate: R.pathOr(null, ['person', 'Removal_Court_Order_Date'], corticon),
          appropriatepermanencyforchildoption1notbeingreturnedhome: R.pathOr(null, ['person', 'Appropriate_Permanency_For_Child_Option_1_Not_Being_Returned_Home'], corticon),
          countyofjurisdiction_ldss: R.pathOr(null, ['person', 'CountyOfJurisdiction_LDSS'], corticon),
          childguardianattachment: R.pathOr(null, ['person', 'Child_Guardian_Attachment'], corticon),
          childguardianid: R.pathOr(null, ['person', 'ChildGuardianID'], corticon),
          gender: R.pathOr(null, ['person', 'Gender'], corticon),

          name: R.pathOr(null, ['person', 'Name'], corticon),
          childremovaldate: R.pathOr(null, ['person', 'Child_Removal_Date'], corticon),

          ageappropriateconsultation: R.pathOr(null, ['person', 'Age_Appropriate_Consultation_Taken_Place_With_the_Child'], corticon),
          secondguardianexists: R.pathOr(null, ['person', 'SecondGuardianExists'], corticon),

          appropriatepermanencyforchildoption2notbeingadopted: R.pathOr(null, ['person', 'Appropriate_Permanency_For_Child_Option_2_Not_Being_Adopted'], corticon),
          successorguardianexists: R.pathOr(null, ['person', 'SuccessorGuardianExists'], corticon),

          guardianshipfinalizationdate: R.pathOr(null, ['GuardianshipFinalizationDate_FinalizationDateOfCourtOrder'], corticon),
          nameofsuccessorguardian: R.pathOr(null, ['successorGuardian', 'NameOfSuccessorGuardian'], corticon),
          childsuccessorguardianid: R.pathOr(null, ['successorGuardian', 'ChildSuccessorGuardianID'], corticon),
          dateofsuccessionaddendum: R.pathOr(null, ['successorGuardian', 'DateOfSuccessionAddendum'], corticon),

          numberofadditionalhouseholdmembers: R.pathOr(null, ['NumberOfAdditionalHouseholdMembers'], corticon),
          gapeligibilitystatus: R.pathOr(null, ['status', 'GAPEligibilityStatus'], corticon),
          inputjson: JSON.stringify(payload.payload),
          outputjson: JSON.stringify(corticonRes),
          pagesnapshot: JSON.stringify(pagesnapshot),
        };

        const householdmember = [];
        R.forEach((obj) => {
          householdmember.push({
            nationalandstatecriminalhistorybackgroundcheck_hh: R.pathOr(null, ['National_and_state_criminal_history_background_check_HH'], obj),
            applicablechildwelfareagenciesinthepreviousstatescontactedtoobtainchildabuseandmaltreatmentinformation: R.pathOr(null, ['Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information_HH'], obj),
            outofstatewithinpast5yearsoftheapplicationforgap: R.pathOr(null, ['Out_of_state_within_past_5_years_of_the_application_for_GAP_HH'], obj),
            dateofbirthofhouseholdmember: R.pathOr(null, ['DateOfBirthOfHouseholdMember'], obj),
            childabuseandmaltreatmentdatabasecheck_hh: R.pathOr(null, ['Child_abuse_and_maltreatment_data_base_check_HH'], obj),
          });
        }, R.pathOr([], ['householdMember'], corticon));

        const sg_householdmembers = [];
        R.forEach((obj) => {
          sg_householdmembers.push({
            sg_dateofbirthofhouseholdmember: R.pathOr(null, ['SG_DateOfBirthOfHouseholdMember'], obj),
            sg_nationalandstatecriminalhistorybackgroundcheck: R.pathOr(null, ['SG_National_and_state_criminal_history_background_check_HH'], obj),
            sg_outofstatewithinpast5yearsoftheapplicationforgap: R.pathOr(null, ['SG_Out_of_state_within_past_5_years_of_the_application_for_GAP_HH'], obj),
            sg_applicablechildwelfareagenciesinthepreviousstatescontactedtoobtainchildabuseandmaltreatmentinformation: R.pathOr(null, ['SG_Applicable_child_welfare_agencies_in_the_previous_states_contacted_to_obtain_child_abuse_and_maltreatment_information_HH'], obj),
            sg_dateofchildabuseandmaltreatmentdatabasecheckoutofstate: R.pathOr(null, ['SG_Date_Of_Child_abuse_and_maltreatment_data_base_check_OutOfState_HH'], obj),
            sg_dateofnationalandstatecriminalhistorybackgroundcheck: R.pathOr(null, ['SG_DateOf_National_and_state_criminal_history_background_check_HH'], obj),
            sg_childabuseandmaltreatmentdatabasecheck: R.pathOr(null, ['SG_Child_abuse_and_maltreatment_data_base_check_HH'], obj),
            sg_dateofchildabuseandmaltreatmentdatabasecheck: R.pathOr(null, ['SG_Date_Of_Child_abuse_and_maltreatment_data_base_check_HH'], obj),
          });
        }, R.pathOr([], ['secondGuardian', 'secondGuardianHouseholdMembers'], corticon));

        const person_siblingdetails = [];
        R.forEach((obj) => {
          person_siblingdetails.push({
            sibling_gap_eligiblitystatus: R.pathOr(null, ['SiblingGAPEligiblityStatus'], obj),
            siblingname: R.pathOr(null, ['SiblingName'], obj),
            siblingguardianid: R.pathOr(null, ['SiblingGuardianID'], obj),
          });
        }, R.pathOr([], ['person', 'siblingDetails'], corticon));

        const person_licensedfosterhome = [];
        R.forEach((obj) => {
          person_licensedfosterhome.push({
            lastsixmonthfiscalcodeandpaymentstatus: R.pathOr(null, ['LastSixMonthFiscalCodeandPaymentStatus'], obj),
            dateofnationalandstatecriminalhistorybackgroundcheck: R.pathOr(null, ['DateOf_National_and_state_criminal_history_background_check'], obj),
            dateoffullapproval_fp: R.pathOr(null, ['DateOfFullApprovalFP'], obj),
            nationalandstatecriminalhistorybackgroundcheck: R.pathOr(null, ['National_and_state_criminal_history_background_check'], obj),
            outofstatewithinpast5yearsoftheapplicationfor_gap: R.pathOr(null, ['Out_of_state_within_past_5_years_of_the_application_for_GAP'], obj),
            dateofchildabuseandmaltreatmentdatabasecheckoutofstate: R.pathOr(null, ['Date_Of_Child_abuse_and_maltreatment_data_base_check_OutOfState'], obj),
            latestfostercareplacementstartdatewithperpectiveguardian: R.pathOr(null, ['LatestFosterCarePlacementStartDateWithPerpectiveGuardian'], obj),
            applicablechildwelfareagenciesinthepreviousstatescontacted: R.pathOr(null, ['DateOf_National_and_state_criminal_history_background_check'], obj),
            dateofchildabuseandmaltreatmentdatabasecheck: R.pathOr(null, ['Date_Of_Child_abuse_and_maltreatment_data_base_check'], obj),
            fosterhomeapprover: R.pathOr(null, ['FosterHome_Approver'], obj),
            childabuseandmaltreatmentdatabasecheck: R.pathOr(null, ['Child_abuse_and_maltreatment_data_base_check'], obj),
          });
        }, R.pathOr([], ['person', 'licensedFosterHome'], corticon));

        R.forEach((obj) => {
          const key = keymap.get(obj.Step);
          if (key) {
            jsonPayload[key] = R.path(['ReasonCode'], obj);
          }
        }, R.pathOr([], ['reason'], corticon));
        jsonPayload.householdmember = householdmember;
        jsonPayload.sg_householdmembers = sg_householdmembers;
        jsonPayload.person_siblingdetails = person_siblingdetails;
        jsonPayload.person_licensedfosterhome = person_licensedfosterhome;

        let sql = '';
        let result = '';
        var jsonPayloadone = JSON.stringify(jsonPayload);
        var finaljsonpayload = jsonPayloadone.replace(/'/g, "''");
        sql = 'select * from sp_ive_gap_audit(\'' + finaljsonpayload + '\')';
        util.executeDBQuery(sql, []).then(data => {
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
        }).catch(err => reject(err));
      } catch (error) {
        return reject(error);
      }
    });
  };

  const processReDetermination = (payload, transactionid, cjamsPid, removalid, pagesnapshot, guardiansubsidyid) => {
    return new Promise(async (resolve, reject) => {
      try {
        const keymap = new Map(
          [
            ['MissingInfo', 'missinginfo'],
            ['EGAPV', 'egapv'],
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
        const corticon = corticonRes.Objects[0];
        const jsonPayload = {
          transactionid,
          category: 'R',
          cjamsPid,
          removalid,
          guardiansubsidyid: guardiansubsidyid,
          gapauditmessages: gapAuditMessages(R.pathOr([], ['Messages', 'Message'], corticonRes)),
          childmeetcontinueeligibilitycriteria: R.pathOr(null, ['ChildMeetContinueEligibilityCriteria'], corticon),
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
          clientid: cjamsPid,
          hourspermonthemployed: R.pathOr(null, ['person', 'HoursPerMonthEmployed'], corticon),
          startdateofemployment: R.pathOr(null, ['person', 'StartDateOfEmployment'], corticon),
          childdisabilitystartdate: R.pathOr(null, ['person', 'ChildDisabilityStartDate'], corticon),
          startdateofpostsecondaryorvocationaleducation: R.pathOr(null, ['person', 'StartDateOfpostSecondaryOrVocationalEducation'], corticon),
          nameofsecondaryeducationorequivalentprogram: R.pathOr(null, ['person', 'NameOfSecondaryEducationOrEquivalentProgram'], corticon),
          nameofemployer: R.pathOr(null, ['person', 'NameOfEmployer'], corticon),
          guardianshipfinalizationdate: R.pathOr(null, ['GuardianshipFinalizationDate_FinalizationDateOfCourtOrder'], corticon),
          gapeligibilitystatus: R.pathOr(null, ['status', 'GAPEligibilityStatus'], corticon),
          extgapeligibilitystatus: R.pathOr(null, ['status', 'EXTGAPEligibilityStatus'], corticon),
          inputjson: JSON.stringify(payload.payload),
          outputjson: JSON.stringify(corticonRes),
          pagesnapshot: JSON.stringify(pagesnapshot),
        };

        R.forEach((obj1) => {
          const key = keymap.get(obj1.Step);
          if (key) {
            jsonPayload[key] = R.path(['ReasonCode'], obj1);
          }
        }, R.pathOr([], ['reason'], corticon));

        let sql = '';
        let result = '';
        var jsonPayloadone = JSON.stringify(jsonPayload);
        var finaljsonpayload = jsonPayloadone.replace(/'/g, "''");
        sql = 'select * from sp_ive_gap_audit(\'' + finaljsonpayload + '\')';

        util.executeDBQuery(sql, []).then(data1 => {
          if (data1 !== null && typeof data1 !== 'undefined' && data1.length > 0) {
            result = { data : data1 };
          } else {
            result = { 'data': [] };
          }
          return resolve(result);
        }).catch(err => reject(err));
      } catch (error) {
        return reject(error);
      }
    });
  };

  IVEGAP.gapAudit = (data) => {
    try {
      if (data && data.cjamsPid && (data.initialDetermination || data.reDetermination)) {
        const processJobsArray = [];
        const transactionid = uuidv4();
        if (data.initialDetermination) {
          processJobsArray.push(processInitialDetermination(data.initialDetermination, transactionid, data.cjamsPid, data.removalid, data.pagesnapshot, data.guardiansubsidyid));
        }

        if (data.reDetermination) {
          processJobsArray.push(processReDetermination(data.reDetermination, transactionid, data.cjamsPid, data.removalid, data.pagesnapshot, data.guardiansubsidyid));
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

  IVEGAP.updateSiblingInformation = (data) => {
    try {
      let noClientId = false;
      data.forEach((item) => {
        if (!item.toclientid) {
          noClientId = true;
        }
      });
      if (!data || noClientId) {
        throw new Error(invalidinputmsg);
      }
      let result = '';
      const sql = 'SELECT * FROM sp_gap_worksheet_sibling_info($1)';
      return util.executeDBQuery(sql, [JSON.stringify(data)]).then(data2 => {
        if (data2 !== null && typeof data2 !== 'undefined' && data2.length > 0) {
          result = { data : data2 };
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

  IVEGAP.deleteSiblingInformation = (data) => {
    try {
      let result = '';
      const sql = 'DELETE FROM ivesiblinginfo WHERE ivesiblinginfoid = $1'
      return util.executeDBQuery(sql, [data.ivesiblinginfoid]).then(data3 => {
        if (data3 !== null && typeof data3 !== 'undefined' && data3.length > 0) {
          result = { data : data3 };
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

  IVEGAP.getsignatureinfo = (data) => {
     if (!data && !data.eligibilityperiodid) {
            throw new Error(invalidinputmsg);
      }
      let result = '';
      const sql = 'select tpe.supervisorname, tpe.supervisorsubmissiondate, tpe.supervisorsignature, tpe.specialistname, tpe.specialistsubmissiondate , tpe.specialistsignature from tb_client_eligibility tce join tb_eligibility_period tpe on tpe.eligibility_id = tce.eligibility_id and tpe.eligibility_period_id = $1 where tce.eligibility_type_cd = \'2935\' and tce.delete_sw = \'N\' and tce.client_id = $2'
        return util.executeSecondaryNodeDBQuery(sql,[data.eligibilityperiodid, data.clientid])
        .then(data4 => {
            if (data4 !== null && typeof data4 !== 'undefined' && data4.length > 0) {
                result = { data : data4 };
            } else {
                result = { 'data': [] };
            }
          return result;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
}

IVEGAP.updateIVESignature = (data) => {
    try {
        let result = '';
        let username;
        let usersignature;
        let usersignaturedate;
        
        var sql = '';
        if (data && data.roletype === 'IVESV' || data.roletype === 'IVEQA' || data.roletype === 'IVEADMIN') {
            sql = 'update tb_eligibility_period tep set supervisorname = $1, supervisorsignature = $2, supervisorsubmissiondate = $3 where tep.eligibility_period_id = $4'; 

            username = data.supervisorname;
            usersignature = data.supervisorsign;
            usersignaturedate = data.supervisorsigndt;
        } else if (data && data.roletype === 'IVESP' || data && data.roletype === 'IVEEA') {
            sql = 'update tb_eligibility_period tep set specialistname = $1, specialistsignature = $2, specialistsubmissiondate = $3 where tep.eligibility_period_id = $4'; 
            
            username = data.specalistname;
            usersignature = data.specalistsign;
            usersignaturedate = data.specalistsigndt;
        }  
        return util.executeDBQuery(sql, [username, usersignature, usersignaturedate, data.periodid]).then(data5 => {
            result = {
                'message': 'Signature Updated successfully',
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

  IVEGAP.gatGapAuditMessagesByAuditId = (eligibilityperiodid) => {
    let result = '';
    const sql = `select m.cjamspid, m.gapauditid, m.severity, m.message from tb_gapaudit_messages m join tb_ive_gapaudit g on g.gapauditid = m.gapauditid join tb_eligibility_period tep on tep.eligibility_period_id = g.eligibility_period_id where tep.eligibility_period_id = ${eligibilityperiodid}`;
          
    return util.executeSecondaryNodeDBQuery(sql)
        .then(data6 => {
        if (data6 !== null && typeof data6 !== 'undefined' && data6.length > 0) {
          result = { data : data6 };
        } else {
          result = { 'data': [] };
        }
        return result;
      }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
      });
  };

  IVEGAP.gapHistory = (clientId) => {

    let result = '';
    const sql = `select distinct tce.client_id, tce.guardian_subsidy_id, tce.start_dt, tce.end_dt , tce.case_id,
          (select r.tosecurityusersid from routing r INNER JOIN gapagreement ga on r.objectid::varchar = ga.gapagreementid::varchar AND ga.activeflag = 1
          INNER JOIN guardianship g on ga.gapid = g.gapid where r.activeflag=1 AND r.eventcode='GAAR' AND r.routingstatustypeid::text = '73' and
          r.toroleid in ('IVESP','IVEEA') and g.alternateid = tce.guardian_subsidy_id order by r.insertedon desc limit 1) as ivegapassigneduser
          from tb_client_eligibility tce where tce.eligibility_type_cd = '2935' and tce.client_id = $1`;

    return util.executeSecondaryNodeDBQuery(sql, [clientId])
        .then(data6 => {    // NOSONAR
        if (data6 !== null && typeof data6 !== 'undefined' && data6.length > 0) {
          result = { data : data6 };
        } else {
          result = { 'data': [] };
        }
        return result.data;
      }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
      });
  };

  IVEGAP.getguardianinfo = (data) => {
    try {
        if (!data && !data.providerapprovalid) {
            throw new Error(invalidinputmsg);
        }
        
        if (typeof data.providerapprovalid === 'string' && data.providerapprovalid.trim() === '') {
            data.providerapprovalid = null;
        }
        
        let result = '';

        // Use $1 for PostgreSQL parameterized query
        const sql = 'SELECT * FROM sp_gap_worksheet_guardian_info($1)';
        const params = [data.providerapprovalid];

        return util.executeDBQuery(sql, params).then(data7 => {
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
}

IVEGAP.savegapdata = (data, reqctx) => {
  const suserid = reqctx?.req?.headers?.securityusersid;
  try {
    if (!data || !data.clientId) {
      throw new Error(invalidinputmsg);
    }

        if (typeof data.providerapprovalid === 'string' && data.providerapprovalid.trim() === '') {
            delete data.providerapprovalid;
        }
        
        Object.keys(data).forEach((key) => (data[key] === null || data[key] === '') && delete data[key]);

        data.securityuserid = data && data.securityuserid ? data.securityuserid : suserid;

        const jsonPayload = JSON.stringify(data);

        // Use $1 for PostgreSQL parameterized query
        const sql = 'SELECT * FROM savegapeligibilityinfo($1)';
        const params = [jsonPayload];

        return util.executeDBQuery(sql, params).then(data8 => {
            const hasData = data8 && data8.length > 0;
            return { data: hasData ? data8 : [] };
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    } catch (e) {
        throw errorUtils.formatExceptionError(e);
    }
};

  IVEGAP.remoteMethod(
    'gapEligibilityWorksheet', {
      description: 'Get gap eligibilty worksheet by client id',
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
      }
    ],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/gap/gap-eligibility-worksheet/:clientId/:removalId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEGAP.remoteMethod(
    'gapAudit', {
      description: 'Gap Audits API',
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
        path: '/gap/audit',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEGAP.remoteMethod(
    'gatGapAuditMessagesByAuditId', {
      description: 'Get Gap Audit Messages By Audit Id API',
      accepts: [{
        arg: 'gapAuditId',
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
        path: '/gap/audit-messages/:gapAuditId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  // To save sibling information 
  IVEGAP.remoteMethod(
    'updateSiblingInformation', {
      description: 'Update Sibling Information API',
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
        path: '/gap/eligibility-worksheet/sibling',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  // To delete sibling information 
  IVEGAP.remoteMethod(
    'deleteSiblingInformation', {
      description: 'Delete Sibling Information API',
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
        path: '/gap/eligibilityworksheet/sibling/delete',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEGAP.remoteMethod(
    'gapHistory', {
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
        path: '/gap/gap-history/:clientId',
        verb: 'get',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  IVEGAP.remoteMethod(
    'getguardianinfo', {
        description: 'Get eligibilty worksheet guardian data',
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
            path: '/gap/getguardianinfo',
            verb: 'post',
            status: 200,
            errorStatus: 400,
            contentType: jsoncontenttype,
        },
    }
);

IVEGAP.remoteMethod(
  'savegapdata', {
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
      path: '/gap/savegapdata',
      verb: 'post',
      status: 200,
      errorStatus: 400,
      contentType: jsoncontenttype,
    },
  }
);

IVEGAP.remoteMethod(
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
          path: '/gap/ivegapsignature',
          verb: 'post',
          status: 200,
          errorStatus: 400,
          contentType: jsoncontenttype,
      },
  }
);

IVEGAP.remoteMethod(
  'getsignatureinfo', {
      description: 'Get gap signature data',
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
          path: '/gap/getgapsignature',
          verb: 'post',
          status: 200,
          errorStatus: 400,
          contentType: jsoncontenttype,
      },
  }
);


}

