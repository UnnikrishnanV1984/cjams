'use strict';
const LOGGER = require("log4js").getLogger("tb_service_purchase_authorization");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_service_purchase_authorization) {
      
    Tb_service_purchase_authorization.remoteMethod('updateservicepurchaseauthorization', 
    {
        http: {
            path: '/updateservicepurchaseauthorization/:id',
            verb: 'put'
        },
       accepts : [
        {
          arg: 'id',
         type: 'string',
          required: true,
          http: {source: 'path'}
      },
        {arg : 'data',type : 'object',
           http : {source : 'body'}}
            ],
        returns: {
          type : 'object',
        root : true
        }

});

    
    Tb_service_purchase_authorization.updateservicepurchaseauthorization=(id,request)=>{
        return new Promise((resolve, reject) => {
            Tb_service_purchase_authorization.updateAll({service_log_id:id}, request ,function(err, res){
                if (err){
                    LOGGER.error('error');   
                }
                else{
                    resolve(res);
                }
    })
})
    .then(data => data)
    .catch(err => util.logError(err));        
                
    };


    Tb_service_purchase_authorization.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_service_purchase_authorization.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_service_purchase_authorization.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
