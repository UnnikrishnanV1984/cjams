'use strict';
const LOGGER = require("log4js").getLogger("tb_receivable_detail");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
var email = require('../models/email');
const newwriteoffnotificationmsg = 'New Write-Off Request for " (Receivable Id : ';
const writeoffrejectednotificationmsg = 'Write off request Rejected';
const routingfinancesql = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
const accountreceivablenotificationmsg = 'Manual Account Receivable for Ancillary payment id (';
const approvednotificationmsg = ') has been approved ';

// Every list endpoint here wraps its rows with the totalcount that the SQL
// functions carry on every row. Shared so the identical block is not repeated
// per endpoint.
const withCount = rows => ({
    'data': rows,
    'count': (rows !== null && rows.length > 0) ? rows[0].totalcount : 0
});

// Shared failure path for the read endpoints: log locally, then rethrow so the
// caller still sees a failed request.
const logAndRethrow = err => {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
};

module.exports = function(Tb_receivable_detail) {

    Tb_receivable_detail.remoteMethod('getproviderclientsearch', {
        http: {
                path: '/getproviderclientsearch',
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

    Tb_receivable_detail.getproviderclientsearch = function(request,reqctx)
    {  
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
            var insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            var inputjson = request.where;
            var pagesize = request.limit;
            var pagenumber = request.page;
            inputjson.enteredby = insertedby;
            inputjson.pagesize = pagesize;
            inputjson.pagenumber = pagenumber;
          const sql = 'select * from tb_providersearch($1)';
          return util.executeDBQuery(sql,[inputjson])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    //
    
    Tb_receivable_detail.remoteMethod('getProviderOverPaymentList', {
     accepts : {
    arg : 'filter',
    type : 'Object',
    http : {
    source : 'query'
    },
    required : true
    },
    http : {
    path: '/getProviderOverPaymentList',
    verb : 'get'
    },
    returns : {
    type : 'Object',
    root : true
    }
    });


    Tb_receivable_detail.getProviderOverPaymentList = function(request)
    {  
 
          const sql = 'select * from tb_provideroverpaymentList($1,$2,$3,$4)';
          return util.executeDBQuery(sql,[request.where.providerid,request.where.client_id,request.page,request.limit])
        .then(data => {
            var result={};
            if(data.length >0)
            {
                
                result={
                   data: data,
                   totalamount :data[0].totalamount,
                   totalreceivable_balance_no : data[0].totalreceivable_balance_no,
                   under_payment : data[0].under_payment
            }
            return result;
        }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };


    Tb_receivable_detail.remoteMethod('updateProviderOverPaymentList', {
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
    http: { "verb": "patch", "path": "/updateProviderOverPaymentList/:id" },
    returns: {
        type: 'Object',
        root: true
    }
});


	Tb_receivable_detail.updateProviderOverPaymentList = async function (id,request,reqctx) {
		const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
		var _email = util.getSecurityDetails(request,reqctx).email;
		var requestuserinfo = { 'token': '','email': _email };
		var fullname;
		await util.getuserinfo(requestuserinfo).then(data => {
			fullname = data.fullname;
		});
		request.create_user_id = 'Finance';
		LOGGER.debug(request.create_user_id);
		request.update_user_id = suserid;
		var mailtouser;
		if (request.intakeserviceid == null && request.intakeserviceid == undefined) {
			request.intakeserviceid = '';
		}
		return Tb_receivable_detail.findById(id,{
			fields: ['receivable_detail_id','amount_no','receivable_balance_no','receivable_id','update_user_id']
		}).then(data => {
			if (data) {
				mailtouser = data.update_user_id;
				LOGGER.debug(mailtouser);
				const notify = getNotificationObject(request, data, fullname, id, suserid, reqctx);
				request = notify.request;
				var nofiticationJson = notify.nofiticationJson;
			}
			return Tb_receivable_detail.updateAll({ receivable_detail_id: id },request).then(_data => {
					return _data;
			}).then(_data => {
				return app.models.Tb_receivable_collection_status.updateAll({ receivable_detail_id: id },{ delete_sw: 'Y',active_sw: 'N' })
			}).then(data2 => {
				request.receivable_detail_id = id;
				request.active_sw = 'Y';
				return app.models.Tb_receivable_collection_status.create(request)
					.then(_data1 => {
						const sql = 'select * from checkupdatePIF($1)';
						return util.executeDBQuery(sql,[id])
							.then(_data => {
								return _data;
							})
							.then(data1 => {

								if (request.eventcode == "FNSWO" && (request.write_off_approval_status === '3045' || request.write_off_approval_status === '3047' || request.write_off_approval_status === '3281')) {
											const noty = getnofiticationText(request);
											var status = noty.status;
											var notifymsg = noty.notifymsg;
											var routeddescription = noty.routeddescription;
											var comments = noty.comments;

										var eventcode = request.eventcode;

										//if(true) {                                    //SonarQube fix commented this as it always evaluates true

										return util.executeDBQuery(routingfinancesql,[id,suserid,eventcode,status,comments,request.assignedtoid,false,false,false,notifymsg,routeddescription,request.intakeserviceid])
											.then(_data => {
												return _data;
											})
											.then(_data => {
												return receivabledetailhistory(request, id, suserid, mailtouser, nofiticationJson);
											})
											.catch(err => {
												LOGGER.error(err);
												return err;
											})
										// });  


										//} 

								}

								return data1;
								//  
							})
							.catch(err => {
								LOGGER.error(err);
								return err;
							})
					})
			})
		})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	}

	function getNotificationObject(request, data, fullname, id, suserid, reqctx){
		const nofiticationJson = {};
		switch(request.write_off_approval_status) {
			case '3047':
				request.approved_by = suserid;
				request.receivable_balance_no = data.receivable_balance_no - request.receivable_balance_amount;
				LOGGER.debug(request.collection_status_cd == '775')
				if (request.collection_status_cd == '775') {

					request.receivable_balance_no = 0.00;
				}

				request.written_off_request_amount_no = request.receivable_balance_amount;
				nofiticationJson.securityusersid = data.update_user_id;
				nofiticationJson.usernotificationtypekey = "System";
				nofiticationJson.objectid = id;
				nofiticationJson.subject = 'Write-Off Request for " (Receivable Id : ' + data.receivable_id + ') " has been approved by  "' + fullname + '"';
				nofiticationJson.priorityleveltypekey = "Normal";
				nofiticationJson.body = newwriteoffnotificationmsg + data.receivable_id + ') " has been approved by  "' + fullname + '"';

				app.models.Usernotification.Add(nofiticationJson,reqctx);
				break;
			case '3045':
				request.write_off_request_user_id = suserid;
				request.written_off_amount_no = request.receivable_balance_amount;
				nofiticationJson.securityusersid = request.assignedtoid;
				nofiticationJson.usernotificationtypekey = "System";
				nofiticationJson.objectid = id;
				nofiticationJson.subject = newwriteoffnotificationmsg + data.receivable_id + ') " has been assigned by  "' + fullname + '"';
				nofiticationJson.priorityleveltypekey = "Normal";
				nofiticationJson.body = newwriteoffnotificationmsg + data.receivable_id + ') " has been assigned by  "' + fullname + '"';

				app.models.Usernotification.Add(nofiticationJson,reqctx);
				//email send 
				email.SendEmailForFinance(request.assignedtoemail,nofiticationJson.subject,nofiticationJson.body);
				break;
		}
		return {
			nofiticationJson,
			request
		}
	}

	function getnofiticationText(request){
		let status = 0;
		let notifymsg = '';
		let routeddescription = '';
		let comments = '';
		switch(request.write_off_approval_status) {
			case '3045':
				status = 30;
				notifymsg = 'Write off request  Submitted for review';
				routeddescription = 'Write off request  Submitted for review';
				comments = 'Write off request   Submitted for review';
				break;
			case '3047':
				status = 33;
				notifymsg = 'Write off request  Approved ';
				routeddescription = 'Write off request Approved';
				comments = 'Write off request Approved';
				break;
			case '3281':
				status = 34;
				notifymsg = writeoffrejectednotificationmsg;
				routeddescription = writeoffrejectednotificationmsg;
				comments = writeoffrejectednotificationmsg;
				break;
		}
		return {
			status,notifymsg,routeddescription,comments
		}
	}

	function receivabledetailhistory(request, id, suserid, mailtouser, nofiticationJson){
		if (request.write_off_approval_status === '3047' || request.write_off_approval_status === '3281') {
			const sql = 'select * from receivabledetailhistory($1,$2) ';
			return util.executeDBQuery(sql,[id,suserid])
				.then(data => {
					LOGGER.info(data);
					return data;
				})
				.catch(err => {
					LOGGER.error(err)
					return err;
				})
		}

		if (request.write_off_approval_status === '3047') {
			const sql = 'select email from muser where securityusersid=$1 ';
			LOGGER.debug(mailtouser);
			return util.executeDBQuery(sql,[mailtouser])
				.then(data => {
					return data;
				})
				.then(data => {
					if (data.length > 0) {
						email.SendEmailForFinance(data[0].email,nofiticationJson.subject,nofiticationJson.body);
					}
					return data;
				}).catch(err => {
					LOGGER.error(err)
					return err;
				});
		}
		return data;
	}

Tb_receivable_detail.remoteMethod('getOverPaymentList', {
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

Tb_receivable_detail.getOverPaymentList=(request)=>{
    var pageno = request.page;
    var pagesize = request.limit;

   var sql= "select * from overpaymenthistorylistdetails($1,$2,$3)";
    return util.executeDBQuery(sql,[request.where.providerid,pagesize,pageno])
.then(withCount)
.catch(logAndRethrow);

};



Tb_receivable_detail.getOverPaymentListDetails=(request)=>{
            const pageno = request.page;
            const pagesize = request.limit;
            var sql= 'select * from overpaymenthistory($1,$2,$3,$4)';
            return util.executeDBQuery(sql,[request.where.paymentdetailid,request.where.providerid, pagesize, pageno])
        .then(withCount)
        .catch(logAndRethrow);

        };

       
        
        Tb_receivable_detail.remoteMethod('getOverPaymentListDetails', {
                accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                source : 'query'
                },
                required : true
                },
                http : {
                path: '/getOverPaymentListDetails',
                verb : 'get'
                },
                returns : {
                type : 'Object',
                root : true
                }
                });

                Tb_receivable_detail.remoteMethod('accreceivableprovidersearch', {
                    http: {
                            path: '/accreceivableprovidersearch',
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
            
        Tb_receivable_detail.accreceivableprovidersearch = function(request,reqctx)
        {    
            let suserid = undefined;
            if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            suserid = reqctx.req.headers.securityusersid
            } 
                var insertedby = (request && request.securityuserid?request.securityuserid:suserid);
                var inputjson = request.where;
                var pagesize = request.limit;
                var pagenumber = request.page;
                inputjson.enteredby = insertedby;
                inputjson.pagesize = pagesize;
                inputjson.pagenumber = pagenumber;
                const sql = 'select * from accreceivableprovidersearch($1)';
                return util.executeDBQuery(sql,[inputjson])
            .then(data => util.encryptresponse(data))
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        };

                Tb_receivable_detail.getpaymenthistory=(request)=>{
                    const pageno = request.page;
                    const pagesize = request.limit;
                    var sql= 'select * from getpaymenthistory($1,$2,$3)';
                    return util.executeDBQuery(sql,[request.where.provider_id, pagesize, pageno])
                .then(withCount)
                .catch(logAndRethrow);
                            
                };
        
               
                
                Tb_receivable_detail.remoteMethod('getpaymenthistory', {
                        accepts : {
                        arg : 'filter',
                        type : 'Object',
                        http : {
                        source : 'query'
                        },
                        required : true
                        },
                        http : {
                        path: '/getpaymenthistory',
                        verb : 'get'
                        },
                        returns : {
                        type : 'Object',
                        root : true
                        }
                        });

                        
                Tb_receivable_detail.getauditlog=(request)=>{
                    const pageno = request.page;
                    const pagesize = request.limit;
                    var sql= 'select * from sp_audit_log_change_history($1,$2,$3,$4)';
                    return util.executeDBQuery(sql,[request.where.screenid, pagesize, pageno, request.where.screen])
                .then(withCount)
                .catch(logAndRethrow);
                };
        
               
                
                Tb_receivable_detail.remoteMethod('getauditlog', {
                        accepts : {
                        arg : 'filter',
                        type : 'Object',
                        http : {
                        source : 'query'
                        },
                        required : true
                        },
                        http : {
                        path: '/getauditlog',
                        verb : 'get'
                        },
                        returns : {
                        type : 'Object',
                        root : true
                        }
                        });

                        
                        
                Tb_receivable_detail.get_audit_log_placement_validation=(request)=>{
                    const pageno = request.page;
                    const pagesize = request.limit;
                    var sql= 'select * from SP_Audit_Log_Placement_Validation($1,$2,$3)';
                    return util.executeDBQuery(sql,[request.where,pageno,pagesize])
                .then(withCount)
                .catch(logAndRethrow);
                };
        
               
                
                Tb_receivable_detail.remoteMethod('get_audit_log_placement_validation', {
                        accepts : {
                        arg : 'filter',
                        type : 'Object',
                        http : {
                        source : 'query'
                        },
                        required : true
                        },
                        http : {
                        path: '/get_audit_log_placement_validation',
                        verb : 'get'
                        },
                        returns : {
                        type : 'Object',
                        root : true
                        }
                        });

                              
                Tb_receivable_detail.get_audit_log_account_receivables=(request)=>{
                    const pageno = request.page;
                    const pagesize = request.limit;
                    var sql= 'select * from SP_Audit_Log_Account_Receivables($1,$2,$3)';
                    return util.executeDBQuery(sql,[request.where,pageno,pagesize])
                .then(withCount)
                .catch(logAndRethrow);
                };
        
               
                
                Tb_receivable_detail.remoteMethod('get_audit_log_account_receivables', {
                        accepts : {
                        arg : 'filter',
                        type : 'Object',
                        http : {
                        source : 'query'
                        },
                        required : true
                        },
                        http : {
                        path: '/get_audit_log_account_receivables',
                        verb : 'get'
                        },
                        returns : {
                        type : 'Object',
                        root : true
                        }
                        });

                                 
                Tb_receivable_detail.get_audit_log_system_adjustments=(request)=>{
                    const pageno = request.page;
                    const pagesize = request.limit;
                    var sql= 'select * from SP_Audit_Log_System_Adjustments($1,$2,$3)';
                    return util.executeDBQuery(sql,[request.where,pageno,pagesize])
                .then(withCount)
                .catch(logAndRethrow);
                };
        
               
                
                Tb_receivable_detail.remoteMethod('get_audit_log_system_adjustments', {
                        accepts : {
                        arg : 'filter',
                        type : 'Object',
                        http : {
                        source : 'query'
                        },
                        required : true
                        },
                        http : {
                        path: '/get_audit_log_system_adjustments',
                        verb : 'get'
                        },
                        returns : {
                        type : 'Object',
                        root : true
                        }
                        });

    //add manual receivable for ancilary payments

    
    Tb_receivable_detail.remoteMethod('addManualReceivable', {
        http: {
                path: '/addManualReceivable',
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

	Tb_receivable_detail.addManualReceivable = function (request,reqctx) {
		const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
		var inputjson = request;
		inputjson.securityuserid = suserid;
		const sql = 'select * from sp_add_manual_receivable($1)';
		return util.executeDBQuery(sql,[inputjson])
			.then(data => {
				let notifymsg = '';
				let routeddescription = '';
				let comments = '';
				if (request.eventcode === 'MANREC') {
					if (request.status === 73) //Forwarded to Case Supervisor
					{
						notifymsg = 'Manual Account Receivable Request for Ancillary payment id (' + request.payment_id + ') ';
						routeddescription = 'Manual Account Receivable Request for Ancillary payment id (' + request.payment_id + ') ';
						comments = 'Manual Account Receivable Request';
					}
					else if (request.status === 74) //Forwarded to Finance worker
					{
						notifymsg = accountreceivablenotificationmsg + request.payment_id + approvednotificationmsg;
						routeddescription = accountreceivablenotificationmsg + request.payment_id + approvednotificationmsg;
						comments = 'Manual Account Receivable Approved';
					}
				}
				var sql1 = routingfinancesql;
				if (request.intakeserviceid === null && request.intakeserviceid === undefined) {
					request.intakeserviceid = '';
				}
				var receivable_detail_id = '';
				if (data.length > 0) {
					receivable_detail_id = data[0].sp_add_manual_receivable;
				}
				return util.executeDBQuery(sql1,[receivable_detail_id,suserid,request.eventcode,request.status,comments,request.assignedtoid,false,false,false,notifymsg,routeddescription,request.intakeserviceid])
					.then(_data => {
						LOGGER.info(_data);
						return _data;
					})
					.catch(err => {
						LOGGER.error(err);
						return err;
					})
				//  return data;
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};

    
    
    Tb_receivable_detail.remoteMethod('approveManualReceivable', {
        http: {
                path: '/approveManualReceivable',
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

    Tb_receivable_detail.approveManualReceivable = function(request,reqctx)
    {  const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
                if(request.eventcode === 'MANREC')
        {

      if(request.status === 74) //Forwarded to Finance worker
    {
    var notifymsg = accountreceivablenotificationmsg+request.payment_id+approvednotificationmsg;
    var routeddescription = accountreceivablenotificationmsg+request.payment_id+approvednotificationmsg;
    var comments = 'Manual Account Receivable Approved';
    }
}
var sql = routingfinancesql;
request.intakeserviceid = util.nullcheck(request.intakeserviceid);

return util.executeDBQuery(sql, [request.receivable_detail_id, suserid, request.eventcode, request.status, comments, request.assignedtoid, false, false, false, notifymsg,routeddescription,request.intakeserviceid])
.then(data => {
        var approvalStatus = '3047';
        if(request.status === 75)
        {
            approvalStatus = '3281'; 
        }
        var inputjson = request;
        inputjson.securityuserid = suserid;
      const sql1 = "update tb_receivable_detail set approval_status_cd =$2 ,action_dt = now()::date where receivable_detail_id = $1";
      return util.executeDBQuery(sql1,[request.receivable_detail_id,approvalStatus]);
})
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    
    //write-off dashboard

    Tb_receivable_detail.remoteMethod('getproviderclientsearchDashboard', {
        http: {
                path: '/getproviderclientsearchDashboard',
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

    Tb_receivable_detail.getproviderclientsearchDashboard = function(request,reqctx)
    {  
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
            var insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            var inputjson = request.where;
            var pagesize = request.limit;
            var pagenumber = request.page;
            inputjson.enteredby = insertedby;
            inputjson.pagesize = pagesize;
            inputjson.pagenumber = pagenumber;
          const sql = 'select * from tb_providersearch_dashboard($1)';
          return util.executeSecondaryNodeDBQuery(sql,[inputjson])
            .then(data => util.encryptresponse(data))
            .then(data => { return data; })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    
    Tb_receivable_detail.remoteMethod('getproviderclientsearchDashboardWriteOff', {
        http: {
                path: '/getproviderclientsearchDashboardWriteOff',
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

    Tb_receivable_detail.getproviderclientsearchDashboardWriteOff = async function(request,reqctx)
    {  
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            suserid = reqctx.req.headers.securityusersid
        } 
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		}  
        var requestuserinfo = {'token': '', 'email': _email};
        var role ;
        await util.getuserinfo(requestuserinfo).then (data => {
          role = data.roletypekey;
        });  
 
            var insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            var inputjson = request.where;
            var pagesize = request.limit;
            var pagenumber = request.page;
            inputjson.enteredby = insertedby;
            inputjson.pagesize = pagesize;
            inputjson.pagenumber = pagenumber;
            inputjson.roletypekey = role;
          const sql = 'select * from tb_providersearch_dashboard_wirteoff($1)';
          return util.executeSecondaryNodeDBQuery(sql,[inputjson])
            .then(data => {
              return data;
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    
//error correction dashboard 
Tb_receivable_detail.remoteMethod('listManualReceivableDashboard', {
    http: {
            path: '/listManualReceivableDashboard',
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

Tb_receivable_detail.listManualReceivableDashboard = function(request,reqctx)
{ 
    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
const dataQuery = "select * from sp_manual_receivable_dashboard ($1,$2,$3,$4,$5)";
return util.executeDBQuery(dataQuery, [request.routingstatustypeid,(request && request.securityuserid?request.securityuserid: suserid),request.page,request.limit,request.statusval])
.then(data => ({ data: data }))
.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

Tb_receivable_detail.getpaymenthistorybyclientid=(request)=>{
    const pageno = request.page;
    const pagesize = request.limit;
    var sql= 'select * from getpaymenthistorybyclientid($1,$2,$3)';
    return util.executeDBQuery(sql,[request.where, pagesize, pageno])
    .then(withCount)
    .catch(logAndRethrow);
    };

    Tb_receivable_detail.remoteMethod('getpaymenthistorybyclientid', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
            source : 'query'
        },
        required : true
        },
        http : {
            path: '/getpaymenthistorybyclientid',
            verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
    });

    
Tb_receivable_detail.getpaymentdetails=(request)=>{
    const pageno = request.page;
    const pagesize = request.limit;
    var sql= 'select * from getpaymentdetails($1,$2,$3,$4,$5,$6)';
    return util.executeDBQuery(sql,[request.where.paymentid,pagesize, pageno,request.where.sortorder,
            request.where.sortcolumnm,request.where.clientid])
    .then(withCount)
    .catch(logAndRethrow);
    };

    Tb_receivable_detail.remoteMethod('getpaymentdetails', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
            source : 'query'
        },
        required : true
        },
        http : {
            path: '/getpaymentdetails',
            verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
    });


    
    
    Tb_receivable_detail.remoteMethod('list', {
        http: {
            path: '/list',
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

    Tb_receivable_detail.list =(request)=> {
        if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
        var receivable_detail_id = request.where.receivable_detail_id;
        var sql = `select count(1) over() as totalcount,up.fullname as requested_by,up1.fullname as approved_by
        ,rdh.write_off_action_date as approved_date
        ,rdh.write_off_request_date as requested_date,rdh.written_off_amount_no,rdh.receivable_detail_id,
        case rdh.write_off_approval_status when '3047' then 'Approved' when '3281' then 'Denied' end as approval_status
        from tb_receivable_detail_history rdh
        inner join routing r on r.objectid = rdh.receivable_detail_id::varchar and r.eventcode = 'FNSWO'
        left join userprofile up on up.securityusersid = rdh.write_off_request_user_id
        left join userprofile up1 on up1.securityusersid = r.tosecurityusersid
        where receivable_detail_id=$1 
        group by up.fullname,up1.fullname ,rdh.write_off_action_date ,rdh.write_off_request_date ,rdh.written_off_amount_no,rdh.receivable_detail_id
        ,rdh.write_off_approval_status
         order by rdh.write_off_action_date desc
        limit $2 offset $3`;
		return util.executeDBQuery(sql, [receivable_detail_id, request.limit, request.skip])
		.then(withCount)
		.catch(logAndRethrow);
    };

    Tb_receivable_detail.remoteMethod('listFiscalunitTicklersDashboard', {
        http: {
                path: '/listFiscalunitTicklersDashboard',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });
    
    Tb_receivable_detail.listFiscalunitTicklersDashboard = function(request)
    { 
        const dataQuery = "select * from sp_fiscalunitticklers_dashboard($1,$2,$3,$4,$5,$6,$7,$8)";
        return util.executeSecondaryNodeDBQuery(dataQuery, [request.page,request.limit, request.statusval,request.typeval,request.dueval,request.v_county_cd,request.provtype,request.roletypekey])
            .then(data => {
                return { data: data };
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Tb_receivable_detail.remoteMethod('fiscalunitticklersupdate', {
        http: {
                path: '/fiscalunitticklersupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });
    
    Tb_receivable_detail.fiscalunitticklersupdate = function(request)
    { 
        const dataQuery = "select * from fiscalunitticklersupdate($1)";
        return util.executeDBQuery(dataQuery, [request])
        .then(data => ({ data: data }))
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Tb_receivable_detail.receivableColletionStatusList = function(request)
    { 
        const dataQuery = "select * from receivable_colletion_status_list($1)";
        return util.executeDBQuery(dataQuery, [request.where.receivable_detail_id])
        .then(data => ({ data: data }))
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Tb_receivable_detail.remoteMethod('receivableColletionStatusList', {
        http: {
                path: '/receivableColletionStatusList',
                verb: 'get'
        },
        accepts : [ {arg : 'filter',type : 'object',
            http : {source : 'query'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Tb_receivable_detail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_receivable_detail.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_receivable_detail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}