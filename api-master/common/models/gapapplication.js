'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
const pdf = require('../models/pdf');
const LOGGER = require("log4js").getLogger("Gapapplication");
module.exports = function(Gapapplication) {   

    /**Gapapplication add */
    Gapapplication.remoteMethod('add', {
        http: {
                path: '/add',
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
    Gapapplication.add = (request, reqctx) => {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if (request.gapid!=null && request.gapid!==undefined && request.gapapplicationid!=null && request.gapapplicationid!==undefined) {
           return Gapapplication.updateguardianship(request, _securityusersid);
       } else {
           return Gapapplication.addguardianship(request, _securityusersid);
       }
   }

   Gapapplication.updateguardianship = async function(request, _securityusersid)
   {
       var comments = '';
       if(request.comments !== undefined && request.comments !== null)
           {comments = request.comments;}
        const securityuserid = request.securityuserid ? request.securityuserid : _securityusersid;
        if(request.intakeserviceid == null || request.intakeserviceid === undefined){
            request.intakeserviceid = '';
        }

        try {
           await app.models.Guardianship.updateAll(
               {gapid:request.gapid},
               {
                   guardianoneid:request.guardianoneid,
                   guardiantwoid:request.guardiantwoid,
                   guardianonename:request.guardianonename,
                   guardiantwoname:request.guardiantwoname,
                   guardianoneproviderid:request.guardianoneproviderid,
                   guardiantwoproviderid:request.guardiantwoproviderid,
                   updatedby:securityuserid,
                   successionaddendumdate:request.successionaddendumdate,
                   successorguardianname:request.successorguardianname,
                   cofinaldate:request.cofinaldate,
                   empprogramstartdate:request.empprogramstartdate,
                   empprogramname:request.empprogramname,
                   primaryrelationshipkey:request.primaryrelationshipkey,
                   secondaryrelationshipkey:request.secondaryrelationshipkey,
                   fosterhomeapprover:request.fosterhomeapprover,
                   isrcgunderstandpurpose:request.isrcgunderstandpurpose,
                   isrcgacknowledgedruledoutplans:request.isrcgacknowledgedruledoutplans,
                   isrcgapprovedhomeforsixmonths:request.isrcgapprovedhomeforsixmonths,
                   isrcgcomprehensivestudycompleted:request.isrcgcomprehensivestudycompleted,
                   isrcgcompletedprotectiveclearance:request.isrcgcompletedprotectiveclearance,
                   isrcgauthorizedmentalinfo:request.isrcgauthorizedmentalinfo,
                   isrcgshowpermanentcommitment:request.isrcgshowpermanentcommitment,
                   isrcgwillstablehome:request.isrcgwillstablehome,
                   isrcgprovidesupervision:request.isrcgprovidesupervision,
                   iscgcompletedannualreconsideration:request.iscgcompletedannualreconsideration,
                   isrcghavefinancialsupport:request.isrcghavefinancialsupport,
                   isrcgagreestoapplyssn:request.isrcgagreestoapplyssn,
                   isrcgnotifybehalfofchild:request.isrcgnotifybehalfofchild,
                   isrcgnotifylocaldeptforchanges:request.isrcgnotifylocaldeptforchanges,
                   isrcgguardianshipassistancepayment:request.isrcgguardianshipassistancepayment,
                   isrcgunderstandgacanbeterminated:request.isrcgunderstandgacanbeterminated,
                   isrcgandcwdiscussedrequirements:request.isrcgandcwdiscussedrequirements,
                   isapprovedresourceparent: request.isapprovedresourceparent,
                   isapprovedkinshipplacement: request.isapprovedkinshipplacement,
                   documentsigned: request.documentsigned,
                   iscgenteredagreement: request.iscgenteredagreement,
                   switchprovider: request.switchprovider,
                   switchproviderreason: request.switchproviderreason,
                   effectiveswitchdate: request.effectiveswitchdate
               }
           );
           await Gapapplication.updateAll(
                   {gapapplicationid: request.gapapplicationid},
                   {
                    planmeetingdate:request.planmeetingdate,
                    guardianonedate:request.guardianonedate,
                    guardiantwodate:request.guardiantwodate,
                    ldssdirectordate:request.ldssdirectordate,
                    guardian1signature: request.guardian1signature,
                    guardian2signature: request.guardian2signature,
                    ldssdirectorsignature: request.ldssdirectorsignature
               });
           if(request.switchprovider) {
            var switchsql = `INSERT INTO providerswitchinfo (objectid, objecttype, approvalstatus,requestedby, insertedby, updatedby,
                         decisiondate , activeflag, oldproviderid, newproviderid) values ($1,$2,$3,$4,$5,$6,now(),$7, $8, $9)`;
            await util.executeDBQuery(switchsql, [request.gapapplicationid, 'GAP','Review',securityuserid,securityuserid, securityuserid, 1, request.oldproviderid ,request.newproviderid]);
           }
           var status = 15;
           var nofitymsg = 'Guardianship Submitted for review';
           var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
           await util.executeDBQuery(sql, [request.gapapplicationid, securityuserid, 'GAAP', status, comments, '', false, false, false,
                                      nofitymsg,'',request.servicecaseid,'',1]);
           return "Guardianship Updated Successfully";
        } catch (err) {
           LOGGER.error('>>>>ERROR:', err);
           throw err;
        }
        }

    Gapapplication.remoteMethod('addAttachment', {
                http: {
                    path: '/addAttachment',
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
    

    Gapapplication.addAttachment = function(request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const securityuserid = (request.securityuserid ? request.securityuserid: _securityusersid);
        if (request.attachment != null && request.attachment !== undefined && request.attachment !== "") {
            if (Array.isArray(request.attachment)) {
                request.attachment.map(attach => {
                    attach.documentattachment = {};
                    attach.objectid = request.gapapplicationid;
                    attach.servicecaseid = request.servicecaseid;
                    attach.objecttypekey = 'gapapplication';
                    attach.insertedby = securityuserid;
                    attach.updatedby = securityuserid;
                    attach.servicerequestid = request.intakeserviceid;          //SonarQube fix - removed the self-assignments
                    attach.documentattachment.attachmentclassificationtypekey = attach.attachmentclassificationtypekey;
                    attach.documentattachment.attachmentclassificationsubtypekey = attach.attachmentclassificationsubtypekey;
                    attach.documentattachment.attachmentdate = attach.documentdate;
                    attach.documentattachment.attachmenttypekey = attach.attachmenttypekey;
                });
            }

            return app.models.Documentproperties.addcommonattachment(request.attachment, null, reqctx).then((res)=>{
                return { code: 200, message: 'success', data: res}
            }).catch(err=>{
                LOGGER.error(err);
            })
        }
        return Promise.resolve({ code: 400, message: 'Invalid request' });
    }

Gapapplication.remoteMethod('deleteAttachment', {
    http: {
        path: '/deleteAttachment',
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
        type: 'object',
        root: true
    }
});

Gapapplication.deleteAttachment = async (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }
    if (request.documentpropertiesid != null && request.documentpropertiesid !== undefined && request.documentpropertiesid !== "") {
        const documentpropertiesid = request.documentpropertiesid;
        const sql = ` update documentproperties
            set activeflag = 0, updatedon = now(), updatedby = $1 where documentpropertiesid = $2`
        try {
            await util.executeDBQuery(sql, [(request && request.securityuserid?request.securityuserid: _securityusersid), documentpropertiesid]);
            return { code: 200, message: 'Sucess!' };
        } catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }
    } else {
        return { code: 500, message: 'Error in deleting the document' }
    }

};
    // Gapapplication.addAttachment = function(request, cb) {
    //     let response = [];
    //     let result = [];
    //             if (request.attachment != null && request.attachment != undefined && request.attachment != "" && Array.isArray(request.attachment)) {
    //                 var nowDate = new Date();
    //                     request.attachment.forEach(attach => {
    //                         attach.objectid = request.gapapplicationid;
    //                         attach.servicecaseid = request.servicecaseid;
    //                         attach.objecttypekey = 'gapapplication';
    //                         attach.insertedby = (request && request.securityuserid?request.securityuserid: app.currentUser.securityusersid);
    //                         attach.updatedby = (request && request.securityuserid?request.securityuserid: app.currentUser.securityusersid);
        
    //                         response.push (app.models.Documentproperties.create({
    //                             objecttypekey: attach.objecttypekey,
    //                             servicerequestid: attach.servicerequestid, 
    //                             servicecaseid: attach.servicecaseid,
    //                             objectid: attach.objectid ? attach.objectid : '00000000-0000-0000-0000-000000000000',
    //                             documenttypekey: 'Attachment',
    //                             intakenumber: attach.intakenumber,
    //                             documentdate: attach.documentdate,
    //                             thirdpartysourceid: attach.thirdpartysourceid,
    //                             filename: attach.filename,
    //                             originalfilename: attach.originalfilename,
    //                             title: attach.title,
    //                             description: attach.description,
    //                             mime: attach.mime,
    //                             meta: attach.meta,
    //                             encoding: attach.encoding,
    //                             numberofbytes: attach.numberofbytes,
    //                             insertedby: attach.insertedby,
    //                             updatedby: attach.updatedby,
    //                             expirationdate: nowDate.toJSON(),
    //                             rootobjectid: attach.objectid ? attach.objectid : '00000000-0000-0000-0000-000000000000',
    //                             rootobjecttypekey: attach.objecttypekey,
    //                             s3bucketpathname: attach.s3bucketpathname,
    //                             ecmsdocumentid:attach.ecmsdocumentid
    //                             })
    //                             );
    //                     });
    //             }
    //             // return Promise.all(response)
    //             // .then(data => 
    //             //     { 
    //             //         cb(null,data);
    //             //     }
    //             //     ).catch(err => 
    //             //         {
    //             //             LOGGER.error(err);
    //             //             cb(err);
    //             //         });
    //             return Promise.all(response).then(function(err, values) { 
    //                 var res = values.map(x=>{                         
    //                     result.push(x);                           
    //                 }); 
    //                 if(err) {
    //                     LOGGER.error(err);
    //                     cb(err,null);
    //                 }
    //                 cb(null,result);
    //               });
    // }
   Gapapplication.addguardianship = async function(request, _securityusersid)
   {
       var comments = '';
       if(request.comments !== undefined && request.comments !== null)
           {comments = request.comments;}
       /* else
           {comments = '';}	   */
        const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);
        try {
           const data = await app.models.Guardianship.create({
               intakeserviceid:request.intakeserviceid,
               servicecaseid:request.servicecaseid,
               permanencyplanid:request.permanencyplanid, 
               guardianoneid:request.guardianoneid,
               guardiantwoid:request.guardiantwoid,
               guardianonename:request.guardianonename,
               guardiantwoname:request.guardiantwoname,
               isrcgunderstandpurpose:request.isrcgunderstandpurpose,
               isrcgacknowledgedruledoutplans:request.isrcgacknowledgedruledoutplans,
               isrcgapprovedhomeforsixmonths:request.isrcgapprovedhomeforsixmonths,
               isrcgcomprehensivestudycompleted:request.isrcgcomprehensivestudycompleted,
               isrcgcompletedprotectiveclearance:request.isrcgcompletedprotectiveclearance,
               isrcgauthorizedmentalinfo:request.isrcgauthorizedmentalinfo,
               isrcgshowpermanentcommitment:request.isrcgshowpermanentcommitment,
               isrcgwillstablehome:request.isrcgwillstablehome,
               isrcgprovidesupervision:request.isrcgprovidesupervision,
               iscgcompletedannualreconsideration:request.iscgcompletedannualreconsideration,
               isrcghavefinancialsupport:request.isrcghavefinancialsupport,
               isrcgagreestoapplyssn:request.isrcgagreestoapplyssn,
               isrcgnotifybehalfofchild:request.isrcgnotifybehalfofchild,
               isrcgnotifylocaldeptforchanges:request.isrcgnotifylocaldeptforchanges,
               isrcgguardianshipassistancepayment:request.isrcgguardianshipassistancepayment,
               isrcgunderstandgacanbeterminated:request.isrcgunderstandgacanbeterminated,
               isrcgandcwdiscussedrequirements:request.isrcgandcwdiscussedrequirements,
               isapprovedresourceparent: request.isapprovedresourceparent,
               isapprovedkinshipplacement: request.isapprovedkinshipplacement,
               documentsigned: request.documentsigned,
               iscgenteredagreement: request.iscgenteredagreement,
               //guardiantwoid:request.guardiantwoid,
               guardianoneproviderid:request.guardianoneproviderid,
               guardiantwoproviderid:request.guardiantwoproviderid,
               insertedby: securityuserid,
               updatedby: securityuserid,
               successionaddendumdate:request.successionaddendumdate,
               successorguardianname:request.successorguardianname,
               cofinaldate:request.cofinaldate,
               empprogramstartdate:request.empprogramstartdate,
               empprogramname:request.empprogramname,
               primaryrelationshipkey:request.primaryrelationshipkey,
               secondaryrelationshipkey:request.secondaryrelationshipkey,
               fosterhomeapprover:request.fosterhomeapprover

           });
           const resp = await Gapapplication.create({
                   gapid: data.gapid,
                   planmeetingdate:request.planmeetingdate,
                    guardianonedate:request.guardianonedate,
                    guardiantwodate:request.guardiantwodate,
                    ldssdirectordate:request.ldssdirectordate,
                    guardian1signature: request.guardian1signature,
                    guardian2signature: request.guardian2signature,
                    ldssdirectorsignature: request.ldssdirectorsignature,
                    insertedby: securityuserid,
                    updatedby: securityuserid
               });
           var status = 15;
           var nofitymsg = 'Guardianship Submitted for review';
           var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
           await util.executeDBQuery(sql, [resp.gapapplicationid, securityuserid, 'GAAP', status, comments, '', false, false, false, nofitymsg,'',request.servicecaseid,'',1]);
           return resp;
        } catch (err) {
           LOGGER.error('>>>>ERROR:', err);
           throw err;
        }
           }
    /**Gapapplication getguardianship */
    Gapapplication.remoteMethod('getguardianship', {
        http: {
            path: '/getguardianship',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Gapapplication.getguardianship =(request)=> {
        // The filter arg is optional, and util.beforeremote only defaults
        // filter.where when the arg is already present -- it builds its own
        // local object otherwise and never writes it back to ctx.args. So a
        // call with no filter query param arrives here as undefined; read the
        // criteria defensively instead of throwing before the query runs.
        var where = request?.where || {};
        var permanencyplanid = where.permanencyplanid?where.permanencyplanid:null;
        var objectid = where.objectid?where.objectid:null;
        var objecttype = where.objecttype?where.objecttype:'';
        var totalcount = 0;
        var sql = 'select * from getguardianship($1,$2,$3)';

		return util.executeSecondaryNodeDBQuery(sql, [permanencyplanid,objectid,objecttype])
		.then(data => {
                if (data!==null && data.length>0) {
                    totalcount= data[0].totalcount;}
                var result;
                result = {
                    'data' : data,
                    'count' : totalcount
                };
                return result;
		})
		.catch(err => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
    };



    Gapapplication.remoteMethod('getgappdftoprint', {

        http: {
            path: '/getgappdftoprint',
            verb: 'post'
        },
        accepts: [{
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body'
                }
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res'
                }
            }
    
        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    });

    Gapapplication.getgappdftoprint = (request, res) => {
        return Promise.resolve(pdf.gapAgreementPDF(request));
    }
 

    Gapapplication.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapapplication.observe('access', (ctx, next) => util.access(ctx, next));
    Gapapplication.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    