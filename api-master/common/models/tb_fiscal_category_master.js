'use strict';
const LOGGER = require("log4js").getLogger("tb_fiscal_category_master");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_fiscal_category_master) {
    
    Tb_fiscal_category_master.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ,{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
        returns: {
            type : 'string',
            root : true
        }
    });

    Tb_fiscal_category_master.addupdate = function(request,reqctx)
    {  let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
        var fiscal_category_id = request.fiscal_category_id;
        var insertedon = new Date().toLocaleString();
        var securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
        if (!fiscal_category_id){
          
             return Tb_fiscal_category_master.findOne({
                where:{
                    fiscal_category_cd:request.fiscal_category_cd, 
                },
                fields:['fiscal_category_id']
               }).then(_data =>{
                   LOGGER.debug(JSON.stringify(_data)+"data");
                   if(_data){
                       _data.value = 'false';
                   return _data;
                   } else{
                    request.create_user_id = securityusersid;
                    request.update_user_id = securityusersid;
                   
                    request.create_ts= insertedon;
                return Tb_fiscal_category_master.create(request).then(data1 => {
                    data1.value = 'true';
                 return data1;
                })
                   }
                  
               })
               
              
        }else if (fiscal_category_id){
            request.update_user_id = securityusersid;
            request.update_ts = insertedon;
            return Tb_fiscal_category_master.updateAll({fiscal_category_id:fiscal_category_id},request).then(_data => {
                return _data;
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
      
    };


    Tb_fiscal_category_master.list = (request) => {
                const pageno = request.page;
                const pagesize = request.limit;
                var totalcount = 0;

                var sql= 'select * from getfiscalcategorylist($1,$2,$3,$4,$5)';
                return util.executeDBQuery(sql,[request.where.fiscal_category_id, pagesize, pageno,request.where.sortcolumn,request.where.sortorder])
            .then(data => {
                        if (data!==null && data.length>0)
                         {totalcount= data[0].totalcount;

                        }
                        var result;
                        result = {
                            'data' : data,
                            'count' : totalcount,

                        };
                        return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

            };
            
            Tb_fiscal_category_master.remoteMethod('list', {
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
                    type : 'Object',
                    root : true
                    }
                    });

                    Tb_fiscal_category_master.remoteMethod('deletecategory', {
                        http: {
                                path: '/deletecategory',
                                verb: 'post'
                        },
                        accepts : [ {arg : 'data',type : 'object',
                            http : {source : 'body'}} ],
                        returns: {
                            type : 'string',
                            root : true
                        }
                    });

                    Tb_fiscal_category_master.deletecategory = function(request)
                    {  
                        var fiscal_category_id = request.fiscal_category_id;
                     
                            return Tb_fiscal_category_master.updateAll({fiscal_category_id:fiscal_category_id}, {"delete_sw":"Y"}).then(data => {
                                return data;
                            }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                
                        
                      
                    };

                      
            Tb_fiscal_category_master.remoteMethod('fiscalcategoryvalidation', {
                accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                source : 'query'
                },
                required : true
                },
                http : {
                path: '/fiscalcategoryvalidation',
                verb : 'get'
                },
                returns : {
                type : 'Object',
                root : true
                }
                });

                Tb_fiscal_category_master.fiscalcategoryvalidation = (request) => {

                    LOGGER.debug(JSON.stringify(request)+"fiscalcategoryvalidation");
                    return Tb_fiscal_category_master.findOne({
                        where:{
                            fiscal_category_cd:request, 
                        },
                        fields:['fiscal_category_id']
                       }).then(data =>{
                           let message = 'false';
                           if(data){
                               message = 'true';
                           }
                           return message;
                       })
                            
                };

                Tb_fiscal_category_master.remoteMethod('listplacementstructures', {
                    http: {
                        path: '/listplacementstructures',
                        verb: 'get'
                    },
                    accepts : [ 
                    {
                        arg : 'filter',
                        type : 'object',
                        http : {source : 'query'}
                    } ],  
                    returns: {
                        type : 'object',
                        root : true
                    } 
                });
            
                Tb_fiscal_category_master.listplacementstructures = function(request){
                    var eligibilitycd = request.where.eligibilitycd;
                    var sql = "select fiscal_category_id, concat(fiscal_category_cd,' - ',fiscal_category_desc) as description from tb_fiscal_category_master where trim(eligibility_cd)=$1"
                    return util.executeDBQuery(sql,[eligibilitycd])
                      .then(res =>{
                        return res
                      })
                      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    }

                   
    
    
        Tb_fiscal_category_master.observe('before save', (ctx, next) => util.beforesave(ctx, next));
        Tb_fiscal_category_master.observe('access', (ctx, next) => util.access(ctx, next));
        Tb_fiscal_category_master.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
