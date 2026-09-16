'use strict';
const LOGGER = require("log4js").getLogger("tb_payment_receipt");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_payment_receipt) {
    
    Tb_payment_receipt.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }  ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Tb_payment_receipt.addupdate = function(request,reqctx){
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        var receipt_id = request.receipt_id;
        if (receipt_id == undefined || receipt_id == '' || receipt_id == null){
              var securityusersid= suserid;
       request.create_user_id = securityusersid;
    request.update_user_id = securityusersid;

   
  
        return Tb_payment_receipt.create(request).then(data => {
            LOGGER.debug(data+"data");
            data = JSON.parse(JSON.stringify(data));
           data.collected_amount_no = data.payment_amount_no;
            data.update_user_id = securityusersid;
            LOGGER.debug(JSON.stringify(data)+"input data for json");
            var updatepaymentreceiptdetailsSql = "SELECT * FROM updatepaymentreceiptdetails($1)";

            util.executeDBQuery(updatepaymentreceiptdetailsSql, [data])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            return data;
		}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        } else if (receipt_id){
            LOGGER.debug(request,+"giving intput")
            var sql = "select * from updatereceiptdetails($1)"
            return util.executeDBQuery(sql, [request]).then(res =>{
                return res
              })
              .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
      
    };


            Tb_payment_receipt.list = (request) => {
                const pageno = request.page;
                const pagesize = request.limit;
                var totalcount = 0;
                var balanceamount = 0;
                var sql= 'select * from receivableReceiptList($1,$2,$3,$4)';
                return util.executeDBQuery(sql,[request.where.paymentdetailid,request.where.providerid, pagesize, pageno])
                    .then(data => {
                        if (data!==null && data.length>0)
                         {totalcount= data[0].totalcount;
                            balanceamount=data[0].receivable_balance_no;
                        }
                        var result;
                        result = {
                            'data' : data,
                            'count' : totalcount,
                            'balanceamount' : balanceamount
                        };
                        return result;
                })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

            };
            
            Tb_payment_receipt.remoteMethod('list', {
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

                    Tb_payment_receipt.remoteMethod('deletePayment', {
                        http: {
                                path: '/deletePayment',
                                verb: 'post'
                        },
                        accepts : [ {arg : 'data',type : 'object',
                            http : {source : 'body'}}, {
                              arg: 'reqctx',
                              type: 'object',
                              http: {
                                source: 'context'
                              }
                            } ],
                        returns: {
                            type : 'string',
                            root : true
                        }
                    });

                    Tb_payment_receipt.deletePayment = function(request, reqctx)
                    {  
                      let _securityusersid = undefined;
                      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                        _securityusersid = reqctx.req.headers.securityusersid;
                      } 
                            return Tb_payment_receipt.updateAll({receipt_id:request.receipt_id}, {"delete_sw":"Y", update_user_id: request && request.securityuserid?request.securityuserid: _securityusersid}).then(data => {
                                return data;
                            }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                
                        
                      
                    };
    
                    // receipt fast payment 
                    Tb_payment_receipt.remoteMethod('getReceiptFastPayment', {
                        http: {
                                path: '/getReceiptFastPayment',
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

                    Tb_payment_receipt.getReceiptFastPayment = function(request,reqctx)
                    {   let suserid = undefined;
                        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                          suserid = reqctx.req.headers.securityusersid
                        }
                        request.securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
                        var sql = "select * from get_receipt_fast_entry($1,$2,$3,$4,$5,$6,$7)"
                        return util.executeDBQuery(sql, [request.account_type_cd,request.transaction_source_cd,request.page,request.limit,request.client_id,request.client_name,request.securityusersid]).then(res =>{
                            return res
                          })
                          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    };


                    Tb_payment_receipt.remoteMethod('receiptreversal', {
                        http: {
                                path: '/receiptreversal',
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

                    Tb_payment_receipt.receiptreversal = function(request,reqctx)
                    {    let suserid = undefined;
                        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                          suserid = reqctx.req.headers.securityusersid
                        }
                        request.securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
                        var sql = "select * from updatereceiptreversal($1)"
                        return util.executeDBQuery(sql, [request]).then(res =>{
                            return res
                          })
                          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    };

                    Tb_payment_receipt.remoteMethod('getreversalreceiptlist', {
                        accepts :[ {
                        arg : 'filter',
                        type : 'Object',
                        http : {
                        source : 'query'
                        },
                        required : true
                        },{
                            arg: 'reqctx',
                            type: 'object',
                            http: {source: 'context'}
                          } ],
                        http : {
                        path: '/getreversalreceiptlist',
                        verb : 'get'
                        },
                        returns : {
                        type : 'Object',
                        root : true
                        }
                        });

                        Tb_payment_receipt.getreversalreceiptlist = (request,reqctx) => {
                            let suserid = undefined;
                            if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                              suserid = reqctx.req.headers.securityusersid
                            } 
                            var input = request.where;
                            input.page = request.page;
                            input.limit = request.limit;
                            var totalcount = 0;
                            input.securityusersid= (request && request.securityuserid?request.securityuserid: suserid);

                            var sql= 'select * from getreversalreceiptlist($1)';
                            return util.executeDBQuery(sql,[input])
                                .then(data => {
                                    if (data!==null && data.length>0)
                                     {totalcount= data[0].totalcount;

                                    }
                                    var result;
                                    result = {
                                        'data' : data,
                                        'count' : totalcount

                                    };
                                    return result;
                            })
                        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                        };
                        
                        Tb_payment_receipt.remoteMethod('approvereceiptreversal', {
                            http: {
                                    path: '/approvereceiptreversal',
                                    verb: 'post'
                            },
                            accepts : [ {arg : 'data',type : 'object',
                                http : {source : 'body'}},{
                                    arg: 'reqctx',
                                    type: 'object',
                                    http: {source: 'context'}
                                  }  ],
                            returns: {
                                type : 'string',
                                root : true
                            }
                        });
    
                        Tb_payment_receipt.approvereceiptreversal = function(request,reqctx)
                        {    let suserid = undefined;
                            if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                              suserid = reqctx.req.headers.securityusersid
                            }
                            request.securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
                            var sql = "select * from approvereceiptreversal($1)"
                            return util.executeDBQuery(sql, [request]).then(res =>{
                                return res
                              })
                              .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                        };
    
    Tb_payment_receipt.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_payment_receipt.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_payment_receipt.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
