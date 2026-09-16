'use strict';
const LOGGER = require("log4js").getLogger("fmisresponse");
var server = require('../../server/server');
const app = require('../../server/server');
const util = require('../utils/utils');
var fs = require('fs');
var result = 'done';

module.exports = function(fmisResponse) {
fmisResponse.getResponse = (request) => {
    fs.readFile('./inboundfiles/fmis_response_input.txt', 'utf8', (err,data) => {
        if (err) {
            LOGGER.error(err);
            return;
        }
        LOGGER.debug("File Has been read");
        var ar  = data.split("\n");
		var lines  = ar.length;
        LOGGER.debug('No of lines '+ar.length);
		for(let i=0;i<lines;i++) {
			
			// NOSONAR
            // Header processing : when i=0
			 //if(i==0){
			// 	LOGGER.debug('Processing Header:'+i);
			// 	var header = ar[0];	
			// 	var statusCode = header.substr(0,3); 
			// 	var currentTimestamp = header.substr(3,26); 				
			// 	var batchNo = header.substr(29,5);			
			// 	var text = header.substr(34,22);
			// 	LOGGER.debug(statusCode,"1",currentTimestamp,"1",batchNo,"1",text);
			// 	 var insertRec = new PS('insert-rec', 'INSERT INTO interfacecsesinbound(statusCode, currentTimestamp, batchNo, text) VALUES($1, $2, $3, $4) ');
			// 	insertRec.values = [statusCode, currentTimestamp, batchNo, text];
			// 	LOGGER.debug(insertRec.values);
			// 	db.any(insertRec)
			// 	.then(() => {
			// 		LOGGER.debug('success')
			// 	})
			// 	.catch(error => {
			// 		LOGGER.debug(error) 
			// 	}); 
			//LOGGER.debug('here');	
			// }
			// Detail records processing i=1 ...lines-2,  i<lines-1
			
		    if ( i>=0){
				LOGGER.debug('Processing Detail records:'+i);
				var detail = ar[i];
				
				var batch_dt= detail.substr(3,8);    // `echo "$line" | awk '{if (substr($0,4,8)~/^[0-9 ]/) {print substr($0,4,8)} else {print "Batch Dt Invalid"} }' `
				var batch_type= detail.substr(11,1);    // `echo "$line" | awk '{if (substr($0,12,1)~/^[A-Za-z0-9 ]/) {print substr($0,12,1)} else {print "Batch Type Invalid"} }' `
				var batch_no= detail.substr(12,3);    // `echo "$line" | awk '{if (substr($0,13,3)~/^[0-9]/) {print substr($0,13,3)} else {print "Batch No. Invalid"} }' `
				var batch_seq_no= detail.substr(15,5);    // `echo "$line" | awk '{if (substr($0,16,5)~/^[0-9 ]/) {print substr($0,16,5)} else {print "Batch Seq. No Invalid"} }' `
				var user_id= detail.substr(20,8);    // `echo "$line" | awk '{if (substr($0,21,8)~/^[A-Za-z0-9]/ ) {print substr($0,21,8)} else {print "User ID Invalid"} }' `
				var terminal_id= detail.substr(28,4);    // `echo "$line" | awk '{if (substr($0,29,4)~/^[A-Za-z0-9 ]/) {print substr($0,29,4)} else {print "Terminal ID Invalid"} }' `
				var effective_dt= detail.substr(32,8);    // `echo "$line" | awk '{if (substr($0,33,8)~/^[0-9 ]/) {print substr($0,33,8)} else {print "Effective Dt Invalid"} }' `
				var disburse_method_ind= detail.substr(40,1);    // `echo "$line" | awk '{if (substr($0,41,1)~/^[A-Za-z ]/) {print substr($0,41,1)} else {print "Disburse Method Invalid"} }' `
				var capitalize_ind= detail.substr(41,1);    // `echo "$line" | awk '{if (substr($0,42,1)~/^[0-9 ]/) {print substr($0,42,1)} else {print "Capitalize IND Invalid"} }' `
				var transaction_cd= detail.substr(42,3);    // `echo "$line" | awk '{if (substr($0,43,3)~/^[0-9 ]/) {print substr($0,43,3)} else {print "Transaction CD Invalid"} }' `
				var modifier= detail.substr(45,1);    // `echo "$line" | awk '{if (substr($0,46,1)~/^[0-9 ]/) {print substr($0,46,1)} else {print "Modifier Invalid"} }' `
				var reverse_ind= detail.substr(46,1);    // `echo "$line" | awk '{if (substr($0,47,1)~/^[0-9 ]/) {print substr($0,47,1)} else {print "ReverseIND Invalid"} }' `   
				var agency_object_cd= detail.substr(80,4);    // `echo "$line" | awk '{if (substr($0,81,4)~/^[0-9 ]/)  {print substr($0,81,4)} else {print "Agency Object Invalid"} }' `
				var vendor_number= detail.substr(156,10);    // `echo "$line" | awk '{if (substr($0,157,10)~/^[0-9A-Za-z]/ ) {print substr($0,157,10)} else {print "Vendor No. Invalid"} }' `
				var invoice_no= detail.substr(170,14);    // `echo "$line" | awk '{if (substr($0,171,14)~/^[0-9]/ ) {print substr($0,171,14)} else {print "Invoice No. Invalid"} }' `
				var warrant_no= detail.substr(238,9);    // `echo "$line" | awk '{if (substr($0,239,9)~/^[0-9A-Za-z ]/) {print substr($0,239,9)} else {print "Warrant No. Invalid"} }' `
				var trans_amt= detail.substr(282,13);    // `echo "$line" | awk '{if (substr($0,283,13)~/^[0-9]/ ) {print substr($0,283,13)} else {print "Trans Amt Invalid"} }' `
				var wrnt_wrtn_dt= detail.substr(813,8);    // `echo "$line" | awk '{if (substr($0,814,8)~/^[0-9 ]/ ) { print substr($0,814,8)} else {print "Warrent Written Dt Invalid"} }' `
				var doc_no= detail.substr(200,8);    // `echo "$line" | awk '{if (substr($0,201,8)~/^[0-9A-Za-z ]/) {print substr($0,201,8)} else {print "Cur Doc No. Invalid"} }' `
				var doc_no_sfx= detail.substr(208,3);    // `echo "$line" | awk '{if (substr($0,209,3)~/^[0-9 ]/) {print substr($0,209,3)} else {print "Cur Doc No. Suffix Invalid"} }' `

 				const dataQuery = 'insert into tb_fmis_response (BATCH_DT,BATCH_TYPE,BATCH_NO,BATCH_SEQ_NO,USER_ID,TERMINAL_ID,EFFECTIVE_DATE,DISBURSE_METHOD_IND,CAPITALIZE_IND,TRANSACTION_CODE,MODIFIER,REVERSE_IND,AGENCY_OBJECT_CD,VENDOR_NUMBER,INVOICE_NO,WARRANT_NO,WARRANT_WRITTEN_DT,CUR_DOC_NO,CUR_DOC_NO_SUFFIX,TRANS_AMT,CREATE_USER_ID,UPDATE_USER_ID,DELETE_SW) VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21, $22, $23)';
                 return util.executeDBQuery(dataQuery, [batch_dt,batch_type,batch_no,batch_seq_no,user_id,terminal_id,effective_dt,disburse_method_ind,capitalize_ind,transaction_cd,modifier,reverse_ind,agency_object_cd,vendor_number,invoice_no,warrant_no,wrnt_wrtn_dt,doc_no,doc_no_sfx,trans_amt,'interface','interface','N'])
                     .then(_result => {
                        LOGGER.debug('success');
                        return _result;
                     }).catch(_err => { LOGGER.error('>>>>ERROR:', _err); throw _err; });
				
			}
			// Footer processing i=lines-1
			//if(i==( lines-1)){
			// else {
			// 	LOGGER.debug('Processing Footer:'+i);
			// 	var footer = ar[lines-1];
				
			// 	 var insertRec = new PS('insert-rec', 'INSERT INTO csesinbound(statusCode, currentTimestamp, batchNo, text) VALUES($1, $2, $3, $4)  WHERE id = 1;');
			// 	insertRec.values = [statusCode, currentTimestamp, batchNo, text];
			// 	LOGGER.debug(insertRec.values);
			// 	db.any(insertRec)
			// 	.then(() => {
			// 		LOGGER.debug('success')

			// 	})
			// 	.catch(error => {
			// 		LOGGER.debug(error) 
			// 	}); 
				
			// }
			
        } 
		
    });
    return Promise.resolve(result);
    };
    fmisResponse.remoteMethod('getResponse', {
        http: {
            path: '/getResponse',
            verb: 'get'
        },
        accepts: {
            arg: 'servicelogData',
            type: 'Object',
            http: {
                source: 'body'
            }
        },
        returns: {
            arg: 'Data',
            type: 'Object'
        }
    });

    fmisResponse.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    fmisResponse.observe('access', (ctx, next) => util.access(ctx, next));
    fmisResponse.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};

