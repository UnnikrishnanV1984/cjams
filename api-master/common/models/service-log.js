'use strict';
const LOGGER = require("log4js").getLogger("service-log");
var server = require('../../server/server');
const app = require('../../server/server');
const util = require('../utils/utils');

// The service-log save/update/list endpoints all end the same way: run one query
// and return its result untouched, logging locally on success and handing
// failures to the central logger. Shared so the identical tail is not repeated
// per endpoint.
const runServiceLogQuery = (dataQuery, params) => util.executeDBQuery(dataQuery, params)
    .then(result => {
        LOGGER.debug('success');
        LOGGER.debug(result, 'result');
        return result;
    })
    .catch(err => util.logError(err));

module.exports = function (Servicelog) {
    Servicelog.saveServiceLog = (servicelogData,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        const dataQuery = `INSERT INTO tb_service_log (case_id,start_dt, end_dt, start_tm, end_tm, estimated_start_dt, estimated_end_dt,
                              frequency_cd, duration_cd, agency_service_ldss_id, agency_program_area_id, create_user_id, update_user_id, description_tx,intakeservicerequestactorid,client_id
                              ,serviceplanid,serviceplanactionid) VALUES (
                                 $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14,$15,$16,$17,$18)`;

        var insertedby = (servicelogData && servicelogData.securityuserid?servicelogData.securityuserid: suserid);
        if (insertedby === undefined) {
            insertedby = ' ';
        }
        var updatedby = (servicelogData && servicelogData.securityuserid?servicelogData.securityuserid: suserid);
        if (updatedby === undefined) {
            updatedby = ' ';
        }
        LOGGER.error('user id>>', insertedby, app.currentUser);
        return runServiceLogQuery(dataQuery, [servicelogData.daNumber,
        servicelogData.startDt,
        servicelogData.endDt,
        servicelogData.startTm,
        servicelogData.endTm,
        servicelogData.estimatedStartDt,
        servicelogData.estimatedEndDt,
        servicelogData.frequencyCd,
        servicelogData.durationCd,
        servicelogData.agencyServiceLdssId,
        servicelogData.agencyProgramAreaId, insertedby, updatedby,
        servicelogData.descriptionTx,
        servicelogData.intakeservicerequestactorid,
        servicelogData.client_id,
        servicelogData.serviceplanid,
        servicelogData.serviceplanactionid
        ]);
    };
    Servicelog.remoteMethod('saveServiceLog', {
        http: {
            path: '/save',
            verb: 'post'
        },
        accepts: [{
            arg: 'servicelogData',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }

    });


    /**
     * update
     */
    Servicelog.updateServiceLog = (servicelogData, reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }  
        suserid = (servicelogData && servicelogData.securityuserid ? servicelogData.securityuserid: suserid);
        LOGGER.debug('start date',servicelogData.startDt);
        const dataQuery = `UPDATE tb_service_log SET
        start_dt=$1, end_dt= $2, start_tm= $3, end_tm=$4, estimated_start_dt=$5,
        estimated_end_dt=$6, frequency_cd=$7, duration_cd=$8, agency_service_ldss_id=$9,
        agency_program_area_id=$10, description_tx=$11, intakeservicerequestactorid =$12
        ,serviceplanid=$14,serviceplanactionid=$15, update_ts= now(), update_user_id=$16 WHERE service_log_id = $13`;
        LOGGER.debug('start date',servicelogData.startDt);
        LOGGER.debug('end date',servicelogData.endDt);
        LOGGER.debug('start time',servicelogData.startTm);
        LOGGER.debug('end time',servicelogData.endTm);
        LOGGER.debug('estimated start date',servicelogData.estimatedStartDt);
        LOGGER.debug('estimated end date',servicelogData.estimatedEndDt);
        LOGGER.debug('frequency',servicelogData.frequencyCd);
        LOGGER.debug('duration',servicelogData.durationCd);
        LOGGER.debug('service id',servicelogData.agencyServiceLdssId);
        LOGGER.debug('apa id',servicelogData.agencyProgramAreaId);
        LOGGER.debug('description',servicelogData.descriptionTx);
        LOGGER.debug('service log id',servicelogData.serviceLogId);
        return runServiceLogQuery(dataQuery, [servicelogData.startDt,
        servicelogData.endDt,
        servicelogData.startTm,
        servicelogData.endTm,
        servicelogData.estimatedStartDt,
        servicelogData.estimatedEndDt,
        servicelogData.frequencyCd,
        servicelogData.durationCd,
        servicelogData.agencyServiceLdssId,
        servicelogData.agencyProgramAreaId,
        servicelogData.descriptionTx,
        servicelogData.intakeservicerequestactorid,
        servicelogData.serviceLogId,
        servicelogData.serviceplanid,
        servicelogData.serviceplanactionid,
        suserid]);
    };
    Servicelog.remoteMethod('updateServiceLog', {
        http: {
            path: '/update',
            verb: 'put'
        },
        accepts: [{
            arg: 'servicelogData',
            type: 'object',
            http: {
                source: 'body'
            }
        },
        {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
        }],
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }

    });

    /**
     * list
     */
    Servicelog.getServiceLogs = (request) => {
        var caseNumber = request.where.daNumber;
        var v_client_id = request.where.client_id;
        var sortColumn = request.where.sortcolumn?request.where.sortcolumn:'actual_begin_date';
        var sortOrder = request.where.sortorder?request.where.sortorder:'desc';
        const dataQuery = 'SELECT * FROM get_codes_discription_service_log($1,$2) order by '+ sortColumn + ' ' + sortOrder;
        return runServiceLogQuery(dataQuery,[caseNumber,v_client_id]);
    };
    Servicelog.remoteMethod('getServiceLogs', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            }
        },
        returns: {
            arg: 'servicelogData',
            type: 'Object'
        }
    });


    // Vender get call    //
    //

   Servicelog.getVendorList = async (request, reqctx) => {
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var requestuserinfo = {'token': '', 'email': _email};
        var caseNumber = request.where.daNumber;
        var clientid = request.where.clientid;
        var servicelogid =  request.where.service_log_id;
        var page = request.page?request.page:1;
        let limit; 
        
        if(request.incaseplan){ limit = 9999;} 
        else{ limit = request.limit ? request.limit : 10;}

        var sroletypekey ;
        await util.getuserinfo(requestuserinfo).then (data => {
        sroletypekey = data.roletypekey;
        });  
        const dataQuery = 'SELECT * FROM GET_PROVIDER_SERVICE_LOG($1,$2,$3,$4,$5,$6,$7,$8)';
        return util.executeSecondaryNodeDBQuery(dataQuery,[caseNumber,sroletypekey,clientid,servicelogid
                ,page,limit,request.where.sortorder,request.where.sortcolumn])
        .then(result => {
                    var data;
                    data = {
                        servicelogData : result
                    };
                    LOGGER.debug('success');
                    LOGGER.debug(result, 'result');
                    return data;
        }).then(result => {
                    return util.encryptresponse(result);
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };
    Servicelog.remoteMethod('getVendorList', {
        http: {
            path: '/getVendorList',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            }
        },
        {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        returns: {
            // arg: 'servicelogData',
            type: 'Object',
            root: true
        }
    });

    Servicelog.remoteMethod('addAttachment', {
        http: {
            path: '/addAttachment',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        }
        ,{
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Servicelog.addAttachment = (request,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        var nowDate = new Date();
        if (request.attachment != null && request.attachment != undefined && request.attachment != "" && Array.isArray(request.attachment)) {
            const attach = request.attachment[0];
            const sql = ` INSERT INTO documentproperties (objecttypekey, 
                          servicerequestid,
                          servicecaseid,
                          objectid,
                          documenttypekey,
                          intakenumber,
                          actualdocumentdate,
                          thirdpartysourceid,
                          filename,
                          originalfilename,
                          title,
                          description,
                          mime,
                          meta,
                          encoding,
                          numberofbytes,
                          insertedby,
                          updatedby,
                          expirationdate,
                          rootobjectid,
                          rootobjecttypekey,
                          s3bucketpathname,
                          ecmsdocumentid,
                          additionalobjecttype,
                          additionalobjectid)
                      values(
                         $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $17, $18, $19, $20, $21, $22, $23, $24
                      )RETURNING documentpropertiesid, servicecaseid, objectid, ecmsdocumentid; `
                      return util.executeDBQuery(sql, ['Servicecase',
                      attach.servicerequestid,
                      request.servicecaseid,
                      request.servicecaseid,
                      'Attachment',
                      attach.intakenumber,
                      attach.actualdocumentdate,
                      attach.thirdpartysourceid,
                      attach.filename,
                      attach.originalfilename,
                      attach.title,
                      attach.description,
                      attach.mime,
                      attach.meta,
                      attach.encoding,
                      attach.numberofbytes,
                      suserid,
                      nowDate.toJSON(),
                      request.servicecaseid,
                      'Servicecase',
                      attach.s3bucketpathname,
                      attach.ecmsdocumentid,
                      'purchaseAuthReceipt',
                      attach.authId ? attach.authId : null])
                      .then(data => {
                          return data;
                      })
                      .then(data => {
                if (Array.isArray(data) && data.length > 0) {
                    for(let i = 0; request.attachment.length > i; i++){
                    Servicelog.addDocumentCategories(data[0].documentpropertiesid, request.attachment[i],request.securityuserid,suserid);}
                }
                return data;
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })
        } else {
            return Promise.resolve({ code: 500, message: 'Error in saving the document' });
        }

    };

    Servicelog.remoteMethod('deleteAttachment', {
        http: {
            path: '/deleteAttachment',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Servicelog.deleteAttachment = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        if (request.documentpropertiesid != null && request.documentpropertiesid != undefined && request.documentpropertiesid != "") {
            const documentpropertiesid = request.documentpropertiesid;
            const sql = ` update documentproperties
                set activeflag = 0, updatedon = now(), updatedby = $1 where documentpropertiesid = $2`
            return util.executeDBQuery(sql, [(request && request.securityuserid?request.securityuserid: suserid), documentpropertiesid]).then(data => {
                return { code: 200, message: 'Sucess!' };
            })
                .catch(err => {
                    LOGGER.error(err);
                });
        } else {
            return Promise.resolve({ code: 500, message: 'Error in deleting the document' });
        }

    };

    Servicelog.addDocumentCategories = (documentpropertiesid, request,securityuserid,suserid) => {
        var nowDate = new Date();
        if (documentpropertiesid != null && documentpropertiesid != undefined && documentpropertiesid != "") {
            const documentattachments = request
            return app.models.Documentattachment.create({
                documentpropertiesid: documentpropertiesid,
                attachmenttypekey: "Document",
                attachmentclassificationtypekey : documentattachments.attachmentclassificationtypekey ,
                attachmentclassificationsubtypekey : documentattachments.attachmentclassificationsubtypekey,
                attachmentdate: nowDate.toJSON(),
                
                insertedby: (securityuserid?securityuserid:suserid),
                updatedby: (securityuserid?securityuserid:suserid),
                insertedon: nowDate.toJSON(),
                updatedon: nowDate.toJSON(),
                activeflag: 1,
                expirationdate: nowDate.toJSON()
              }
              ).then(data =>{ 
                  return data;
                }).catch(err =>{
                    LOGGER.error(err);
                });
        } else {
            return { code: 500, message: 'Error in saving the document' }
        }
    };

    //vendor update

    Servicelog.editVendorServiceLog = (servicelogData, reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }  
        suserid = (servicelogData && servicelogData.securityuserid ? servicelogData.securityuserid: suserid);
        const dataQuery = `UPDATE tb_service_log SET
        estimated_start_dt=$1, estimated_end_dt=$2, frequency_cd=$3, duration_cd=$4,
        provider_service_id=$5, agency_program_area_id=$6, court_ordered_sw=$7,
        referred_dt=$8, outcome_tx=$9, end_service_reason_cd=$10, no_service_reason_cd=$11,
        start_dt=$12, end_dt=$13, start_tm=$14, end_tm=$15, description_tx=$16,serviceplanid=$18,
        serviceplanactionid=$19,agency_sub_program_area_id=$20, end_service_subcategory_reason=$21,
        end_reason_desc_tx=$22, update_ts= now(), update_user_id=$23 WHERE service_log_id = $17`;
        return runServiceLogQuery(dataQuery, [servicelogData.estimatedStartDt,
        servicelogData.estimatedEndDt,
        servicelogData.frequencyCd,
        servicelogData.durationCd,
        servicelogData.providerServiceId,
        servicelogData.agencyProgramAreaId,
        servicelogData.courtOrderedSw,
        servicelogData.referredDt,
        servicelogData.outcome,
        servicelogData.endServiceReasonCd,
        servicelogData.noServiceReasonCd,
        servicelogData.startDt,
        servicelogData.endDt,
        servicelogData.startTm,
        servicelogData.endTm,
        servicelogData.descriptionTx,
        servicelogData.serviceLogId,
        servicelogData.serviceplanid,
        servicelogData.serviceplanactionid,
        servicelogData.agencysubprogramareaid,
        servicelogData.endsubcategoryreason,
        servicelogData.endReasonNotes,
        suserid
        ]);
    };

   
    Servicelog.remoteMethod('editVendorServiceLog', {
        http: {
            path: '/editVendorServiceLog',
            verb: 'put'
        },
        accepts: [{
            arg: 'servicelogData',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
        }],
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }

    });


    //vendor insert api
    Servicelog.vendorSaveServiceLog = (servicelogData,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }  
        const dataQuery = `INSERT INTO tb_service_log (client_id ,case_id, estimated_start_dt, estimated_end_dt,
                              frequency_cd, duration_cd, provider_service_id, agency_program_area_id, 
                              court_ordered_sw, outcome_tx, end_service_reason_cd, no_service_reason_cd,
                              start_dt, end_dt, start_tm, end_tm,
                              description_tx, referred_dt, create_user_id, update_user_id,serviceplanid,serviceplanactionid,ldss_cd, agency_sub_program_area_id, end_service_subcategory_reason, end_reason_desc_tx) VALUES (
                                 $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20,$21,$22,$23, $24, $25, $26)`;

        var insertedby = (servicelogData && servicelogData.securityuserid?servicelogData.securityuserid: suserid);
        if (insertedby === undefined) {
            insertedby = ' ';
        }
        var updatedby = (servicelogData && servicelogData.securityuserid?servicelogData.securityuserid: suserid);
        if (updatedby === undefined) {
            updatedby = ' ';
        }

        LOGGER.error('user id>>', insertedby, app.currentUser);

        return runServiceLogQuery(dataQuery, [servicelogData.client_id,servicelogData.daNumber,
        servicelogData.estimatedStartDt,
        servicelogData.estimatedEndDt,
        servicelogData.frequencyCd,
        servicelogData.durationCd,
        servicelogData.providerServiceId,
        servicelogData.agencyProgramAreaId,
        servicelogData.courtOrderedSw,
        servicelogData.outcomeTx,
        servicelogData.endServiceReasonCd,
        servicelogData.noServiceReasonCd,
        servicelogData.startDt,
        servicelogData.endDt,
        servicelogData.startTm,
        servicelogData.endTm,
        servicelogData.descriptionTx,
        servicelogData.referredDt, insertedby, updatedby,
        servicelogData.serviceplanid,
        servicelogData.serviceplanactionid,
        servicelogData.ldss_cd,
        servicelogData.agencysubprogramareaid,
        servicelogData.endsubcategoryreason,
        servicelogData.endReasonNotes
        ]);
    };
    Servicelog.remoteMethod('vendorSaveServiceLog', {
        http: {
            path: '/vendorSaveServiceLog',
            verb: 'post'
        },
        accepts: [{
            arg: 'servicelogData',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }
    });
    Servicelog.deleteVendorService = request => {

        const authCheckSql = "select 1 from tb_service_purchase_authorization where service_log_id = $1 and delete_sw = 'N' limit 1";
        const sqlCmd = "update tb_service_log set delete_sw = 'Y' where service_log_id = $1  and client_id=$2 and case_id=$3";

        return util.executeDBQuery(authCheckSql, [request.service_log_id])
        .then(authorizations => {
            if (authorizations && authorizations.length > 0) {
                throw new Error('This service log has a purchase authorization and cannot be deleted.');
            }
            return util.executeDBQuery(sqlCmd, [request.service_log_id,request.client_id,request.case_id]);
        })
        .catch(err => {
            util.logError(err);
            throw err;
        });
      };
  
      Servicelog.remoteMethod('deleteVendorService', {
          http: {
                  path: '/deleteVendorService',
                  verb: 'put'
          },
          accepts : [ {arg : 'data',type : 'object',
              http : {source : 'body'}} ],
          returns: {
              type : 'object',
              root : true
          }
      });
      Servicelog.remoteMethod('getServicePlanActionList', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Servicelog.getServicePlanActionList=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        const personid =request.where.personid;
        LOGGER.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>personid>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>',personid);
        var totalcount = 0;
        var sql= 'select * from get_service_plan_action_list($1,$2,$3)';
        return util.executeDBQuery(sql,[personid, pageno, pagesize]).then(data => {
            var result;
            if (data!==null && data.length>0)
            {
                if(data[0].get_service_plan_action_list)
                {
                    totalcount= data[0].get_service_plan_action_list[0].totalcount;
                    result = {
                        'data' : data[0].get_service_plan_action_list,
                        'count' : totalcount
                    };
                } else{
                    result = {
                        'data' : [],
                        'count' : totalcount
                    };
                }
            }
            return result;
        })
    .catch(err => util.logError(err));

    };
    Servicelog.remoteMethod('getServicePlanList', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Servicelog.getServicePlanList=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;
        var sql= 'select * from get_service_plan_list($1,$2,$3)';
        return util.executeDBQuery(sql,[request.where.serviceplanactionid, pageno, pagesize]).then(data => {
            var result;
            if (data!==null && data.length>0)
            {
                if(data[0].get_service_plan_list)
                {
                    totalcount= data[0].get_service_plan_list[0].totalcount;
                    result = {
                        'data' : data[0].get_service_plan_list,
                        'count' : totalcount
                    };
                }
                else{
                    result = {
                        'data' : data[0].get_service_plan_list,
                        'count' : totalcount
                    };
                }
            }
            return result;
        })
    .catch(err => util.logError(err));

    };

 /**
     *  Multiple clientid list
     */
    Servicelog.getServiceLogsmultiple = (request) => {
        var caseNumber = request.where.daNumber;
        var v_client_id = request.where.client_id;
        const dataQuery = 'SELECT * FROM get_codes_discription_service_log_multiple($1,$2)';
        return runServiceLogQuery(dataQuery,[caseNumber,v_client_id]);
    };
    Servicelog.remoteMethod('getServiceLogsmultiple', {
        http: {
            path: '/servicelogmultipelist',
            verb: 'get'
        },
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            }
        },
        returns: {           
            type: 'Object',
            root: true
        }
    });


    Servicelog.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicelog.observe('access', (ctx, next) => util.access(ctx, next));
    Servicelog.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}