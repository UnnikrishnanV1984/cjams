'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
const Logger = require("log4js").getLogger("adoptioncaseagreementrevision");
module.exports = function(Adoptioncaseagreementrevision) {   

    Adoptioncaseagreementrevision.remoteMethod('createagreementrevision', {
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

    Adoptioncaseagreementrevision.createagreementrevision = async (request, reqctx) => {
        
        var securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        var now = new Date();
        
        request.updatedby = securityusersid;
        request.updatedon = now;
        
        request.status = 'Review';

        if (!request.adoptionagreementid) {
            let gen_random_uuid;
            var genid = "select * from gen_random_uuid()"; //@TM: use generated subsidy agreement id if unavailable
            util.executeDBQuery(genid, []).then((resp)=>{
                resp = JSON.parse(JSON.stringify(resp));
                gen_random_uuid = resp[0].gen_random_uuid
            }).catch((error)=>{
                Logger.error(error); 
            });
            
            request.adoptionagreementid = gen_random_uuid;
            request.insertedby = securityusersid;
            request.insertedon = now;
        }

        if (request.adoptionagreementid) {
            // De-activate any existing review/incomplete records
            var revision = "update adoptioncaseagreementrevision"
                +" set activeflag = 0"
                +" where adoptioncaseagreementid = \'"+request.adoptionagreementid+"\'"
                +" and activeflag = 1"
                +" and (approvalstatustypekey = '3045' or approvalstatustypekey ='3046' or approvalstatustypekey is null)";
            return util.executeDBQuery(revision, []).then(()=>{
                return 'success'
            })
            .then( res => {
                if (res === "success") {
                    // Create revision - Agreement record should be created only after approval
                    return Adoptioncaseagreementrevision.create(request).then(data => {
                        if (util.isNullorEmpty(request.attachment)) {
                            request.attachment.map(attach => {
                                attach.documentattachment = {};
                                attach.objectid = request.adoptionagreementid;
                                attach.servicecaseid = request.servicecaseid;
                                attach.objecttypekey = attach.rootobjecttypekey;
                                attach.insertedby = securityusersid;
                                attach.updatedby = securityusersid;
                                attach.servicerequestid = request.intakeserviceid; //SonarQube fix - removed the self-assignments
                                attach.documentattachment.attachmentclassificationtypekey = attach.attachmentclassificationtypekey;
                                attach.documentattachment.attachmentclassificationsubtypekey = attach.attachmentclassificationsubtypekey;
                                attach.documentattachment.attachmentdate = attach.documentdate;
                                attach.documentattachment.attachmenttypekey = attach.attachmenttypekey;
                            });
                            return app.models.Documentproperties.addcommonattachment(request.attachment, null, reqctx).then(()=>{
                              return data;
                            }).catch(err=>{
                                LOGGER.error(err)
                            })
                        }
                        return data;
                    }).catch(err => LOGGER.error(err));
                } else {
                    return Promise.resolve('Unable to create revision!');
                }
            }).then(res => {
                if(request.switchprovider) {
                    var sql = `INSERT INTO providerswitchinfo (objectid, objecttype, approvalstatus,requestedby, insertedby, updatedby,
                        decisiondate , activeflag, oldproviderid, newproviderid) values ($1,$2,$3,$4,$5,$6,$7,$8, $9, $10)`;
                        return util.executeDBQuery(sql, [res.adoptioncaseagreementrevisionid, 'Adoption','Review',securityusersid,securityusersid, securityusersid,
                        now, 1, request.oldproviderid ,request.newproviderid]).then((resp)=>{
                            return res;
                        }).catch((error)=>{
                            Logger.error(error); 
                            return err;
                        });
               } else {
                   return res;
               } 

            }).catch((error)=>{
                Logger.error(error); 
            });
        }
    }
    Adoptioncaseagreementrevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptioncaseagreementrevision.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptioncaseagreementrevision.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));    
}
  