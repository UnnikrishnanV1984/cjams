'use strict';
const LOGGER = require("log4js").getLogger("attachment");
let app = require('../../server/server');
const util = require('../utils/utils');
let uuid = require('node-uuid');
const fs = require("fs");
let path = require('path');
let str = require('string-to-stream');
const mime = require('mime');
const axios = require('axios');
let FormData = require('form-data');
const commonapi = require('../models/commonapi');
const documentproperties = require('../models/documentproperties');
let config = require('../../server/config.json');
const moment = require('moment');
const { Logger } = require("log4js");
const content_type = "application/json";
const dt_format = 'MM/DD/YYYY';
const https = require('https'); 

module.exports = Attachment => {    

    Attachment.uploadsFile = (ctx, res, srno, filetype,docsInfo, attachmenttype, personid, objecttypekey,
        objectid,additionalobjectid, additionalobjecttype, actualdocumentdate, description,other, servicecaseid, insertedby, servicerequestid, reqctx) => { //NOSONAR
        res.setHeader("custom-log", "uploadfile");
        let documentUploadInfo = [];
        let caseRintake = '';
        if(docsInfo) {
            documentUploadInfo = docsInfo.split("|");
        }else{
            documentUploadInfo.push('Document');
            documentUploadInfo.push('CW-CJAMS');
            documentUploadInfo.push('CW-Other Document');
        }
      	 var check='';
      	if(srno){
          check = srno.charAt(0);
           }
        
        if(check === 'i' || check ==='I') {
            caseRintake = 'Intake';
        }  else {
            caseRintake = 'Case';
        }
        documentUploadInfo.push(srno);
        LOGGER.debug("docsData", documentUploadInfo);
        
        res.attachmenttype = attachmenttype;
        res.personid = personid;
        res.objecttypekey = objecttypekey;
        res.additionalobjectid = additionalobjectid;
        res.additionalobjecttype = additionalobjecttype;
        res.objectid = objectid;
        res.actualdocumentdate =actualdocumentdate;
        res.description = description;
        res.other = other;
        res.servicecaseid =servicecaseid;
        res.servicerequestid =servicerequestid;
        res.insertedby = insertedby;
        res.documentUploadInfo = documentUploadInfo;
        res.caseRintake = caseRintake;
        return Attachment.plainUploadsFiletoECMS(ctx, res, srno,filetype, reqctx);
    }

    // For Uploading the document or image to ECMS 
    Attachment.plainUploadsFiletoECMS = (ctx, res, srno,filetype, reqctx) => {
        return Attachment.uploadFileToEcms(ctx, res, srno,filetype, reqctx);
    }

    //Code for Uploading Plain file to ECMS
    Attachment.getFileHash = (filepath) => {
        return new Promise((resolve, reject) => {
            var crypto = require('crypto'); //SonarQube fix - removed the non used hash_algorithm

            fs.readFile(filepath, function (err, data) {
                var checksum = crypto
                    .createHash('md5')
                    .update(data, 'utf8')
                    .digest('hex');
                resolve(checksum);
            });
        });

    };

    function getSecurityDetails(reqctx, res){
        let suserid=undefined;
        if(reqctx && reqctx.req &&reqctx.req.headers){
          suserid=reqctx.req.headers.securityusersid
        }
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}
        return {suserid, _email, insertedby: res.insertedby ? res.insertedby :suserid}
    }

    // plain upload for ECMs
    Attachment.uploadFileToEcms = async (ctx, res, srno,filetype, reqctx) => {
        const _email=getSecurityDetails(reqctx, res)._email;
        const insertedby = getSecurityDetails(reqctx, res).insertedby;
        
        var requestuserinfo = {'token': '', 'email': _email};
        var sroletypekey ;
        await util.getuserinfo(requestuserinfo).then (data => {
			sroletypekey = data.roletypekey;
            res.username = data.fullname;
		});  
        return new Promise((resolve, reject) => {

            var returnData = {};    //SonarQube fix - commented it as maxfilesize is only assigned not used anywhere else
            /* NOSONAR
            let maxfilesize = config.uploadMaxSize; 
            if (maxfilesize != null && maxfilesize !== undefined) {
                maxfilesize = maxfilesize * 1024 * 1024;
            }
            else {
                maxfilesize = 10 * 1024 * 1024;
            }*/
            var filename = "";
          	if(srno){
             	 res.setHeader("custom-log1", srno);
               }
            app.models.Localstorage.saveFile(ctx, res, srno )
            .then(data => {
                    filename = data.filename;
                        if(filetype !== 'video'){
                            return Promise.resolve(data);
                        }
                        const destExtn ='.mp4';
                        const srcFileName = data.filename;
                        const srcFileNameWOExtn = srcFileName.substring(0, srcFileName.lastIndexOf('.'));
                        const destFileName = srcFileNameWOExtn + '_' + uuid() + destExtn;
                        filename = destFileName;
                        LOGGER.debug("calling vdeo convert");
                        return Attachment.videoConvert(srcFileName, "uploads/"+destFileName);
                    })
                    .then(data => {
                        res.setHeader("custom-log2", filename);
                        const uploadRoot = path.resolve(app.dataSources.localstorage.settings.root,'uploads');
                        const requested = path.basename(filename);
                        var filepath = path.resolve(uploadRoot, requested); 
                        LOGGER.debug(filepath);
                        LOGGER.debug(filename);
                        res.fName = filename;
                        return Attachment.getEcmsDocumentInfo(ctx, res, srno).then(function(docInfo) {
                        var reqInfo = Attachment.getEcmsRequestInfo(ctx, res, srno);
                        Attachment.getFileHash(filepath).then(hash => {
                        var userroletypekey = sroletypekey;
                        docInfo.filemdhash = hash;
                        let externalapidata = {};                        
                        const documentrequest = {
                            uploadFile: {
                                value: fs.createReadStream(filepath),
                                options: { filename: filepath, contentType: null }
                            },
                            ecmsDocumentInfo: {
                                value: JSON.stringify(docInfo),
                                options: { filename: 'blob', contentType: content_type }
                            },
                            requestInfo: {
                                value: JSON.stringify(reqInfo),
                                options: { filename: 'blob', contentType: content_type }
                            }
                        };
                        externalapidata = getexternalapidata(res, srno, docInfo, insertedby, documentrequest,'ecms_document');
                        var v_externalapilogsid = null;
                        commonapi.addupdateexternalapilogs(externalapidata).then(resp => {
                            v_externalapilogsid = resp;
                        });
                        app.models.Role.findOne({
                            fields:{"openamrole":true},
                            where:{
                                roletypekey: userroletypekey,
                            }
                          }).then(async function(rolededetails) {

                            try {
                                const form = returnFormDataFn(documentrequest)
                                const response = await axios.post(config.uploadFileToECMSPath, form, {
                                    headers: {
                                        'appKey': config.appKey,
                                        'role': config.role,
                                        'cache-control': 'no-cache',
                                        ...form.getHeaders()
                                    }
                                });
                                var attachmentinfo = [];
                                const infoObj = {
                                    insertedby: insertedby,
                                    filename: filename,
                                    docInfo: docInfo
                                }
                                returnData = getAttachementinfo(returnData, response.data, res, srno, v_externalapilogsid, infoObj);
                                returnData.insertedby = insertedby;
                                returnData.updatedby = insertedby;
                                attachmentinfo[0] = returnData;
                                resolve(saveDocumentProperties(attachmentinfo, reqctx));

                            } catch (err) {
                                handleEcmsUploadError(err, v_externalapilogsid, insertedby, reject);
                            }
                        });
                    });
                });
                }).catch(err => {
                    LOGGER.error(err);
                    return err;
                }) 
        });
    };

    // This metadata is free text -- description, filename, the caller-supplied 'other' --
    // and a query string cannot carry it. An unencoded '&' makes qs start a new key, and
    // a '#' opens the URL fragment, which browsers and most HTTP clients strip before the
    // request is sent, so values arrived truncated at the first special character. The
    // '#' case was not fixable here at all: those bytes never reach this process. It is
    // taken as a JSON body instead, which needs no URL escaping and also keeps the text
    // out of the access log and clear of the URL length limit.
    Attachment.edmsuploadmetadata = (ctx, res, data, reqctx) => { //NOSONAR
        res.setHeader("custom-log", "uploadfile");
        data = data || {};
        let documentUploadInfo = [];
        let caseRintake = '';
        if(data.docsInfo) {
            // A JSON body is not coerced per field the way the old string-typed query
            // arguments were, so don't assume these two arrived as strings.
            documentUploadInfo = String(data.docsInfo).split("|");
        }else{
            documentUploadInfo.push('Document');
            documentUploadInfo.push('CW-CJAMS');
            documentUploadInfo.push('CW-Other Document');
        }
        let check='';
        if(data.srno){
        check = String(data.srno).charAt(0);
        }

        if(check === 'i' || check ==='I') {
            caseRintake = 'Intake';
        }  else {
            caseRintake = 'Case';
        }
        documentUploadInfo.push(data.srno);
        LOGGER.debug("docsData", documentUploadInfo);

        res.attachmenttype = data.attachmenttype;
        res.personid = data.personid;
        res.objecttypekey = data.objecttypekey;
        res.additionalobjectid = data.additionalobjectid;
        res.additionalobjecttype = data.additionalobjecttype;
        res.objectid = data.objectid;
        res.actualdocumentdate =data.actualdocumentdate;
        res.description = data.description;
        res.other = data.other;
        res.servicecaseid =data.servicecaseid;
        res.servicerequestid =data.servicerequestid;
        res.insertedby = data.insertedby;
        res.fName = data.filename;
        res.filesize = data.filesize;
        res.documentUploadInfo = documentUploadInfo;
        res.caseRintake = caseRintake;
        res.deletedocid = data.deletedocid;
        if(data.fileSha256Hash){
            res.fileSha256Hash = data.fileSha256Hash;
        }
        return Attachment.uploadMetadataToEdms(res, data.srno, reqctx);
    }

    // For sending the document metadata to EDMS to fetch the dynamic URL 
    Attachment.uploadMetadataToEdms = async (res, srno, reqctx) => {
        const _email=getSecurityDetails(reqctx, res)._email;
        const insertedby = getSecurityDetails(reqctx, res).insertedby;        
        let requestuserinfo = {'token': '', 'email': _email};
        await util.getuserinfo(requestuserinfo).then (data => {
            res.username = data.fullname;
		});  
        return new Promise((resolve, reject) => {
            let returnData = {};    
          	if(srno){
                res.setHeader("custom-log1", srno);
            }            
            Attachment.getEdmsDocumentInfo(res, srno).then(function(docInfo) {
                let externalapidata = {};
                externalapidata = getexternalapidata(res, srno, docInfo, insertedby, docInfo,'edms_metadata_upload');
                let v_externalapilogsid = null;
                commonapi.addupdateexternalapilogs(externalapidata).then(resp => {
                    v_externalapilogsid = resp;
                });
                axios.post(
                    config.uploadFileToEDMSPath,
                    docInfo,
                    {
                        headers: {
                            'appKey': config.appKey,
                            'role': config.role,
                            'cache-control': 'no-cache',
                            'content-type': 'application/json'
                        }
                    }
                )
                .then(async (resp) => {
                    let attachmentinfo = [];
                    const infoObj = {
                        insertedby: insertedby,
                        filename: res.fName,
                        docInfo: docInfo
                    }
                    returnData = getEdmsAttachementinfo(returnData, resp.data, res, srno, v_externalapilogsid, infoObj);
                    returnData.insertedby = insertedby;
                    returnData.updatedby = insertedby;
                    attachmentinfo[0] = returnData;                            
                    resolve(saveDocumentProperties(attachmentinfo, reqctx));
                })
                .catch((err) => {
                    LOGGER.error(err);
                    externalapidata = {};
                    externalapidata.details =  {
                        externalapilogsid: v_externalapilogsid,
                        objecttype: 'edms_metadata_upload',
                        updatedby: insertedby,
                        insertedby: insertedby
                    }
                    externalapidata.info = null;
                    externalapidata.status = 'update';
                    externalapidata.resstatus = 'error';
                    
                    if (err.response) {
                        externalapidata.response = err.response.data;
                        commonapi.addupdateexternalapilogs(externalapidata);
                        reject(err.response); 
                    } else {
                        externalapidata.response = err;
                        commonapi.addupdateexternalapilogs(externalapidata);
                        reject(err);
                    }
                });
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                reject(err);
            });
        });
    };

    Attachment.getEdmsDocumentInfo = (res, srno) => {
        LOGGER.debug("EdmsDocumentInfo",res.username ,"File name ",res.fName);
        if(res.attachmenttype === 'person' || res.attachmenttype === 'Client') {
        LOGGER.debug(res.attachmenttype);
        let query = {};
        if(res.attachmenttype === 'person'){
            query = {personid : res.personid};
        }else{
            query = {cjamspid : res.personid};
        }

        return app.models.Person.findOne({
            fields:{"firstname":true,"lastname":true,"dob":true,"cjamspid":true,"personid":true},
            where:  query
            }).then(function(persondetails) {
            if(!persondetails)
                {persondetails={};}
            return app.models.Personidentifier.findOne({
                fields:{"personidentifiervalue":true},
                where:{
                    personid: persondetails.personid,
                    personidentifiertypekey:'SSN'
                }
                }).then(function(personssndetails) {
                    return getedmspersonssndetails(srno, personssndetails, res, persondetails);
            });
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
        } else {
            let caseno = null;
            if(['Case','Intake'].includes(res.caseRintake)){ //SonarQube fix - to extract nested ternary operation into independent statement.
                caseno = srno;
            }
            return Promise.resolve({
                "uploadedBy": res.username? res.username :'CJAMS',
                "agencyCode": config.agencyCode,
                "ownerSystem": config.ownerSystem,
                "ownerRepo": "Default",
                "originatingSystem": config.originatingSystem,
                "documentId": "1",
                "dynamicFields": {
                        "dateOfBirth": [null],
                        "clientId": null,
                        "cjamsId": null,
                        "ssn": null,
                        "dob": null,
                        "lastName": null,
                        "firstName": null,
                        "mdmId": null,
                        "cjamsDocumentId": null,
                        "entityType": "Case",
                        "entityId": null,
                        "personID": null,
                        "testSSN": [""],
                        "clientITIN": "",
                        "needaddwork": "false",
                        "HeadOfHouseHoldSsn": "",
                        "CaseNumber": [caseno],
                        "doctor'sName": ["false"],
                        "mytestDate": null,
                        "stampedDate": null,
                        "familyViolence": "false",
                        "receivedDate": new Date(),
                        "caseManager": [""],
                        "piiInd": "false"
                },
                "deletedInd": false,
                "tags": [
                        {
                            "code": "verification_cd",
                            "value": "PEND"
                        }
                    ],   
                "documentName": res.fName,
                "fileSha256Hash":res.fileSha256Hash,
                "status": "",
                "fileData": {},
                "comments": "",
                "documentCategory": checkEmptyStr(res.documentUploadInfo[1]).trim(),
                "documentType": checkEmptyStr(res.documentUploadInfo[2]).trim(),
                "filemdhash": "7669d00ad7a4c66040f036d771241716",
                "generatedBy": "",
                "generatedDate": new Date(),
                "workflowState": "",
                "updatedBy": "",
                "updatedTs": new Date().getTime(),
                "administration": "CJAMS-CW",
                "jurisdiction": "",
                "sensitivity": "",
                "site": "",
                "expectedNumOfPages": "",
                "receivedNumOfPages": "",
                "storageFileName": res.fName,
                "uploadedDate": new Date()
            });
        }
    };   

    function getedmspersonssndetails(srno, personssndetails, res, persondetails) {
        let casenum = srno;
        if (!personssndetails) { personssndetails = {}; }
        if (res.attachmenttype === 'person') {
            casenum = '';
        }
        return app.models.Personidentifier.findOne({
            fields: { "personidentifiervalue": true },
            where: {
                personid: persondetails.personid,
                personidentifiertypekey: 'MDM_ID'
            }
        }).then(function (personmdmdetails) {
            if (!personmdmdetails) { personmdmdetails = {}; }
            return {
                "uploadedBy": res.username ? res.username : 'CJAMS',
                "agencyCode": config.agencyCode,
                "ownerSystem": config.ownerSystem,
                "ownerRepo": "Default",
                "originatingSystem": config.originatingSystem,
                "documentId": "1",
                "dynamicFields": {
                        "dateOfBirth": [checkEmptyStr(persondetails.dob)],
                        "clientId": checkEmptyStr(persondetails.cjamspid),
                        "cjamsId": checkEmptyStr(persondetails.cjamspid),
                        "ssn": checkEmptyStr(personssndetails.personidentifiervalue),
                        "dob": checkEmptyStr(persondetails.dob),
                        "lastName": checkEmptyStr(persondetails.lastname),
                        "firstName": checkEmptyStr(persondetails.firstname),
                        "mdmId": checkEmptyStr(personmdmdetails.personidentifiervalue),
                        "cjamsDocumentId": null,
                        "entityType": "Client",
                        "entityId": persondetails.personid,
                        "personID": persondetails.personid,
                        "testSSN": [checkEmptyStr(personssndetails.personidentifiervalue)],
                        "clientITIN": "",
                        "needaddwork": "false",
                        "HeadOfHouseHoldSsn": "",
                        "CaseNumber": [(res.caseRintake === 'Case') ? casenum : null,],
                        "doctor'sName": ["false"],
                        "mytestDate": null,
                        "stampedDate": null,
                        "familyViolence": "false",
                        "receivedDate": new Date(),
                        "caseManager": [""],
                        "piiInd": "false"
                },
                "deletedInd": false,
                "tags": [
                        {
                            "code": "verification_cd",
                            "value": "PEND"
                        }
                    ],   
                "documentName": res.fName,
                "fileSha256Hash":res.fileSha256Hash,
                "status": "",
                "fileData": {},
                "comments": "",
                "documentCategory": checkEmptyStr(res.documentUploadInfo[1]).trim(),
                "documentType": checkEmptyStr(res.documentUploadInfo[2]).trim(),
                "filemdhash": "7669d00ad7a4c66040f036d771241716",
                "generatedBy": "",
                "generatedDate": new Date(),
                "workflowState": "",
                "updatedBy": "",
                "updatedTs": new Date().getTime(),
                "administration": "CJAMS-CW",
                "jurisdiction": "",
                "sensitivity": "",
                "site": "",
                "expectedNumOfPages": "",
                "receivedNumOfPages": "",
                "storageFileName": res.fName,
                "uploadedDate": new Date()
            };
        });
    }

    function getEdmsAttachementinfo(returnData, resp, res, srno, v_externalapilogsid, infoObj){
        const docInfo = infoObj.docInfo;
        const insertedby = infoObj.insertedby;
        const filename = infoObj.filename;
        let result = resp;
        returnData.filename = result.documentId;
        returnData.originalfilename = filename;
        returnData.date = new Date();
        returnData.mime = "application/*";
        returnData.s3bucketpathname = result.uploadUrl;
        returnData.ecmsdocumentid = result.documentId;
        returnData.srno = srno;
        const externalapidata = {};
        externalapidata.details =  {
            externalapilogsid: v_externalapilogsid,
            objecttype: 'edms_metadata_upload',
            updatedby: insertedby,
            insertedby: insertedby
        }
        externalapidata.info = null;
        externalapidata.status = 'update';
        externalapidata.response = returnData;
        externalapidata.resstatus = returnData.ecmsdocumentid ? 'success' : 'error';
        commonapi.addupdateexternalapilogs(externalapidata);
        const servicecaseid =  res.servicecaseid ? res.servicecaseid : null;
        const objectid = res.objecttypekey === 'ServiceRequest' ? res.objectid : null;
        const servicerequestid = (res.servicerequestid ? res.servicerequestid : null);
        returnData.documentattachment = {};
        returnData.documenttypekey = 'Attachment';
        returnData.attachmenttypekey = res.attachmenttype;
        returnData.attachmenttype = res.attachmenttype;
        returnData.personid = res.personid;
        returnData.intakenumber = res.objecttypekey === 'ServiceRequest' ? srno : null;
        returnData.documentdate =  moment(new Date()).format(dt_format) ;
        returnData.actualdocumentdate =  res.actualdocumentdate && res.actualdocumentdate != 'undefined' ? res.actualdocumentdate: moment(new Date()).format(dt_format) ;        
        returnData.description = res.description;
        returnData.other = res.other;
        returnData.documentattachment.attachmentclassificationtypekey = res.documentUploadInfo[1] ;
        returnData.documentattachment.attachmentclassificationsubtypekey = res.documentUploadInfo[2] ;
        returnData.documentattachment.attachmentdate = moment(new Date()).format(dt_format) ;
        returnData.documentattachment.attachmenttypekey = 'Document';
        returnData.documentattachment.activeflag = 1;
        returnData.servicecaseid = res.objecttypekey === 'Servicecase' ? res.objectid : servicecaseid;
        returnData.rootobjecttypekey = res.objecttypekey && !res.personid ? res.objecttypekey : docInfo.dynamicFields.entityType;
        returnData.objecttypekey = res.objecttypekey && !res.personid ? res.objecttypekey : docInfo.dynamicFields.entityType;
        returnData.servicerequestid = (res.objecttypekey === 'courtorder' || res.objecttypekey === 'investigationappeal' || returnData.objecttypekey === 'Client') ? servicerequestid : objectid;
        returnData.objectid = res.personid ? res.personid : checkNull(res.objectid);        
        returnData.additionalobjectid = checkNull(res.additionalobjectid);
        returnData.additionalobjecttype = checkNull(res.additionalobjecttype);
        returnData.uploadstatus = 'Pending';
        returnData.activeflag = 3;
        returnData.title = res.documentUploadInfo[2] ;
        returnData.filesize = res.filesize;
        returnData.deletedocid = res.deletedocid;
        return returnData;
    }

    function saveDocumentProperties(attachmentinfo, reqctx){
        if(attachmentinfo && attachmentinfo.length) {
            return Attachment.savetodocumentproperties(attachmentinfo, reqctx);
        }
    }

    function getexternalapidata(res, srno, docInfo, insertedby, documentrequest, objecttype){
        const externalapidata = {};
        externalapidata.details =  {
            objectid: res.personid ? res.personid : srno,
            objecttype: objecttype,
            objectsubtype: res.objecttypekey && !res.personid ? res.objecttypekey : docInfo?.dynamicFields?.entityType,
            updatedby: insertedby,
            insertedby: insertedby
        }
        externalapidata.resstatus = '';
        externalapidata.request = documentrequest;
        externalapidata.response = null;
        externalapidata.status = 'add';
        return externalapidata;
    }

    function getAttachementinfo(returnData, resp, res, srno, v_externalapilogsid, infoObj){
        const docInfo = infoObj.docInfo;
        const insertedby = infoObj.insertedby;
        const filename = infoObj.filename;
        const uploadRoot = path.resolve(app.dataSources.localstorage.settings.root,'uploads');
        const requested = path.basename(filename);
        let filepath = path.resolve(uploadRoot, requested); 
        let result = resp;
        returnData.filename = result.documentId;
        returnData.originalfilename = filename;

        returnData.date = new Date();
        returnData.mime = "application/*";
        returnData.numberofbytes = fs.statSync(filepath).size;
        returnData.s3bucketpathname = "/attachments/downloadFileFromECMS?docId=" + result.documentId + "&filename=" + filename;
        returnData.ecmsdocumentid = result.documentId;
        returnData.srno = srno;
        const externalapidata = {};
            externalapidata.details =  {
                externalapilogsid: v_externalapilogsid,
                objecttype: 'ecms_document',
                updatedby: insertedby,
                insertedby: insertedby
            }

            externalapidata.info = null;
            externalapidata.status = 'update';
            externalapidata.response = returnData;
        externalapidata.resstatus = returnData.ecmsdocumentid ? 'success' : 'error';
        commonapi.addupdateexternalapilogs(externalapidata);
        const servicecaseid =  res.servicecaseid ? res.servicecaseid : null;
        const objectid = res.objecttypekey === 'ServiceRequest' ? res.objectid : null;
        const servicerequestid = (res.servicerequestid ? res.servicerequestid : null);
        returnData.documentattachment = {};
        returnData.documenttypekey = 'Attachment';
        returnData.attachmenttypekey = res.attachmenttype;
        returnData.attachmenttype = res.attachmenttype;
        returnData.personid = res.personid;
        returnData.intakenumber = res.objecttypekey === 'ServiceRequest' ? srno : null;
        returnData.documentdate =  moment(new Date()).format(dt_format) ;
        returnData.actualdocumentdate =  res.actualdocumentdate && res.actualdocumentdate != 'undefined' ? res.actualdocumentdate: moment(new Date()).format(dt_format) ;        
        returnData.description = res.description;
        returnData.other = res.other;
        returnData.documentattachment.attachmentclassificationtypekey = res.documentUploadInfo[1] ;
        returnData.documentattachment.attachmentclassificationsubtypekey = res.documentUploadInfo[2] ;
        returnData.documentattachment.attachmentdate = moment(new Date()).format(dt_format) ;
        returnData.documentattachment.attachmenttypekey = 'Document';
        returnData.documentattachment.activeflag = 2;
        returnData.servicecaseid = res.objecttypekey === 'Servicecase' ? res.objectid : servicecaseid;
        returnData.servicerequestid = (res.objecttypekey === 'courtorder' || res.objecttypekey === 'investigationappeal') ? servicerequestid : objectid;
        returnData.rootobjecttypekey = res.objecttypekey && !res.personid ? res.objecttypekey : docInfo.dynamicFields.entityType;
        returnData.objecttypekey = res.objecttypekey && !res.personid ? res.objecttypekey : docInfo.dynamicFields.entityType;
        returnData.objectid = res.personid ? res.personid : res.objectid;        
        returnData.additionalobjectid = checkNull(res.additionalobjectid);
        returnData.additionalobjecttype = checkNull(res.additionalobjecttype);
        returnData.activeflag = 2;
        return returnData;
    }

    Attachment.getEcmsDocumentInfo = (ctx, res, srno) => {
         LOGGER.debug("EcmsDocumentInfo",res.username ,"File name ",res.fName);
         if(res.attachmenttype === 'person' || res.attachmenttype === 'Client') {
            LOGGER.debug(res.attachmenttype);
               var query = {};
            if(res.attachmenttype === 'person'){
                query = {personid : res.personid};
            }else{
                query = {cjamspid : res.personid};
            }

            return app.models.Person.findOne({
                fields:{"firstname":true,"lastname":true,"dob":true,"cjamspid":true,"personid":true},
                where:  query
              }).then(function(persondetails) {
                if(!persondetails)
                    {persondetails={};}
                return app.models.Personidentifier.findOne({
                    fields:{"personidentifiervalue":true},
                    where:{
                        personid: persondetails.personid,
                        personidentifiertypekey:'SSN'
                    }
                  }).then(function(personssndetails) {
                    return getpersonssndetails(srno, personssndetails, res, persondetails);
                });
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } else {
            var caseno = null;
            if(['Case','Intake'].includes(res.caseRintake)){ //SonarQube fix - to extract nested ternary operation into independent statement.
                caseno = srno;
            }
            return Promise.resolve({
                "uploadedBy": res.username? res.username :'CJAMS',
                "agencyCode": config.agencyCode,
                "ownerSystem": config.ownerSystem,
                "originatingSystem": config.originatingSystem,
                "dynamicFields": {
                    "clientId": null,
                    "cjamsId": null,
                    "ssn": null,
                    "dob": null,
                    "lastName": null,
                    "firstName": null,
                    "caseNumber": caseno,
                    "mdmId": null,
                    "cjamsDocumentId": null,
                    "entityType": "Case",
                    "entityId": null
                },
                "documentName": res.fName,
                "filemdhash": "331e8397807e65be4f838ccd95787880",
                "uploadedDate": new Date(),
                "documentCategory": checkEmptyStr(res.documentUploadInfo[1]).trim(),
                "documentType": checkEmptyStr(res.documentUploadInfo[2]).trim(),
                "administration": "",
                "jurisdiction":"",
                "site": "",
                "updatedTs": new Date().getTime(),
            });
        }
    };

    function getpersonssndetails(srno, personssndetails, res, persondetails) {
        var casenum = srno;
        if (!personssndetails) { personssndetails = {}; }
        if (res.attachmenttype === 'person') {
            casenum = '';
        }
        return app.models.Personidentifier.findOne({
            fields: { "personidentifiervalue": true },
            where: {
                personid: persondetails.personid,
                personidentifiertypekey: 'MDM_ID'
            }
        }).then(function (personmdmdetails) {
            if (!personmdmdetails) { personmdmdetails = {}; }
            return {
                "uploadedBy": res.username ? res.username : 'CJAMS',
                "agencyCode": config.agencyCode,
                "ownerSystem": config.ownerSystem,
                "originatingSystem": config.originatingSystem,
                "dynamicFields": {
                    "clientId": checkEmptyStr(persondetails.cjamspid),
                    "cjamsId": checkEmptyStr(persondetails.cjamspid),
                    "ssn": checkEmptyStr(personssndetails.personidentifiervalue),
                    "dob": checkEmptyStr(persondetails.dob),
                    "lastName": checkEmptyStr(persondetails.lastname),
                    "firstName": checkEmptyStr(persondetails.firstname),
                    "caseNumber": (res.caseRintake === 'Case') ? casenum : null,
                    "mdmId": checkEmptyStr(personmdmdetails.personidentifiervalue),
                    "cjamsDocumentId": null,
                    "entityType": "Client",
                    "entityId": persondetails.personid
                },
                "documentName": res.fName,
                "filemdhash": "331e8397807e65be4f838ccd95787880",
                "uploadedDate": new Date(),
                "documentCategory": checkEmptyStr(res.documentUploadInfo[1]).trim(),
                "documentType": checkEmptyStr(res.documentUploadInfo[2]).trim(),
                "administration": "",
                "jurisdiction": "",
                "site": "",
                "updatedTs": new Date().getTime(),
            };
        });
    }

    function checkEmptyStr(value){
        return value ? value : '';
    }

    function checkNull(value){
        return value && value != 'undefined' ?  value : null;
    }

    Attachment.getEcmsRequestInfo = (ctx, res, srno) => {
        return {
            "agencyCode": config.agencyCode,
            "originatingSystem": config.originatingSystem,
            "ownerSystem": config.ownerSystem,
            "uploadedBy": res.username ? res.username :'CJAMS',
            "sessionId": "adhgakfgabjdhdagduhdgauyd"
        };
    };

    Attachment.downloadFile = async (ctx, res, docId, filename) => {

      
        var data = {
            agencyCode: config.agencyCode,
            originatingSystem: config.originatingSystem,
            ownerSystem: config.ownerSystem,
            requestedBy: 'cjamsuser',
            documentId: docId
        };
        var role = config.role;

        // Neither query arg is declared required, so a link missing filename
        // reaches here as undefined and the startsWith below throws a TypeError
        // that error-logger flattens into the same undiagnosable 400.
        if (!docId || !filename) {
            return res.status(400).json({ error: 'docId and filename are both required' });
        }

        if (filename.startsWith('UIR') && filename.length === 33) {
            data.ownerRepo = 'PROV_OLM';
            role = config.olmrole;
        }
        const uploadRoot = path.resolve(app.dataSources.localstorage.settings.root,'uploads');
        const requested = path.basename(filename);
        const dest = path.resolve(uploadRoot, requested); 
        var writestream = fs.createWriteStream(dest);

        try {
            const req = await axios({
                method: 'post',
                url: config.downloadFileFromECMSPath,
                data: data,
                headers: {
                    appKey: config.appKey,
                    role: role,
                    'Content-Type': content_type
                },
                responseType: 'stream',
                validateStatus: function (status) {
                    return true;
                }
            });

            req.data.pipe(writestream);

            writesteamfile(writestream, res, filename, dest);

        } catch (err) {
            res.status(500).json({ error: 'Unable to reach ECMS' });
        }
    };
    // Content-Disposition must be latin1/ASCII-safe. Document names coming from
    // ECMS/EDMS can contain smart quotes, accents or CR/LF, which make
    // res.setHeader throw ERR_INVALID_CHAR. Emit an ASCII fallback plus an
    // RFC 5987 filename* so the original name still reaches the browser.
    function contentDisposition(filename) {
        const name = path.basename(String(filename || 'download'));
        const ascii = name.replace(/[^\x20-\x7e]/g, '_').replace(/["\\]/g, '_');
        return 'inline; filename="' + ascii + '"; filename*=UTF-8\'\'' + encodeURIComponent(name);
    }

    function writesteamfile(writestream,res,filename,dest) {
        writestream.on('close', function () {
            try {
                res.setHeader('Content-Disposition', contentDisposition(filename));
                res.setHeader('Content-Transfer-Encoding', 'binary');
                res.setHeader('Content-Type', mime.lookup(dest));
                res.sendFile(dest);
            } catch (err) {
                LOGGER.error(err);
                if (!res.headersSent) {
                    res.status(500).json({ error: 'Unable to send file' });
                }
            }
        });
    }
   

    Attachment.downloadEDMSFile = (reqctx, res, docId, filename) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            _securityusersid = reqctx.req.headers.securityusersid;
        }  	
        let data = {
            agencyCode: config.agencyCode,
            originatingSystem: config.originatingSystem,
            ownerSystem: config.ownerSystem,
            ownerRepo : "Default",
            uploadedBy: 'cjamsuser',
            documentId: docId
        };
        let externalapidata = {};  
        externalapidata.details =  {
            objectid: docId,
            objecttype: 'edms_document_download',
            objectsubtype: null,
            updatedby: _securityusersid,
            insertedby: _securityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = data;
        externalapidata.response = null;
        externalapidata.status = 'add';
        let v_externalapilogsid = null;
        commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
            v_externalapilogsid = data1;
        });
        let role = config.role;

        if (filename.startsWith('UIR') & filename.length === 33) {
            data.ownerRepo = 'PROV_OLM';
            role = config.olmrole;
        }
        const uploadRoot = path.resolve(app.dataSources.localstorage.settings.root,'uploads');
        const requested = path.basename(filename);
        var dest = path.resolve(uploadRoot, requested); 
 
        let writestream = fs.createWriteStream(dest);

        return axios.post(
                config.downloadFileFromEDMSPath,
                data,
                {
                    headers: {
                        appKey: config.appKey,
                        'role': role,
                        'Content-Type': content_type
                    }
                }
            )
            .then(async (result) => {
                externalapidata = {};
                externalapidata.details =  {
                    externalapilogsid: v_externalapilogsid,
                    objecttype: 'edms_document_download',
                    updatedby: _securityusersid,
                    insertedby: _securityusersid
                }
                externalapidata.info = null;
                externalapidata.status = 'update';
                externalapidata.response = result.data;
                externalapidata.resstatus = 'success';
                commonapi.addupdateexternalapilogs(externalapidata);   
                const fs1 = require('fs');
                const presignedUrl = result?.data?.downloadUrl;
                https.get(presignedUrl, (response) => {
                    if (response.statusCode !== 200) {
                        console.error(`Failed to download file: ${response.statusCode}`);
                        return;
                    }
                    response.pipe(writestream);
                    writesteamfile(writestream,res,filename,dest);
                }).on('error', (err) => {
                    // Delete the file on error
                    fs1.unlink(dest, (unlinkErr) => {
                        if (unlinkErr) {
                            LOGGER.error(unlinkErr);
                        }
                    });
                    LOGGER.error(err);           
                });  
            })
            .catch((err) => {
                LOGGER.error(err);
                externalapidata = {};
                externalapidata.details =  {
                    externalapilogsid: v_externalapilogsid,
                    objecttype: 'edms_document_download',
                    updatedby: _securityusersid,
                    insertedby: _securityusersid
                } 
                externalapidata.info = null;
                externalapidata.status = 'update';
                externalapidata.resstatus = 'error';
                if (err.response) {
                    externalapidata.response = err.response.data;
                    commonapi.addupdateexternalapilogs(externalapidata);
                    return err.response;
                } else {
                    externalapidata.response = res1.body;
                    commonapi.addupdateexternalapilogs(externalapidata);
                    return res1;
                }
            })      
    };


    Attachment.savetodocumentproperties = async (req, reqctx) => {
        let securityusersid = undefined;
        if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
        securityusersid = reqctx.req.headers.securityusersid;
        }       
        const deletedocid = req[0].deletedocid;
        const sql = 'UPDATE documentproperties SET activeflag=0,updatedon=now(),updatedby= $1 WHERE ecmsdocumentid = $2';
        return app.models.Documentproperties.addcaseworkerattachment(req, null, reqctx).then((res)=>{
            if(deletedocid) {                 
                return util.executeDBQuery(sql,[securityusersid,deletedocid])
                .then(data => {
                    return res;
                })
            }else {
                return res;
            }
        }).then(res1 => {
            if(res1 && res1.length > 0) {
                return res1[0];
            }
            else {
                return res1;
            }          
        })
    }

    Attachment.videoConvert = (srcVideo, destVideo) => {
        function isValidFileName(fileName) {
            // This regex allows letters, numbers, dots, dashes, and underscores
            return /^[a-zA-Z0-9.\-_]+$/.test(fileName);
          }
        const outputPath = config.outputPath;
        const srcFileName = outputPath + 'uploads/' + srcVideo;
        const destFileName = outputPath + destVideo;
        LOGGER.debug("Source path : " + srcFileName);
// Assuming srcFileName and destFileName are inputs that need to be validated

        return new Promise((resolve, reject) => {
            LOGGER.debug("inside resolve");
            if (!isValidFileName(srcFileName) || !isValidFileName(destFileName)) {
                reject(new Error('Invalid file name'));
              } else {
            const execCmd = config.ffmpegCmd;
            // Prepare arguments array safely
            const args = [
              '-i', srcFileName, // Input file
              destFileName       // Output file
              // Add other ffmpeg arguments as needed
                ];
            exec(execCmd,args, (err, stdout, stderr) => {
                if (err) {
                    LOGGER.error(err);
                    reject(err);
                }
                else {
                    resolve(destFileName);
                }
            });}
        })
            .then(data => data)
            .catch(err => err);
    };

    Attachment.remoteMethod('uploadsFile',
        {
            accepts: [
                { arg: 'req', type: 'object', 'http': { source: 'context' } },
                { arg: 'res', type: 'object', 'http': { source: 'res' } },
                { arg: 'srno', type: 'string', 'http': { source: 'query' } },
                { arg: 'filetype', type: 'string', 'http': { source: 'query' } },
                { arg: 'docsInfo', type: 'string', 'http': { source: 'query' } },
                { arg: 'attachmenttype', type: 'string', 'http': { source: 'query' } },
                { arg: 'personid', type: 'string', 'http': { source: 'query' } },
                { arg: 'objecttypekey', type: 'string', 'http': { source: 'query' } },
                { arg: 'objectid', type: 'string', 'http': { source: 'query' } },
                { arg: 'additionalobjectid', type: 'string', 'http': { source: 'query' } },
                { arg: 'additionalobjecttype', type: 'string', 'http': { source: 'query' } },
                { arg: 'actualdocumentdate', type: 'string', 'http': { source: 'query' } },
                { arg: 'description', type: 'string', 'http': { source: 'query' } },
                { arg: 'other', type: 'string', 'http': { source: 'query' } },
                { arg: 'servicecaseid', type: 'string', 'http': { source: 'query' } },
                { arg: 'insertedby', type: 'string', 'http': { source: 'query' } },
                { arg: 'servicerequestid', type: 'string', 'http': { source: 'query' } }, {
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  }

               
            ],
            http: {
                verb: 'post'
            },
            returns: { type: 'json', root: true }
        });
    
    // EDMS Upload File
    // The metadata arrives as a JSON body rather than as query parameters: the free-text
    // fields (description, filename, other) were being truncated at the first '&' or '#'
    // in the query string. See Attachment.edmsuploadmetadata for the details.
    Attachment.remoteMethod('edmsuploadmetadata',
        {
            accepts: [
                { arg: 'req', type: 'object', 'http': { source: 'context' } },
                { arg: 'res', type: 'object', 'http': { source: 'res' } },
                { arg: 'data', type: 'object', 'http': { source: 'body' } },
                { arg: 'reqctx', type: 'object', http: {source: 'context'} }
            ],
            http: {
                verb: 'post'
            },
            returns: { type: 'json', root: true }
        });

    //for ECMS upload

    Attachment.remoteMethod('uploadFileToEcms',
        {
            accepts: [
                { arg: 'req', type: 'object', 'http': { source: 'context' } },
                { arg: 'res', type: 'object', 'http': { source: 'res' } },
                { arg: 'srno', type: 'string', 'http': { source: 'query' } },
                { arg: 'filetype', type: 'string', 'http': { source: 'query' } }, {
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  }
            ],
            http: { path: '/uploadFileToEcms', verb: 'post' },

            returns: { type: 'json', root: true }
        });

    Attachment.remoteMethod('downloadFile',
    {
        accepts: [
            { arg: 'req', type: 'object', 'http': { source: 'context' } },
            { arg: 'res', type: 'object', 'http': { source: 'res' } },
            { arg: 'docId', type: 'string', 'http': { source: 'query' } },
            { arg: 'filename', type: 'string', 'http': { source: 'query' } }
        ],
        http: { path: '/downloadFileFromECMS', verb: 'get' },
        returns: [
            { arg: 'body', type: 'file', root: true },
            { arg: 'Content-Type', type: 'string', http: { target: 'header' } },
            { arg: 'Content-Disposition', type: 'string', http: { target: 'header' } }
        ]
    });

    // 411,690 documentproperties rows store s3bucketpathname as
    // '/attachments/DownloadFile?docId=...&filename=...', and the components that
    // open the stored value verbatim ('/api' + s3bucketpathname, e.g.
    // document-upload-list, notes, court-order) therefore request a path that no
    // route here has ever served. loopback#urlNotFound raises a 404 and
    // error-logger rewrites every error to statusCode 400, which is why this
    // arrives as a bare "HttpError 400, No stack trace". The query arguments are
    // the same docId/filename pair downloadFile already takes, so alias the legacy
    // path onto it -- the producer of those rows is outside this repo and they are
    // still being written, so a data fix alone would not hold.
    Attachment.legacyDownloadFile = Attachment.downloadFile;

    Attachment.remoteMethod('legacyDownloadFile',
    {
        accepts: [
            { arg: 'req', type: 'object', 'http': { source: 'context' } },
            { arg: 'res', type: 'object', 'http': { source: 'res' } },
            { arg: 'docId', type: 'string', 'http': { source: 'query' } },
            { arg: 'filename', type: 'string', 'http': { source: 'query' } }
        ],
        http: { path: '/DownloadFile', verb: 'get' },
        returns: [
            { arg: 'body', type: 'file', root: true },
            { arg: 'Content-Type', type: 'string', http: { target: 'header' } },
            { arg: 'Content-Disposition', type: 'string', http: { target: 'header' } }
        ]
    });

    Attachment.remoteMethod('downloadEDMSFile',
    {
        accepts: [
            { arg: 'req', type: 'object', 'http': { source: 'context' } },
            { arg: 'res', type: 'object', 'http': { source: 'res' } },
            { arg: 'docId', type: 'string', 'http': { source: 'query' } },
            { arg: 'filename', type: 'string', 'http': { source: 'query' } }
        ],
        http: { path: '/downloadFileFromEDMS', verb: 'get' },
        returns: [
            { arg: 'body', type: 'file', root: true },
            { arg: 'Content-Type', type: 'string', http: { target: 'header' } },
            { arg: 'Content-Disposition', type: 'string', http: { target: 'header' } }
        ]
    });

    Attachment.remoteMethod(
        'downloadFileViewFromEDMS',
        {
            http: {
            path: '/downloadFileViewFromEDMS',
            verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
              },
              {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
            }],
            returns: {
                type: 'object',
                root: true
            }    
    });

    Attachment.downloadFileViewFromEDMS = function (data, reqctx) {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            _securityusersid = reqctx.req.headers.securityusersid;
        }  	
        const docID = data.where.docId;
        const filename = data.where.filename;
        let downloadreq = {
            agencyCode: config.agencyCode,
            originatingSystem: config.originatingSystem,
            ownerSystem: config.ownerSystem,
            ownerRepo : "Default",
            uploadedBy: 'cjamsuser',
            documentId: docID
        };
        let externalapidata = {};  
        externalapidata.details =  {
            objectid: docID,
            objecttype: 'edms_document_download',
            objectsubtype: null,
            updatedby: _securityusersid,
            insertedby: _securityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = downloadreq;
        externalapidata.response = null;
        externalapidata.status = 'add';
        let v_externalapilogsid = null;
        commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
            v_externalapilogsid = data1;
        });
        let role = config.role;

        if (filename.startsWith('UIR') & filename.length === 33) {
            downloadreq.ownerRepo = 'PROV_OLM';
            role = config.olmrole;
        }

        return axios.post(
            config.downloadFileFromEDMSPath,
            downloadreq,
            {
                headers: {
                    appKey: config.appKey,
                    'role': role,
                    'Content-Type': content_type
                }
            }
        )
        .then(async (result) => {
            externalapidata = {};
            externalapidata.details =  {
                externalapilogsid: v_externalapilogsid,
                objecttype: 'edms_document_download',
                updatedby: _securityusersid,
                insertedby: _securityusersid
            }
            externalapidata.info = null;
            externalapidata.status = 'update';
            externalapidata.response = result.data;
            externalapidata.resstatus = 'success';
            commonapi.addupdateexternalapilogs(externalapidata);   
            return result.data;
        })
        .catch((err) => {
            LOGGER.error(err);
            externalapidata = {};
            externalapidata.details =  {
                externalapilogsid: v_externalapilogsid,
                objecttype: 'edms_document_download',
                updatedby: _securityusersid,
                insertedby: _securityusersid
            } 
            externalapidata.info = null;
            externalapidata.status = 'update';
            externalapidata.resstatus = 'error';
            if (err.response) {
                externalapidata.response = err.response.data;
                commonapi.addupdateexternalapilogs(externalapidata);
                return err.response;
            } else {
                externalapidata.response = err;
                commonapi.addupdateexternalapilogs(externalapidata);
                return err;
            }
        })
    }
    
    Attachment.updatefileuploaded = async function (data, req, reqctx) {
        const _securityusersid = util.getSecurityDetails(req, reqctx).securityuserid;
        let _email = util.getSecurityDetails(req, reqctx).email;
        let requestuserinfo = {'token': '', 'email': _email};
        let username;
        await util.getuserinfo(requestuserinfo).then (resp => {
            username = resp.fullname;
		});  
        let suserid=undefined;
        let externalapidata = {};
        if(data && data.length > 0) {
            suserid = data[0].updatedby;
            const userid = suserid ? suserid : _securityusersid;
            const reqInfo = {
                "agencyCode": config.agencyCode,
                "ownerSystem": config.ownerSystem,
                "originatingSystem": config.originatingSystem,
                "updateBy":username ? username: 'CJAMS',
                "ownerRepo":"Default",
                "tobeUpdateMetadata":{
                                        "documentCategory":data[0].documentattachment.attachmentclassificationtypekey.trim(),
                                        "documentType":data[0].documentattachment.attachmentclassificationsubtypekey.trim()
                                    },
                "documentCategory":data[0].existingDocumentCategory.trim(),
                "documentType":data[0].existingDocumentType.trim(),
                "documentName":data[0].originalfilename,
                "documentId":data[0].ecmsdocumentid
            };

            const reqdoc = {
                updateDocumentInfo: {
                    value: JSON.stringify(reqInfo),
                    options: { filename: 'blob', contentType: content_type}
                }
            }
            externalapidata.details =  {
                objectid: data[0].ecmsdocumentid,
                objecttype: 'ecms_document_update',
                objectsubtype: null,
                updatedby: userid,
                insertedby: userid
            }
            externalapidata.resstatus = '';
            externalapidata.request = reqdoc;
            externalapidata.response = null;
            externalapidata.status = 'add';
            let v_externalapilogsid = null;
            commonapi.addupdateexternalapilogs(externalapidata).then(resp => {
                v_externalapilogsid = resp;
            });
            const form = returnFormDataFn(reqdoc);
            return axios.post(
                config.updateFileToECMSPath,
                form,
                {
                    headers: {
                        'appKey': config.appKey,
                        'role': config.role,
                        'cache-control': 'no-cache',
                        ...form.getHeaders()
                    }
                }
            )
            .then(async (resp) => {
                externalapidata = {};
                externalapidata.details =  {
                    externalapilogsid: v_externalapilogsid,
                    objecttype: 'ecms_document_update',
                    updatedby: userid,
                    insertedby: userid
                }
                externalapidata.info = null;
                externalapidata.status = 'update';
                externalapidata.response = resp.data;
                externalapidata.resstatus = 'success';
                commonapi.addupdateexternalapilogs(externalapidata);                                          
                return Attachment.savetodocumentproperties(data); 
            })
            .catch((err) => {
                LOGGER.error(err);
                externalapidata = {};
                externalapidata.details =  {
                    externalapilogsid: v_externalapilogsid,
                    objecttype: 'ecms_document_update',
                    updatedby: userid,
                    insertedby: userid
                } 
                externalapidata.info = null;
                externalapidata.status = 'update';
                externalapidata.resstatus = 'error';
                if (err.response) {
                    externalapidata.response = err.response.data;
                    commonapi.addupdateexternalapilogs(externalapidata);
                    return err.response.data;
                } else {
                    externalapidata.response = err;
                    commonapi.addupdateexternalapilogs(externalapidata);
                    return err;
                }
            })
        } else {
            return 'Failed updating Document Properties';
        }
    }

    Attachment.remoteMethod(
        'updatefileuploaded',
        {
            http: {
            path: '/updatefileuploaded',
            verb: 'post'
            },
            accepts: [{
            arg: 'data', type: 'array',
            http: { source: 'body' }
            },
            {
            arg: 'request', type: 'object',
            http: { source: 'req' }
            },
            {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
            }],
            returns: {
            type: 'object',
            root: true
        }
    
    });

    Attachment.updatelargefileuploaded = async function (data, req, reqctx) {
        const _securityusersid = util.getSecurityDetails(req, reqctx).securityuserid;
        let _email = util.getSecurityDetails(req, reqctx).email;
        let requestuserinfo = {'token': '', 'email': _email};
        let username;
        await util.getuserinfo(requestuserinfo).then (resp => {
            username = resp ? resp.fullname : undefined;
		}).catch(err => {
            LOGGER.error(err);
        });
        let suserid=undefined;
        let externalapidata = {};
        if(data && data.length > 0) {
            suserid = data[0].updatedby;
            const userid = suserid ? suserid : _securityusersid;
            const reqInfo = {
                "agencyCode": config.agencyCode,
                "ownerSystem": config.ownerSystem,
                "originatingSystem": config.originatingSystem,
                "updateBy":username ? username: 'CJAMS',
                "ownerRepo":"Default",
                "tobeUpdateMetadata":{
                                        "documentCategory":data[0].documentattachment.attachmentclassificationtypekey.trim(),
                                        "documentType":data[0].documentattachment.attachmentclassificationsubtypekey.trim()
                                    },
                "documentCategory":data[0].existingDocumentCategory.trim(),
                "documentType":data[0].existingDocumentType.trim(),
                "documentName":data[0].originalfilename,
                "documentId":data[0].ecmsdocumentid
            };
            
            const reqdoc = {
                updateDocumentInfo: {
                    value: JSON.stringify(reqInfo),
                    options: { filename: 'blob', contentType: content_type}
                }
            }
            externalapidata.details =  {
                objectid: data[0].ecmsdocumentid,
                objecttype: 'edms_document_update',
                objectsubtype: null,
                updatedby: userid,
                insertedby: userid
            }
            externalapidata.resstatus = '';
            externalapidata.request = reqdoc;
            externalapidata.response = null;
            externalapidata.status = 'add';
            let v_externalapilogsid = null;
            commonapi.addupdateexternalapilogs(externalapidata).then(resp => {
                v_externalapilogsid = resp;
            });

            return axios.post(
                config.updateFileToEDMSPath,
                reqInfo,
                {
                    headers: {
                        'appKey': config.appKey,
                        'role': config.role,
                        'cache-control': 'no-cache',
                        'Content-Type': 'application/json'
                    }
                }
            )
            .then(async (resp) => {
                externalapidata = {};
                externalapidata.details =  {
                    externalapilogsid: v_externalapilogsid,
                    objecttype: 'edms_document_update',
                    updatedby: userid,
                    insertedby: userid
                }
                externalapidata.info = null;
                externalapidata.status = 'update';
                externalapidata.response = resp.data;
                externalapidata.resstatus = 'success';
                commonapi.addupdateexternalapilogs(externalapidata);                                          
                return Attachment.savetodocumentproperties(data);  
            })
            .catch((err) => {
                LOGGER.error(err);
                externalapidata = {};
                externalapidata.details =  {
                    externalapilogsid: v_externalapilogsid,
                    objecttype: 'edms_document_update',
                    updatedby: userid,
                    insertedby: userid
                } 
                externalapidata.info = null;
                externalapidata.status = 'update';
                externalapidata.resstatus = 'error';
                if (err.response) {
                    externalapidata.response = err.response.data;
                    commonapi.addupdateexternalapilogs(externalapidata);
                    return err.response.data;
                } else {
                    externalapidata.response = err;
                    commonapi.addupdateexternalapilogs(externalapidata);
                    return err;
                }
            });
        } else {
            return 'Failed updating Document Properties';
        }
    }

    Attachment.remoteMethod(
        'updatelargefileuploaded',
        {
            http: {
            path: '/updatelargefileuploaded',
            verb: 'post'
            },
            accepts: [{
            arg: 'data', type: 'array',
            http: { source: 'body' }
            },
            {
            arg: 'request', type: 'object',
            http: { source: 'req' }
            },
            {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
            }],
            returns: {
            type: 'object',
            root: true
        }
    
    });

    Attachment.uploadOutageFileToCases = async (ctx, res, uploadfile) => {
        return new Promise(async (resolve, reject) => {
            let pending = await Attachment.getOutageRecord(ctx);
            while(pending && pending.length>0) {
                await Attachment.processbatch(ctx, res, pending[0]);
                pending = await Attachment.getOutageRecord(ctx);
            }
            resolve ("Process Completed");
        });
    }

    Attachment.processbatch = (ctx, res, rec) =>{
        return new Promise(async (resolve, reject) => {
            const prop = await Attachment.uploadOutageFiletoECMS(ctx, res, rec);
            await Attachment.saveOutageAttachmentProperties(ctx, res, prop, rec);
            await Attachment.updateProcessedRecord(rec.srno);
            await Attachment.sleep(1000);
            resolve(true);
        });
    }

    Attachment.getOutageRecord = (ctx, srno) => {
        var sql = "SELECT * FROM cjams.temp_outage_uploads WHERE isuploaded=false LIMIT 1";
        return util.executeDBQuery(sql, [])
            .then(data => {
                const toprocess = [];
                data.forEach(d => {
                    const rec = {};
                    rec.srno = d.srno;
                    rec.docsInfo = "Document|Other|Other";
                    rec.attachmenttype = "case";
                    rec.objecttypekey = d.objecttype;
                    rec.objectid = d.objectid;
                    rec.insertedby = ctx.req.headers.securityusersid;
                    rec.description = "OUTAGE NOTICE";
                    toprocess.push(rec);
                });
                return toprocess;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return false; });
    }
    
    Attachment.uploadOutageFiletoECMS = (ctx, res, data) => {
        return new Promise(async (resolve, reject) => {
           await Attachment.uploadsFile 
                (       ctx
                    ,   res      
                    ,   data.srno               // srnoD,
                    ,   null                    // filetype,
                    ,   data.docsInfo           // docsInfo, 
                    ,   data.attachmenttype     // attachmenttype,
                    ,   null                    // personid,
                    ,   data.objecttypekey      // objecttypekey, 
                    ,   data.objectid           // objectid,
                    ,   null                    // additionalobjectid,
                    ,   null                    // additionalobjecttype,
                    ,   null                    // actualdocumentdate,
                    ,   null                    // servicecaseid,
                    ,   data.insertedby         // insertedby,
                    ,   null                    // servicerequestid
                    ,   ctx                     // reqctx
                )
                .then(d=>{
                    const resp = [d];
                    resolve(resp);
                })
                .catch(err=>{
                    reject(err);
                });
        });
    }

    Attachment.saveOutageAttachmentProperties = (ctx, res, data, rec) => {
        return new Promise(async (resolve) => {
            data[0].description = "OUTAGE NOTICE";
            data[0].title = "Other(OUTAGE NOTICE)";
            await app.models.Documentproperties.addcaseworkerattachment(data, ctx, ctx)
            .then(d=>{
                resolve(d);
            });
        });
    }

    Attachment.updateProcessedRecord = (srno) => {
        var sql = "UPDATE cjams.temp_outage_uploads SET isuploaded=true WHERE srno=$1";
        return util.executeDBQuery(sql, [srno])
            .then(() => true)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return false; });
    }

    Attachment.sleep = (ms) => {
        return new Promise((r) => {
            setTimeout(() => {
                return r(true);
            }, ms);
        });
    }


    Attachment.remoteMethod('uploadOutageFileToCases',
    {
        accepts: [
            { arg: 'ctx', type: 'object', 'http': { source: 'context' } },
            { arg: 'res', type: 'object', 'http': { source: 'res' } },
            { arg: 'uploadfile', type: 'string', 'http': { source: 'query' } }, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }
        ],
        http: { path: '/uploadoutagefiletocases', verb: 'post' },

        returns: { type: 'json', root: true }
    });



    Attachment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Attachment.observe('access', (ctx, next) => util.access(ctx, next));
    Attachment.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
    Attachment.afterRemote('downloadFile', (ctx, data, next) => {
        ctx.res.contentType('application/*');
        next();
    })
}; 

