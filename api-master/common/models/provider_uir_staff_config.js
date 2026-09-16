'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_staff_config");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_staff_config) {

    Provider_uir_staff_config.remoteMethod('addupdate', {
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

    
    Provider_uir_staff_config.addupdate = (request,reqctx)=>{
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
       if(request.provider_uir_staff_config_id== null || request.provider_uir_staff_config_id == undefined)
       {
           return Provider_uir_staff_config.create({
               provider_uir_id:request.provider_uir_id,             
               provider_staff_id:request.provider_staff_id,       
               inserted_by: suserid,
               updated_by: suserid
           }).then(data => {
              return data;
       })
   }
       else
       {
            return Provider_uir_staff_config.updateAll(
           {provider_uir_staff_config_id:request.provider_uir_staff_config_id},
           {              
            provider_uir_id:request.provider_uir_id,         
            provider_staff_id:request.provider_staff_id,               
            inserted_by: suserid,
            updated_by: suserid
       }).then(res=>{
           return "UIR Updated Successfully";
       })
       }
    }

    
    Provider_uir_staff_config.remoteMethod('list', {
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


  
  Provider_uir_staff_config.list = function (request) {

    var sql = 'select * from getproviderstaffconfig($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_staff_config_id])
      .then(data => {
        if(data){
          return data[0].getproviderstaffconfig;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  Provider_uir_staff_config.getadditionastaffdetails = function (request) {
    var appid = request.where.provider_applicant_id;
    var getappstaff = 'select tps.employee_first_nm, tps.employee_last_nm, tpas.provider_staff_id, * from tb_provider_applicant_staff tpas left join tb_provider_staff tps on tps.provider_staff_id = tpas.provider_staff_id left join provider_uir_actor_involved puai on puai.provider_staff_id = tpas.provider_staff_id::VARCHAR where tpas.provider_applicant_id = $1';

    return util.executeDBQuery(getappstaff, [appid])
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Provider_uir_staff_config.remoteMethod(
    'getadditionastaffdetails', {
      http: {
        path: '/getadditionastaffdetails',
        verb: 'post'
      },
      accepts: {
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      },
      returns: {
        type: 'object',
        root: true
      }
    }
  );


    Provider_uir_staff_config.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Provider_uir_staff_config.observe('access', (ctx, next) => util.access(ctx, next));
    Provider_uir_staff_config.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
    };
    
