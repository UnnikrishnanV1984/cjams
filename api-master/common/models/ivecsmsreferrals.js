'use strict';
const errorUtils = require('../../server/utils/error-utils');
const util = require('../utils/utils');
var app = require('../../server/server');
const axios = require('axios');
const { config } = require('exceljs');
const _ = require('lodash');
const LOGGER = require("log4js").getLogger("ivecsmsreferrals");

const query_fcCsms = 'select * from sp_fostercare_retry_csmsrecords($1, $2, $3, $4, $5, $6, $7, $8)';

module.exports = function(IVEReferrals) {


  // Perform call the CSMS API
  function sendCSMSRequest(data,clientid,removalid, eligibility_period_id, sqnm_sw) {
   
    return new Promise(async (resolve, reject) => { 
      try { 
        const options = {
        method: 'POST',
        uri: `${app.get('CSMSAPI')}/batchive/camel/ivEService`,
        body: data,
        json: true,
      };
      const responseData = await axios.post(options.uri, options.body, {headers: {
                    'Content-Type': 'application/json'
                }});
      const csmsresponse = responseData.data;
  
      let sql = '';
      let result = '';
      let csmsfailureflag = false;
      const csmsResponseJson = JSON.stringify(csmsresponse);
  
      const referralId = csmsresponse.referralId ? csmsresponse.referralId : null;
  
      if (csmsresponse.message && csmsresponse.message !== '4000' && csmsresponse.message !== '4001' && csmsresponse.messageCode !== '4000' && csmsresponse.messageCode !== '4001') {
        csmsfailureflag = true;
      }
  
      sql = query_fcCsms;
      util.executeDBQuery(sql,[data, csmsResponseJson, clientid , removalid , sqnm_sw , referralId, csmsfailureflag, eligibility_period_id])
      .then(resp => {
          result = formatResults(resp);
          return resolve(result);
        })
      .catch(err => {
          LOGGER.error(err)
          return reject(err);
        })
    } catch (error) {
  
      let sql = '';
      let result = '';
      const csmsResponseJson = JSON.stringify(error);

      if(error.message.includes('Referral ID') && error.message.includes('exists with same ive case number')) {
        checkreferalId(data, error);
        
      } else if (error.statusCode === 500 && error.message.includes('500')) {
        return  retryCSMSRequest(data,clientid,removalid, eligibility_period_id, sqnm_sw);
      } else {
      sql = query_fcCsms;

      util.executeDBQuery(sql,[data, csmsResponseJson, clientid , removalid , sqnm_sw , null, true, eligibility_period_id])
      .then(resp => {
          result = formatResults(resp);
          return resolve(result);
        })
      .catch(err => {
          LOGGER.error(err)
          return reject(err);
        })
return reject(error);
    }
  }
  });
  
  }

  function checkreferalId(data,error) {
    const errorCheck = error.message.split('Referral ID')[1];
    const referralIdDetails = errorCheck.split('exists')[0];
    if (referralIdDetails) {
      data.referralId = Number(referralIdDetails);
      data.ivdRecordType = 'UPDT-E';
      return retryCSMSRequest(data,clientid,removalid,eligibility_period_id,sqnm_sw);
    }
  }


  function retryCSMSRequest(data,clientid,removalid, eligibility_period_id, sqnm_sw) {
   
    return new Promise(async (resolve, reject) => { 
      try { 
        const options = {
        method: 'POST',
        uri: `${app.get('CSMSAPI')}/batchive/camel/ivEService`,
        body: data,
        json: true,
      };
      const resp = await axios.post(options.uri, options.body, {headers: {
                    'Content-Type': 'application/json'
                }});
      const csmsresponse = resp.data;

      let sql = '';
      let result = '';
      let csmsfailureflag = false;
      const csmsResponseJson = JSON.stringify(csmsresponse);

      if (csmsresponse.message && csmsresponse.message !== '4000' && csmsresponse.message !== '4001' && csmsresponse.messageCode !== '4000' && csmsresponse.messageCode !== '4001') {
        csmsfailureflag = true;
      }

      sql = query_fcCsms;

        util.executeDBQuery(sql,[data, csmsResponseJson, clientid , removalid , sqnm_sw , null, csmsfailureflag, eligibility_period_id])
        .then(_data => {
            result = formatResults(_data);
            return resolve(result);
        })
        .catch(err => reject(err));
    } catch (error) {

      let sql = '';
      let result = '';
      const csmsResponseJson = JSON.stringify(error);

      sql = query_fcCsms;

        util.executeDBQuery(sql, [data, csmsResponseJson, clientid , removalid , sqnm_sw , null, true, eligibility_period_id])
        .then(_data => {
            result = formatResults(_data);
            return resolve(result);
        })
        .catch(err => {
            LOGGER.error(err);
            return reject(err);
        });
      return reject(error);
    }
  });
  
  }

  function formatResults(data) {
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
  


  IVEReferrals.updatencpcasenumbers = function (data,reqctx) {
      const formatData = JSON.stringify(data);

      let sql = 'select * from sp_csms_updatencpcasenumbers($1)';

      return util.executeDBQuery(sql, [formatData])
        .then(_data => {
          if(_data && _data.length > 0) {
            return {
              _data,
            };
          } else {
            return {message: 'Please try again later', code: 500};
          }
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };

  IVEReferrals.ivecsmsData = (data, reqctx) => {
      let sql = '';
      let result = '';
      sql = `select json_agg(d) from (
                 select a.csmsref_process_sw,a.eligibility_period_id, a.csmsrefpayload, tce.client_id, tce.removal_id, tep.sqnm_sw from cjams.ive_auto_approvals a
                 join tb_eligibility_period tep on tep.eligibility_period_id =  a.eligibility_period_id
                 join tb_client_eligibility tce on tce.eligibility_id = tep.eligibility_id
                 where a.activeflag = 1 and coalesce(a.auto_approval_process_sw, 'N') = 'Y' and coalesce(a.csmsref_process_sw, 'N') = 'N' order by a.insertedon desc limit $1
      ) d`;


      return util.executeDBQuery(sql ,[data.where.limit])
      .then(_data => {
        if (_data !== null && typeof _data !== 'undefined' && _data.length > 0) {
         // To be enabled with the new API
         result = _data[0].json_agg;

        if (result && result.length) {
           result.forEach(element =>{
             if (element.csmsrefpayload) {
              sendCSMSRequest(element.csmsrefpayload, element.client_id,	element.removal_id, element.eligibility_period_id, element.sqnm_sw);
              }
          })
        }

        } else {
          result = {
            'data': [],
          };
        }
        LOGGER.info(result);
        return _data;
      })
      .catch(e => {
        const error = errorUtils.formatExceptionError(e);
        LOGGER.error('>>>>ERROR:', error);
        throw error;
      });
  };
  

  // CSMS Reverse flow
  IVEReferrals.remoteMethod(
    'updatencpcasenumbers', {
      description: 'To get csms case numbers',
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
        path: '/ive/updatencpcasenumbers/',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: 'application/json',
      },
    }
  );  

   // Trigger to pass IVE json to CSMS data
   IVEReferrals.remoteMethod(
    'ivecsmsData', {
      description: 'Trigger to Send IVE Data',
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
        path: '/ive/csmsreferrals',
        verb: 'post',
        status: 200,
        errorStatus: 400,
        contentType: 'application/json',
      },
    }
  );


};
