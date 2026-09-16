'use strict';
const LOGGER = require("log4js").getLogger("provider_uir");
const util = require('../utils/utils');
var app = require('../../server/server');

const uirsubmittedmsg ='UIR  Submitted for Review';
const uirsubmittedforapproval ='UIR  Submitted for Approved';
const uirsubmittedforclosuremsg ='UIR  Submitted for Closed'; 

module.exports = function(Provider_uir) {

    Provider_uir.remoteMethod('addupdate', {
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


   
    Provider_uir.addupdate = (request,reqctx)=>{
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        if(request.provider_uir_id== null || request.provider_uir_id == undefined)
        {
           
            return Provider_uir.create({

                provider_id:request.provider_id,
                uir_no:request.uir_no,
                licence_type:request.licence_type,
                level_supervision:request.level_supervision,
                location_incident:request.location_incident,
                location_area:request.location_area,
                location_area_other:request.location_area_other,
                incident_datetime:request.incident_datetime,
                incident_date:request.incident_date,
                incident_time:request.incident_time,
                is_classthreeincident: request.is_classthreeincident,
                additional_youth_info: request.additional_youth_info,
                class3_brief_desc:request.class3_brief_desc,
                program_nm:request.program_nm,
                discovered_datetime:request.discovered_datetime, 
                narrative_before_incident:request.narrative_before_incident,
                narrative_incident_occur:request.narrative_incident_occur,
                narrative_during_incident:request.narrative_during_incident,
                narrative_after_incident:request.narrative_after_incident,
                role_incident:request.role_incident,
                restraint_typekey:request.restraint_typekey,
                duration_restraint:request.duration_restraint,
                duration_restraint_other:request.duration_restraint_other,
                is_de_escalation:request.is_de_escalation,
                is_seen_medical:request.is_seen_medical,                 
                is_injury_sustained:request.is_injury_sustained,  
                injury_severity_rating:request.injury_severity_rating,  
                is_injury_result:request.is_injury_result,  
                is_seclusion:request.is_seclusion,  
                duration_seclusion:request.duration_seclusion,  
                is_staff_assaulted:request.is_staff_assaulted,
                uir_status:request.uir_status, 
                notifiy_is_attach:request.notifiy_is_attach, 
                notifiy_attach_other:request.notifiy_attach_other, 
                notification_comments:request.notification_comments, 
                notifiy_staff_member:request.notifiy_staff_member, 
                notifiy_signdatetime:request.notifiy_signdatetime,  
                precipitate_event:request.precipitate_event,
                gang_related_explain:request.gang_related_explain,
                gang_incident_videotapped:request.gang_incident_videotapped,
                gang_support_evidence:request.gang_support_evidence,
                inserted_by: suserid,
                updated_by: suserid
               
    
            }).then(data => {
              LOGGER.debug("datataaaaa",data)
               return data;
        })
    }
        else
        {
            LOGGER.debug("yesssss itz in");
             return Provider_uir.updateAll(
            {provider_uir_id:request.provider_uir_id},
            {
                provider_id:request.provider_id,
                uir_no:request.uir_no,
                licence_type:request.licence_type,
                level_supervision:request.level_supervision,
                location_incident:request.location_incident,
                location_area:request.location_area,
                location_area_other:request.location_area_other,
                incident_datetime:request.incident_datetime,
                incident_date:request.incident_date,
                incident_time:request.incident_time,
                is_classthreeincident: request.is_classthreeincident,
                additional_youth_info: request.additional_youth_info,
                class3_brief_desc:request.class3_brief_desc,
                program_nm:request.program_nm,
                discovered_datetime:request.discovered_datetime,  
                narrative_before_incident:request.narrative_before_incident,
                narrative_incident_occur:request.narrative_incident_occur,
                narrative_during_incident:request.narrative_during_incident,
                narrative_after_incident:request.narrative_after_incident,
                role_incident:request.role_incident,
                restraint_typekey:request.restraint_typekey,
                duration_restraint:request.duration_restraint,
                duration_restraint_other:request.duration_restraint_other,
                is_de_escalation:request.is_de_escalation,
                is_seen_medical:request.is_seen_medical,                 
                is_injury_sustained:request.is_injury_sustained,  
                injury_severity_rating:request.injury_severity_rating,  
                is_injury_result:request.is_injury_result,  
                is_seclusion:request.is_seclusion,  
                duration_seclusion:request.duration_seclusion,  
                is_staff_assaulted:request.is_staff_assaulted, 
                uir_status:request.uir_status, 
                notifiy_is_attach:request.notifiy_is_attach, 
                notifiy_attach_other:request.notifiy_attach_other, 
                notification_comments:request.notification_comments, 
                notifiy_staff_member:request.notifiy_staff_member, 
                notifiy_signdatetime:request.notifiy_signdatetime,  
                precipitate_event:request.precipitate_event,
                gang_related_explain:request.gang_related_explain,
                gang_incident_videotapped:request.gang_incident_videotapped,
                gang_support_evidence:request.gang_support_evidence,               
                inserted_by: suserid,
                updated_by: suserid
        }).then(res=>{
            LOGGER.debug("request>>>>>>>>>>.", res);
            return  request;
        }).catch(err => util.logError(err));
        }        
}


Provider_uir.remoteMethod(
    'listdashboard',
    {
      http: {
        path: '/listdashboard',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
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
        type: 'object',
        root: true
      }
    }
  );
 

  Provider_uir.listdashboard = (data,reqctx) => {
    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
    const userid = data && data.securityuserid?data.securityuserid: suserid;
    var Totalcount = 0;
    var pageNumber = data.page;
    var pageLimit = data.limit;
    var sortcolumn = data.where.sortcolumn;
    var sortorder = data.where.sortorder;
    var status = data.where.status;
    var uir_no = data.where.uir_no;
    var provider_id = data.where.provider_id;
    var provider_name = data.where.provider_name;
    var program_name = data.where.program_name;
    var youth_identification_number = data.where.youth_identification_number;
    var child_name = data.where.child_name;

   
    if (sortcolumn == null || sortcolumn == undefined) {sortcolumn = "receiveddate";}
    if (sortorder == null || sortorder == undefined) {sortorder = "desc";}
    var sql = '';
  
    sql = 'select * from listprovideruir($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';  
    LOGGER.debug("userid",userid)
    const params = [userid,status, pageNumber, pageLimit,uir_no,provider_id,provider_name,program_name,youth_identification_number,child_name,sortcolumn,sortorder];
  
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


Provider_uir.remoteMethod('list', {
    accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
        source : 'query'
      },
      required : true
    },
    http : {
      path: '/list',
      verb : 'get'
    },
    returns : {
      type : 'string',
      root : true
    }
  });


  
  Provider_uir.list = function (request) {

    var sql = 'select * from getprovideruirdetails($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getprovideruirdetails;
        }else {
          return data;
        }
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

  };
  Provider_uir.remoteMethod('site_list', {
    accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
        source : 'body'
      },
      required : true
    },
    http : {
      path: '/site_list',
      verb : 'post'
    },
    returns : {
      type : 'object',
      root : true
    }
  });


  
  Provider_uir.site_list = function (request) {

    var sql = 'select * from listsiteinformation($1,$2)';
    var params = [request.where.provider_id,request.where.site_id];
    LOGGER.debug('iddddddddddddddd',request.where.provider_id);
    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };
  Provider_uir.remoteMethod('uir_update_list', {
    accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
        source : 'body'
      },
      required : true
    },
    http : {
      path: '/uir_update_list',
      verb : 'post'
    },
    returns : {
      type : 'object',
      root : true
    }
  });
  Provider_uir.uir_update_list = function (request) {

    var sql = 'select * from incidentreportupdate($1,$2)';
    var params = [request.filter.where.provider_id,request.filter.where.uir_no];
    LOGGER.debug('iddddddddddddddd',request.filter.where.provider_id);
    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };
  
  Provider_uir.getproviderprogramsinformation =function(request){
    var providerid = request.where.provider_id;
   var sql = 'select tpl.license_no, tpl.license_level, tpl.license_type, (select value_tx from tb_picklist_values where picklist_type_id=286 and trim(picklist_value_cd)=trim(tpl.license_status_cd)) as license_status_cd, tpl.site_id, tp.provider_nm, tp.provider_category_cd, tp.adr_work_phone_tx, tcp.contract_id, tcp.program_status_cd, tpp.provider_nm as parent_provider_nm from tb_provider_licensing tpl join tb_provider tp on tpl.site_id = tp.provider_id 	inner join tb_provider tpp on tpp.provider_id = tpl.provider_id left join tb_contract_program tcp on tpl.license_no = tcp.license_no where tpl.provider_id=$1'

    return util.executeDBQuery(sql,[providerid])
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };
    
  Provider_uir.remoteMethod(
    'getproviderprogramsinformation', 
    {
      accepts : {
        arg : 'data',
        type : 'object',
        http : {
          source : 'body'
        },
      },
      http: {
        path: '/getproviderprogramsinformation',
        verb: 'POST'
      },
      returns : {
        type : 'object',
        root : true
      }
    }
  );

  Provider_uir.getproviderprogramsinformationlist =function(req){
    var providerid = req.where.provider_id;
   var sql = 'select tpl.license_no, tpl.license_level, tpl.license_type, (select value_tx from tb_picklist_values where picklist_type_id=286 and trim(picklist_value_cd)=trim(tpl.license_status_cd)) as license_status_cd, tpl.site_id, tp.provider_nm, tp.provider_category_cd, tp.adr_work_phone_tx, tcp.contract_id, tcp.program_status_cd, tpp.provider_nm as parent_provider_nm from tb_provider_licensing tpl join tb_provider tp on tpl.site_id = tp.provider_id 	inner join tb_provider tpp on tpp.provider_id = tpl.provider_id left join tb_contract_program tcp on tpl.license_no = tcp.license_no where tpl.provider_id=$1'

    return util.executeDBQuery(sql,[providerid])
      .then(data1 => data1)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

  Provider_uir.remoteMethod('getproviderprogramsinformationlist', {
    accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
        source : 'query'
      },
      required : true
    },
    http : {
      path: '/getproviderprogramsinformationlist',
      verb : 'get'
    },
    returns : {
      type : 'object',
      root : true
    }
  });


  Provider_uir.remoteMethod(
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
      }
      ,{
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

    Provider_uir.routingupdate = function (request,reqctx) {
      let suserid = undefined;
      let status = 0;
      let notifymsg = '';
      let comments = '';
      let asignsecurityusersid = '';
      let routeddescription = '';
      let eventcode = '';

      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      } 
        
        if(request.status == "Review") {
            status = 49;
            notifymsg =uirsubmittedmsg;            
            comments = uirsubmittedmsg;
            asignsecurityusersid = request.assingsecurityuserid;
            routeddescription = uirsubmittedmsg;  
            eventcode='PRUIR';
            
          } 

          if(request.status == "Approved") {
            status = 50;
            notifymsg =uirsubmittedforapproval;            
            comments = uirsubmittedforapproval; 
            asignsecurityusersid = request.assingsecurityuserid;
            routeddescription = uirsubmittedforapproval;  
            eventcode='PRUIR';
            
          } 

          if(request.status == "Closed") {
            status = 51;
            notifymsg =uirsubmittedforclosuremsg;           
            comments = uirsubmittedforclosuremsg; 
            asignsecurityusersid = request.assingsecurityuserid;
            routeddescription = uirsubmittedforclosuremsg; 
            eventcode='PRUIR';
            
          } 
        
        
        
        if(request.provider_uir_id !=null) {

          var qry = 'SELECT * FROM routingprovideruir($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13)';
          return util.executeDBQuery(qry, [request.provider_uir_id, request && request.securityuserid?request.securityuserid: suserid, eventcode, status, comments, asignsecurityusersid, false, false, false, notifymsg, routeddescription,request.intakeserviceid, request.notification])
            .then(result => result)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        } else {return Promise.resolve(null);}

      }



Provider_uir.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Provider_uir.observe('access', (ctx, next) => util.access(ctx, next));
Provider_uir.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
