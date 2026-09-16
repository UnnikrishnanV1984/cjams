'use strict';
const LOGGER = require("log4js").getLogger("tb_account_fast_entry");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_account_fast_entry) {
    
    
                    // receipt fast payment 
                    Tb_account_fast_entry.remoteMethod('add', {
                        http: {
                                path: '/add',
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

                    Tb_account_fast_entry.add = function(request,reqctx)
                    {    let suserid = undefined;
                        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                          suserid = reqctx.req.headers.securityusersid
                        } 
                        var securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
                        request.fast_entry.create_user_id = securityusersid;
                     request.fast_entry.update_user_id = securityusersid;
                     request.fast_entry.create_ts = new Date().toLocaleString();    
                     request.fast_entry.update_ts = new Date().toLocaleString();    
                        return Promise.all(request.fast_entry.map(newreq => Tb_account_fast_entry.create(newreq)))
                        .then(data => 
                            {
           
                            //     data.forEach(element => {
                            //         LOGGER.debug(element);
                            //         LOGGER.debug(element.fast_entry_id);
                            //         return new Promise((resolve, reject) => {
                            //             const ds = app.dataSources.hcuewelfare;
                            //             var sql = "update tb_account_transaction w=set post_sw ='N' where transaction_id= $1 "
                            //             return ds.connector.execute(sql, [element.original_transaction_id],(err, data) => {
                            //               if (err) reject(err);
                            //               else resolve(data);
                            //             });
                            //           }).then(res =>{ 
                            //             return res;
                            //           });
                                    
                            //     });
                            //    //LOGGER.debug(data);

                               return data;
                            })
                        .catch(err =>err);
                    };
    
    
                    // receipt fast payment 
                    Tb_account_fast_entry.remoteMethod('updatePostEntry', {
                        http: {
                                path: '/updatePostEntry',
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

                    Tb_account_fast_entry.updatePostEntry = function(request,reqctx)
                    {   let suserid = undefined;
                        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                          suserid = reqctx.req.headers.securityusersid
                        }
                        let res_arr = [];
                        let req_arr = [];
                        var securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
                        request.fast_entry.create_user_id = securityusersid;
                     request.fast_entry.update_user_id = securityusersid;
                     request.fast_entry.create_ts = new Date().toLocaleString();    
                     request.fast_entry.update_ts = new Date().toLocaleString();
                        return Promise.all(request.fast_entry.map(newreq => app.models.Tb_account_transaction.create(newreq)))
                        .then(data => 
                            {
                                LOGGER.debug(data[0]);
                                res_arr =data;
                                return Promise.all(res_arr.map(newreq => 
                                    Tb_account_fast_entry.updateAll({fast_entry_id:newreq.fast_entry_id}, {
                                        post_sw : newreq.post_sw,
                                        post_dt : newreq.post_dt,
                                        update_user_id: (request && request.securityuserid?request.securityuserid: suserid),
                                        update_ts: new Date().toLocaleString()
                                    })))
                                .then(data2 => {
                                    req_arr = request.fast_entry;
                                    req_arr.forEach(element => {
                                        LOGGER.debug(element);
                                        LOGGER.debug(element.fast_entry_id);
                                        var sql = "update tb_client_account set total_balance_no = coalesce(total_balance_no , 0) + $2 where client_account_id=$1"
                                        return util.executeDBQuery(sql, [element.client_account_id,element.transaction_amount_no]).then(res =>{
                                            return res;
                                          })
                                          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                                    });
                                    return data2;
                                })
                        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    };
    
    

    Tb_account_fast_entry.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_account_fast_entry.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_account_fast_entry.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
