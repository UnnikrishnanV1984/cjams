'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_actor_involved");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_actor_involved) {

    Provider_uir_actor_involved.remoteMethod('addupdate', {
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


   
    Provider_uir_actor_involved.addupdate = (request,reqctx)=>{
      let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }     

        if(request.provider_uir_actor_involved_id== null || request.provider_uir_actor_involved_id == undefined)
        {
           
            return Provider_uir_actor_involved.create({

                provider_uir_id:request.provider_uir_id, 
                provider_staff_id:request.provider_staff_id,  
                provider_uir_actor_detail_id:request.provider_uir_actor_detail_id,  
                role_incident:request.role_incident,
                restraint_typekey:request.restraint_typekey,
                duration_phiscial_restraint:request.duration_phiscial_restraint,
                duration_phiscial_restraint_other:request.duration_phiscial_restraint_other,
                is_intervention:request.is_intervention,  
                is_leaving_supervision:request.is_leaving_supervision,  
                is_prevention:request.is_prevention,  
                is_flexcuff:request.is_flexcuff,  
                is_handcuff:request.is_handcuff,  
                is_legiron:request.is_legiron,   
                is_helmets:request.is_helmets,
                is_handcuff_legiron:request.is_handcuff_legiron,
                is_protective_device:request.is_protective_device,
                duration_mechanical_restraint:request.duration_mechanical_restraint,
                duration_mechanical_restraint_other:request.duration_mechanical_restraint_other,               
                is_de_escalation:request.is_de_escalation,
                is_seen_medical:request.is_seen_medical,                 
                is_injury_sustained:request.is_injury_sustained,  
                injury_severity_rating:request.injury_severity_rating,  
                is_injury_result:request.is_injury_result,  
                is_seclusion:request.is_seclusion,  
                duration_seclusion:request.duration_seclusion,  
                is_staff_assaulted:request.is_staff_assaulted,
                inserted_by: (request && request.securityuserid ? request.securityuserid : suserid),
                updated_by: (request && request.securityuserid ? request.securityuserid : suserid), 
                is_primary_staff_involved:request.is_primary_staff_involved
               
    
            }).then(data => {
               return data;
        })
    }
        else
        {
             return Provider_uir_actor_involved.updateAll(
            {provider_uir_actor_involved_id:request.provider_uir_actor_involved_id},
            {
                provider_uir_id:request.provider_uir_id, 
                provider_staff_id:request.provider_staff_id,  
                provider_uir_actor_detail_id:request.provider_uir_actor_detail_id,  
                role_incident:request.role_incident,
                restraint_typekey:request.restraint_typekey,
                duration_phiscial_restraint:request.duration_phiscial_restraint,
                duration_phiscial_restraint_other:request.duration_phiscial_restraint_other,
                is_intervention:request.is_intervention,  
                is_leaving_supervision:request.is_leaving_supervision,  
                is_prevention:request.is_prevention,  
                is_flexcuff:request.is_flexcuff,  
                is_handcuff:request.is_handcuff,  
                is_legiron:request.is_legiron,   
                is_helmets:request.is_helmets,
                is_handcuff_legiron:request.is_handcuff_legiron,
                is_protective_device:request.is_protective_device,
                duration_mechanical_restraint:request.duration_mechanical_restraint,
                duration_mechanical_restraint_other:request.duration_mechanical_restraint_other,               
                is_de_escalation:request.is_de_escalation,
                is_seen_medical:request.is_seen_medical,                 
                is_injury_sustained:request.is_injury_sustained,  
                injury_severity_rating:request.injury_severity_rating,  
                is_injury_result:request.is_injury_result,  
                is_seclusion:request.is_seclusion,  
                duration_seclusion:request.duration_seclusion,  
                is_staff_assaulted:request.is_staff_assaulted,
                updated_by:(request && request.securityuserid?request.securityuserid:suserid),
                is_primary_staff_involved:request.is_primary_staff_involved

                
        }).then(res=>{
            return  request;
        }).catch(err => util.logError(err));
        }        
        
}


Provider_uir_actor_involved.remoteMethod('list', {
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


  
  Provider_uir_actor_involved.list = function (request) {

    var sql = 'select * from getprovideractorinvolved($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getprovideractorinvolved;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  Provider_uir_actor_involved.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Provider_uir_actor_involved.observe('access', (ctx, next) => util.access(ctx, next));
  Provider_uir_actor_involved.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
  
  };
  
