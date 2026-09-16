'use strict';
const LOGGER = require("log4js").getLogger("adoptionagreementrevision");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Adoptionagreementrevision) {
    
    Adoptionagreementrevision.remoteMethod('createagreementrevision', {
        http: {
                path: '/createagreementrevision',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Adoptionagreementrevision.createagreementrevision = async (request, reqctx) => {
        var securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        var now = new Date();

        request.updatedby = securityusersid;
        request.updatedon = now;
        request.status = 'Review';
        request.attachment = request.attachment && Array.isArray(request.attachment) ? request.attachment : [];

        if (!request.adoptionagreementid) {
            var genid = "select * from gen_random_uuid()"; //@TM: use generated subsidy agreement id if unavailable
            const gen_random_uuid = await util.executeDBQuery(genid, [])
                .then(rateid => {
                    var generatedId = JSON.parse(JSON.stringify(rateid));
                    return generatedId[0].gen_random_uuid;
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
            request.insertedby = securityusersid;
            request.insertedon = now;
            request.adoptionagreementid = gen_random_uuid;
        } 
            // De-activate any existing review/incomplete records
        if (request.adoptionagreementid) {
            var revision = "update adoptionagreementrevision"
            +" set activeflag = 0"
            +" where adoptionagreementid = \'"+request.adoptionagreementid+"\'"
            +" and activeflag = 1"
            +" and (approvalstatustypekey = '3045' or approvalstatustypekey ='3046' or approvalstatustypekey is null)";
            return util.executeDBQuery(revision, [])
            .then(() => "success")
            .then( res => {
                if (res === "success") {
                    // Create revision - Agreement record should be created only after approval
                    return Adoptionagreementrevision.create(request).then(data => {
                            request.attachment.map(attach => {
                                attach.documentattachment = {};
                                attach.objectid = request.adoptionagreementid;
                                attach.servicecaseid = request.servicecaseid;
                                attach.objecttypekey = attach.rootobjecttypekey;
                                attach.insertedby = securityusersid;
                                attach.updatedby = securityusersid;
                                attach.servicerequestid = request.intakeserviceid;          //SonarQube fix - removed the self-assignments
                                attach.documentattachment.attachmentclassificationtypekey = attach.attachmentclassificationtypekey;
                                attach.documentattachment.attachmentclassificationsubtypekey = attach.attachmentclassificationsubtypekey;
                                attach.documentattachment.attachmentdate = attach.documentdate;
                                attach.documentattachment.attachmenttypekey = attach.attachmenttypekey;
                            });

                             app.models.Documentproperties.addcommonattachment(request.attachment, null, reqctx).then((res1)=>{
                                return { code: 200, message: 'success', data: res1}
                            }).catch(err=>{
                                LOGGER.error(err);
                            })
                        return data;
                    }).catch(err => LOGGER.error(err));
                }
                return Promise.resolve('Unable to create revision!');
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        }
    }

    Adoptionagreementrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionagreementrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionagreementrevision.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}   
 