'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_actor_detail");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_actor_detail) {

    Provider_uir_actor_detail.remoteMethod('addupdate', {
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


   
    Provider_uir_actor_detail.addupdate = (request,reqctx)=>{
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
         var  resprovideruirid = null; 

        if(!util.nullcheck(request.provider_uir_actor_detail_id))
        {
          if(request.provider_uir_id == null && request.provider_uir_id == undefined)
        {

          return   app.models.Provider_uir.create(           
            {

              uir_no:request.uir_no,
              provider_id:request.object_id,              
              inserted_by: suserid,
              updated_by: suserid         

          }
          ).then(data =>{

            resprovideruirid = data.provider_uir_id;
           
            return Provider_uir_actor_detail.create({

                provider_uir_id:resprovideruirid,
                uir_actor_type:request.uir_actor_type,
                first_name:request.first_name,
                last_name:request.last_name,
                dob:request.dob,
                address:request.address,
                phone_no:request.phone_no,
                gender:request.gender,
                youth_identifier:request.youth_identifier,
                placing_agency:request.placing_agency,               
                inserted_by: suserid,
                updated_by: suserid,
                admitting_charge: request.admitting_charge,
                identifier_no: request.identifier_no,
                provider_id: request.object_id
            }).then(data1 => {
              if(request.uir_actor_type === 'youth'){
              app.models.Provider_uir_youth_detail.create({
                provider_uir_id:resprovideruirid,
                uir_no :request.uir_no,
                provider_uir_actor_id :data1.provider_uir_actor_detail_id,                             
                insertedby: suserid,
                updatedby: suserid, 
                provider_id: request.object_id,
                activeflag: 1
              })
            }
               return data1;
        })
      })
    }
    else
    {
      return Provider_uir_actor_detail.create({

        provider_uir_id:request.provider_uir_id,
        uir_actor_type:request.uir_actor_type,
        first_name:request.first_name,
        last_name:request.last_name,
        dob:request.dob,
        address:request.address,
        phone_no:request.phone_no,
        gender:request.gender,
        youth_identifier:request.youth_identifier,
        placing_agency:request.placing_agency,               
        inserted_by: suserid,
        updated_by: suserid,
        admitting_charge: request.admitting_charge,
        identifier_no: request.identifier_no,
        provider_id: request.object_id
    }).then(data => {
      if(request.uir_actor_type === 'youth'){
      app.models.Provider_uir_youth_detail.create({
        provider_uir_id:request.provider_uir_id,
        uir_no :request.uir_no,
        provider_uir_actor_id :data.provider_uir_actor_detail_id,   
        insertedby: suserid,
        updatedby: suserid,  
        provider_id: request.object_id,
        activeflag: 1
      })
    }
       return data;
})
    }
  }
        else
        {
             return Provider_uir_actor_detail.updateAll(
            {provider_uir_actor_detail_id:request.provider_uir_actor_detail_id},
            {
                provider_uir_id:request.provider_uir_id,
                uir_actor_type:request.uir_actor_type,
                first_name:request.first_name,
                last_name:request.last_name,
                dob:request.dob,
                address:request.address,
                phone_no:request.phone_no,
                gender:request.gender,
                youth_identifier:request.youth_identifier,
                placing_agency:request.placing_agency,               
                updated_by: suserid,
                admitting_charge: request.admitting_charge,
                identifier_no: request.identifier_no

        }).then(res=>{
            return "UIR Updated Successfully";
        })
        }
}

Provider_uir_actor_detail.remoteMethod('list', {
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


  
  Provider_uir_actor_detail.list = function (request) {

    var sql = 'select * from getprovideruiractordetails($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getprovideruiractordetails;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  Provider_uir_actor_detail.remoteMethod('deleteactortype', {
    http: {
            path: '/deleteactortype',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'string',
        root : true
    }
});

Provider_uir_actor_detail.deleteactortype = function(request)
{  
    var uiractortypeid = request.provider_uir_actor_detail_id;
    LOGGER.debug(uiractortypeid)
 
        return Provider_uir_actor_detail.updateAll({provider_uir_actor_detail_id:uiractortypeid}, {active_flag:0}).then(data => {
            return data;
        }).catch(err => util.logError(err));

    
  
};


Provider_uir_actor_detail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Provider_uir_actor_detail.observe('access', (ctx, next) => util.access(ctx, next));
Provider_uir_actor_detail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
