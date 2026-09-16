'use strict';
const LOGGER = require("log4js").getLogger("tb_placement_stru_category_link");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_placement_stru_category_link) {

    Tb_placement_stru_category_link.remoteMethod('addupdate', {
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

  Tb_placement_stru_category_link.addupdate = function(request,reqctx)
  {   let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
      var placement_stru_cate_link_id = request.placement_stru_cate_link_id;
      var insertedon = new Date().toLocaleString();
      var securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
     
      if (placement_stru_cate_link_id){   
        request.update_user_id = securityusersid;
        request.update_ts = insertedon;
         return Tb_placement_stru_category_link.update({placement_stru_cate_link_id:placement_stru_cate_link_id},request).then(data => {
           return data;
        })
      }else {
        const response = [];
        var result = [];
    
        var fiscalcode = request.fiscal_category_id;
        if(Array.isArray(fiscalcode)){
        fiscalcode.forEach(element => {
            request.fiscal_category_id = element;
            request.create_user_id = securityusersid;
            request.update_user_id = securityusersid;
            request.create_ts= insertedon;
            response.push(
               Tb_placement_stru_category_link.create(request))
     })
     return Promise.all(response).then(function(values) { 
        values.forEach(x=>{                         
            result.push(x);                           
        }); 
        return result;
      });  
    }
       
       
   
      }
   
      return Promise.resolve([]);
  };

  Tb_placement_stru_category_link.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Tb_placement_stru_category_link.observe('access', (ctx, next) => util.access(ctx, next));
  Tb_placement_stru_category_link.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