// Code for deleting the file from ECMS
module.exports.deleteFileFromECMS = async (docId, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
    }  	
    let _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
        _email = reqctx.req.headers.user_email_captureby_application;
    }  
    let requestuserinfo = {'token': '', 'email': _email};
    let username ;
    await util.getuserinfo(requestuserinfo).then (data1 => {
        username = data1.fullname;
    });  
    let externalapidata = {};  
    let data = {
            agencyCode: config.agencyCode,
            originatingSystem: config.originatingSystem,
            ownerSystem: config.ownerSystem,
            requestedBy: username ? username : 'CJAMS',
            documentId: docId
        };
    externalapidata.details =  {
        objectid: docId,
        objecttype: 'ecms_document_delete',
        objectsubtype: null,
        updatedby: _securityusersid,
        insertedby: _securityusersid
    }
    externalapidata.resstatus = '';
    externalapidata.request = data;
    externalapidata.response = null;
    externalapidata.status = 'add';
    let v_externalapilogsid = null;
    commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
        v_externalapilogsid = data1;
    });
    return axios.post(
        config.deleteFileFromECMSPath,
        data,
        {
            headers: {
                'appKey': config.appKey,
                'role': config.role,
                'cache-control': 'no-cache',
                'Content-Type': content_type
            }
        }
    )
    .then(async (result) => {
        externalapidata = {};
        externalapidata.details =  {
            externalapilogsid: v_externalapilogsid,
            objecttype: 'ecms_document_delete',
            updatedby: _securityusersid,
            insertedby: _securityusersid
        }
        externalapidata.info = null;
        externalapidata.status = 'update';
        externalapidata.response = result.data;
        externalapidata.resstatus = 'success';
        commonapi.addupdateexternalapilogs(externalapidata);    
        return result.data;
    })
    .catch((err) => {
        LOGGER.error(err);
        externalapidata = {};
        externalapidata.details =  {
            externalapilogsid: v_externalapilogsid,
            objecttype: 'ecms_document_delete',
            updatedby: _securityusersid,
            insertedby: _securityusersid
        } 
        externalapidata.info = null;
        externalapidata.status = 'update';
        externalapidata.resstatus = 'error';
        if (err.response) {
            externalapidata.response = err.response.data;
            commonapi.addupdateexternalapilogs(externalapidata);
            return err.response.data;
        } else {
            externalapidata.response = err;
            commonapi.addupdateexternalapilogs(externalapidata);
            return err;
        }
    })
}

