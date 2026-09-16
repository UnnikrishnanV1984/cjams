'use strict';
const LOGGER = require("log4js").getLogger("tb_provider_complaint");
const util = require('../utils/utils');
var app = require('../../server/server');
var email = require('../models/email');
const complaintreferralnotification = 'Provider Complaint Refferal  Submitted for review';
module.exports = function(Tb_provider_complaint) {

    


    Tb_provider_complaint.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
            } ],
        returns: {
            type : 'string',
            root : true
        }
    });


   
    Tb_provider_complaint.addupdate = async function(request,reqctx) { 
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
      var _email = util.getSecurityDetails(request, reqctx).email;  
      var requestuserinfo = {'token': '', 'email': _email};
      var teamtypekey ;
    	await util.getuserinfo(requestuserinfo).then (data => {
        teamtypekey = data.teamtypekey;
      });
      let respprovidercomplaint='';
      if(request.intakeserviceid == null && request.intakeserviceid == undefined){
        request.intakeserviceid = '';
      }

        if(request.provider_complaintid== null || request.provider_complaintid == undefined)
        {
           
            return Tb_provider_complaint.create({
                provider_complaintid:request.provider_complaintid,
                intakeservreqinputtypeid:request.intakeservreqinputtypeid,
                complaint_source:request.complaint_source,
                source_information_type:request.source_information_type,
                complaint_date:request.complaint_date,
                narrative:request.narrative,
                complainant_firstname:request.complainant_firstname,
                complainant_lastname:request.complainant_lastname,
                complainant_phone:request.complainant_phone,
                complainant_email:request.complainant_email,
                complainant_address1:request.complainant_address1,
                complainant_address2:request.complainant_address2,
                complainant_city:request.complainant_city,
                complainant_state:request.complainant_state,
                complainant_county:request.complainant_county,
                isrouted:request.isrouted,
                routedusersid:request.routedusersid,
                complaint_number:request.complaint_number,
                routedon:request.routedon,
                teamtype_key:teamtypekey,
                provider_id:request.provider_id,
                site_id:request.site_id,
                is_draft:request.is_draft,
                activeflag:request.activeflag,
                inserted_by: suserid,
                updated_by: suserid,
                old_id:request.old_id ,
                complainant_zipcode:request.complainant_zipcode,  
                source_specification:request.source_specification  
    
            }).then(data => {
                respprovidercomplaint=data;
                routingprovider(data, request, data.complaint_number, data.is_draft, suserid);
                return respprovidercomplaint;

            }).then(data => {

                return data;
              })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

        }
        else
        {
             return Tb_provider_complaint.updateAll(
            {provider_complaintid:request.provider_complaintid},
            {
                intakeservreqinputtypeid:request.intakeservreqinputtypeid,
                complaint_source:request.complaint_source,
                source_information_type:request.source_information_type,
                complaint_date:request.complaint_date,
                narrative:request.narrative,
                complainant_firstname:request.complainant_firstname,
                complainant_lastname:request.complainant_lastname,
                complainant_phone:request.complainant_phone,
                complainant_email:request.complainant_email,
                complainant_address1:request.complainant_address1,
                complainant_address2:request.complainant_address2,
                complainant_city:request.complainant_city,
                complainant_state:request.complainant_state,
                complainant_county:request.complainant_county,
                isrouted:request.isrouted,
                routedusersid:request.routedusersid,
                complaint_number:request.complaint_number,
                routedon:request.routedon,
                teamtype_key:teamtypekey,
                provider_id:request.provider_id,
                site_id:request.site_id,
                is_draft:request.is_draft,
                activeflag:request.activeflag,
                inserted_by: suserid,
                updated_by:suserid,
                old_id:request.old_id,
                complainant_zipcode:request.complainant_zipcode,  
                source_specification:request.source_specification,
                summary:request.summary,
                outcomes:request.outcomes    
                
        }).then(data => {
            routingprovider(data, request, request.complaint_number, request.is_draft, suserid);        
            return data;
           
        }).then(data => {
                    return  request;
                }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
        
        
}

  function routingprovider(data, request, respcomplaintno, is_draft, suserid) {
    if (is_draft === 1 && request.eventcode != null && request.asignsecurityusersid != null) {
      if (request.eventcode == "PRCM") {
        var status = 27;
        var notifymsg = complaintreferralnotification;
        var comments = complaintreferralnotification;
        var routeddescription = complaintreferralnotification;
        var eventcode = 'PRCM';
        var asignsecurityusersid = request.asignsecurityusersid;


        if (respcomplaintno != null) {
          var sql = 'select * from routingprovider($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';

          return util.executeDBQuery(sql,[respcomplaintno,suserid,eventcode,status,comments,asignsecurityusersid,false,false,false,notifymsg,routeddescription,request.intakeserviceid])
            .then(_data => {
              return _data;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
      }
    }
  }

Tb_provider_complaint.remoteMethod(
    'list',
    {
      http: {
        path: '/list',
        verb: 'post'
      },
      accepts:[ {
        arg: 'data',
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
        type: 'object',
        root: true
      }
    }
  );
 

  Tb_provider_complaint.list = (data,reqctx)=> {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    const userid = (data && data.securityuserid?data.securityuserid: suserid);
    var Totalcount = 0;
    var pageNumber = data.page;
    var pageLimit = data.limit;
    var sortcolumn = data.where.sortcolumn;
    var sortorder = data.where.sortorder;
    var status = data.where.status;
    var complaint_number = data.where.complaint_number;
  
   
    if (sortcolumn == null || sortcolumn == undefined) {sortcolumn = "receiveddate";}
    if (sortorder == null || sortorder == undefined) {sortorder = "desc";}
    var sql = '';
  
    sql = 'select * from listprovidercomplaint($1,$2,$3,$4,$5,$6,$7)';  
  
    const params = [userid,status, pageNumber, pageLimit,complaint_number, sortcolumn, sortorder];

    return util.executeDBQuery(sql, params)
      .then(_data => {
        if (_data!=null && _data.length > 0) {Totalcount = _data[0].totalcount;}
        var result;
        result = {
          'data': _data,
          'count': Totalcount
        };
        return result;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

  };
  
  
  Tb_provider_complaint.remoteMethod('providercomplaintdetail', {
    accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
        source : 'query'
      },
      required : true
    },
    http : {
      path: '/providercomplaintdetail',
      verb : 'get'
    },
    returns : {
      type : 'string',
      root : true
    }
  });


  
  Tb_provider_complaint.providercomplaintdetail = function (request) {

    var sql = 'select * from getprovidercomplaintdetails($1)';

    return util.executeDBQuery(sql, [request.where.complaint_number])
      .then(data => {
        if (data) {
          return data[0].getprovidercomplaintdetails;
        } else {
          return data;
        }
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

  };

  Tb_provider_complaint.remoteMethod(
    'routingupdate',
    {
      http: {
        path: '/routingupdate',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      } 

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

    Tb_provider_complaint.routingupdate = function (request,reqctx) {
      let status = '';
      let notifymsg = '';
      let comments = '';
      let asignsecurityusersid = '';
      let routeddescription = '';
      let eventcode = '';
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        if(request.status == "refferal_approved") {
            status = 28;
            notifymsg =request.notification;            
            comments = request.comments;
            asignsecurityusersid = request.assingsecurityuserid;
            routeddescription = request.notification;  
            eventcode='PRCM';
          } 
          else if(request.status == "refferel_rejected") {
            status = 29;
            notifymsg =request.notification;            
            comments = request.comments;
            asignsecurityusersid = request.assingsecurityuserid;
            routeddescription = request.notification;  
            eventcode='PRCM';
          } 
          else if(request.status == "complaint_submited") {
            status = 31;
            notifymsg =request.notification;            
            comments = request.comments;
            asignsecurityusersid = request.assingsecurityuserid;
            routeddescription = request.notification;  
            eventcode='PRCM';
  
          } 
          else if(request.status == "closed") {
            status = 32;
            notifymsg =request.notification;            
            comments = request.comments;
            asignsecurityusersid = request.assingsecurityuserid;
            routeddescription = request.notification;  
            eventcode='PRCM';

            if(request.agency_email !=null)
            {
              email.SendProvrefEmail(request.agency_email, 'Refers To Another licensing Agency', request.comments);
            }
  
          } 
        
        if(request.complaint_number !=null) {
          var qry = 'SELECT * FROM routingprovider($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
          return util.executeDBQuery(qry, [request.complaint_number, suserid, eventcode, status, comments, asignsecurityusersid, false, false, false, notifymsg, routeddescription,request.intakeserviceid])
            .then(result => {
                return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        } else {return Promise.resolve(null);}

      }


      Tb_provider_complaint.remoteMethod('routinglist', {
        accepts : {
          arg : 'filter',
          type : 'Object',
          http : {
            source : 'query'
          },
          required : true
        },
        http : {
          path: '/routinglist',
          verb : 'get'
        },
        returns : {
          type : 'string',
          root : true
        }
      });

      Tb_provider_complaint.routinglist = function (request) {

        var sql = 'select * from getprovidercompliantsrouting($1)';
        var params = [request.where.complaint_number];

        return util.executeDBQuery(sql, params)
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });

      };

    Tb_provider_complaint.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_provider_complaint.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_provider_complaint.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
