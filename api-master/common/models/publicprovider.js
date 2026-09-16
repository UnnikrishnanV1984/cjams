'use strict';
const LOGGER = require("log4js").getLogger("publicprovider");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('../models/email');

module.exports = function (Publicprovider){

    Publicprovider.getpublicproviderservices =function(request){
        var providerid = request.where.provider_id;
        var sql = 'SELECT ts.service_nm,* FROM tb_provider_services tps join tb_services ts on tps.service_id = ts.service_id where tps.provider_id=$1 order by provider_service_id desc';

        return util.executeDBQuery(sql, [providerid])
          .then(data => {
            return {data : data};
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      };
    
      Publicprovider.remoteMethod(
        'getpublicproviderservices', 
        {
          accepts : {
            arg : 'data',
            type : 'object',
            http : {
              source : 'body'
            },
          },
          http: {
            path: '/getpublicproviderservices',
            verb: 'POST'
          },
          returns : {
            type : 'object',
            root : true
          }
        }
        );

        Publicprovider.addpublicproviderservices =function(request,reqctx){
          let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
      request.create_ts= new Date();
      request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);

      var newJsonDataStringyfied = JSON.stringify(request)
      LOGGER.debug(newJsonDataStringyfied);
      if (request!=null && request!=undefined)
      {
        var addprovservices = 'select * from addprovidercontractlicenseservices($1)';
        return util.executeDBQuery(addprovservices, [newJsonDataStringyfied])
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      }
        return Promise.resolve({ data: null, message: 'Invalid request' });
    };
              
    Publicprovider.remoteMethod(
          'addpublicproviderservices', 
                {
                  http: {
                      path: '/addpublicproviderservices',
                      verb: 'post'
                  },
                  accepts : [ {arg : 'data',type : 'object',
                      http : {source : 'body'}}
                      ,{
                                  arg: 'reqctx',
                                  type: 'object',
                                  http: {source: 'context'}
                                } ],   
                  returns: {
                    type : 'object',
                  root : true
                  }
                  }
        );


        Publicprovider.deletepublicproviderservices =function(request){
            var servicecategorycd = request.where.provider_service_id;
            var sql = "update tb_provider_services set end_dt=now()::date ,service_status='Inactive'  where provider_service_id = $1";
            LOGGER.debug(sql);
            return util.executeDBQuery(sql, [servicecategorycd])
                .then(data => {
                    return {data : data};
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
        };
    
        Publicprovider.remoteMethod(
                    'deletepublicproviderservices', 
                            {
                                accepts : {
                                    arg : 'data',
                                    type : 'object',
                                    http : {
                                        source : 'body'
                                    },
                                },
                                http: {
                                    path: '/deletepublicproviderservices',
                                    verb: 'POST'
                                },
                                returns : {
                                    type : 'object',
                                    root : true
                                }
                            }
                );


  

    Publicprovider.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Publicprovider.observe('access', (ctx, next) => util.access(ctx, next));
    Publicprovider.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