// Code for deleting the file from ECMS
module.exports.deleteLargeFileFromEDMS = async (docId, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
    }  	
    let _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
        _email = reqctx.req.headers.user_email_captureby_application;
    }  
    let requestuserinfo = {'token': '', 'email': _email};
    let username ;
    await util.getuserinfo(requestuserinfo).then (data1 => {
        username = data1.fullname;
    });  
    let externalapidata = {};  
    let data = {
            agencyCode: config.agencyCode,
            originatingSystem: config.originatingSystem,
            ownerSystem: config.ownerSystem,
            requestedBy: username ? username : 'CJAMS',
            documentId: docId
        };
    externalapidata.details =  {
        objectid: docId,
        objecttype: 'edms_document_delete',
        objectsubtype: null,
        updatedby: _securityusersid,
        insertedby: _securityusersid
    }
    externalapidata.resstatus = '';
    externalapidata.request = data;
    externalapidata.response = null;
    externalapidata.status = 'add';
    let v_externalapilogsid = null;
    commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
        v_externalapilogsid = data1;
    });
    return axios.post(
        config.deleteFileFromEDMSPath,
        data,
        {
            headers: {
                'appKey': config.appKey,
                'role': config.role,
                'cache-control': 'no-cache',
                'Content-Type': content_type
            }
        }
    )
    .then(async (result) => {
        externalapidata = {};
        externalapidata.details =  {
            externalapilogsid: v_externalapilogsid,
            objecttype: 'edms_document_delete',
            updatedby: _securityusersid,
            insertedby: _securityusersid
        }
        externalapidata.info = null;
        externalapidata.status = 'update';
        externalapidata.response = result.data;
        externalapidata.resstatus = 'success';
        commonapi.addupdateexternalapilogs(externalapidata);    
        return result.data; 
    })
    .catch((err) => {
        LOGGER.error(err);
        externalapidata = {};
        externalapidata.details =  {
            externalapilogsid: v_externalapilogsid,
            objecttype: 'edms_document_delete',
            updatedby: _securityusersid,
            insertedby: _securityusersid
        } 
        externalapidata.info = null;
        externalapidata.status = 'update';
        externalapidata.resstatus = 'error';
        if (err.response) {
            externalapidata.response = err.response.data;
            commonapi.addupdateexternalapilogs(externalapidata);
            return err.response.data;
        } else {
            externalapidata.response = err;
            commonapi.addupdateexternalapilogs(externalapidata);
            return err;
        }
    })
}

function returnFormDataFn(documentrequest) {
    const formData = new FormData();
    Object.keys(documentrequest).forEach(key => {
        const field = documentrequest[key];

        formData.append(
            key,
            field.value,
            field.options
        );
    });
    return formData;
}

function handleEcmsUploadError(err, v_externalapilogsid, insertedby, reject) {
    LOGGER.error(err);
    let externalapidata = {};
    externalapidata.details = {
        externalapilogsid: v_externalapilogsid,
        objecttype: 'ecms_document',
        updatedby: insertedby,
        insertedby: insertedby
    }
    externalapidata.info = null;
    externalapidata.status = 'update';
    externalapidata.resstatus = 'error';
    const logData = err.response ? err.response.data : err;
    const errorToReject = err.response ? err.response : err;

    externalapidata.response = logData;
    commonapi.addupdateexternalapilogs(externalapidata);
    
    reject(errorToReject);
}