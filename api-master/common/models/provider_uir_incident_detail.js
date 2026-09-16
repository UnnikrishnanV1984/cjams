'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_incident_detail");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_incident_detail) {

    Provider_uir_incident_detail.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} 
            ,{
                        arg: 'reqctx',
                        type: 'object',
                        http: {source: 'context'}
                      }],
        returns: {
            type : 'string',
            root : true
        }
    });


    Provider_uir_incident_detail.addupdate = (request,reqctx)=>{
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        var  resprovideruirid = null; 

       if(request.provider_uir_incident_detail_id== null || request.provider_uir_incident_detail_id == undefined)
       {
         if(request.provider_uir_id == null && request.provider_uir_id == undefined)
       {

         return   app.models.Provider_uir.create(           
           {
             uir_no:request.uir_no,
             provider_id:request.provider_id,              
             inserted_by: suserid,
             updated_by: suserid         
         }
         ).then(data =>{
           resprovideruirid = data.provider_uir_id;
           return Provider_uir_incident_detail.create({
               provider_uir_id:resprovideruirid,
               incident_type:request.incident_type,
               incident_precipitating_event:request.incident_precipitating_event,
               other_class3:request.other_class3,
               incident_level_of_supervision:request.incident_level_of_supervision,
               incident_location:request.incident_location,
               incident_area:request.incident_area,
               incident_date: request.incident_date,
               incident_time: request.incident_time, 
               discovered_date: request.discovered_date,
               discovered_time: request.discovered_time,
               precipitating_event: request.precipitating_event,
               uir_no:request.uir_no,      
               inserted_by: suserid,
               updated_by: suserid
           }).then(data1 => {
              return data1;
       })
     })
   }
   else
   {
     return Provider_uir_incident_detail.create({
        provider_uir_id:request.provider_uir_id,
        incident_type:request.incident_type,
        incident_precipitating_event:request.incident_precipitating_event,
        other_class3:request.other_class3,
        incident_level_of_supervision:request.incident_level_of_supervision,
        incident_location:request.incident_location,
        incident_area:request.incident_area,
        incident_date: request.incident_date,
        incident_time: request.incident_time,
        discovered_date: request.discovered_date,
        discovered_time: request.discovered_time,
        precipitating_event: request.precipitating_event,
        uir_no:request.uir_no,      
        inserted_by: suserid,
        updated_by: suserid
   }).then(data => {
      return data;
})
   }
 }
       else
       {
            return Provider_uir_incident_detail.updateAll(
           {provider_uir_incident_detail_id:request.provider_uir_incident_detail_id},
           {
            provider_uir_id:request.provider_uir_id,
            incident_type:request.incident_type,
            incident_precipitating_event:request.incident_precipitating_event,
            other_class3:request.other_class3,
            incident_level_of_supervision:request.incident_level_of_supervision,
            incident_location:request.incident_location,
            incident_area:request.incident_area,
            incident_date: request.incident_date,
            incident_time: request.incident_time,
            discovered_date: request.discovered_date,
            discovered_time: request.discovered_time,
            precipitating_event: request.precipitating_event,
            uir_no:request.uir_no,           
            inserted_by: suserid,
            updated_by: suserid

       }).then(res=>{
           return "UIR Updated Successfully";
       })
       }
       
       
}

Provider_uir_incident_detail.remoteMethod('list', {
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

  Provider_uir_incident_detail.list = function (request) {

    var sql = 'select * from getprovideruirincidentdetails($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getprovideruirincidentdetails;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };


}
