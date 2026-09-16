'use strict';
const LOGGER = require("log4js").getLogger("provider_uir_witness");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Provider_uir_witness) {

    Provider_uir_witness.remoteMethod('addupdate', {
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

    
  Provider_uir_witness.addupdate = (request,reqctx) => {
    const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
    var resprovideruirid = null;
    if (request.provider_uir_witness_id === null || request.provider_uir_witness_id === undefined) {

      if (request.provider_uir_id === null && request.provider_uir_id === undefined) {

        return app.models.Provider_uir.create(
          {
            uir_no: request.uir_no,
            provider_id: request.provider_id,
            inserted_by: suserid,
            updated_by: suserid
          }
        ).then(data => {
          resprovideruirid = data.provider_uir_id;
          return Provider_uir_witness.create({
            provider_uir_id: resprovideruirid,
            first_name: request.first_name,
            last_name: request.last_name,
            actor_type_id: request.actor_type_id,
            other_actor_type: request.other_actor_type,
            witness_statement: request.witness_statement,
            inserted_by: suserid,
            updated_by: suserid
          }).then(_data => {
            return _data;
          })
        })
      }
      else {
        return Provider_uir_witness.create({
          provider_uir_id: request.provider_uir_id,
          first_name: request.first_name,
          last_name: request.last_name,
          actor_type_id: request.actor_type_id,
          other_actor_type: request.other_actor_type,
          witness_statement: request.witness_statement,
          inserted_by: suserid,
          updated_by: suserid
        }).then(data => {
          return data;
        })
      }
    }
    else {
      return Provider_uir_witness.updateAll(
        { provider_uir_witness_id: request.provider_uir_witness_id },
        {
          provider_uir_id: request.provider_uir_id,
          first_name: request.first_name,
          last_name: request.last_name,
          actor_type_id: request.actor_type_id,
          other_actor_type: request.other_actor_type,
          witness_statement: request.witness_statement,
          updated_by: suserid

        }).then(res => {
          return "UIR Updated Successfully";
        })
    }
  }

    
    Provider_uir_witness.remoteMethod('list', {
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


  
  Provider_uir_witness.list = function (request) {

    var sql = 'select * from getuirwitnessdetails($1)';

    return util.executeDBQuery(sql, [request.where.provider_uir_id])
      .then(data => {
        if(data){
          return data[0].getuirwitnessdetails;
        }else {
          return data;
        }
      }).catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  Provider_uir_witness.remoteMethod('deletewitness', {
    http: {
            path: '/deletewitness',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'string',
        root : true
    }
});

Provider_uir_witness.deletewitness = function(request)
{  
    var witnessid = request.provider_uir_witness_id;
    LOGGER.debug(witnessid)
 
        return Provider_uir_witness.updateAll({provider_uir_witness_id:witnessid}, {active_flag:0}).then(data => {
            return data;
        }).catch(err => util.logError(err));

    
  
};



  Provider_uir_witness.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Provider_uir_witness.observe('access', (ctx, next) => util.access(ctx, next));
  Provider_uir_witness.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
    };
    
