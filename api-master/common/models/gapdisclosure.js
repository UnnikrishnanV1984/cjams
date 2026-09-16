'use strict';
const LOGGER = require("log4js").getLogger("gapdisclosure");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Gapdisclosure) {   

    /**Gapdisclosure add */
    Gapdisclosure.remoteMethod('add', {
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
    Gapdisclosure.add = (request, reqctx) => {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if (request.gapid!=null && request.gapid!==undefined && request.gapdisclosureid!=null && request.gapdisclosureid!==undefined) {
           return Gapdisclosure.updateguardianship(request, _securityusersid);
       } else {
           return Gapdisclosure.addguardianship(request, _securityusersid);
       }
   }

   Gapdisclosure.updateguardianship = function(request, _securityusersid)
   {
       var comments = '';
       if(request.comments !== undefined && request.comments !== null)
           {comments = request.comments;}
       /* else 
           {comments = '';} */
           const securityuserid = (request.securityuserid ? request.securityuserid: _securityusersid);

           return app.models.Guardianship.updateAll(
               {gapid:request.gapid},
               {
                   updatedby:securityuserid,
                   successionaddendumdate:request.successionaddendumdate,
                   successorguardianname:request.successorguardianname,
                   cofinaldate:request.cofinaldate,
                   empprogramstartdate:request.empprogramstartdate,
                   empprogramname:request.empprogramname,
                   primaryrelationshipkey:request.primaryrelationshipkey,
                   secondaryrelationshipkey:request.secondaryrelationshipkey,
                   fosterhomeapprover:request.fosterhomeapprover
               }
           ).then(respo=>{
               return Gapdisclosure.updateAll(
                   {gapdisclosureid: request.gapdisclosureid},
                   {
                   disclosuredate:request.disclosuredate,
                   ischildplacedsixmonths:request.ischildplacedsixmonths,
                   isproviderapprovedgap:request.isproviderapprovedgap,
                   iscourthearingcustody:request.iscourthearingcustody,
                   isreunificationremoved:request.isreunificationremoved,
                   isadoptionremoved:request.isadoptionremoved,
                   iscgprovidesafe:request.iscgprovidesafe,
                   isothergapfinsupport:request.isothergapfinsupport,
                   dateofplanning: request.dateofplanning,
                   iscgattendedorientation:request.iscgattendedorientation,
                   orientationmeetingdate:request.orientationmeetingdate,
                   isrequirementdiscussed:request.isrequirementdiscussed,
                   iscgparticipategap:request.iscgparticipategap,
                   iscgenteredagreement:request.iscgenteredagreement,
                   iscgcompleteauthorization:request.iscgcompleteauthorization,
                   iscgaftercareservice:request.iscgaftercareservice,
                   isneedadditionalservices:request.isneedadditionalservices,
                   iscgcompleteannualreview:request.iscgcompleteannualreview,
                   issuspendedfromguardian:request.issuspendedfromguardian,
                   insertedby:securityuserid,
                   issuccessorguardianexists:request.issuccessorguardianexists,
                   isconsultationchildage:request.consultationguardianshiparrangement,
                   isguardianattach:request.strongattachmentprimaryguardian,
                   isguardiantwoattach:request.strongattachmentsecondaryguardian
               })
           }).then(resp => {
               var status = 15;
               var nofitymsg = 'Guardianship Submitted for review';

               if(request.intakeserviceid == null && request.intakeserviceid == undefined){
                   request.intakeserviceid = '';
               }
               var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
               util.executeDBQuery(sql, [request.gapdisclosureid, securityuserid, 'GADR', status, comments, '', false, false, false, nofitymsg,'',request.servicecaseid,'',1]);
               return "Guardianship Updated Successfully"
           })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
              } 

   Gapdisclosure.addguardianship = function(request, _securityusersid)
   {
       var comments = '';
       if(request.comments !== undefined && request.comments !== null) 
           {comments = request.comments;}
       /* else 
           {comments = '';}	   */
        const securityuserid = (request && request.securityuserid ? request.securityuserid : _securityusersid);
           return app.models.Guardianship.updateAll(
            {gapid:request.gapid},
            {
                guardianoneid:request.guardianoneid,
                guardiantwoid:request.guardiantwoid,
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
                fosterhomeapprover:request.fosterhomeapprover
            }
        ).then(respo=>{
               return Gapdisclosure.create({
                   gapid: request.gapid,
                   disclosuredate:request.disclosuredate,
                   ischildplacedsixmonths:request.ischildplacedsixmonths,
                   isproviderapprovedgap:request.isproviderapprovedgap,
                   iscourthearingcustody:request.iscourthearingcustody,
                   isreunificationremoved:request.isreunificationremoved,
                   isadoptionremoved:request.isadoptionremoved,
                   iscgprovidesafe:request.iscgprovidesafe,
                   isothergapfinsupport:request.isothergapfinsupport,
                   dateofplanning: request.dateofplanning,
                   iscgattendedorientation:request.iscgattendedorientation,
                   orientationmeetingdate:request.orientationmeetingdate,
                   isrequirementdiscussed:request.isrequirementdiscussed,
                   iscgparticipategap:request.iscgparticipategap,
                   iscgenteredagreement:request.iscgenteredagreement,
                   iscgcompleteauthorization:request.iscgcompleteauthorization,
                   iscgaftercareservice:request.iscgaftercareservice,
                   isneedadditionalservices:request.isneedadditionalservices,
                   iscgcompleteannualreview:request.iscgcompleteannualreview,
                   issuspendedfromguardian:request.issuspendedfromguardian,
                   insertedby: securityuserid,
                   updatedby: securityuserid,
                   issuccessorguardianexists:request.issuccessorguardianexists,
                   isconsultationchildage:request.consultationguardianshiparrangement,
                   isguardianattach:request.strongattachmentprimaryguardian,
                   isguardiantwoattach:request.strongattachmentsecondaryguardian
               })
           }).then(resp => {
               var status = 15;
               var nofitymsg = 'Guardianship Submitted for review';
               var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
                   util.executeDBQuery(sql, [resp.gapdisclosureid, securityuserid, 'GADR', status, comments, '', false, false, false, nofitymsg,'',request.servicecaseid,'',1]);
               return resp
           }) .catch(err =>util.logError(err));
           }
    /**Gapdisclosure getguardianship */
    Gapdisclosure.remoteMethod('getguardianship', {
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

    Gapdisclosure.getguardianship =(request)=> {
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
                    totalcount= data[0].totalcount;
                }
                        var result;
                        result = {
                            'data' : data,
                            'count' : totalcount
                        };
                        return result;
		})
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }; 

    Gapdisclosure.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Gapdisclosure.observe('access', (ctx, next) => util.access(ctx, next));
    Gapdisclosure.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}