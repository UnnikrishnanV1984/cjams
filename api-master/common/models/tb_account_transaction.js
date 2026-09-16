'use strict';
const LOGGER = require("log4js").getLogger("tb_account_transaction");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
var email = require('../models/email');
const purchaseauthmsg = 'Purchase Authorization (';

module.exports = function (Tb_account_transaction) {
     
    Tb_account_transaction.remoteMethod('addClientTransaction', {
        http: {
                path: '/addClientTransaction',
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

	Tb_account_transaction.addClientTransaction = function (request,reqctx) {
		const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
		LOGGER.debug("user",suserid);
		request.create_user_id = suserid;
		request.update_user_id = suserid;
		const v_client_account_id = request.client_account_id;
		const v_transaction_amount_no = request.transaction_amount_no;
		const v_credit_debit_sw = request.credit_debit_sw;
		const v_update_user_id = request.update_user_id;
		let result = {};
		const sql = "select * from sp_check_client_transation($1,$2,$3)";
		return util.executeDBQuery(sql,[v_client_account_id,request.benefit_start_dt,request.transaction_source_cd])
		.then(data => {
				return data;
		})
		.then(data => {
			if (data.length > 0) {
				if (data[0].sp_check_client_transation === true) {
					result = {
						"isexists": false
					};
					return Tb_account_transaction.create(request)
						// .then(data => data)
						.then(data7 => {
							let sql1 = "select * from update_child_account_balance($1,$2,$3,$4)";
							util.executeDBQuery(sql1,[v_client_account_id,v_transaction_amount_no,v_credit_debit_sw,v_update_user_id])
							.then(data1 => {
									LOGGER.info(data1);
							})
							.catch(err => {
									LOGGER.error(err)
									throw err;
							})
							//return data;
						}).then(data2 => {
							let sql2 = "select * from balanceexceedtickler($1,$2)";
							return util.executeDBQuery(sql2,[request.client_account_id,request.create_user_id])
							.then(data3 => {
									return data3;
							})
							.then(data9 => {
								if (data9?.length > 0 && data9[0].total_balance_no >= 1500) {
									let sql5 = "select up.securityusersid, up.email from v_userprofile up  where up.roletypekey in ('FNSFW','FNSFS')"
										+ "and up.countyid in (select distinct u.countyid from v_userprofile u where u.securityusersid = '" + suserid + "')";

									return util.executeDBQuery(sql5,[])
										.then(data5 => {
											return data5;
										})
										.then(data8 => {
											return result;
										}).catch(err => {
											LOGGER.error(err);
											return err;
										})
								}
								return result;
							})
							.catch(err => {
								LOGGER.error(err);
								return err;
							})
						})
				} else {
					result = {
						"isexists": true
					};
					return result
				}
			} else {
				result = {
					"isexists": true
				};
				return result
			}
		})
		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
	}

    //update method

    Tb_account_transaction.remoteMethod('updateClientTransaction', 
    {
        http: {
            path: '/updateClientTransaction/:id',
            verb: 'put'
        },
       accepts : [
        {
          arg: 'id',
         type: 'number',
          required: true,
          http: {source: 'path'}
      },
        {arg : 'data',type : 'object',
           http : {source : 'body'}},{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }
            ],
        returns: {
          type : 'object',
        root : true
        }
});
 
Tb_account_transaction.updateClientTransaction = function(id,request,reqctx)
{  let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    request.create_user_id = (request && request.securityuserid?request.securityuserid:suserid);
   LOGGER.debug(request.create_user_id);
    request.update_user_id = (request && request.securityuserid?request.securityuserid: suserid);
    return Tb_account_transaction.updateAll({transaction_id:id}, request)
    .then(data => data)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

    Tb_account_transaction.deleteClientTransaction = (transactionId) => {
        const dataQuery = 'delete from tb_account_transaction where transaction_id=$1';

        return util.executeDBQuery(dataQuery, [transactionId])
            .then(data => {
                return { data: data };
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_account_transaction.remoteMethod('deleteClientTransaction', {
        accepts: {
            arg: 'id',
            type: 'number',
            http: {
                source: 'path'
            },
        },
        http: {
            path: '/deleteClientTransaction/:id',
            verb: 'POST'
        },
        returns: {
            type: 'object',
            root: true
        }
    });

    //delete by authorized id
    
    Tb_account_transaction.deleteClientTransactionbyAuthId = (transactionId,request,reqctx) => {
        const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
        const dataQuery1 = "update tb_account_transaction set delete_sw='N' where authorization_id=$1";
        return util.executeDBQuery(dataQuery1,[transactionId])
            .then(data => {
                LOGGER.info(data);
                return { data: data };
            })
            .then(_data6 => {
                const dataQuery2 = "update routing set remarks='Denied', tosecurityusersid = $3 ,activeflag=1,routingstatustypeid ='62', routeddescription =$2    where objectid=$1 ::character varying and activeflag = 1 and eventcode  in ('PCAUTH','PCAUTHR')";

                return util.executeDBQuery(dataQuery2,[transactionId,request.reason_tx,suserid])
                    .then(data1 => {
                        LOGGER.info(data1);
                        return { data: data1 };
                    })
                    .then(_data => {
                        const dataQuery = "UPDATE tb_service_purchase_authorization set reason_tx = $2, update_user_id = $3, update_ts = now()  where authorization_id =$1";
                        return util.executeDBQuery(dataQuery,[transactionId,request.reason_tx,suserid])
                        .then(data => ({ data: data }))
                        .then(data => {

                            if (request.fiscal_category_cd == '7503' || request.fiscal_category_cd == '7502') {
                                const dataQuery4 =
                                    `INSERT INTO tb_account_transaction
							(client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
							notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
							
							select $1,'5530', '5475', tat.benefit_start_dt, tat.benefit_end_dt , $2, now(),
							'C','',now(),$4,now(),$4,'N',null,$3 
							from tb_account_transaction tat  where tat.authorization_id = $3`;
                                util.executeDBQuery(dataQuery4,[request.client_account_id,request.cost_no,transactionId,suserid])
                                    .then(data3 => {
                                        return { data: data3 };
                                    })
                                    .then(_data4 => {
                                        const dataQuery3 =
                                            `update tb_client_account set obligated_for_anc=case when (select coalesce(cost_no,0) <= coalesce(obligated_for_anc,0) from tb_service_purchase_authorization where authorization_id=$2) then
							 (coalesce(obligated_for_anc ,0) - coalesce((select cost_no from tb_service_purchase_authorization where authorization_id=$2),0)) else 0 end 
									where client_account_id = $1;`;
                                        return util.executeDBQuery(dataQuery3,[request.client_account_id,transactionId])
                                            .then(data5 => {
                                                return { data: data5 };
                                            })
                                            .catch(err => {
                                                LOGGER.error(err);
                                                return err;
                                            })
                                    })
                                    .catch(err => {
                                        LOGGER.error(err);
                                        return err;
                                    })
                            }
                            else {
                                return data;
                            }
                        })
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    })
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })

    };


    
    Tb_account_transaction.rejectbyAuthId = (transactionId,request,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        const dataQuery = "update routing set remarks='Denied',tosecurityusersid = $3 ,activeflag=1,routingstatustypeid ='62',routeddescription =$2 where objectid=$1 ::character varying and activeflag = 1 and eventcode  in ('PCAUTH','PCAUTHR')";
        return util.executeDBQuery(dataQuery, [transactionId,request.reason_tx,suserid])
        .then(data => {
            const dataQuery1 = "UPDATE tb_service_purchase_authorization set reason_tx = $2 where authorization_id =$1";
            return util.executeDBQuery(dataQuery1, [transactionId,request.reason_tx]).then (data2 =>{
								let sql ="select r.fromsecurityusersid,mu.email from routing r join muser mu on mu.securityusersid = r.fromsecurityusersid and mu.activeflag =1 where eventcode  in ('PCAUTH','PCAUTHR') and objectid = $1 :: character varying";
								return util.executeDBQuery(sql,[transactionId])
								.then(data3 => {
										return data3;
								})
								.then(data4 => {
               if(data4.length >0){
               data4.forEach(userObj=>{
                   var nofiticationJson ={};
                     nofiticationJson.securityusersid = userObj.fromsecurityusersid;
                     nofiticationJson.usernotificationtypekey="System";
                     nofiticationJson.objectid=transactionId;
                     nofiticationJson.subject=purchaseauthmsg+transactionId+') Rejected for Case ('+ request.case_id +')';
                     nofiticationJson.priorityleveltypekey ="High";
                     nofiticationJson.body=purchaseauthmsg+transactionId+') Rejected for Case ('+ request.case_id +')';
                     app.models.Usernotification.Add(nofiticationJson,reqctx);
                     email.SendEmailForFinance(userObj.email,nofiticationJson.subject,nofiticationJson.body);
                     return request;
                   });}
           }).catch(err => {
						LOGGER.error(err);
						return err;
				})
            })
        })
       
    };


    
    
    Tb_account_transaction.remoteMethod('rejectbyAuthId', {
       
		accepts: [
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
		http: { "verb": "POST", "path": "/rejectbyAuthId/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});


    Tb_account_transaction.returnbyAuthId = (transactionId,request,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        const dataQuery = "update routing set remarks='Returned',tosecurityusersid = $3 ,activeflag=1,routingstatustypeid ='850',routeddescription =$2 where objectid=$1 ::character varying and activeflag = 1 and eventcode  in ('PCAUTH','PCAUTHR')";
        return util.executeDBQuery(dataQuery, [transactionId,request.return_tx,suserid])
        .then(data1 => {
            const dataQuery1 = "UPDATE tb_service_purchase_authorization set reason_tx = $2 where authorization_id =$1";
            return util.executeDBQuery(dataQuery1, [transactionId,request.return_tx]).then (data3 =>{
								let sql ="select r.fromsecurityusersid,mu.email from routing r join muser mu on mu.securityusersid = r.fromsecurityusersid and mu.activeflag =1 where eventcode  in ('PCAUTH','PCAUTHR') and objectid = $1 :: character varying";
								util.executeDBQuery(sql,[transactionId])
								.then(data4 => {
									return data4;
								})
									.then(data5 => {
										if (data5.length > 0) {
											data5.forEach(userObj => {
												var nofiticationJson = {};
												nofiticationJson.securityusersid = userObj.fromsecurityusersid;
												nofiticationJson.usernotificationtypekey = "System";
												nofiticationJson.objectid = transactionId;
												nofiticationJson.subject = purchaseauthmsg + transactionId + ') Returned for Case (' + request.case_id + ')';
												nofiticationJson.priorityleveltypekey = "High";
												nofiticationJson.body = purchaseauthmsg + transactionId + ') Returned for Case (' + request.case_id + ')';
                                                app.models.Usernotification.Add(nofiticationJson,reqctx);
												email.SendEmailForFinance(userObj.email,nofiticationJson.subject,nofiticationJson.body);
												return request;
											});
										}
									}).catch(err => {
										LOGGER.error(err);
										return err;
									})
            })
        })
       
    };


    
    
    Tb_account_transaction.remoteMethod('returnbyAuthId', {
       
		accepts: [
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			}
            ,{
                      arg: 'reqctx',
                      type: 'object',
                      http: {source: 'context'}
                    }],
		http: { "verb": "POST", "path": "/returnbyAuthId/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});

    Tb_account_transaction.remoteMethod('deleteClientTransactionbyAuthId', {
       
		accepts: [
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
		http: { "verb": "POST", "path": "/deleteClientTransactionbyAuthId/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});

    
    Tb_account_transaction.remoteMethod('getClientAccountTransactions', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });
    
    Tb_account_transaction.getClientAccountTransactions=(request)=>{

        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;
        var sql= 'select * from get_child_transactions_details_list($1,$2,$3)';
        return util.executeDBQuery(sql,[JSON.stringify(request.where), pageno, pagesize])
            .then(data => {
                if (data!==null && data.length>0) {totalcount= data[0].totalcount;}
                var result;
                result = {
                    'data' : data,
                    'count' : totalcount
                };
                return result;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };
    
     
    Tb_account_transaction.remoteMethod('getTransactionSource', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
            path: "/getTransactionSource"
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });
    
    Tb_account_transaction.getTransactionSource=(request)=>{

        var totalcount = 0;
        var sql= 'select * from get_transaction_source($1)';
        return util.executeDBQuery(sql,[request.where.client_account_id])
            .then(data1 => {
                if (data1 !== null && data1.length > 0) {totalcount= data1[0].totalcount;}
                var result;
                result = {
                    'data' : data1,
                    'count' : totalcount
                };
                return result;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };
    
    Tb_account_transaction.remoteMethod('clientTransactionErrorCorrection', {
        http: {
                path: '/clientTransactionErrorCorrection',
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

    Tb_account_transaction.clientTransactionErrorCorrection = function(request,reqctx)
    {   let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        LOGGER.debug("user",(request && request.securityuserid?request.securityuserid: suserid));
        request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);
        request.update_user_id = (request && request.securityuserid?request.securityuserid: suserid);
        request.create_ts = new Date().toLocaleString();
        request.update_ts = new Date().toLocaleString(); 

        return Tb_account_transaction.upsert(request)
       .then(data =>{
        var eventcode=request.eventcode;
    let sql = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
    util.executeDBQuery(sql, [data.transaction_id, (request && request.securityuserid?request.securityuserid: suserid), eventcode, request.status, request.comments, request.assignedtoid, false, false, false, request.notifymsg,request.routeddescription,request.intakeserviceid])
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        return data;
                 })
                //.then(data => {                   
                //         var nofiticationJson ={};
                //           nofiticationJson.securityusersid = request.assignedtoid;
                //           nofiticationJson.usernotificationtypekey="System";
                //           nofiticationJson.objectid=v_trans_id;
                //           nofiticationJson.subject='Error Correction Request for Transaction id ('++')  ';
                //           nofiticationJson.priorityleveltypekey ="Normal";
                //           nofiticationJson.body='Childs ('+childname+') Conserved account balance reaches $1500 ';
                          
                //           var ins =	app.models.Usernotification.Add(nofiticationJson);
                //           //email send 
                //         //   var emailstatus= email.SendEmailForFinance(userObj.email,nofiticationJson.subject,nofiticationJson.body);
                //           return data;
                //         }).catch(err => util.logError(err));
    }
    
    Tb_account_transaction.remoteMethod('clientTransactionErrorCorrectionApproval', {
        http: {
                path: '/clientTransactionErrorCorrectionApproval',
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

    Tb_account_transaction.clientTransactionErrorCorrectionApproval = function(request,reqctx)
    {   const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        LOGGER.debug("user",suserid);
        request.create_user_id = suserid;
        request.update_user_id = suserid;
        
        var v_client_account_id = request.client_account_id;
        var v_transaction_amount_no = request.transaction_amount_no;
        var v_credit_debit_sw = request.credit_debit_sw;
        var v_update_user_id=request.update_user_id;
        var eventcode=request.eventcode;
        var sql = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
        return util.executeDBQuery(sql, [request.transaction_id, suserid, eventcode, request.status, request.comments, request.assignedtoid, false, false, false, request.notifymsg,request.routeddescription,request.intakeserviceid])
        .then(data => {
            let sql7 ="select * from update_child_account_balance($1,$2,$3,$4)";
            util.executeDBQuery(sql7,[v_client_account_id,v_transaction_amount_no,v_credit_debit_sw,v_update_user_id])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            return data;
            })
            .then(data => {
                if(request.status == 82)
                {
                let sql6 ="update tb_account_transaction set adjustment_approval_status_cd = '3047',update_ts=now() where transaction_id = $1";
                util.executeDBQuery(sql6,[request.transaction_id])
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                return data;
                }
                else
                {return data;}
                }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Tb_account_transaction.remoteMethod('clientTransactionErrorCorrectionReject', {
        http: {
                path: '/clientTransactionErrorCorrectionReject',
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

    Tb_account_transaction.clientTransactionErrorCorrectionReject = function(request,reqctx)
    {   const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        const dataQuery = "update routing set remarks='Denied',tosecurityusersid = $3  ,activeflag=1,routingstatustypeid ='83',routeddescription =$2 where objectid=$1 ::character varying and activeflag = 1  and eventcode ='CACCTRANS'";
        return util.executeDBQuery(dataQuery, [request.transaction_id,request.reason_tx,suserid])
        .then(data => ({ data: data }))
        // .then(data => {
        //     return new Promise((resolve, reject) => {
        //         var ds = server.dataSources.hcuewelfare;
        //         const dataQuery = "update tb_account_transaction set delete_sw ='Y' where transaction_id = $1";
        //         return ds.connector.execute(dataQuery, [request.transaction_id], (err, data) => {
        //             if (err) reject(err);
        //             else resolve({ data: data });
        //         });
        //     })
            .then(data => {
                const dataQuery1 = "update tb_account_transaction set adjustment_approval_status_cd ='3281' where transaction_id = $1";
                return util.executeDBQuery(dataQuery1, [request.transaction_id])
                .then(data4 => ({ data: data4 }));
        })
            .then(data => {
                let sql ="select r.fromsecurityusersid,mu.email from routing r join muser mu on mu.securityusersid = r.fromsecurityusersid and mu.activeflag =1 where eventcode ='CACCTRANS' and objectid = $1 :: character varying";
                return util.executeDBQuery(sql,[request.transaction_id]).then(data6 => {
                    if(data6.length >0){
                    data6.forEach(userObj=>{
                        var nofiticationJson ={};
                          nofiticationJson.securityusersid = userObj.fromsecurityusersid;
                          nofiticationJson.usernotificationtypekey="System";
                          nofiticationJson.objectid=request.transaction_id;
                          nofiticationJson.subject='Error Correction for client Account ('+request.account_no_tx+') is Denied';
                          nofiticationJson.priorityleveltypekey ="High";
                          nofiticationJson.body='Error Correction for client Account ('+request.account_no_tx+') is Denied';
                          app.models.Usernotification.Add(nofiticationJson,reqctx);
                          email.SendEmailForFinance(userObj.email,nofiticationJson.subject,nofiticationJson.body);
                          return request;
                        });}
                        return data6;
                })
            })
          
       // })
    }

    Tb_account_transaction.remoteMethod('getClientEligibilityStatus', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
            path: "/getClientEligibilityStatus"
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });
    
    Tb_account_transaction.getClientEligibilityStatus=(request)=>{

        var totalcount = 0;
        var sql= 'select * from get_client_eligibility_tatus($1,$2)';
        return util.executeDBQuery(sql,[request.where.client_id,request.where.case_id])
            .then(data2 => {
                    if (data2 !== null && data2.length>0) {totalcount= data2[0].totalcount;}
                    var result;
                    result = {
                        'data' : data2,
                        'count' : totalcount
                    };
                    return result;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    Tb_account_transaction.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_account_transaction.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_account_transaction.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
