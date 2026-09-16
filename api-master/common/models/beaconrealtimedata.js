'use strict';
const LOGGER = require("log4js").getLogger("beaconrealtimedata");
const app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const axios = require('axios');
const ds = loopback.createDataSource('memory');
const config = require('../../server/config.json');
const becaonmodel = require('../models/beaconrealtimedata.json');
const commonapi = require('../models/commonapi');

module.exports = function (beaconrealtimedata) {

  beaconrealtimedata.getbeaconrealtimedata = function (request, reqctx) {
    let suserid = util.getSecurityDetails(request, reqctx).securityuserid;
    let beaconrequestdetailsid = nullCheck(request?.where?.beaconrequestdetailsid);
    let ssn = nullCheck(request?.where?.ssn);
    let sourcetrackingid = nullCheck(request?.where?.sourcetrackingid);
    let pageNum = request?.pageNum ? request?.pageNum : 0;
    let pageSize = request?.pageSize ? request?.pageSize : 10;
    let segment = nullCheck(request?.segment);
    let Username = nullCheck(request?.username);
    if (ssn == null || ssn == undefined || ssn == '' || ssn == 'null') {
      return Promise.resolve([])
    }
    const requestbody = {
      "SSN": ssn,
      "SourceTrackingId": sourcetrackingid,
      "Pagination": {
        "Segment": segment,
        "PageNum": pageNum,
        "PageSize": pageSize
      }
    };
    let cipherencryptvalue = util.cipherencrypt(requestbody);
    let encryptedvalue ={
      encrypted :cipherencryptvalue
    }
    var options = {
      url: config.beconConfig.url,
      json: true,
      body: encryptedvalue,
      headers: {
        Authorization: app.get('apiKeys').beacon_bearer_token,
        "Content-Type": config.beconConfig.ContentType,
        Username: Username,
        uid: suserid,
        "Interface-Job-Source": config.beconConfig.beacondolJobSource,
        "interface-job-code": config.beconConfig.beacondoljobcode
      }
    };
    
    let externalapidata = {};
    externalapidata.details = {
      objectid: beaconrequestdetailsid,
      objecttype: 'beacon_realtime_response',
      objectsubtype: null,
      updatedby: suserid,
      insertedby: suserid
    }
    externalapidata.resstatus = ' ';
    externalapidata.request = options;
    externalapidata.response = null;
    externalapidata.status = 'add';
    var v_externalapilogsid = null;
    commonapi.addupdateexternalapilogs(externalapidata).then(_data => {
      v_externalapilogsid = _data;
    });
    return addupdateexternalapilogs(options, beaconrequestdetailsid, v_externalapilogsid, suserid)
    .then(data => {
      if((data?.historyResponse ||data?.realtimeResponse)&& !data.error.length>0 ){
      becaonmodel.data.tracking_id = data?.realtimeResponse?.trackingId;
      becaonmodel.data.status = data?.realtimeResponse?.status;
      becaonmodel.data.source_tracking_id = data?.realtimeResponse?.sourceTrackingId;
      let wages = data?.realtimeResponse?.beaconData?.wagesData.map(t => {
        let p = {...becaonmodel.wages};
        p.ssn = data?.realtimeResponse?.beaconData?.SSN;
        p.first_name = data?.realtimeResponse?.beaconData?.firstName;
        p.last_name = data?.realtimeResponse?.beaconData?.lastName;
        p.employer_id = t?.employerAccountId;
        p.employer_name = t?.employerBusinessName;
        p.wage_amount = t?.reportedWageAmount;
        p.year_quarter = t?.wageQuarter;
        p.year = t?.wageYear;
        p.state = data?.realtimeResponse?.beaconData?.state;
        return p;
      });
      becaonmodel.data.wages = wages;
      becaonmodel.data.claimant.first_name=data.realtimeResponse.beaconData.firstName;
      becaonmodel.data.claimant.last_name=data.realtimeResponse.beaconData.lastName;
      becaonmodel.data.claimant.effective_date = data.realtimeResponse.beaconData?.UIData?.BYBDate;
      becaonmodel.data.claimant.ssn = data.realtimeResponse.beaconData.SSN;
      becaonmodel.data.claimant.claim_id = null;
      becaonmodel.data.claimant.benefit_year_begin_date = data.realtimeResponse.beaconData?.UIData?.BYBDate;
      becaonmodel.data.claimant.benefit_year_end_date = data.realtimeResponse.beaconData?.UIData?.BYEDate;
      becaonmodel.data.claimant.state = data.realtimeResponse.beaconData.state;
      becaonmodel.data.claimant.last_day_of_work = data.realtimeResponse.beaconData?.UIData?.lastDayWorked;
      becaonmodel.data.claimant.adress_line_1 = data.realtimeResponse.beaconData.claimantMailingAddressLine1;
      becaonmodel.data.claimant.adress_line_2 = data.realtimeResponse.beaconData.claimantMailingAddressLine2;
      becaonmodel.data.claimant.city = data.realtimeResponse.beaconData.city;
      becaonmodel.data.claimant.zip = data.realtimeResponse.beaconData.zipCode;
      becaonmodel.data.claimant.paidDateWeek1 = data.realtimeResponse.beaconData?.UIData?.paidDateWeek1;
      becaonmodel.data.claimant.paidDateWeek2 = data.realtimeResponse.beaconData?.UIData?.paidDateWeek2;
      becaonmodel.data.claimant.paidDateWeek3 = data.realtimeResponse.beaconData?.UIData?.paidDateWeek3;
      becaonmodel.data.claimant.paidDateWeek4 = data.realtimeResponse.beaconData?.UIData?.paidDateWeek4;
      becaonmodel.data.claimant.netPayWeek1 = data.realtimeResponse.beaconData?.UIData?.netPayWeek1;
      becaonmodel.data.claimant.netPayWeek2 = data.realtimeResponse.beaconData?.UIData?.netPayWeek2;
      becaonmodel.data.claimant.netPayWeek3 = data.realtimeResponse.beaconData?.UIData?.netPayWeek3;
      becaonmodel.data.claimant.netPayWeek4 = data.realtimeResponse.beaconData?.UIData?.netPayWeek4;
      becaonmodel.data.claimant.grossPayWeek1 = data.realtimeResponse.beaconData?.UIData?.grossPayWeek1;
      becaonmodel.data.claimant.grossPayWeek2 = data.realtimeResponse.beaconData?.UIData?.grossPayWeek2;
      becaonmodel.data.claimant.grossPayWeek3 = data.realtimeResponse.beaconData?.UIData?.grossPayWeek3;
      becaonmodel.data.claimant.grossPayWeek4 = data.realtimeResponse.beaconData?.UIData?.grossPayWeek4;

      becaonmodel.data.historyResponse.ssn = data?.realtimeResponse?.beaconData?.SSN;
      becaonmodel.data.historyResponse.processedDate = data?.historyResponse?.processedDate;
      becaonmodel.data.historyResponse.processAdjustmentDate = data.historyResponse?.adjustedPaymentHistoryDetailsSegment?.results;
      becaonmodel.data.historyResponse.employerName = data?.historyResponse?.employerSegment?.results;
      becaonmodel.data.historyResponse.totalEmployers = data?.historyResponse?.employerSegment?.total || 0;
      let historyclaimant = data?.historyResponse?.claimHistorySegment?.results.map(t => {
        let p ={... becaonmodel.historyclaimant};
        p.claimhistorysegmentid =t.claimHistorySegmentId;
        p.claim_status = t.status;
        p.ssnmasterid =t.ssnMasterId;
        p.claimtype =t.claimType;
        p.programtype =t.programType;
        p.effective_date = t.byb;
        p.mba =t.mba;
        p.claim_id = t.claimId;
        p.benefit_year_begin_date = t.byb;
        p.benefit_year_end_date = t.bye;
        p.paymentHistorySegment = t.paymentHistorySegment;
        p.adjustedPaymentHistoryDetailsSegment = t.adjustedPaymentHistoryDetailsSegment;
        return p;
      });
      becaonmodel.data.historyResponse.claimHistorySegment.pageNum =data?.historyResponse?.claimHistorySegment?.pageNum;
      becaonmodel.data.historyResponse.claimHistorySegment.pageSize =data?.historyResponse?.claimHistorySegment?.pageSize;
      becaonmodel.data.historyResponse.claimHistorySegment.total =data?.historyResponse?.claimHistorySegment?.total;
      becaonmodel.data.historyResponse.claimHistorySegment.results = historyclaimant;
      let historypayments = data?.historyResponse?.paymentHistorySegment?.results.map(t => {
        let p = {...becaonmodel.historypayments};
        p.paymenthistorysegmentid =t.paymentHistorySegmentId;
        p.ssnmasterid =t.ssnMasterId;
        p.weeklyEndingDate = t.weeklyEndingDate;
        p.dateCertificationReceived = t.dateCertificationReceived;
        p.programName = t.programName;
        p.datePaymentIssued = t.datePaymentIssued;
        p.benefitAmount = t.benefitAmount;
        p.paymentAmount = t.paymentAmount;
        p.overpayment = t.overpayment;
        p.processStatus = t.processStatus;
        return p;
      });
      becaonmodel.data.historyResponse.paymentHistorySegment.pageNum =data?.historyResponse?.paymentHistorySegment?.pageNum;
      becaonmodel.data.historyResponse.paymentHistorySegment.pageSize =data?.historyResponse?.paymentHistorySegment?.pageSize;
      becaonmodel.data.historyResponse.paymentHistorySegment.total =data?.historyResponse?.paymentHistorySegment?.total;
      becaonmodel.data.historyResponse.paymentHistorySegment.results = historypayments;
      let  historywages = data?.historyResponse?.quarterlyWageSegment?.results.map(t => {
        let p = {...becaonmodel.historywages};
        p.ssnmasterid =t.ssnMasterId;
        p.quarterlywagesegmentid =t.quarterlyWageSegmentId;
        p.employer_id = t.employerMarylandAccountNumber;
        p.wage_amount = t.incomeAmount;
        p.year_quarter = t.wageQuarter;
        p.year = t.wageYear;
        return p;
      });
      becaonmodel.data.historyResponse.quarterlyWageSegment.pageNum =data?.historyResponse?.quarterlyWageSegment?.pageNum;
      becaonmodel.data.historyResponse.quarterlyWageSegment.pageSize =data?.historyResponse?.quarterlyWageSegment?.pageSize;
      becaonmodel.data.historyResponse.quarterlyWageSegment.total =data?.historyResponse?.quarterlyWageSegment?.total;
      becaonmodel.data.historyResponse.quarterlyWageSegment.results = historywages;
      let  overpaymentInquiry = data?.historyResponse?.overpaymentInquiry?.results.map(t => {
        let p = {...becaonmodel.overpaymentInquiry};
        p.overpaymentInquiryId =t.overpaymentInquiryId;
        p.ssnMasterId =t.ssnMasterId;
        p.dateOfDiscovery = t.dateOfDiscovery;
        p.amountOfOverpayment = t.amountOfOverpayment;
        return p;
      });
      becaonmodel.data.historyResponse.overpaymentInquiry.pageNum =data?.historyResponse?.overpaymentInquiry?.pageNum;
      becaonmodel.data.historyResponse.overpaymentInquiry.pageSize =data?.historyResponse?.overpaymentInquiry?.pageSize;
      becaonmodel.data.historyResponse.overpaymentInquiry.total =data?.historyResponse?.overpaymentInquiry?.total;
      becaonmodel.data.historyResponse.overpaymentInquiry.results = overpaymentInquiry;

      let  overpaymentReimbursement = data?.historyResponse?.overpaymentReimbursement?.results.map(t => {
        let p = {...becaonmodel.overpaymentReimbursement};
        p.overpaymentReimbursementId =t.overpaymentReimbursementId;
        p.ssnMasterId =t.ssnMasterId;
        p.datePaymentReceived = t.datePaymentReceived;
        p.overpaymentRepayment = t.overpaymentRepayment;
        return p;
      });
      becaonmodel.data.historyResponse.overpaymentReimbursement.pageNum =data?.historyResponse?.overpaymentReimbursement?.pageNum;
      becaonmodel.data.historyResponse.overpaymentReimbursement.pageSize =data?.historyResponse?.overpaymentReimbursement?.pageSize;
      becaonmodel.data.historyResponse.overpaymentReimbursement.total =data?.historyResponse?.overpaymentReimbursement?.total;
      becaonmodel.data.historyResponse.overpaymentReimbursement.results = overpaymentReimbursement;

      LOGGER.debug(data);
      return util.encryptresponse(becaonmodel.data);}
      else{
        if (typeof data?.error?.[0]?.ErrorMessage === 'string') {
          return  data.error[0].ErrorMessage.trim().substring(0, 200);

      }else{
        return 'error in common api'
      }
      }
    })
  };

  function addupdateexternalapilogs(options, beaconrequestdetailsid, v_externalapilogsid, suserid){
    let externalapidata = {};
    return new Promise((resolve, reject) => {
      axios.post(options.url, options.body,{headers: options.headers})
      .then((res) => {
        const dataresolved = res.data;
        let data =JSON.parse(util.cipherdecrypt(dataresolved.encrypted));
          externalapidata = {};
          externalapidata.details = {
            objectid: beaconrequestdetailsid,
            objecttype: 'beacon_realtime_response',
            externalapilogsid:v_externalapilogsid,
            objectsubtype: null,
            updatedby: suserid,
            insertedby: suserid
          }
          if (data?.error && data.error.length > 0) {
            externalapidata.resstatus = 'error'
          } else{
            externalapidata.resstatus = 'success';
          }
          externalapidata.request = options;
          externalapidata.response = data;
          externalapidata.status = 'update';
          commonapi.addupdateexternalapilogs(externalapidata);
          resolve(data);
      })
      .catch((err) => {
        externalapidata = {};
        externalapidata.details = {
          objectid: beaconrequestdetailsid,
          objecttype: 'beacon_realtime_response',
          externalapilogsid:v_externalapilogsid,
          objectsubtype: null,
          updatedby: suserid,
          insertedby: suserid
        }
        externalapidata.resstatus = 'error';
        externalapidata.request = options;
        externalapidata.status = 'update';
        if (err.response) {
          externalapidata.response = err.response.data;
          commonapi.addupdateexternalapilogs(externalapidata);
          LOGGER.error(err.response.data);
          reject(err.response.data); 
        } else {
          externalapidata.response = err;
          commonapi.addupdateexternalapilogs(externalapidata);
          LOGGER.error(err); 
          reject(err);
        }        
      });
    })
  }

 function nullCheck(value) {
    return value ? value : null;
  }


  beaconrealtimedata.remoteMethod('getbeaconrealtimedata', {
    accepts: [{
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: { source: 'context' }
    }],
    http: {
      path: '/getbeaconrealtimedata',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });




  beaconrealtimedata.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  beaconrealtimedata.observe('access', (ctx, next) => util.access(ctx, next));
  beaconrealtimedata.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}