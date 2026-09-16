'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_classincident");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_classincident) {

    Provider_uir_classincident.remoteMethod('addupdate', {
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

    
    Provider_uir_classincident.addupdate = (request,reqctx)=>{
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
      let prs =[];
      var  resprovideruirid = null;

        if(request.provider_uir_id == null && request.provider_uir_id == undefined)
        {
          return app.models.Provider_uir.create(           
            {
              uir_no:request.uir_no,
              provider_id:request.provider_id,
              licence_type:request.licence_type,
              level_supervision:request.level_supervision,
              location_incident:request.location_incident,
              location_area:request.location_area,
              location_area_other:request.location_area_other,
              incident_datetime:request.incident_datetime,
              discovered_datetime:request.discovered_datetime ,
              precipitate_event:request.precipitate_event,
              inserted_by: suserid,
              updated_by: suserid             
          }
          ).then(data =>{
            resprovideruirid = data.provider_uir_id;
            prs = createProvider_uir_classincident(request,resprovideruirid,suserid,prs);
  return Promise.all(prs);
          })
        }
        else
        {
          prs.push( app.models.Provider_uir.updateAll(
            {provider_uir_id:request.provider_uir_id},
            {
              level_supervision:request.level_supervision,
              location_incident:request.location_incident,
              location_area:request.location_area,
              location_area_other:request.location_area_other,
              precipitate_event:request.precipitate_event,
              incident_datetime:request.incident_datetime,
              discovered_datetime:request.discovered_datetime  
  
          }
          ));

          prs.push( app.models.Provider_uir_classincident.updateAll(
            {provider_uir_id:request.provider_uir_id},
            { activeflag:0  }
        
          ));

          prs = createProvider_uir_classincident(request,provider_uir_id,suserid,prs);
        
        return Promise.all(prs);
        }
  
    }

  function createProvider_uir_classincident(request,provider_uir_id,suserid,prs) {
    const class1_typekey = request.class1_typekey;
    const class2_typekey = request.class2_typekey;
    const class3_typekey = request.class3_typekey;
    if (Array.isArray(class1_typekey)) {
      class1_typekey.forEach(class1_typekey1 => {
        prs.push(
          app.models.Provider_uir_classincident.create({

            provider_uir_id: provider_uir_id,
            class1_typekey: class1_typekey1.class1_typekey,
            insertedby: suserid,
            updatedby: suserid
          })
        )
      });
    }

    if (Array.isArray(class2_typekey)) {
      class2_typekey.forEach(class2_typekey1 => {
        prs.push(
          app.models.Provider_uir_classincident.create({
            provider_uir_id: provider_uir_id,
            class2_typekey: class2_typekey1.class2_typekey,
            insertedby: suserid,
            updatedby: suserid
          })
        )
      });
    }
    if (Array.isArray(class3_typekey)) {
      class3_typekey.forEach(class3_typekey1 => {
        prs.push(
          app.models.Provider_uir_classincident.create({
            provider_uir_id: provider_uir_id,
            class3_typekey: class3_typekey1.class3_typekey,
            other_class3: request.other_class3,
            insertedby: suserid,
            updatedby: suserid
          })
        )
      });
    }
    return prs;
  }

    
    Provider_uir_classincident.remoteMethod('list', {
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


  
  Provider_uir_classincident.list = function (request) {

    var sql = 'select * from getproviderclassincident($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getproviderclassincident;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };



    Provider_uir_classincident.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Provider_uir_classincident.observe('access', (ctx, next) => util.access(ctx, next));
    Provider_uir_classincident.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
    };
    
