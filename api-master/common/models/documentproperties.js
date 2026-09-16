'use strict';
const LOGGER = require("log4js").getLogger("documentproperties");
let app = require('../../server/server');
const util = require('../utils/utils');
const attachement = require('./attachment');
let fs = require('fs');
let config = require('../../server/config.json');
const dummyid = '00000000-0000-0000-0000-000000000000';
const commonapi = require('../models/commonapi');
const filenamestr = "(filename: ";

const DELETE_SUCCESS_MSG = "Attachment Deleted Successfully ";

const deleteResult = (data, ecmsRes = null) => ({
  "msg": DELETE_SUCCESS_MSG,
  "ecmsRes": ecmsRes,
  "data": data
});

/*global  window */

module.exports = function (Documentproperties) {
  let sInserby = "", sIntakenumber = "";// Added for auditlog
  let ipaddress,sintakeobj;// for audit log
  // const io = app.get("socketio");   

  // EDMS CALL BACK to update upload status and virus scan status.
  Documentproperties.updateuploadstatus = function (data, reqctx) {
    data.currenttimestamp = new Date();
    const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
    let v_activeflag = 4;
    if (data.uploadStatus == 'SUCCESS' && data.virusStatus == 'SUCCESS') {
      v_activeflag = 1;
    } 
    let externalapidata = {};
    externalapidata.details = {
      objectid: data.id,
      objecttype: 'edms_uploadstatus_update',
      updatedby: _usecurityusersid,
      insertedby: _usecurityusersid
    }
    externalapidata.resstatus = '';
    externalapidata.request = data;
    externalapidata.response = null;
    externalapidata.status = 'add';
    let v_externalapilogsid = null;     
    return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
      v_externalapilogsid = data1;
      if (data.id && data.uploadStatus) {
        let sql = "UPDATE cjams.documentproperties SET uploadstatus=$1, activeflag = $2, finalstatus = $3, updatedby=$4, updatedon=now() WHERE ecmsdocumentid=$5";
        return util.executeDBQuery(sql, [data.uploadStatus, v_activeflag, data.virusStatus, _usecurityusersid, data.id])
        .then(() => {
          // try {
          //   io.emit('fileuploadstatusdata', JSON.stringify(data));
          // }
          // catch(err1) {
          //   LOGGER.error('Wsserver SOCKET.IO -', err1);
          // }
          // After external system call is complete
          let externalapidata2 = {};
          externalapidata2 = getexternalapirespdata(v_externalapilogsid, _usecurityusersid, 'edms_uploadstatus_update', 'success', 'SUCCESS')
          commonapi.addupdateexternalapilogs(externalapidata2);
          return externalapidata2.response;
        })
        .catch(err => {
          LOGGER.error('postgres update failed for updateuploadstatus',err,data.id);
          let externalapidata1 = {};
          externalapidata1 = getexternalapirespdata(v_externalapilogsid, _usecurityusersid, 'edms_uploadstatus_update', 'error', err)
          commonapi.addupdateexternalapilogs(externalapidata1);
          LOGGER.error('updateuploadstatus promise catch',err,data.id);
        });
      } else {
        let externalapidata3 = {};
        externalapidata3 = getexternalapirespdata(v_externalapilogsid, _usecurityusersid, 'edms_uploadstatus_update', 'error', 'documentId/uploadStatus missing')
        commonapi.addupdateexternalapilogs(externalapidata3);
        return { message: "documentId/uploadStatus missing" };
      }
    })
    .catch(err => {
      LOGGER.error('updateuploadstatus addupdateexternalapilogs error',err);
    });
  };

  Documentproperties.remoteMethod('updatepresignurlstatus', {
    http: {
            path: '/updatepresignurlstatus',
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
  });

  Documentproperties.updatepresignurlstatus = function (data, reqctx) {
    const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
    let sql = "UPDATE cjams.documentproperties SET ispresignedurlinitiated=$1,updatedby=$2, updatedon=now() WHERE ecmsdocumentid=$3";
    return util.executeDBQuery(sql, [data.presignedurlstatus, _usecurityusersid, data.ecmsdocumentid])
    .then(response => {
      return response;
    })
    .catch(err => {
      LOGGER.error('postgres update failed for updatepresignurlstatus',err);
      LOGGER.error('updatepresignurlstatus promise catch',err);
    });
  };

  function getexternalapirespdata(v_externalapilogsid, securityusersid, objecttype, resstatus, response) {
    const externalapidata = {};
    externalapidata.details = {
      externalapilogsid: v_externalapilogsid,
      objecttype: objecttype,
      updatedby: securityusersid,
      insertedby: securityusersid
    }

    externalapidata.info = null;
    externalapidata.status = 'update';
    externalapidata.resstatus = resstatus;
    externalapidata.response = response;
    return externalapidata;
  } 

  Documentproperties.getattachments = function (id, data) {
    const nolimit = data.nolimit;
    const limit = data.limit;
    const skip = (data.page - 1) * data.limit;
    const order = data.order;
    return Documentproperties.find({
      fields: ['documentpropertiesid', 'title', 'documenttypekey', 'insertedon', 'documentdate', 'mime', 'insertedby', 's3bucketpathname'],
      where: {
        and: [{ activeflag: 1 }, { servicerequestid: id },
        { objecttypekey: 'ServiceRequest' }, { filename: { 'neq': null } }]
      },
      limit: limit, nolimit: nolimit, skip: skip, order: order,
      include: [{
        relation: 'documentattachment',
        where: { activeflag: 1 },
        scope: { fields: ['documentpropertiesid', 'attachmenttypekey', 'attachmentclassificationtypekey', 'assessmenttemplateid'] }
      },
      {
        relation: 'userprofile',
        scope: { fields: ['securityusersid', 'firstname', 'lastname', 'displayname'] }
      }]
    }
    ).catch(err => LOGGER.error(err));
  }


  Documentproperties.getintakeattachments = function (id, data) {
    const nolimit = data.nolimit;
    const limit = data.limit;
    const skip = (data.page - 1) * data.limit;
    const order = data.order;
    return Documentproperties.find({
      fields: ['documentpropertiesid', 'title', 'documenttypekey', 'insertedon', 'updatedon', 'insertedby',
       'updatedby', 'documentdate', 'mime', 'insertedby', 's3bucketpathname', 'description','other', 'filename', 'numberofbytes', 'originalfilename'],
      where: { and: [{ activeflag: 1 }, { intakenumber: id }, { objecttypekey: 'ServiceRequest' }, { filename: { 'neq': null } }] },
      limit: limit, nolimit: nolimit, skip: skip, order: order,
      include: [{
        relation: 'documentattachment',
        where: { activeflag: 1 },
        scope: { fields: ['documentpropertiesid', 'attachmenttypekey', 'attachmentclassificationtypekey', 'assessmenttemplateid'] }
      },
      {
        relation: 'userprofile',
        scope: { fields: ['securityusersid', 'firstname', 'lastname', 'displayname'] }
      },
      {
        relation: 'updateduserprofile',
        scope: { fields: ['securityusersid', 'firstname', 'lastname', 'displayname'] }
      }]
    }
    ).catch(err => LOGGER.error(err));
  }

  Documentproperties.getcaseworkerattachments = (request) => {
    var v_servicecaseid = request.where.servicecaseid;
    var v_servicerequestid = request.where.servicerequestid;
    var v_adoptioncaseid = request.where.adoptioncaseid;
   var wherecondition = {};

     if(v_adoptioncaseid) {
      wherecondition = {
        objectid: v_adoptioncaseid,
        activeflag: 1,
        objecttypekey: 'Adoptioncase'
      }
    } else if (v_servicecaseid) {
      wherecondition = {
        objectid: v_servicecaseid,
        objecttypekey: 'Servicecase',
        filename: { 'neq': null }
      }
    } else {
      wherecondition = {
        objectid: v_servicerequestid,
        activeflag: 1,
          objecttypekey: 'ServiceRequest'
      }
    } 

    let personid = request.where.personid ? request.where.personid : null;
    LOGGER.debug(wherecondition);
    var sql = 'select * from searchcaseworkerattachments($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16)';
    LOGGER.debug(sql + "sql");
      return util.executeSecondaryNodeDBQuery(sql,[request.where.servicecaseid,request.where.servicerequestid,request.where.adoptioncaseid
        ,request.where.objecttypekey,request.page,request.limit,request.where.category,request.where.subcategory,request.where.sortcolumn,request.where.sortby
        ,request.where.worker,request.where.intakenumber,personid ,request.where.title, request.where.actualdocumentdate, request.where.activeflag
      ])
      .then(data => data)
      .catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  }

  Documentproperties.getPersonAttachmentByPersonId = (request) => {
    var v_personId = request.where.personId;
    var sql = 'select documenttypekey, * from documentproperties ' + 
   ' inner join documentattachment on documentproperties.documentpropertiesid=documentattachment.documentpropertiesid ' +
    ' where  documentproperties.objectid=$1 and documentattachment.attachmentclassificationtypekey=\'CW-Client Photo\' ' +
    ' order by documentproperties.updatedon desc limit 1 ';
    LOGGER.debug(sql + "sql");
      return util.executeSecondaryNodeDBQuery(sql,[v_personId 
      ])
      .then((data) => {
          return data;
      })
      .catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });

  }

  Documentproperties.updatepersonattachments = function (id, personid, status, documentpropertiesid, casetype, data) {
    if (status === "true" || status === true) {

      return Documentproperties.update(
        {
          objecttypekey: 'Person',
          documentpropertiesid: documentpropertiesid,
          // objectid:personid,
          // servicerequestid:"00000000-0000-0000-0000-000000000000"
        },
        {
          objecttypekey: 'CasePerson',
          servicerequestid: (casetype === 'CPS') ? id : null,
          servicecaseid: (casetype === 'CPS') ? null : id,
        }).then(res => {
          LOGGER.debug("in update successs");
          LOGGER.debug(res);

          return { error: 0, message: "Document has been successfully added to the case tab!" };
        }).catch(err => {
          LOGGER.error(err);
          return { error: 1, message: "error occured", err: err };
        });
    } else {
      LOGGER.debug("here");
      return Documentproperties.updateAll(
        {
          objecttypekey: 'CasePerson',
          documentpropertiesid: documentpropertiesid,
          // objectid:id
        },
        {
          objecttypekey: 'Person',
          servicecaseid: null,
          servicerequestid: null
        /*  objectid: personid,
          rootobjectid: personid,
          intakenumber: dummyid,
          objecttypekey: 'Person',
          rootobjecttypekey: 'Person',
          servicerequestid: "00000000-0000-0000-0000-000000000000"*/
        }).then(res => {
          LOGGER.debug("inre sponse");
          LOGGER.debug(res);
          return { error: 0, message: "Document has been successfully removed from the case tab." };
        }).catch(err => {
          LOGGER.error(err);
          return { error: 1, message: "error occured", err: err };
        });
    }
  }

  Documentproperties.updateTemporaryId = async function(temporaryId, updatedby, newId) {
    const sqlQuery = `UPDATE documentproperties SET additionalobjectid = $1, updatedon=now() ,updatedby = $2 WHERE additionalobjectid = $3`;
    const params = [newId, updatedby, temporaryId];

    try {
        const result = await util.executeDBQuery(sqlQuery, params);
        return result.rowCount;
    } catch (error) {
        LOGGER.error(error)
        throw error;
    }
  }; 
  
  Documentproperties.remoteMethod('updateTemporaryId', {
    http: { path: '/updateTemporaryId', verb: 'post' },
    accepts: [
      { arg: 'temporaryId', type: 'string', required: true },
      { arg: 'updatedby', type: 'string', required: true },
      { arg: 'newId', type: 'string', required: true }
    ],
    returns: { arg: 'message', type: 'string' }
  });  

  Documentproperties.remoteMethod('copyexistingdocuments', {
    http: {
        path: '/copyexistingdocuments',
        verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
        }  ],
    returns: {
        type : 'object',
        root : true
    }
  });

  Documentproperties.copyexistingdocuments = (request,reqctx) => {
      
      let sql = "select * from cjams.insertdocumentproperties($1)";

      return util.executeDBQuery(sql,[JSON.stringify(request.data)])
          .then(data => data)
          .catch(err => LOGGER.error(err)
          );
  }

  Documentproperties.getpersonattachments = function (id, personid, data) {
    const nolimit = data.nolimit;
    const limit = data.limit;
    const skip = (data.page - 1) * data.limit;
    const order = data.order;
    return Documentproperties.find({
      fields: ['documentpropertiesid', 'objecttypekey', 'title', 'documenttypekey', 'insertedon', 'updatedon', 'insertedby', 'updatedby', 'documentdate', 
              'mime', 'insertedby', 's3bucketpathname', 'description', 'other','filename', 'numberofbytes', 'originalfilename', 'ecmsdocumentid','actualdocumentdate'],
      where: {
        and: [
          { activeflag: 1 },
          { or: [{ objecttypekey: 'Person', objectid: personid }, { objecttypekey: 'CasePerson', objectid: id, intakenumber: personid }] },
          { filename: { 'neq': null } }
        ]
      },
      limit: limit, nolimit: nolimit, skip: skip, order: order,
      include: [{
        relation: 'documentattachment',
        where: { activeflag: 1 },
        scope: { fields: ['documentpropertiesid', 'attachmenttypekey', 'attachmentclassificationtypekey','attachmentclassificationsubtypekey', 'assessmenttemplateid'] }
      },
      {
        relation: 'userprofile',
        scope: { fields: ['securityusersid', 'firstname', 'lastname', 'displayname'] }
      },
      {
        relation: 'updateduserprofile',
        scope: { fields: ['securityusersid', 'firstname', 'lastname', 'displayname'] },
      }]
    }
    ).catch(err => LOGGER.error(err));
  }
 
  Documentproperties.getpersonattachmentsive = (request) => {
    var v_personId = request.where.objectid;
    const pageno = request.page;
    const pagesize = request.limit;
    var sql = 'select * from getattachmentsforive($1,$2,$3)';
      return util.executeSecondaryNodeDBQuery(sql,[v_personId, pageno, pagesize])
      .then((data) => {
        return data;
      })
     .catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  }


  Documentproperties.getservicecaseattachments = (request) => {

      const pageno = request.page;
      const pagesize = request.limit;
      var sql = "select * from getservicecaseattachments($1,$2,$3)"

      return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid, pageno, pagesize])
      .then((data) => {
        return data && data.length > 0 ? data[0].getservicecaseattachments : null;
      })
      .catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  };



  Documentproperties.remoteMethod('getservicecaseattachments', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      verb: 'get'
    },
    returns: {
      type: 'string',
      root: true
    }
  });

  Documentproperties.remoteMethod('getattachments', {
    accepts: [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
    },
    {
      arg: 'data',
      type: 'object',
      required: false,
      http: { source: 'query' }
    }
    ],
    http: { "verb": "get", "path": "/getattachments/:id" },
    returns: {
      type: 'object',
      root: true
    }
  });


  Documentproperties.remoteMethod('getintakeattachments', {
    accepts: [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
    },
    {
      arg: 'data',
      type: 'object',
      required: false,
      http: { source: 'query' }
    }
    ],
    http: { "verb": "get", "path": "/getintakeattachments/:id" },
    returns: {
      type: 'object',
      root: true
    }
  });

  Documentproperties.remoteMethod('updatepersonattachments', {
    accepts: [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
    },
    {
      arg: 'personid',
      type: 'string',
      required: true,
      http: { source: 'path' }
    },
    {
      arg: 'status',
      type: 'string',
      required: false,
      http: { source: 'path' }
    },
    {
      arg: 'documentpropertiesid',
      type: 'string',
      required: false,
      http: { source: 'path' }
    },
    {
      arg: 'casetype',
      type: 'string',
      required: false,
      http: { source: 'path' }
    },
    {
      arg: 'data',
      type: 'object',
      required: false,
      http: { source: 'query' }
    }
    ],
    http: { "verb": "get", "path": "/updatepersonattachments/:id/:personid/:status/:documentpropertiesid/:casetype" },
    returns: {
      type: 'object',
      root: true
    }
  });
  Documentproperties.remoteMethod('getpersonattachments', {
    accepts: [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
    },
    {
      arg: 'personid',
      type: 'string',
      required: true,
      http: { source: 'path' }
    },
    {
      arg: 'data',
      type: 'object',
      required: false,
      http: { source: 'query' }
    }
    ],
    http: { "verb": "get", "path": "/getpersonattachments/:id/:personid" },
    returns: {
      type: 'object',
      root: true
    }
  });

  Documentproperties.remoteMethod('getcaseworkerattachments', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: { "verb": "get", "path": "/getcaseworkerattachments" },
    returns: {
      type: 'string',
      root: true
    }
  });

  Documentproperties.remoteMethod('getPersonAttachmentByPersonId', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: { "verb": "get", "path": "/getPersonAttachmentByPersonId" },
    returns: {
      type: 'string',
      root: true
    }
  });



  Documentproperties.addattchment = function (request, req, reqctx) {
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
    var nowDate = new Date();
    var documentpropertiessave;
    let returnData = {};
    sIntakenumber = request.intakenumber;//for Audit log
    const securityuserid = _securityusersid;
    sInserby =  request && request.insertedby ? request.insertedby : securityuserid;
    request.activeflag = request.activeflag ? request.activeflag : 1;
    if (request.documentpropertiesid === undefined) {
      
      request = checkRequestValues(req, request);
  
      return Documentproperties.find({
        where: {
          and: [{ originalfilename: request.originalfilename }, {title: request.title}, { servicerequestid: request.servicerequestid },
          { objectid: request.objectid }, { objecttypekey: request.objecttypekey },
          { intakenumber: request.intakenumber }]
        }
      }).then(res => {
        // removing duplicate document check as per defect CDM-133
          LOGGER.debug("check check else *****", request);
          return Documentproperties.create({
            objecttypekey: request.objecttypekey,
            servicerequestid: request.servicerequestid,
            servicecaseid: request.servicecaseid,
            objectid: request.objectid,
            documenttypekey: 'Attachment',
            intakenumber: request.intakenumber,
            documentdate: request.documentdate,
            thirdpartysourceid: request.thirdpartysourceid,
            filename: request.filename,
            originalfilename: request.originalfilename,
            title: request.title,
            description: request.description,
            other: request.other,
            mime: request.mime,
            meta: request.meta,
            encoding: request.encoding,
            numberofbytes: request.numberofbytes,
            insertedby: sInserby,
            updatedby: sInserby,
            expirationdate: nowDate.toJSON(),
            rootobjectid: request.objectid,
            rootobjecttypekey: request.objecttypekey,
            // The client posts back the value it was displaying, which several screens
            // prefix in place -- store the bare relative path so the prefix cannot
            // accumulate into a url no route serves.
            s3bucketpathname: util.apiResourcePath(request.s3bucketpathname),
            ecmsdocumentid: request.ecmsdocumentid,
            additionalobjectid: request.additionalobjectid,
            additionalobjecttype:request.additionalobjecttype,
            actualdocumentdate: request.actualdocumentdate,
            activeflag: request.activeflag,
            uploadstatus: request.uploadstatus,
            finalstatus: request.finalstatus,
            filesize: request.filesize
          })
      }).then(response => {
        LOGGER.debug("response", response);
        documentpropertiessave = response;
        
        if (response.documentpropertiesid !== undefined) {
          const documentattachments = request.documentattachment;
          if (documentattachments.documentattachmentid === undefined) {
            return app.models.Documentattachment.create({
              documentpropertiesid: response.documentpropertiesid,
              attachmenttypekey: documentattachments.attachmenttypekey,
              attachmentclassificationtypekey: documentattachments.attachmentclassificationtypekey,
              attachmentclassificationsubtypekey : documentattachments.attachmentclassificationsubtypekey,
              attachmentdate: documentattachments.attachmentdate,
              sourceauthor: documentattachments.sourceauthor,
              sourceposition: documentattachments.sourceposition,
              sourceaddress: documentattachments.sourceaddress,
              sourcephonenumber: documentattachments.sourcephonenumber,
              attachmentsubject: documentattachments.attachmentsubject,
              attachmentpurpose: documentattachments.attachmentpurpose,
              acquisitionmethod: documentattachments.acquisitionmethod,
              locationoforiginal: documentattachments.locationoforiginal,
              note: documentattachments.note,
              insertedby: sInserby,
              updatedby: sInserby,
              activeflag: documentattachments.activeflag,
              assessmenttemplateid: documentattachments.assessmenttemplateid,
              expirationdate: nowDate.toJSON()
            }
            )
          }
        } else {
          return response;
        }
      }).then(result => {
        returnData = getDPReturnData(documentpropertiessave, result);
        return returnData;
      }).catch(err => err);
    } else {
      return Documentproperties.find({
        where: { 
          documentpropertiesid: request.documentpropertiesid ,
          activeflag: request.activeflag
        }
      })
        .then(res => {
          return updateDocumentproperties(res, request, _securityusersid);
        })
        .then(data => {
          return checkupdateDPResponse(data);
        })
        .catch(err => util.logError(err));
    }
  }

  function checkupdateDPResponse(data) {
    const returnData = JSON.parse(JSON.stringify(data));
    if (returnData.length > 0) { return returnData[0]; }
    else { return returnData; }
  }

  function getDPReturnData(documentpropertiessave, result){
    let returnData = {};
    if (documentpropertiessave.documentpropertiesid !== undefined) {
      returnData = documentpropertiessave;
    } else {
      returnData.Documentattachment = result;
    }
    return returnData;
  }

  function updateDocumentproperties(res, request, _securityusersid){
    if (res.length > 0) {
      var prs = [];
      prs.push(Documentproperties.updateAll({ documentpropertiesid: request.documentpropertiesid, activeflag: request.activeflag },
        {
          title: request.title,
          filename: request.filename,
          originalfilename: request.originalfilename,
          description: request.description, 
          other: request.other,
          intakenumber: request.intakenumber,
          documentdate: request.documentdate,
          actualdocumentdate: request.actualdocumentdate,
          updatedby: sInserby,
          updatedon: new Date(),
          activeflag: 1
        }));
      prs.push(app.models.Documentattachment.updateAll({ documentpropertiesid: request.documentpropertiesid, activeflag: request.activeflag},
       // request.documentattachment
       {
        attachmentclassificationtypekey: request.documentattachment.attachmentclassificationtypekey,
        attachmentclassificationsubtypekey : request.documentattachment.attachmentclassificationsubtypekey,
        activeflag: 1,
        updatedby: _securityusersid
       }
      ));
      return Promise.all(prs)
      .then(data => {
        if (data && data.length > 0) {
          var sql = `Select dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon, 
                      (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), 
                      dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,
                      dp.numberofbytes, dp.originalfilename from documentproperties dp where dp.activeflag = 1 and dp.documentpropertiesid = $1`;
          return util.executeDBQuery(sql,[request.documentpropertiesid])
            .then(_data => {
              return _data;
            })
            .catch(err => {
              LOGGER.error(err);
              return err;
            })

        }
      })
      .catch(err => err);
      // return res;
    }
    else {
      return new Promise((resolve, reject) => {
        return resolve("Document not available to edit"); });
    }
  }

  function checkRequestValues(req, request){
    if (req){
      if (request.intakenumber) {
        request.servicerequestid = dummyid;
        request.objectid = dummyid;
      } else {
        request.intakenumber = ''
      }}
    
    request = checkObjectId(request);
    if (request.objecttypekey == null || request.objecttypekey === undefined || request.objecttypekey === '') {
      request.objecttypekey = 'ServiceRequest'
    }

    if(request.objecttypekey !== 'investigationappeal' && request.objecttypekey !== 'courtorder' && request.objecttypekey !== 'Client') {
      request.servicerequestid = request.objectid;
    }
    if (request.originalfilename == null || request.originalfilename === undefined) {
      request.originalfilename = request.filename;
    }
    LOGGER.debug("After", request.objectid);


    // request - person and case
    if (request.attachmenttype === 'person') { // only peson
      // request.servicerequestid = dummyid;
      request.objecttypekey = "Person";
      request.objectid = request.personid;
    }
    return request;
  }

  function checkObjectId(request){
    if (request.objectid == null || request.objectid === undefined || request.objectid === '' || request.objectid === 'null') {
      request.objectid = dummyid;
    }
    /*If objectid is null consider serviceid  */
    if (request.servicerequestid != null && request.servicerequestid !== undefined) {
      if (request.servicerequestid !== dummyid && request.objecttypekey !== 'investigationappeal' && request.objecttypekey !== 'courtorder' && request.objecttypekey !== 'Person') {
        request.objectid = request.servicerequestid;
      }
    }
    return request;
  }


  Documentproperties.addintakeattchment = function (data, request, reqctx) {
    sintakeobj = data;
    var prs = data.map(x => Documentproperties.addattchment(x, request, reqctx));
    return Promise.all(prs)
      .then(_data => _data)
      .catch(err => err);
  }



  Documentproperties.addcaseworkerattachment = function (data, request, reqctx) {
    sintakeobj = data;
    LOGGER.debug("ata", data);
    var prs = data.map(x => Documentproperties.addattchment(x,request, reqctx));
    return Promise.all(prs)
      .then(_data => _data)
      .catch(err => err);
  }

  Documentproperties.addcommonattachment = function (data, request, reqctx) {
    sintakeobj = data;
    LOGGER.debug("ata", data);
    var prs = data.map(x => Documentproperties.addattchment(x,request, reqctx));
    return Promise.all(prs)
    .then(_data => _data)
      .catch(err => {
        LOGGER.error(err)
      });
  }


  Documentproperties.ecmsclientdetails = function (data) {
    const avail_codes = ["MDM_ID", "IRN_ID", "CHESSIE_ID", "DJS_ID"];
    var index = avail_codes.indexOf(data.code);
    if (index >= 0) {
      avail_codes.splice(index, 1);
      return app.models.Personidentifier.findOne({
        fields: { "personid": true },
        where: {
          personidentifiertypekey: data.code,
          personidentifiervalue: data.value
        }
      }).then(function (personIdentifier) {
        if (personIdentifier && personIdentifier.personid) {
          return app.models.Person.findOne({
            fields: { "firstname": true, "lastname": true, "cjamspid": true, "dob": true, "gendertypekey": true },
            where: {
              personid: personIdentifier.personid
            }
          }).then(function (dataPerson) {

            if (dataPerson) {
              return app.models.Alias.findOne({
                fields: { "ssn": true },
                where: {
                  personid: personIdentifier.personid
                }
              }).then(function (ssnDetails) {
                return app.models.Personidentifier.find({
                  fields: { "personidentifiervalue": true, personidentifiertypekey: true },
                  where: {
                    personid: personIdentifier.personid,
                    personidentifiertypekey: { inq: avail_codes }
                  }
                }).then(function (personIdentifierDetails) {
                    personIdentifierDetails = checkValueExist(personIdentifierDetails, true);
                  var data_r = {
                    "firstName": dataPerson.firstname,
                    "lastName": dataPerson.lastname,
                    "clientId": dataPerson.cjamspid,
                    "dob": dataPerson.dob,
                    "personId": personIdentifier.personid,
                    "gendertypekey": dataPerson.gendertypekey,
                    //"alienNumber": null,
                    //"individualId": null,
                    //"clidIrn": null,
                    //"mdmId": null,
                    "ssn": null
                  };
                  data_r = checkpersonIdentifierDetails(personIdentifierDetails, data_r);
                  return data_r;
                });
              });
            } else {
              return {
                "statusCode": 400,
                "msg": "Person Id is not found",
              }
            }

          }).catch(err => {
            return {
              "statusCode": 400,
              "name": err.name,
              "msg": err.message
            }
          });
        } else {
          return {
            "statusCode": 400,
            "response": "MDM id not found"
          }
        }
      }).catch(err => {
        return {
          "statusCode": 400,
          "msg": err.message,
          "name": err.name
        }
      });
    } else if (data.code === 'person_id') {
      return ecmsDetailsBasedonPerson(data);
    } else if (data.code === 'caseNumber') {
      return app.models.Intakeservicerequest.findOne({
        where: {
          servicerequestnumber: data.value

        }
      }).then(function (dataIntake) {
        return checkResponseStatus(dataIntake, data);
      }).catch(err => {
        return {
          "statusCode": 400,
          "name": err.name,
          "msg": err.message
        };
      });
    } else {
      return Promise.resolve({"statusCode": 200,response:"person_id/caseNumber is required"});
    }
  }

  function ecmsDetailsBasedonPerson(data){
    return app.models.Person.findOne({
      where: {
        cjamspid: data.value
      }
    }).then(function (dataPerson) {

      if (dataPerson) {
        return app.models.Alias.findOne({
          fields: { "ssn": true },
          where: {
            personid: dataPerson.personid
          }
        }).then(function (ssnDetails) {
          ssnDetails = checkValueExist(ssnDetails, false);
          return app.models.Personidentifier.find({
            fields: { "personidentifiervalue": true, personidentifiertypekey: true },
            where: {
              personid: dataPerson.personid,
              personidentifiertypekey: { inq: ["DJS_ID", "MDM_ID"] }

            }
          }).then(function (personIdentifierDetails) {
              personIdentifierDetails = checkValueExist(personIdentifierDetails, true);

            var data_r = {
              "firstName": dataPerson.firstname,
              "lastName": dataPerson.lastname,
              "clientId": dataPerson.cjamspid,
              "personId": dataPerson.personid,
              "dob": dataPerson.dob,
              "DJS_ID": null,
              "MDM_ID": null,
              "ssn": ssnDetails.ssn
            };
            data_r = checkpersonIdentifierDetails(personIdentifierDetails, data_r);
            return data_r;
          });
        });

      } else {
        return {
          "statusCode": 400,
          "msg": "Person Id is not found",
        }
      }

    }).catch(_err => {
      return {
        "statusCode": 400,
        "name": _err.name,
        "msg": _err.message
      }
    });
  }

  function checkResponseStatus(dataIntake, data){
    if (dataIntake) {
      return {
        "statusCode": 200,
        "response": "Case Number found",
        "Case Id": data.value
      };
    } else {
      return {
        "statusCode": 400,
        "response": "Case Number is not found",
        "Case Id": data.value
      }
    }
  }

  function checkValueExist(value, isArr) {
    if (!value) { 
      value = isArr ? [] : {}; 
    }
    return value
  }

  function checkpersonIdentifierDetails(personIdentifierDetails, data_r){
    for (const element of personIdentifierDetails) {
      data_r[element.personidentifiertypekey] = element.personidentifiervalue;
    }
    return data_r;
  }

  Documentproperties.addEcmsattachment = function (data, request, reqctx) {
    const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
    var isCaseRPerson = "";
    var objectId;
    const securityusersid = _securityusersid;
    if (data.dynamicFields && data.dynamicFields.clientId) {
      isCaseRPerson = "Person";
      return app.models.Person.findOne({
        where: {
          cjamspid: data.dynamicFields.clientId
        }
      }).then(function (dataPerson) {
        if(!dataPerson) {
          return {error:1,message:"Data not found"};
        } else {
          objectId = dataPerson.personid;
          return dataProcess(data, objectId, securityusersid, isCaseRPerson);
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } else if(data.dynamicFields &&  data.dynamicFields.caseNumber) {
      isCaseRPerson = "ServiceRequest";
      return app.models.Intakeservicerequest.findOne({
        where: {
          servicerequestnumber: data.dynamicFields.caseNumber
        }
      }).then(function (dataIntake) {
        if(!dataIntake) {
          return {error:1,message:"Data not found"};
        } else {
          objectId = dataIntake.intakeserviceid;
          return dataProcess(data, objectId, securityusersid, isCaseRPerson);
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } else {
      return Promise.resolve({error:1,message:"clientId/casenumber is required"});
    }

  }

  function dataProcess(data, objectId, securityusersid, isCaseRPerson) {
    var nowDate = new Date();
    var dataRes = [
      {
        "filename": data.documentName,
        "originalfilename": data.documentName,
        "date": nowDate.toJSON(),
        "mime": data.mime, //They need to pass
        "numberofbytes": data.numberofbytes, //They need to pass
        "s3bucketpathname": "/attachments/downloadFileFromECMS?docId=" + data.id + "&filename=" + data.documentName,
        "documentattachment": {
          "attachmenttypekey": data.documentType,
          "attachmentclassificationtypekey": data.documentCategory,
          "attachmentdate": nowDate.toJSON(),
          "sourceauthor": "",
          "attachmentsubject": "",
          "sourceposition": "",
          "attachmentpurpose": "",
          "sourcephonenumber": "",
          "acquisitionmethod": "",
          "sourceaddress": "",
          "locationoforiginal": "",
          "insertedby": securityusersid, //If you want to add inserted by they need to send
          "note": "",
          "updatedby": securityusersid,
          "activeflag": 1,
          "ecmsdocumentid": data.id
        },
        "documentdate": nowDate.toJSON(),
        "title": data.title,
        "objectid": objectId,
        "objecttypekey": isCaseRPerson,
        "rootobjecttypekey": "ServiceRequest",
        "activeflag": 1,
        "insertedby": securityusersid,
        "updatedby": securityusersid
      }
    ];

    LOGGER.debug("called", dataRes[0]);
    sintakeobj = dataRes;

    return Documentproperties.create({
      objecttypekey: dataRes[0].objecttypekey,
      servicerequestid: (dataRes[0].objecttypekey === "ServiceRequest") ? dataRes[0].objectid : dummyid,
      objectid: (dataRes[0].objectid) ? dataRes[0].objectid : dummyid,
      documenttypekey: 'Attachment',
      intakenumber: '',
      documentdate: nowDate.toJSON(),
      thirdpartysourceid: '',
      filename: dataRes[0].filename,
      originalfilename: dataRes[0].originalfilename,
      title: dataRes[0].title,
      description: '',
      other:'',
      mime: dataRes[0].mime,
      meta: '',
      encoding: '',
      numberofbytes: dataRes[0].numberofbytes,
      insertedby: securityusersid,
      updatedby: securityusersid,
      expirationdate: nowDate.toJSON(),
      rootobjectid: dataRes[0].objectid ? dataRes[0].objectid : dummyid,
      rootobjecttypekey: 'ServiceRequest',
      s3bucketpathname: dataRes[0].s3bucketpathname,
      ecmsdocumentid: dataRes[0]['documentattachment'].ecmsdocumentid
    }).then(function (res) {
      LOGGER.debug("res", res);
      return res;
    }).catch(err => {
      LOGGER.debug("dataRes[0].updatedby", securityusersid);
      LOGGER.debug("dataRes[0].insertedby", securityusersid);
      LOGGER.error('>>>>ERROR:', err);
      LOGGER.debug("dataRes[0].numberofbytes", dataRes[0].numberofbytes);
      // throw err;
      return {error:1,message:"Internal error occured.please try again"};
    });
  }

  Documentproperties.addcwattachment = function (data, request, reqctx) {
    sintakeobj = [];
    sintakeobj.push(data);
    return Documentproperties.addattchment(data, request, reqctx);

  }

  Documentproperties.delete = (id, reqctx) => {
    let securityusersid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      securityusersid = reqctx.req.headers.securityusersid;
    }
    const sql = 'UPDATE documentproperties SET activeflag=0,updatedon=now(),updatedby = $1 WHERE documentpropertiesid = $2';

    if (config.state === false) {
      return util.executeDBQuery(sql, [securityusersid, id])
      .then(data => deleteResult(data))
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
      });
    }

    const idsArray = id.split('&');
    const _id = idsArray[0];   //DocumentPropertyID
    const docId = idsArray[1]; //ECMS ID
    // split() yields strings, so the old `idsArray?.[2] === 1` was never true.
    const skipEcms = idsArray?.[2] === '1';

    return util.executeDBQuery(sql, [securityusersid, _id])
      .then(data => {
        // Wrapped in a promise so both paths of this callback return the same type.
        if (skipEcms) {
          return Promise.resolve(deleteResult(data));
        }

        return attachement.deleteFileFromECMS(docId, reqctx)
          .then(res => deleteResult(data, res))
          .catch(_err => {
            LOGGER.error('>>>>ERROR: ECMS delete failed for ' + docId, _err);
            return {
              ...deleteResult(data),
              "statusCode": 400,
              "name": _err.name,
              "msg": _err.message,
              "customErrorMessage": "File already got deleted"
            };
          });
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Documentproperties.deletelargefile = (id, reqctx) => {
    let securityusersid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      securityusersid = reqctx.req.headers.securityusersid;
    }
    const sql = 'UPDATE documentproperties SET activeflag=0,updatedon=now(),updatedby = $1 WHERE documentpropertiesid = $2';

    if (config.state === false) {
      return util.executeDBQuery(sql, [securityusersid, id])
      .then(data => deleteResult(data))
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
      });
    }

    const idsArray = id.split('&');
    const _id = idsArray[0];   //DocumentPropertyID
    const docId = idsArray[1]; //ECMS ID
    // split() yields strings, so the old `idsArray?.[2] === 1` was never true.
    const skipEcms = idsArray?.[2] === '1';

    return util.executeDBQuery(sql, [securityusersid, _id])
      .then(data => {
        // Wrapped in a promise so both paths of this callback return the same type.
        if (skipEcms) {
          return Promise.resolve(deleteResult(data));
        }

        return attachement.deleteLargeFileFromEDMS(docId, reqctx)
          .then(ress => deleteResult(data, ress))
          .catch(_error => {
            LOGGER.error('>>>>ERROR: EDMS delete failed for ' + docId, _error);
            return {
              ...deleteResult(data),
              "statusCode": 400,
              "name": _error.name,
              "msg": _error.message,
              "customErrorMessage": "File already got deleted"
            };
          });
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Documentproperties.remoteMethod('deletelargefile', {
    accepts:
    [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    http: { "verb": "delete", "path": "/deletelargefile/:id" },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Documentproperties.deletebyEcmsId = (data) => {
    var id = data['documentId']
    return Documentproperties.findOne({ attributes: ["documentpropertiesid"], where: { ecmsdocumentid: id } }).then(function (document_details) {
      if (document_details && document_details.documentpropertiesid) {
        const ids = document_details.documentpropertiesid + "&" + id + "&1";
        return Documentproperties.delete(ids);
      } else {
        return { error: 1, msg: "Ecms id not found" };
      }
    }).catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });
  };
  Documentproperties.remoteMethod('delete', {
    accepts:
    [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    http: { "verb": "delete", "path": "/delete/:id" },
    returns: {
      type: 'Object',
      root: true
    }
  });
  Documentproperties.remoteMethod(
    'deletebyEcmsId',
    {
      http: {
        path: '/deletebyEcmsId',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
      }],
      returns: {
        type: 'object',
        root: true
      }

    });


  Documentproperties.remoteMethod(
    'addattchment',
    {
      http: {
        path: '/addattchment',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
      },
      {
        arg: 'request', type: 'object',
        http: { source: 'req' }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }

    });



  Documentproperties.remoteMethod(
    'addintakeattchment',
    {
      http: {
        path: '/addintakeattchment',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'array',
        http: { source: 'body' }
      },
      {
        arg: 'request', type: 'object',
        http: { source: 'req' }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }

    });

  Documentproperties.remoteMethod(
    'addcaseworkerattachment',
    {
      http: {
        path: '/addcaseworkerattachment',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'array',
        http: { source: 'body' }
      },
      {
        arg: 'request', type: 'object',
        http: { source: 'req' }
      }],
      returns: {
        type: 'object',
        root: true
      }

    });

  Documentproperties.remoteMethod(
    'ecmsclientdetails',
    {
      http: {
        path: '/ecmsclientdetails',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
      }],
      returns: {
        type: 'object',
        root: true
      }

    });

    Documentproperties.remoteMethod(
      'getpersonattachmentsive',
      {
        http: {
          path: '/getpersonattachmentsive',
          verb: 'post'
        },
        accepts: [{
          arg: 'data', type: 'object',
          http: { source: 'body' }
        }],
        returns: {
          type: 'object',
          root: true
        }
  
      });



  Documentproperties.remoteMethod(
    'addcwattachment',
    {
      http: {
        path: '/addcwattachment',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
      },
      {
        arg: 'request', type: 'object',
        http: { source: 'req' }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }

    });


  Documentproperties.remoteMethod(
    'addEcmsattachment',
    {
      http: {
        path: '/addEcmsattachment',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
      },
      {
        arg: 'request', type: 'object',
        http: { source: 'req' }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }

    });

  // Audit log  add Update
  Documentproperties.observe('after save', function (ctx, next) {

    var propjson = { "typekey": "", "classkey": "" };
    var logJson = {};
    var description, intakeserviceid, referenceid, Servicerequestnumber, isnew, isedit;
    var logtypekey = "AT";
    if (ctx.isNewInstance) {
      logJson = {
        "data": {
          "type": "", "filename": "", "classificationtype": "", "danumber": "", "title": "",
          "createdby": "", "createadon": "", "documentdate": ""
        }
      }
      isnew = true;
      intakeserviceid = ctx.instance.objectid;
      referenceid = ctx.instance.documentpropertiesid;

      sintakeobj.forEach(x => {
        if (x.filename === ctx.instance.filename) {
          propjson.typekey = x.documentattachment?.attachmenttypekey;
          propjson.classkey = x.documentattachment?.attachmentclassificationtypekey;
        }
        //return x;
      })
      Servicerequestnumber = (intakeserviceid !== dummyid && intakeserviceid !== undefined) ?  ctx.instance.intakenumber : sIntakenumber;
      
      logJson.data.filename = ctx.instance.filename;
      logJson.data.classificationtype = propjson.classkey;
      logJson.data.createdby = sInserby;
      logJson.data.createadon = ctx.instance.insertedon;
      logJson.data.title = ctx.instance.title;
      logJson.data.danumber = Servicerequestnumber;
      logJson.data.type = propjson.typekey;
      description = propjson.typekey + filenamestr + ctx.instance.filename + ") " + " attachment added to DA#";

    } else if (ctx.data !== null && ctx.data !== undefined) {
      isedit = true;
      intakeserviceid = ctx.data.objectid;
      if (ctx.where.objecttypekey || ctx.data.objecttypekey) {
        LOGGER.debug("in object id");
        return next();
      }

      referenceid = ctx.where.documentpropertiesid;

      logJson = {
        "data": {
          "type": "", "filename": "", "classificationtype": "", "danumber": "", "title": "",
          "updatedby": "", "updatedon": "", "documentdate": ""
        }
      }

      sintakeobj.forEach(x => {
        if (x.filename === ctx.data.filename) {
          propjson.typekey = x?.documentattachment?.attachmenttypekey;
          propjson.classkey = x?.documentattachment?.attachmentclassificationtypekey;
        }
        return x;
      })
      const srn = checkServicerequestnumber(intakeserviceid, ctx);
      Servicerequestnumber = srn.Servicerequestnumber;
      logJson.data.type = propjson.typekey;
      logJson.data.filename = ctx.data.filename;
      logJson.data.classificationtype = propjson.classkey;
      logJson.data.updatedby = srn.securityuserid;
      logJson.data.updatedon = ctx.data.updatedon;
      logJson.data.documentdate = ctx.data.documentdate;
      logJson.data.danumber = sIntakenumber;
      logJson.data.title = ctx.data.title;
      logJson.data.danumber = Servicerequestnumber;
      description = propjson.typekey + " (filename: " + ctx.data.filename + ") " + " attachment updated to DA# ";

    }
    var newadd = {
      "description": description,
      "logtypekey": logtypekey,
      "intakeserviceid": intakeserviceid,
      "referenceid": referenceid,
      "servicerequestnumber": Servicerequestnumber,
      "metadata": logJson,
      "ipaddress": ipaddress,
      "isnew": isnew,
      "isedit": isedit
    }
    // Auditlog Recording Added here
    app.models.Auditlog.createlogdetails(newadd);
    next();
  })

  function checkServicerequestnumber(intakeserviceid, ctx){
    let Servicerequestnumber;
    if (intakeserviceid !== dummyid && intakeserviceid !== undefined) {
      Servicerequestnumber = ctx.instance.intakenumber;
    } else {
      Servicerequestnumber = sIntakenumber;
    }
    const securityuserid = ( ctx.data &&  ctx.data.securityuserid? ctx.data.securityuserid: '');
    return {
      Servicerequestnumber,
      securityuserid
    }
  }

  const befRemotefn = (ctx, data, next) => {
    if (ctx.req) {
      ipaddress = ctx.req.connection.remoteAddress;
    }
    next();
  }

  // for audit log ipaddress case worker
  Documentproperties.beforeRemote('addattchment', befRemotefn);

  // for audit log ipaddress  intake
  Documentproperties.beforeRemote('addintakeattchment', befRemotefn);

  // Audit log for delete
  Documentproperties.afterRemote('delete', function (ctx, next) {

    var description, referenceid, Servicerequestnumber, isdelete;
    var title, filename, s3bucketpathname, documentpropertiesid,
      attachmenttypekey, attachmentclassificationtypekey;

    var logtypekey = "IAT";
    isdelete = true;
    ipaddress = ctx.req.connection.remoteAddress;

    // FIX: Split the ID to isolate the UUID from the ECMS ID
    let idsArray = ctx.args.id.split('&');
    let _id = idsArray[0]; 
    
    referenceid = _id; // Use the parsed UUID here

    var logJson = {
      "data":
      {
        "type": "",
        "filename": "",
        "danumber": "",
        "title": "",
        "s3bucketpathname": "",
        "classificationtype": "",
        "updatedby": ""
      }
    };

    var sql = 'Select title,s3bucketpathname, filename,documentpropertiesid,intakenumber from documentproperties where documentpropertiesid = $1';
    LOGGER.debug(sql + "sql");
    // FIX: Pass _id instead of ctx.args.id
    return util.executeDBQuery(sql, [_id])
    .then(data => {
      var result = data[0];
      title = result.title;
      filename = result.filename;
      s3bucketpathname = result.s3bucketpathname;
      Servicerequestnumber = result.intakenumber;
      documentpropertiesid = result.documentpropertiesid;
      LOGGER.debug(title, filename, s3bucketpathname, Servicerequestnumber)

    }).then(respon => {
      return app.models.Documentattachment.find({
        where:
        {
          documentpropertiesid: documentpropertiesid
        }, fields: ['attachmenttypekey', 'attachmentclassificationtypekey']
      })
    }).then(res => {
      var atach = res[0];
      attachmenttypekey = atach.attachmenttypekey;
      attachmentclassificationtypekey = atach.attachmentclassificationtypekey;

      logJson.data.filename = filename;
      logJson.data.danumber = Servicerequestnumber;
      logJson.data.title = title;
      logJson.data.updatedby = app.currentUser.email;
      logJson.data.s3bucketpathname = s3bucketpathname;
      logJson.data.type = attachmenttypekey;
      logJson.data.classificationtype = attachmentclassificationtypekey;
      description = attachmenttypekey + filenamestr + filename + ",title: " + title + ") " + " attachment deleted from DA#";

      var newadd = {
        "description": description,
        "logtypekey": logtypekey,
        "referenceid": referenceid,
        "servicerequestnumber": Servicerequestnumber,
        "metadata": logJson,
        "ipaddress": ipaddress,
        "isdelete": isdelete
      }
      // Auditlog Recording Added here
      app.models.Auditlog.createlogdetails(newadd);

    }).catch(err => err);
  })

  Documentproperties.updateObjectId = (request, reqctx) => {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    if(request.personid && request.documentpropertiesid){
          var personid = request.personid;
          var documentpropertiesid = request.documentpropertiesid;
          var securityuserid = _securityusersid;
          var sql = 'UPDATE cjams.documentproperties SET objectid=$1, updatedby=$2, updatedon=now() WHERE documentpropertiesid=$3';
          return util.executeDBQuery(sql, [personid, securityuserid, documentpropertiesid])
          .then(resp => resp)
          .catch(err => util.logError(err));
    }
      return Promise.resolve('Invalid request');
  }

  Documentproperties.remoteMethod('updateObjectId', {
    http: {
        path: '/updateObjectId',
        verb: 'post'
    },
    accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    returns: {
        type: 'string',
        root: true
    }
  });

Documentproperties.remoteMethod('updateuploadstatus', {
  http: {
          path: '/updateuploadstatus',
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
});

  Documentproperties.getUploadFailedAttachments = (request) => {
    // Secondry node connectoin
    // if (config.issecondarynodesearchenabled) { // secondarynodesearchenabled enabled
    //     ds = app.dataSources.secondarynodesearch;
    //     if (!ds.connected) { // If connection is not active, call the primary node
    //         ds = app.dataSources.hcuewelfare;
    //     }
    // }
    let sql = 'select * from getUploadFailedAttachments($1,$2)';
    LOGGER.debug(sql + "sql");
    return util.executeDBQuery(sql,[request.where.userid, request.where.ecmsdocumentid])
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  }

  Documentproperties.remoteMethod('getUploadFailedAttachments', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: { "verb": "get", "path": "/getUploadFailedAttachments" },
    returns: {
      type: 'string',
      root: true
    }
  });
// To get the latest file of the user where status is updated.
  Documentproperties.getFileUploadStatusUpdate = (request) => {
    let sql = 'select * from getFileUploadStatusUpdate($1,$2)';
    LOGGER.debug(sql + "sql");
    return util.executeDBQuery(sql,[request.where.userid, request.where.filestatuspendinglist])
      .then(data => data)
      .catch(error => { LOGGER.error('>>>>ERROR:', error); throw error; });
  }

  Documentproperties.remoteMethod('getFileUploadStatusUpdate', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {"verb": "get", "path": "/getFileUploadStatusUpdate" },
    returns: {
      type: 'string',
      root: true
    }
  });

  // Presign URL upload failed status update.
  Documentproperties.fileuploadstatusupdate = function (id, reqctx) {
    let securityusersid = 'User';
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      securityusersid = reqctx.req.headers.securityusersid;
    }
    if (id) {
      const sql = 'UPDATE documentproperties SET activeflag=5, uploadstatus = \'FAILED\',updatedon=now(),updatedby = $1 WHERE ecmsdocumentid = $2';
      return util.executeDBQuery(sql,[securityusersid,id])
      .then(data => {
        return data;
      })
      .catch(err => {
          LOGGER.error(err);
          throw err;
      })
    }
      return Promise.resolve('Invalid request');
  };

  Documentproperties.remoteMethod('fileuploadstatusupdate', {
    http: {
      path: '/fileuploadstatusupdate/:id',
      verb: 'post'
    },
    accepts: [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
      },
      {
      arg: 'reqctx',
      type: 'object',
      http: { source: 'context' }
    }],
    returns: {
      type: 'object',
      root: true
    }
  });

  Documentproperties.remoteMethod('getDocumentDetails', {
    accepts: {
      arg: "data",
      type: "Object",
      http: {
        source: "body"
      },
      required: true
    },
    http: {
      path: "/getDocumentDetails",
      verb: "post"
    },
    returns: {
      type: "string",
      root: true
    }
  });

  Documentproperties.getDocumentDetails = (request) => {
    const docId = request.where.documentpropertiesid.trim();
    if (request) {
      const sql = 'select * from documentproperties where documentpropertiesid = $1';
      return util.executeDBQuery(sql, [docId])
        .then(data => {
          const list = data && data.length ? data[0] : [];
          return { data: list };
        });
    }
  }

  Documentproperties.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Documentproperties.observe('access', (ctx, next) => util.access(ctx, next));
  Documentproperties.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};