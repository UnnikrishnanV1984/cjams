'use strict';
const errorUtils = require('../../server/utils/error-utils');
const util = require('../utils/utils');
const app = require('../../server/server');
const LOGGER = require("log4js").getLogger("title-ive");

const axios = require('axios');
const { config } = require('exceljs');
const _ = require('lodash');
const referralid = 'Referral ID';
const jsoncontenttype = "application/json";
const iveroutingdesc = 'Title IV-E Routing';
const ivesenddatadesc = 'Trigger to Send IVE Data';
const qryRouting = 'select * from routingIve($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15)';
const { compareJSON, getJSONDiffObj, mapDifferences } = require('../../server/utils/compareDiff');

module.exports = function(TitleIVE) {

  TitleIVE.iveRouting = (data, reqctx) => {  //NOSONAR
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    let countyData =null;
    if (data.where.county && data.where.county.length) {
      const countyDetails = JSON.stringify(data.where.county);
      const formatCounty = countyDetails.replaceAll("[","{");
      const countyData1 = formatCounty.replaceAll("]","}");
      countyData = countyData1;
    }
   
      let sql = '';
      let result = '';
      let sortingorder = null;

      sql = 'select * from listiveplacement($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)';
      if (data.where.eventType && data.where.eventType !== 'ACA' && data.where.sortingorder){
         sortingorder = data.where.sortingorder;
      }

      if (data.where.eligiblestatus || data.where.filtertype || data.page > 1 || data.where.assignedspecialist){
         sql = 'select * from listiveplacement_nolimit_count($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)';
      }

      let pageLimit = data.limit ? data.limit : null ; 

      if (data.where.countstatus && data.where?.countstatus == 'Initial') {
         sql = 'select count(*) as countdata from listiveplacement($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)';
         pageLimit = null;
      }

        return util.executeSecondaryNodeDBQuery(sql, [(data && data.securityuserid?data.securityuserid: suserid), data.where.status, data.where.roleTypeKey, data.where.eventType, data.page, pageLimit,data.where.fname,data.where.lname,data.where.clientId,data.where.eligiblestatus, data.where.rdate, data.where.todate, countyData, sortingorder, data.where.filtertype, data.where.assignedspecialist]).then((data1)=>{
              if (data1 !== null && typeof data1 !== 'undefined' && data1.length > 0) {
                 result = { data : data1 };
              } else {
                  result = { 'data': [] };    
              } 
              return result;
          }).catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

  };


  TitleIVE.fostercarecountdetails = (data, reqctx) => {
    let suserid = data?.securityuserid;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    let countyData =null;
    let statusData = data.where.status ? data.where.status : null;
    if (data.where.county && data.where.county.length) {
      const countyDetails = JSON.stringify(data.where.county);
      const formatCounty = countyDetails.replaceAll("[","{");
      const countyData1 = formatCounty.replaceAll("]","}");
      countyData = countyData1;
    }

    if (data.where.status && data.where.eventType == 'IVECCR') {
       statusData = null;
    }
   
      let sql = '';
      let result = '';
      let sortingorder = null;

      sql = 'select * from fostercarecountdetails($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18)';
      if (data.where.eventType === 'Fostercare' && data.where.sortingorder){
         sortingorder = data.where.sortingorder;
      }

        return util.executeSecondaryNodeDBQuery(sql, [suserid, statusData, data.where.roleTypeKey, data.where.eventType, data.page, data.limit,data.where.fname,data.where.lname,data.where.clientId,data.where.eligiblestatus, data.where.rdate, data.where.todate, countyData, sortingorder, data.where.assignedspecialist, data.where.filtertype, data.where.requestedtouser, data.where.requestedfromuser]).then((data1)=>{
              if (data1 !== null && typeof data1 !== 'undefined' && data1.length > 0) {
                 result = data1[0];
              } else {
                  result = { 'data': [] };    
              } 
              return result;
          }).catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

  };


  TitleIVE.remoteMethod(
    'fostercarecountdetails', {
      description: iveroutingdesc,
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
        path: '/ive/fostercarecountdetails/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.fostercareineligibledetails = (data, reqctx) => { // NOSONAR
    let suserid = undefined;  
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    let countyData =null;
    if (data.where.county && data.where.county.length) {
      const countyDetails = JSON.stringify(data.where.county);
      const formatCounty = countyDetails.replaceAll("[","{");
      const countyData1 = formatCounty.replaceAll("]","}");
      countyData = countyData1;
    }
      let sql = '';
      let result = '';
      let sortingorder = null;

      sql = 'select * from fostercareineligibledetails($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)';
      if (data.where.eventType === 'Fostercare' && data.where.sortingorder){
         sortingorder = data.where.sortingorder;
      }
      
      return util.executeSecondaryNodeDBQuery(sql, [suserid, data.where.status, data.where.roleTypeKey, data.where.eventType, data.page, data.limit,data.where.fname,data.where.lname,data.where.clientId,data.where.eligiblestatus, data.where.rdate, data.where.todate, countyData, sortingorder, data.where.filtertype, data.where.assignedspecialist]).then((data1)=>{ //NOSONAR
              if (data1 !== null && typeof data1 !== 'undefined' && data1.length > 0) {
                  result = data1[0];
              } else {
                  result = { 'data': [] };
              } 
              return result;
          }).catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });
  };


  TitleIVE.remoteMethod(
    'fostercareineligibledetails', {
      description: iveroutingdesc,
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
        path: '/ive/fostercareineligibledetails/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );
  
  TitleIVE.getiveassignment = (data) => {
    try {
      let sql = '';
      sql = 'select * from getiveassignment($1,$2,$3)';
      return util.executeDBQuery(sql, [data.clientId,data.removalId, data.module]).then(data2 => {
        if (data2 !== null && typeof data2 !== 'undefined') {
          return data2;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  TitleIVE.remoteMethod(
    'iveMyTaskdashboard', {
      description: iveroutingdesc,
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
        path: '/ive/mytaskdashboard/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.iveMyTaskdashboard = (data, reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    let countyData = null ;
    if (data.where.county && data.where.county.length) {
      const countyDetails = JSON.stringify(data.where.county);
      const formatCounty = countyDetails.replaceAll("[","{");
      const countyData1 = formatCounty.replaceAll("]","}");
      countyData = countyData1;
    } 

      let sql = '';
      let result = '';
      const securityuserid = (data && data.securityuserid?data.securityuserid: suserid);
      sql = 'select * from sp_ive_alerts_mytasks_info($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)';
      let pageLimit = data.limit ? data.limit : null ; 
      let eligiblestatus = data.where.eligiblestatus ? data.where.eligiblestatus : null ;

      if (data.where.status && data.where?.status == 'Initial') {
         sql = 'select count(*) as countdata from sp_ive_alerts_mytasks_info($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11)';
         pageLimit = null;
      }

      return util.executeSecondaryNodeDBQuery(sql, [securityuserid, data.where.roleTypeKey, countyData , data.where.clientid , data.where.programtype , data.where.assignedspecialist, pageLimit , data.page, data.where.sortColumn, data.where.sortBy, eligiblestatus]).then((data3)=>{
              if (data3 !== null && typeof data3 !== 'undefined' && data3.length > 0) {
                result = {  data : data3 };
              } else {
                result = { 'data': [] };
              }
              return result;
          }).catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

  };


    TitleIVE.remoteMethod(
    'iveMyTaskCount', {
      description: iveroutingdesc,
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
        path: '/ive/mytaskcount/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.iveMyTaskCount = (data, reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 

      let sql = '';
      let result = '';
      const securityuserid = (data && data.securityuserid?data.securityuserid: suserid);
      sql = 'select * from sp_ive_alerts_mytasks_count($1,$2)';

      return util.executeSecondaryNodeDBQuery(sql, [securityuserid, data.where.roleTypeKey]).then((data3)=>{  // NOSONAR
              if (data3 !== null && typeof data3 !== 'undefined' && data3.length > 0) {
                result = {  data : data3 };
              } else {
                result = { 'data': [] };
              }
              return result;
          }).catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

  };

  TitleIVE.iveRoutingSV = (data, reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
 
      let sql = '';
      let result = '';
      const securityuserid = (data && data.securityuserid?data.securityuserid: suserid);
      
      let pageLimit = data.limit ? data.limit : null ; 
      
      sql = 'select * from getiveapprovallist($1,$2,$3,$4,$5,$6,$7,$8,$9)';
      
      if (data.where.countstatus && data.where?.countstatus == 'Initial') {
         sql = 'select count(*) as countdata from getiveapprovallist($1,$2,$3,$4,$5,$6,$7,$8,$9)';
         pageLimit = null;
      } 

      return util.executeSecondaryNodeDBQuery(sql, [securityuserid, data.where.roleTypeKey, data.page, pageLimit, data.where.clientId, data.where.approvalstatus, data.where.programtype, data.where.requestedtouser, data.where.requestedfromuser]).then((data3)=>{  // NOSONAR
              if (data3 !== null && typeof data3 !== 'undefined' && data3.length > 0) {
                result = {  data : data3 };
              } else {
                result = { 'data': [] };
              }
              return result;
          }).catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

  };


  TitleIVE.assignspecialist = (data, reqctx) => {
    const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
    try {
      const assignedtoid = data.where.assignedtoid;
      const comments = data.where.comments;
      const bulkassignarray = data.where.bulkassign;
      const eventcode = data.where.eventcode;
      const securityusersid =  suserid;
      const status = data.where.status;
      const routeddescription = data.where.routeddescription;
      const fromuserrole = data.where.userprofilerole;
      const touserrole = data.where.touserrole;
      const servicecaseidrouting = '';
      let prs=[];
      if(Array.isArray(bulkassignarray)){
        bulkassignarray.forEach(element => {
          prs.push(util.executeDBQuery(qryRouting, [element.objectid, securityusersid, eventcode, status, comments, assignedtoid, false, false, false, element.notifymsg, routeddescription, element.servicecaseid,servicecaseidrouting,fromuserrole,touserrole]));
        })
        return Promise.all(prs).then(data5 => data5).catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
      } else if (eventcode == 'IVECCR') {

        return util.executeDBQuery(qryRouting, [data.where.objectid, securityusersid, eventcode, status, comments, assignedtoid, false, false, false, data.where.notifymsg, routeddescription, data.where.servicecaseid,servicecaseidrouting,fromuserrole,touserrole]).then(data6 => data6).catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
      }
    } catch (e) {
      const error = errorUtils.formatExceptionError(e);
      LOGGER.debug(e);
      throw error;
    }
      return Promise.resolve([]);
  };


  TitleIVE.routingUpdate = (data, reqctx) => {
    const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
    
    try {
      const notifymsg = data.where.notifymsg;
      const routeddescription = data.where.routeddescription;
      const comments = data.where.comments;
      let status = 67;
      let object_id = '';
     if (data.where.eventcode === 'ABLR') {
      switch(data.where.status){
        case 'SplReview':
          status = 68;
          break;
        case 'SpvApproved':
          status = 77;
          break;
        case 'SpvRejected':
          status = 80;
          break;
       }
        object_id = data.where.adoptionbreakthelinkid;
      } else if (data.where.eventcode === 'PLTR') {
        switch(data.where.status){
          case 'SplReview':
            status = 71;
            break;
          case 'SpvApproved':
            status = 72;
            break;
          case 'SpvRejected':
            status = 78;
            break;
         }
        object_id = data.where.placementid;
      } else if (data.where.eventcode === 'GAAR') {
        switch(data.where.status){
          case 'SplReview':
            status = 74;
            break;
          case 'SpvApproved':
            status = 75;
            break;
          case 'SpvRejected':
            status = 79;
            break;
         }
        object_id = data.where.gapagreementid;
      }
      const servicecaseidrouting = '';
      return util.executeDBQuery(qryRouting, [object_id, suserid, data.where.eventcode, status, comments, data.where.assignedtoid, false, false, false, notifymsg, routeddescription, data.where.servicecaseid, servicecaseidrouting ,data.where.userprofilerole,data.where.touserrole])
      .then(data7 => {
          LOGGER.info(data7);
          return data7;
      })
      .then((res) => {
          const sql = 'select * from adoptionSignature($1,$2,$3,$4,$5,$6,$7)';
          return util.executeDBQuery(sql, [object_id, data.where.signText, data.where.narrative,  suserid, data.where.servicecaseid, status, data.where.eventcode])
          .then(data8 => {
              LOGGER.info(data8);
              return res;
          })
          .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          })
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  TitleIVE.ivecjamsdata = (data, reqctx) => {
   
    try {
      let sql = '';
      let result = '';
      const formatData = JSON.stringify(data);
      sql = 'select * from sp_csms_inbound_data($1)';
      return util.executeDBQuery(sql, [formatData]).then(data9 => {
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


  TitleIVE.iveApprovalStatus = async function(request,reqctx) {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    let _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
        _email = reqctx.req.headers.user_email_captureby_application;
		}  
    let requestuserinfo = {'token': '', 'email': _email};
    let sroletypekey ;
    await util.getuserinfo(requestuserinfo).then (data => {
      sroletypekey = data.roletypekey;
    });  

    const sql = 'select * from sp_ive_status_approval($1,$2,$3,$4,$5,$6,$7,$8,$9)';

    let removalIDCheck;
      
    if (request.where.removalid == 'null' && request.where.eventType == 'Adoption') {
      removalIDCheck = null;
    } else {
      removalIDCheck = request.where.removalid;
    }
    
		return util.executeDBQuery(sql, [request.where.clientid, removalIDCheck, (request && request.securityuserid?request.securityuserid: suserid), request.where.status, sroletypekey, request.where.eventType, request.page, request.limit, request.where.sqnm_sw])
		.then(data => ({'data': data }))
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
	};







  TitleIVE.ivespvApproval = (data) => {
    try {
      let sql = '';
      let result = '';

      sql = 'select * from sp_ive_spv_approval_status($1,$2,$3,$4,$5,$6,$7)';
      return util.executeDBQuery(sql, [data.where.approval_id, data.where.approval_status, data.where.placement_type, data.page, data.limit, data.where.approveduser,  data.securityuserid]).then(data8 => {
        if (data8 !== null && typeof data8 !== 'undefined' && data8.length > 0) {
          result = { data : data8 };
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

  // Perform call the CSMS API
  function sendCSMSRequest(data,clientid,removalid) {

    return new Promise(async (resolve,reject) => {
      try {
        const options = {
          method: 'POST',
          uri: `${app.get('CSMSAPI')}/batchive/camel/ivEService`,
          body: data,
          json: true,
        };
        const csmsresponse = await axios.post(options.uri, options.body, {headers: {
                    'Content-Type': 'application/json'
                }});

        let sql = '';
        let result = '';
        let csmsfailureflag = false;
        const csmsResponseJson = JSON.stringify(csmsresponse.data);

        const cmsData = getCMSResponseData(null, csmsresponse.data)
        const referralId  = cmsData.referralId;
        csmsfailureflag = cmsData.csmsfailureflag;
        

        sql = 'UPDATE ivecsesoutbounddata SET inputjson = $1, outputjson= $2, csmsreferralid = $3, csmsfailureflag = $4 WHERE clientid =$5 AND removalid =$6 and activeflag = 1';
        util.executeDBQuery(sql,[data, csmsResponseJson,referralId,csmsfailureflag,clientid,removalid])
          .then(data9 => {
            result = checkResponse(data9);
            return resolve(result);
          })
          .catch(err => {
            LOGGER.error(err);
            return reject(err);
          })
      } catch (error) {

        let sql = '';
        let result = '';
        const csmsResponseJson = JSON.stringify(error);

        if (error.message.includes(referralid) && error.message.includes('exists with same ive case number')) {
          const errorCheck = error.message.split(referralid)[1];

          const referralIdDetails = errorCheck.split('exists')[0];
          if (referralIdDetails) {
            data.referralId = Number(referralIdDetails);
            data.ivdRecordType = 'UPDT';
            return retryCSMSRequest(data,clientid,removalid);
          }

        } else if (error.statusCode == 500 && error.message.includes('500')) {
          return retryCSMSRequest(data,clientid,removalid);
        } else {
          sql = "UPDATE ivecsesoutbounddata SET outputjson= $1, csmsfailureflag = $2  WHERE clientid =$3 AND removalid =$4 and activeflag = 1";
          util.executeDBQuery(sql,[csmsResponseJson,true,clientid,removalid])
            .then(data23 => {
              result = checkResponse(data23);
              return resolve(result);
            })
            .catch(err => {
              LOGGER.error(err);
              return reject(err);
            })
          return reject(error);
        }
      }
    });

  }


  function retryCSMSRequest(data,clientid,removalid) {
    let result = '';
    return new Promise(async (resolve, reject) => { 
      try { 
        const options = {
        method: 'POST',
        uri: `${app.get('CSMSAPI')}/batchive/camel/ivEService`,
        body: data,
        json: true,
      };
      const csmsresponse = await requestpr(options);

      let sql = '';
      let csmsfailureflag = false;
      const csmsResponseJson = JSON.stringify(csmsresponse);

      const cmsData = getCMSResponseData(data, csmsresponse);
      const referralId =  cmsData.referralId;
      csmsfailureflag =  cmsData.csmsfailureflag;

      sql = 'UPDATE ivecsesoutbounddata SET outputjson= $1, inputjson = $2, csmsreferralid = $3, csmsfailureflag = $4, updatedon=now() WHERE clientid =$5 AND removalid =$6 and activeflag = 1';

        util.executeDBQuery(sql,[csmsResponseJson, data, referralId, csmsfailureflag , clientid, removalid]).then(data10 => {
          if (data10 !== null && typeof data10 !== 'undefined' && data10.length > 0) {
            result = { data : data10 };
          } else {
            result = { 'data': [] };
          }
          return resolve(result);
        }).catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          return reject(err);
        });
    } catch (error) {

      let sql = '';
      const csmsResponseJson = JSON.stringify(error);

      sql = "UPDATE ivecsesoutbounddata SET outputjson= $1, inputjson = $2, csmsfailureflag = $3, updatedon=now() WHERE clientid =$4 AND removalid =$5 and activeflag = 1";

        util.executeDBQuery(sql, [csmsResponseJson, data, true , clientid, removalid]).then(data11 => {
          if (data11 !== null && typeof data11 !== 'undefined' && data11.length > 0) {
            result = { data : data11 };
          } else {
            result = { 'data': [] };
          }
          return resolve(result);
        }).catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          return reject(err);
        });
      return reject(error);
    }
  });

  }
  


   // Perform call the CSMS API
function sendAfcarsToEnE(data,suserid) {

return new Promise(async (resolve, reject) => { 
      try { 
        const options = {
        method: 'POST',  
        uri: `${app.get('IVEAFCARSAPI')}/interfaces/v1/cjams/processAfcarsRequest`,
        headers: {
        "Content-Type": jsoncontenttype,
        "Authorization" : `${app.get('ENEBEARERTOKEN')}`,
        uid: `${app.get('eneuid')}`,
        role: `${app.get('enerole')}`,
      },
        body: data,
        json: true,
      };
      const eneResponse = await requestpr(options);

      let sql = '';
      let result = '';
      const eneResponseJson = JSON.stringify(eneResponse);


    sql = 'select * from afcarseneresponseupdate($1,$2)';

    util.executeDBQuery(sql, [eneResponseJson, (suserid)]).then(data12 => {
          if (data12 !== null && typeof data12 !== 'undefined' && data12.length > 0) {
            result = { data : data12 };
          } else {
            result = { 'data': [] };
          }
          return resolve(result);
        }).catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          return reject(err);
        });
    } catch (error) {
      return reject(error);
    }
 });

}

  function processCSMSRequest(mappedDifferences, obj1, clientIdIve, removalidIve) {
    if (mappedDifferences.length > 0) {
      let uniqueResult = Array.from(new Set(mappedDifferences));
      for (let i = 0; i < uniqueResult.length; i++) {
        uniqueResult[i] = uniqueResult[i].replace(/'/g, '"');
      }

      let diffObjJSON = {
        ...obj1,
        'ivdChangedCodes': uniqueResult
      };

      if(diffObjJSON && diffObjJSON.csmsupdatestop) {
        stopCSMSUpdates(clientIdIve, removalidIve);
      } else {
        sendCSMSRequest(diffObjJSON, clientIdIve, removalidIve);
      }
      
    }
  }


  function stopCSMSUpdates(clientid, removalid) {
    return new Promise((resolve,reject) => {
      let sql = '';
      let result = '';
        sql = "UPDATE ivecsesoutbounddata SET csmsretryuser= $1,updatedon = now() WHERE clientid =$2 AND removalid =$3 and activeflag = 1";
        util.executeDBQuery(sql,['Stop',clientid,removalid])
          .then(data24 => {
            result = checkResponse(data24);
            return resolve(result);
          })
          .catch(err => {
            LOGGER.error(err);
            return reject(err);
          })
    })
  }


  TitleIVE.ivecsmsData = (data, reqctx) => {
    try {
      let sql = '';

      let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }

      const clientIdIve = data.where.clientId;
      const removalidIve =  data.where.removalId;

      sql = 'select * from sp_fostercare_csms_outbound($1,$2,$3,$4);';

      return util.executeDBQuery(sql, [(data && data.where.securityuserid ? data.where.securityuserid: suserid),clientIdIve,removalidIve, data.where.reviewperiod])
        .then(data13 => handleCsmsOutbound(data13, clientIdIve, removalidIve))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  function handleCsmsOutbound(data13, clientIdIve, removalidIve) {
    const hasPayload = data13 !== null && typeof data13 !== 'undefined' && data13.length > 0 && data13[0].sp_fostercare_csms_outbound;
    if (!hasPayload) {
      return { 'data': [] };
    }

    const obj1 = data13[0].sp_fostercare_csms_outbound.new_data;
    const obj2 = data13[0].sp_fostercare_csms_outbound.old_data;

    // new_data is the outbound CSMS payload. The SP returns it as null when
    // there is nothing to send for this client/removal, so stop here instead
    // of reading ivdRecordType off null or posting a payload with no IV-E data.
    if (!obj1) {
      return { 'data': [] };
    }

    // To be enabled with the new API
    if (obj1.ivdRecordType == 'NAPP' || obj1.ivdRecordType == 'CLOS') {
      sendCSMSRequest(obj1, clientIdIve, removalidIve);
    } else {
      const diffKeyArray = Object.keys(compareJSON(obj1, obj2));
      const mappedDifferences = mapDifferences(diffKeyArray);
      processCSMSRequest(mappedDifferences, obj1, clientIdIve, removalidIve);
    }

    return data13;
  }

  TitleIVE.iveafcarsdata = (data, reqctx) => {
    try {
      let sql = '';
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
      sql = 'select json_agg(d) from (select afcarseneresponseid,cjamspid,cisclientid,removaldate:: character varying,returndate :: character varying,ivaflag,xixflag from afcarseneresponse where activeflag =1) d ;'
      return util.executeDBQuery(sql, []).then(data14 => {
        if (data14 !== null && typeof data14 !== 'undefined' && data14.length > 0) {
         // To be enabled with the new API
          sendAfcarsToEnE(data14[0].json_agg,suserid);
        }
        return data14;
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };


  TitleIVE.retrycsmsreferrals = (data, reqctx) => {
    try {
      let sql = '';
      if(data.where.retry == 'Placement') {
      sql = `select json_agg(d) from (select distinct  p.cjamspid,  r.fromsecurityusersid, ir.removalid, null as reviewperiod, ic.csmsfailureflag, ic.csmsreferralid, ic.ivecsesoutboundid  from routing r
        join placement pl on pl.placementtypekey = 'PRPL' and pl.placementid::character varying = r.objectid
        left join person p on p.personid = pl.personid
        left join intakeservreqchildremoval ir on ir.intakeservreqchildremovalid = pl.intakeservreqchildremovalid
        left join ivecsesoutbounddata ic on ic.clientid = p.cjamspid
        where r.eventcode = 'PLTR' and r.routingstatustypeid = 16 and r.activeflag = 1 and r.insertedon::date between $1 and $2 and r.toroleid in ('CWCW','CWSP')
        ) d`;
      } else if (data.where.retry == 'IVE') {
        sql = `select json_agg(d) from (
          select distinct tce.client_id as cjamspid,  u1.securityusersid as fromsecurityusersid, tce.removal_id as removalid, tep.sqnm_sw as reviewperiod from tb_client_eligibility tce 
          join tb_eligibility_period tep on tep.eligibility_id = tce.eligibility_id and tep.delete_sw = 'N' 
          left join userprofile u1 on u1.fullname = tep.approvedby
          where tep.approvalstatus = 'APPROVED' and tep.update_ts:: date between $1 and $2
          and tce.eligibility_type_cd = '2931' and tce.delete_sw = 'N'
          ) d`;
      }

      return util.executeDBQuery(sql ,[data.where.startdt, data.where.enddt]).then(data15 => {
        if (data15 !== null && typeof data15 !== 'undefined' && data15.length > 0) {
         // To be enabled with the new API
         const result1 = data15[0].json_agg;
         const uniqueResult = _.uniqBy(result1, 'cjamspid');
         const finalresult = uniqueResult.filter(value => value.ivecsesoutboundid == null);
         if(finalresult && finalresult.length) {
            retryCSMSFailures(finalresult);
         }

        }
        return data15;
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };



  function retryCSMSFailures(data) {
    data.forEach(element => {
        const sql = 'select * from sp_fostercare_csms_outbound($1,$2,$3,$4)';

        return util.executeDBQuery(sql,[element.fromsecurityusersid,element.cjamspid,element.removalid,element.reviewperiod])
        .then(data16 => {
          return data16[0].sp_fostercare_csms_outbound.new_data;
        })
        .then((res) => {
        if (res) {
          return new Promise(async (resolve,reject) => {
            try {
              const options = {
                method: 'POST',
                uri: `${app.get('CSMSAPI')}/batchive/camel/ivEService`,
                body: res,
                json: true,
              };
              const csmsresponse = await requestpr(options);

              let result = '';
              let csmsfailureflag = false;
              const csmsResponseJson = JSON.stringify(csmsresponse);

              const cmsData = getCMSResponseData(element, csmsresponse)

              const referralId  = cmsData.referralId;
              csmsfailureflag = cmsData.csmsfailureflag;

              let sql1 = 'UPDATE ivecsesoutbounddata SET outputjson= $1, csmsreferralid = $2, csmsfailureflag = $3, csmsretryfailureflag = true,  csmsretryuser = $4  WHERE clientid =$5 AND removalid =$6 and activeflag = 1';

              util.executeDBQuery(sql1,[csmsResponseJson,referralId,csmsfailureflag,'Retry User',element.cjamspid,element.removalid])
              .then(data17 => {
                result = checkResponse(data17);
                return resolve(result);
              })
              .catch(err => {
                  LOGGER.error(err);
                  return reject(err);
              })
            } catch (error) {

              return checkErrorandRevalidate(error,referralid,data,element)
              .then(data18=>{
                return resolve(data18);
              })
              .catch(err=>{
                  LOGGER.error(err);
                  return reject(err);
              });
            }
          })
        } else {
          return res;
        }
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });
    })

  }

  function checkErrorandRevalidate(error,referralid1,data,element) {
    return new Promise((resolve,reject) => {
      let sql = '';
      let result = '';
      const csmsResponseJson = JSON.stringify(error);

      if (error.message.includes(referralid1) && error.message.includes('exists with same ive case number')) {
        const errorCheck = error.message.split(referralid1)[1];

        const referralIdDetails = errorCheck.split('exists')[0];
        if (referralIdDetails) {
          data.referralId = Number(referralIdDetails);
          data.ivdRecordType = 'UPDT';
          return retryCSMSRequest(data,element.cjamspid,element.removalid);
        }

      } else {
        sql = "UPDATE ivecsesoutbounddata SET outputjson= $1, csmsfailureflag = $2, csmsretryfailureflag = true,  csmsretryuser = $3  WHERE clientid =$4 AND removalid =$5 and activeflag = 1";
        util.executeDBQuery(sql,[csmsResponseJson,true,'Retry User',element.cjamspid,element.removalid])
          .then(data19 => {
            result = checkResponse(data19);
            return resolve(result);
          })
          .catch(err => {
            LOGGER.error(err);
            return reject(err);
          })
        return reject(error);
      }
    })
  }

  function getCMSResponseData(element, csmsresponse) {
    let csmsfailureflag = false;
    let referralId = null;
    if (element && element.referralId) { referralId = element.referralId }
    else if (csmsresponse && csmsresponse.referralId) { referralId = csmsresponse.referralId; }

    if (csmsresponse.message && csmsresponse.message !== '4000' && csmsresponse.message !== '4001' && csmsresponse.messageCode !== '4000' && csmsresponse.messageCode !== '4001') {
      csmsfailureflag = true;
    }
    return {
      referralId,
      csmsfailureflag
    }
  }

  function checkResponse(data){
    let result = '';
    if (data !== null && typeof data !== 'undefined' && data.length > 0) {
      result = {
        data,
      };
    } else {
      result = {
        'data': [],
      };
    }
    return result;
  }


  TitleIVE.csmsreferrals = (data,reqctx) => {
    try {
      let sql = '';
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
      sql = 'select * from getcsmsivereferralsinfo()';
      return util.executeDBQuery(sql, []).then(data20 => {
        if (data20 !== null && typeof data20 !== 'undefined' && data20.length > 0) {
         // To be enabled with the new API
          sendAfcarsToEnE(data20[0].json_agg,suserid);
        }
        return data20;
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } catch (e) {
      throw errorUtils.formatExceptionError(e);
    }
  };

  TitleIVE.iveCCRRouting = (data, reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    let countyData = null ;
    if (data.where.county && data.where.county.length) {
      const countyDetails = JSON.stringify(data.where.county);
      const formatCounty = countyDetails.replaceAll("[","{");
      const countyData1 = formatCounty.replaceAll("]","}");
      countyData = countyData1;
    } 
      let sql = '';
      let result = '';


       sql = 'select * from ive_caseclosure($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)';

      let pageLimit = data.limit ? data.limit : null ; 

      if (data.where.countstatus && data.where?.countstatus == 'Initial') {
         sql = 'select count(*) as countdata from ive_caseclosure($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12)';
         pageLimit = null;
      }

        return util.executeSecondaryNodeDBQuery(sql, [data.where.casenumber, data.where.clientId, data.where.status, data.where.roleid, data.where.fromsecurityusersid, data.where.tosecurityuserid, data.where.statustype, suserid, data.page, pageLimit, countyData, data.where.filtertype]).then((data21)=>{
              if (data21 !== null && typeof data21 !== 'undefined' && data21.length > 0) {
                result = {  data : data21 };
              } else {
                result = { 'data': [] };
              }
              return result;
          }).catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

  };

  TitleIVE.remoteMethod(
    'iveCCRRouting', {
      description: 'Title IV-E Case Closure Review Routing',
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
        path: '/ive/closureRouting/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: 'application/json',
      },
    }
  );

  TitleIVE.remoteMethod(
    'iveRouting', {
      description: iveroutingdesc,
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
        path: '/ive/routing/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.remoteMethod(
    'getiveassignment', {
      description: iveroutingdesc,
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
        path: '/ive/getiveassignment/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.remoteMethod(
    'iveRoutingSV', {
      description: iveroutingdesc,
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
        path: '/ive/routingsv/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.remoteMethod(
    'assignspecialist', {
      description: 'Ive Routing',
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
        path: '/ive/assignspecialist/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  // CSMS Reverse flow
  TitleIVE.remoteMethod(
    'ivecjamsdata', {
      description: iveroutingdesc,
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
        path: '/ive/ivecjamsdata/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.remoteMethod(
    'routingUpdate', {
      description: 'Adoption/fostercare Routing',
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
        path: '/ive/routingUpdate/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.remoteMethod(
    'iveApprovalStatus', {
      description: 'Title IV-E Approval Status',
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
        path: '/ive/approval-status/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );
  TitleIVE.remoteMethod(
    'ivespvApproval', {
      description: 'Title IV-E SPV Approval',
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
        path: '/ive/ivespv-approval/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

   // Trigger to pass IVE json to CSMS data
   TitleIVE.remoteMethod(
    'ivecsmsData', {
      description: ivesenddatadesc,
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
        path: '/ive/ivecsms-data/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );


   // Trigger to pass IVE json to ENE
   TitleIVE.remoteMethod(
    'iveafcarsdata', {
      description: ivesenddatadesc,
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
        path: '/ive/afcars-ene/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

  TitleIVE.remoteMethod(
    'csmsreferrals', {
      description: ivesenddatadesc,
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
        path: '/ive/csmsreferrals/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );


  TitleIVE.remoteMethod(
    'retrycsmsreferrals', {
      description: ivesenddatadesc,
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
        path: '/ive/retrycsmsreferrals',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: jsoncontenttype,
      },
    }
  );

};