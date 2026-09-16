'use strict';
const LOGGER = require("log4js").getLogger("purchaseAuthorization");
const app = require('../../server/server');
const util = require('../utils/utils');
var email = require('../models/email');

const noaccountmsg = "no account mapped ";
const purchaseauthstr = 'Purchase Authorization (';
const requestedcasestr = ') requested for Case (';
const purchaseauthroutingmsg = 'Purchase Authorization Forwarded to Payment Approval';
const purchaseauthforwardedforpaymentmsg = 'Forwarded to Payment Approval';

module.exports = function (purchaseAauthorization) {
    purchaseAauthorization.purchaseAuthorize = (purchaseAuthorization,reqctx) => {
        const suserid = util.getSecurityDetails(purchaseAuthorization, reqctx).securityuserid;
        var account_type = '';
        if (purchaseAuthorization.fiscalCategoryCd == '7503') {
            account_type = '591';
        }
        else if (purchaseAuthorization.fiscalCategoryCd == '7502') {
            account_type = '590';
        }
        //check child account amount exceed or not
        // var sql= "select count(1) as isexceed, json_object_agg('total_balance_no' ,total_balance_no) balance   from tb_client_account where client_id=$1  and account_type_cd=$2 and status_cd = '592'";
        var sql = "select * from getchildaccouctexists($1,$2)"
        return util.executeDBQuery(sql,[purchaseAuthorization.client_id,account_type])
        .then(data => {
            return data;
        })
        .then(data => {
            if (data.length > 0) {
         
                const isamountcheck = amountcheck(purchaseAuthorization, data);
                
                if (isamountcheck == 1) //account not exists
                {
                    var result1 = {};
                    result1.isexceed = 1;
                    return result1;
                }
                else if (isamountcheck == 5) //account not exists
                {
                    var result2 = {};
                    result2.isexceed = 5;
                    return result2;
                }
                else if (isamountcheck == 2) //account  exists but balance exceeds
                {
                    var result3 = {};
                    result3.isexceed = 2;
                    return result3;
                }
                else {
                    
                    var insertedby = suserid;
                    LOGGER.error('user id>>',insertedby,app.currentUser);
                    let sql1 = "select * from pa_datevalidation($1,$2,$3)"
                    return util.executeDBQuery(sql1,[purchaseAuthorization.startDt,purchaseAuthorization.endDt,purchaseAuthorization.serviceLogId])
                    .then(data1 => {
                        return addupdatepurchaseAuthorization(purchaseAuthorization, data1, suserid, account_type);

                    })
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                }
            }
            else {
                var result4 = {};
                result4 = { isexceed: false,mgs: noaccountmsg,data: data };
                return result4;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    function amountcheck(purchaseAuthorization, data){
        let isamountcheck = 0;
        if (purchaseAuthorization.fiscalCategoryCd === '7503' || purchaseAuthorization.fiscalCategoryCd === '7502') {
            if (data[0].isexceed === 0) {
                isamountcheck = 1;
            }
            else if (data[0].isfinalcount[0].isfinal > 0) {
                isamountcheck = 5;
            }
            else {
                // total_balance_no >= $1  and 
                if (data[0].balance[0].total_balance_no >= purchaseAuthorization.costNo) {
                    isamountcheck = 3;
                }
                else {
                    isamountcheck = 2;
                }

            }
        }
        return isamountcheck;
    }

    function addupdatepurchaseAuthorization(purchaseAuthorization, data, suserid, account_type){
        const dataQuery = `INSERT INTO tb_service_purchase_authorization(service_log_id,start_dt,end_dt,voucher_sw,fiscal_category_cd,modified_fiscal_category_cd,
            justification_tx,cost_no, create_user_id, update_user_id, create_ts, update_ts, dateofpreapproval,cfecareduration) VALUES (
                                 $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14) RETURNING authorization_id`;

        if (data[0].pa_datevalidation) {
            LOGGER.debug('service log id',purchaseAuthorization.serviceLogId);
            return util.executeDBQuery(dataQuery,[
                purchaseAuthorization.serviceLogId,
                purchaseAuthorization.startDt,
                purchaseAuthorization.endDt,
                purchaseAuthorization.voucherSw,
                purchaseAuthorization.fiscalCategoryCd,
                purchaseAuthorization.fiscalCategoryCd,
                purchaseAuthorization.justificationTx,
                purchaseAuthorization.costNo,
                suserid,
                suserid,
                new Date().toISOString(),
                new Date().toISOString(),
                purchaseAuthorization.dateofPreApproval,
                purchaseAuthorization.cfecareduration
            ])
            .then(result => {
                return result;
            })
            .then(result => {
                if (purchaseAuthorization.fiscalCategoryCd == '7503' || purchaseAuthorization.fiscalCategoryCd == '7502') {
                    var sql = "update  tb_service_purchase_authorization set client_account_id=(select client_account_id from tb_client_account where total_balance_no >= $1  and client_id=$2  and account_type_cd=$4 ) where authorization_id = (select authorization_id from tb_service_purchase_authorization where service_log_id=$3 order by authorization_id desc limit 1)";
                    return util.executeDBQuery(sql,[purchaseAuthorization.costNo,purchaseAuthorization.client_id,purchaseAuthorization.serviceLogId,account_type])
                    .then(data2 => {
                        result[0]['isexceed'] = 3;
                        return result[0];
                    })
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                }
                else {
                    result[0]['isexceed'] = 3;
                    return result[0];
                }
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
        else {
            const result = {};
            result['isexceed'] = 4;
            return result;
        }
    }

    purchaseAauthorization.remoteMethod('purchaseAuthorize', {
        http: {
            path: '/purchaseAuthorize',
            verb: 'post'
        },
        accepts: [{
            arg: '',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ]
,
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }

    });


    purchaseAauthorization.getPurchaseAuthorize=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        request.where.roleid = request.where.roletypekey;
        var totalcount = 0;
        var sql= 'select * from get_purchase_auth_fiscal($1,$2,$3)';
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
    purchaseAauthorization.remoteMethod('getPurchaseAuthorize', {
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

    /*
    isexceed = 5 Finanl Disbursement is inprogress for the selected client
    isexceed = 4 Requested purchase authorization is already available on the selected date
    isexceed = 3 Purchase Authorization request saved successfully
    isexceed = 2 Insufficient Client Account balance, please raise a request at lower cost
    isexceed = 1 Account is not available, kindly please add account for the selected client
    */
    function getAccounttype(purchaseAuthorization){
        var account_type = '';
        if (purchaseAuthorization.fiscalCategoryCd === '7503') {
            account_type = '591';
        }
        else if (purchaseAuthorization.fiscalCategoryCd === '7502') {
            account_type = '590';
        }
        return account_type;
    }

    purchaseAauthorization.updatePurchaseAuthorize = (purchaseAuthorization,reqctx) => {
        const suserid = util.getSecurityDetails(purchaseAuthorization,reqctx).securityuserid;
        var account_type = getAccounttype(purchaseAuthorization);
        //check child account amount exceed or not
        var sql = "select count(1) as isexceed, json_object_agg('total_balance_no' ,total_balance_no) balance   from tb_client_account where client_id=$1  and account_type_cd=$2 and status_cd = '592'";
        return util.executeDBQuery(sql,[purchaseAuthorization.client_id,account_type])
            .then(data => {
                return data;
            })
            .then(data => {
                if (data.length > 0) {
                    const isamountcheck = updateamountcheck(purchaseAuthorization,data);
                    if (isamountcheck == 1) //account not exists
                    {
                        const result = {};
                        result.isexceed = 1;
                        return result;
                    }
                    else if (isamountcheck == 2) //account  exists but balance exceeds
                    {
                        const result = {};
                        result.isexceed = 2;
                        return result;
                    }
                    else {

                        const dataQuery = `UPDATE tb_service_purchase_authorization set 
                                            service_log_id = $1,
                                            start_dt = $2,
                                            end_dt = $3,
                                            voucher_sw = $4,
                                            fiscal_category_cd = $5,
                                            justification_tx = $6,
                                            cost_no = $7,
                                            update_user_id = $8,
                                            update_ts = $9,
                                            modified_fiscal_category_cd = $10,
                                            dateofpreapproval = $11
                                            WHERE authorization_id = $12`;

                        var sql2 = "select * from pa_datevalidation($1,$2,$3)"
                        return util.executeDBQuery(sql2,[purchaseAuthorization.startDt,purchaseAuthorization.endDt,purchaseAuthorization.serviceLogId])
                            .then(data3 => {
                                LOGGER.info(data3);
                                return data3;
                            })
                            .then(data4 => {

                                if (data4[0].pa_datevalidation) {
                                    return util.executeDBQuery(dataQuery,[
                                        purchaseAuthorization.serviceLogId,
                                        purchaseAuthorization.startDt,
                                        purchaseAuthorization.endDt,
                                        purchaseAuthorization.voucherSw,
                                        purchaseAuthorization.fiscalCategoryCd,
                                        purchaseAuthorization.justificationTx,
                                        purchaseAuthorization.costNo,
                                        suserid,
                                        new Date().toISOString(),
                                        purchaseAuthorization.fiscalCategoryCd,
                                        purchaseAuthorization.dateofPreApproval,
                                        purchaseAuthorization.authorizationId
                                    ])
                                    .then(result3 => {
                                        return updatepurchaseAuthorization(purchaseAuthorization, account_type);
                                    })
                                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                                }
                                else {
                                    const result4 = {};
                                    result4['isexceed'] = 4;
                                    return result4;
                                }
                            })
                            .catch(err1 => { LOGGER.error('>>>>ERROR:', err1); throw err1; });
                    }
                }
                else {
                    var result5 = {};
                    result5 = { isexceed: false,mgs: noaccountmsg,data: data };
                    return result5;
                }
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    function updatepurchaseAuthorization(purchaseAuthorization, account_type){
        if (purchaseAuthorization.fiscalCategoryCd == '7503' || purchaseAuthorization.fiscalCategoryCd == '7502') {
            var sql = "update  tb_service_purchase_authorization set client_account_id=(select client_account_id from tb_client_account where total_balance_no >= $1  and client_id=$2  and account_type_cd=$4 ) where authorization_id = (select authorization_id from tb_service_purchase_authorization where service_log_id=$3 limit 1)";
            return util.executeDBQuery(sql,[purchaseAuthorization.costNo,purchaseAuthorization.client_id,purchaseAuthorization.serviceLogId,account_type])
                .then(data => {
                    var result6 = {};
                    result6 = { isexceed: 3 };
                    return result6;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
        else {
            var result = {};
            result = { isexceed: 3 };
            return result;
        }
    }

    function updateamountcheck(purchaseAuthorization, data) {
        let isamountcheck = 0;
        if (purchaseAuthorization.fiscalCategoryCd === '7503' || purchaseAuthorization.fiscalCategoryCd === '7502') {
            if (data[0].isexceed === 0) {
                isamountcheck = 1;
            }
            else {
                // total_balance_no >= $1  and 
                if (data[0].balance.total_balance_no >= purchaseAuthorization.costNo) {
                    isamountcheck = 3;
                }
                else {
                    isamountcheck = 2;
                }
            }
        }
        return isamountcheck;
    }
    purchaseAauthorization.remoteMethod('updatePurchaseAuthorize', {
        http: {
            path: '/updatePurchaseAuthorize',
            verb: 'put'
        },
        accepts: [{
            arg: 'purchaseAuth',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }

    });

    //routing for Purchase Authorization 'CWCW - CWSP'
    purchaseAauthorization.remoteMethod('routingPurchaseAuthorization', {
        http: {
                path: '/routingPurchaseAuthorization',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    // Check if a record exists in tb_payment_header table
    const checkExistingPaymentRecords = (authorization_id, provider_id) => {
        const checkRecordSql = `
            SELECT * 
            FROM tb_payment_header 
            WHERE authorization_id = $1
              AND provider_id = $2
              AND delete_sw = 'N'
        `;
        return util.executeDBQuery(checkRecordSql, [authorization_id, provider_id]);
    };
    const handleRoutingProcess = (req, routingDetails, securityId)=> {
        var eventcode = req.eventcode;
        var sql = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        return util.executeDBQuery(sql,[req.authorization_id,req.v_securityusersid,eventcode,req.status,routingDetails.comments,req.assignedtoid,req.bmanualrouting,false,false,routingDetails.notifymsg,routingDetails.routeddescription,req.intakeserviceid,'',req.roletypekey])
            .then(data => {
                LOGGER.info(data);
                return data;
            })
            .then(_data1 => {
                var report_1099_sw = util.nullcheck(req.report_1099_sw);
                var type_1099_cd = util.nullcheck(req.type_1099_cd);
                var store_receipt_id = util.nullcheck(req.store_receipt_id);
                var v_client_acc_id = req.client_account_id ? req.client_account_id : 0;
                var sql3 = 'select * from sp_tb_purchase_authorization($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
                return util.executeDBQuery(sql3,[req.authorization_id,req.status,req.v_securityusersid,req.costno,req.provider_id,req.startDt,req.endDt,req.payment_method_cd,store_receipt_id,type_1099_cd,report_1099_sw,v_client_acc_id])
                    .then(data5 => {
                        LOGGER.info(data5);
                        return data5;
                    })
                    .then(_data2 => {
                       var sql4 = "select * from getemailuser($1,$2,$3,$4,$5,$6,$7)";
                        return util.executeDBQuery(sql4,[req.authorization_id,eventcode,req.assignedtoid,req.roletypekey,req.v_securityusersid,req.status,req.costno])
                            .then(data => {
                                if (data.length > 0) {
                                    data.forEach(userObj => {
                                        var nofiticationJson = {};
                                        nofiticationJson.securityusersid = userObj.securityusersid;
                                        nofiticationJson.usernotificationtypekey = "System";
                                        nofiticationJson.objectid = '';
                                        nofiticationJson.subject = routingDetails.routeddescription;
                                        nofiticationJson.priorityleveltypekey = "Normal";
                                        nofiticationJson.body = routingDetails.notifymsg;
                                        const requestObj = {
                                            req: {
                                                headers: {
                                                    securityusersid: securityId
                                                }
                                            }
                                        };
                                        app.models.Usernotification.Add(nofiticationJson,requestObj);
                                        //email send 
                                        email.SendEmailForFinance(userObj.email,nofiticationJson.subject,nofiticationJson.body);
                                        return data;
                                    });
                                }
                                return data;
                            })
                            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    })
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                }

    purchaseAauthorization.routingPurchaseAuthorization = (request) => {
    
    const securityId = request.v_securityusersid;

    const getRoutingDetails = (req) => {
        let notifymsg = '';
        let routeddescription = '';
        let comments = '';

        switch (req.status) {
            //Forwarded to Case Supervisor
            case 39:
                if (req.fiscalcategorycd === '7108') {
                    notifymsg = purchaseauthstr + req.authorization_id + requestedcasestr + req.case_id + ') for Approval';
                    routeddescription = 'Purchase Authorization Forwarded to SSA Placement Manager';
                    comments = 'Forwarded to SSA Placement Manager';
                } else {
                    notifymsg = purchaseauthstr + req.authorization_id + requestedcasestr + req.case_id + ') for Approval';
                    routeddescription = 'Purchase Authorization Forwarded to Case Supervisor';
                    comments = 'Forwarded to Case Supervisor';
                }
                break;
            //Forwarded to Fiscal Supervisor
            case 40:
            case 44:
                notifymsg = purchaseauthstr + req.authorization_id + requestedcasestr + req.case_id + ') for Funding Approval';
                routeddescription = 'Purchase Authorization Forwarded to Funding Approval';
                comments = 'Forwarded to Funding Approval';
                break;
            //Forwarded to fiscal Supervisor for payment approvel
            case 41:
            case 43:                
                //Forwarded  Director of finance to FS
                notifymsg = purchaseauthstr + req.authorization_id + requestedcasestr + req.case_id + ') for Payment Approval';
                routeddescription = purchaseauthroutingmsg;
                comments = purchaseauthforwardedforpaymentmsg;
                break;
            //Forwarded to Director of finance or Program Manager
            case 42:
                if (req.roletypekey !== 'LDSSPM') {
                    notifymsg = purchaseauthstr + req.authorization_id + requestedcasestr + req.case_id + ') for Director Approval';
                    routeddescription = 'Purchase Authorization Forwarded to Director Approval';
                    comments = 'Forwarded to Director Approval';
                } else {
                    notifymsg = purchaseauthstr + req.authorization_id + requestedcasestr + req.case_id + ') for Program Manager Approval';
                    routeddescription = 'Purchase Authorization Forwarded to Program Manager Approval';
                    comments = 'Forwarded to Program Manager Approval';
                }
                break;
        }

        return { notifymsg, routeddescription, comments }
    }
    

    const routingDetail = getRoutingDetails(request);

    return checkExistingPaymentRecords(request.authorization_id, request.provider_id)
        .then(existingRecords => {
            if (existingRecords.length > 0) {
                return { message: 'PAYMENT_EXISTS', status: 'error', code: 409 };
            }
            return handleRoutingProcess(request, routingDetail, securityId);
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

//routing for Purchase Authorization  by fiscal category group
purchaseAauthorization.remoteMethod('routingPurchaseAuthorizationbyCategoryCode', {
    http: {
            path: '/routingPurchaseAuthorizationbyCategoryCode',
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


    purchaseAauthorization.routingPurchaseAuthorizationbyCategoryCode = (request,reqctx) => {
        const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
        let notifymsg = '';
        let routeddescription = '';
        let comments = '';
        if (request.status === 41) //Forwarded to fiscal Supervisor for payment approvel
        {
            notifymsg = purchaseauthstr + request.authorization_id + ') requested for Payment Approval';
            routeddescription = purchaseauthroutingmsg;
            comments = purchaseauthforwardedforpaymentmsg;
        }

        //return request.fiscalcategorycd.forEach(categorycd => {
        var sql = 'select * from sp_get_authidbyfiscalcategory($1,$2)';

        return util.executeDBQuery(sql,[suserid,request.fiscalcategorycd])
            .then(data => {
                LOGGER.info(data);
                return data;
            })
            .then(data => {

                if (data.length > 0) {

                    data.forEach(authorization => {
                        var eventcode = request.eventcode;
                        var sql5 = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
                        return util.executeDBQuery(sql5,[authorization.authorization_id,suserid,eventcode,request.status,comments,request.assignedtoid,false,false,false,notifymsg,routeddescription,authorization.intakeserviceid,'',request.roletypekey])
                            .then(data7 => {
                                LOGGER.info(data7);
                                return data7;
                            })
                            .then(_data => {
                                var report_1099_sw = util.nullcheck(request.report_1099_sw);
                                var type_1099_cd = util.nullcheck(request.type_1099_cd);
                                var store_receipt_id = util.nullcheck(request.store_receipt_id);
                                var v_client_acc_id = checkclientaccountid(request.client_account_id);
                                var sql6 = 'select * from sp_tb_purchase_authorization($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
                                return util.executeDBQuery(sql6,[authorization.authorization_id,request.status,suserid,request.costno,request.provider_id,request.startDt,request.endDt,request.payment_method_cd,store_receipt_id,type_1099_cd,report_1099_sw,v_client_acc_id])
                                    .then(data8 => {
                                        var sql7 = "select * from getemailuser($1,$2,$3,$4,$5,$6,$7)";
                                        return util.executeDBQuery(sql7,[request.authorization_id,eventcode,request.assignedtoid,request.roletypekey,suserid,request.status,request.costno])
                                            .then(data9 => {
                                                if (data9.length > 0) {
                                                    data9.forEach(userObj => {
                                                        var nofiticationJson = {};
                                                        nofiticationJson.securityusersid = userObj.securityusersid;
                                                        nofiticationJson.usernotificationtypekey = "System";
                                                        nofiticationJson.objectid = '';
                                                        nofiticationJson.subject = routeddescription;
                                                        nofiticationJson.priorityleveltypekey = "Normal";
                                                        nofiticationJson.body = notifymsg;
                                                        //  var ins =	app.models.Usernotification.Add(nofiticationJson);
                                                        //email send 
                                                        email.SendEmailForFinance(userObj.email,nofiticationJson.subject,nofiticationJson.body);
                                                    });
                                                }
                                                return data9;
                                            })
                                            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                                    })
                                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                                //return data
                            })
                            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                    })
                }
                else {
                    return data;
                }
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        //})
        // }
    }

    function checkclientaccountid(value){
        return value ? value : 0;
    }

//list approvel tabs for finance supervisors
purchaseAauthorization.remoteMethod('listPayableApprovels', {
    accepts : [{
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
        path: '/listPayableApprovels',
        verb : 'get'
    },
    returns : {
        type : 'string',
        root : true
    }
});

// All four approval procedures read the grid's column filters out of the json
// argument and assign them straight into typed locals -- authorization_id and
// service_log_id are int/bigint, cost_no is numeric -- so any non-numeric text
// raises 22P02 before a row is read. The column filters are plain text inputs
// (custom-search.component.html), so typing a name into 'Authorization ID' or
// '1,200.00' into 'Cost Not To Exceed' is enough. error-logger flattens 22P02
// into a bare 400 with nothing naming the field, so screen them here.
const APPROVAL_INT_FIELDS = ['authorization_id', 'service_log_id'];

function hasSearchValue(value) {
    return value !== null && value !== undefined && String(value).trim() !== '';
}

function approvalBadRequest(message) {
    const err = new Error(message);
    err.statusCode = 400;
    return Promise.reject(err);
}

purchaseAauthorization.listPayableApprovels = (request,reqctx) => {
    const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
    LOGGER.debug(suserid+"(request && request.securityuserid?request.securityuserid: suserid)");
    if (!request || !request.where) {
        return approvalBadRequest('listPayableApprovels requires a filter with a where clause');
    }
    if (request.where.user_id === null || request.where.user_id === undefined) {
        request.where.user_id = suserid;
    }

    const invalidInt = APPROVAL_INT_FIELDS.find(field =>
        hasSearchValue(request.where[field]) && !/^\d+$/.test(String(request.where[field]).trim()));
    if (invalidInt) {
        return approvalBadRequest(invalidInt + ' must be numeric');
    }

    // cost_no is a currency column, so accept the grouped and prefixed forms the
    // text input permits and search on the bare number rather than rejecting.
    if (hasSearchValue(request.where.cost_no)) {
        const costNo = String(request.where.cost_no).trim().replace(/[$,\s]/g, '');
        if (!/^\d+(\.\d+)?$/.test(costNo)) {
            return approvalBadRequest('cost_no must be numeric');
        }
        request.where.cost_no = costNo;
    }

    var sql ='';
    var params = [];
    switch (request.where.approveltype) {
        case 'funding':
            sql ='select * from fundingapprovalslist($1,$2,$3,$4,$5,$6,$7,$8,$9)';
            params = [request.where.user_id,request.where.roletypekey ,request.where.status,request.page,request.limit,request.where.sortcolumn,request.where.sortorder,JSON.stringify(request.where),request.where.assigned_pa];
          break;
        case 'payment':
            sql ='select * from paymentapprovalslist($1,$2,$3,$4,$5,$6,$7,$8,$9)';
            params = [request.where.user_id,request.where.roletypekey ,request.where.status,request.page,request.limit,request.where.sortcolumn,request.where.sortorder,JSON.stringify(request.where),request.where.assigned_pa];
          break;
        case 'direcort':
            sql ='select * from sp_list_payable_approvels($1,$2,$3,$4,$5,$6,$7,$8,$9)';
            params = [request.where.user_id,request.where.roletypekey ,request.where.status,request.page,request.limit,request.where.sortcolumn,request.where.sortorder,JSON.stringify(request.where),request.where.assigned_pa];
          break;
        case 'pmanager':
            sql ='select * from programmanagerapprovallist($1,$2,$3,$4,$5,$6,$7,$8,$9)';
            params = [request.where.user_id,request.where.roletypekey,request.where.status,request.page,request.limit,request.where.sortcolumn,request.where.sortorder,JSON.stringify(request.where),request.where.assigned_pa];
          break;
        default:
          // Without this, an unrecognised approveltype left sql as '' and sent an
          // empty query to Postgres, which comes back as an empty result rather
          // than an error -- the caller sees a blank grid and no reason for it.
          return approvalBadRequest('unrecognised approveltype: ' + request.where.approveltype);
      }

    return util.executeDBQuery(sql, params)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

//sp_list_payable_approvels_history

//list approvel tabs for finance supervisors
purchaseAauthorization.remoteMethod('listPayableApprovelsHistory', {
    accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
            source : 'query'
        },
        required : true
    },
    http : {
        path: '/listPayableApprovelsHistory',
        verb : 'get'
    },
    returns : {
        type : 'string',
        root : true
    }
});

purchaseAauthorization.listPayableApprovelsHistory = (request) => {
        var sql ='select * from sp_list_payable_approvels_history($1)';
        return util.executeSecondaryNodeDBQuery(sql, [request.where.authorization_id])
                .then(data => {
                    return data;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};


purchaseAauthorization.validateAmountPerFiscalYear = (request)=>{
    request.where.roleid = request.where.roletypekey;
    var sql= `select coalesce(sum(cost_no), 0) from tb_service_purchase_authorization where delete_sw = 'N'and btrim(fiscal_category_cd) = '4180'
    and coalesce(sprvsr_approval_status_cd, '') = '3047' and start_dt between (case when date_part('month', $1::date)::integer <= 9 then
    ((date_part('year', $1::date) - 1) || '-10-01')::date else (date_part('year', $1::date ) || '-10-01')::date end)
    and (case when date_part('month', $1::date)::integer <= 9 then ((date_part('year', $1::date )) || '-09-30')::date else ((date_part('year', $1::date) + 1 ) || '-09-30')::date end)`;
    return util.executeDBQuery(sql,[request.where.startDate])
    .then(data => data)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};

purchaseAauthorization.remoteMethod('validateAmountPerFiscalYear', {
    accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
            source : 'query'
        },
        required : true
    },
    http : {
        path: '/validatefiscalyearamount',
        verb : 'get'
    },
    returns : {
        type : 'string',
        root : true
    }
});



purchaseAauthorization.remoteMethod('listGroupbyCategoryCode', {
    accepts : [{
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
        path: '/listGroupbyCategoryCode',
        verb : 'get'
    },
    returns : {
        type : 'string',
        root : true
    }
});

purchaseAauthorization.listGroupbyCategoryCode = (request,reqctx) => {
    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        var sql ='select * from sp_get_totalamount_fiscalcategory($1,$2)';
        return util.executeSecondaryNodeDBQuery(sql, [(request && request.securityuserid?request.securityuserid: suserid),request.where.roletypekey])
                .then(data => {
                    return data;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

purchaseAauthorization.remoteMethod('updatepurchaseauthorization', {
    http: {
            path: '/updatepurchaseauthorization',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'string',
        root : true
    }
});


    purchaseAauthorization.updatepurchaseauthorization = (request) => {
        var account_type = '';
        var purchaseAuthorization = request.where;
        purchaseAuthorization.fiscalCategoryCd = purchaseAuthorization.fiscal_category_cd;
        account_type = getAccountType(request);
        //check child account amount exceed or not
        // var sql= "select count(1) as isexceed, json_object_agg('total_balance_no' ,total_balance_no) balance   from tb_client_account where client_id=$1  and account_type_cd=$2 and status_cd = '592'";
        var sql = "select * from getchildaccouctexists($1,$2)";
        return util.executeDBQuery(sql,[request.client_id,account_type])
            .then(data => {
                LOGGER.info(data);
                return data;
            })
            .then(data => {
                if (data.length > 0) {
                    const isamountcheck = amtCheck(request, data);
                    if (isamountcheck === 1) //account not exists
                    {
                        var result = {};
                        result.isexceed = 1;
                        return result;
                    }
                    else if (isamountcheck === 2) //account  exists but balance exceeds
                    {
                        var result7 = {};
                        result7.isexceed = 2;
                        return result7;
                    }
                    else {

                        var totalcount = 0;
                        var sql8 = 'select * from updatepurchaseauthorization($1)';
                        return util.executeDBQuery(sql8,[JSON.stringify(request)])
                            .then(data8 => {
                                if (data8 !== null && data8.length > 0) { totalcount = data8[0].totalcount; }
                                var result8;
                                result8 = {
                                    'data': data8,
                                    'count': totalcount
                                };
                                return result8;
                            })
                            .then(result16 => {
                                return updateServicePurchaseAuthorization(request, account_type);
                            })
                            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    }
                    // else
                    // {
                    // var result={};
                    // result={isexceed:4};               
                    // return result;
                    // }
                    // })
                    //.catch(err => util.logError(err));
                }
                else {
                    var result9 = {};
                    result9 = { isexceed: false,mgs: noaccountmsg,data: data };
                    return result9;
                }
            })
            //.then(data => data)
            .catch(err2 => { LOGGER.error('>>>>ERROR:', err2); throw err2; });
    };

    function getAccountType(request){
        let account_type = '';
        if (request.fiscal_category_cd == '7503') {
            account_type = '591';
        }
        else if (request.fiscal_category_cd == '7502') {
            account_type = '590';
        }
        return account_type;
    }

    function updateServicePurchaseAuthorization(request, account_type){
        if (request.fiscal_category_cd == '7503' || request.fiscal_category_cd == '7502') {
            var sql = `update  tb_service_purchase_authorization set 
                        client_account_id=
                        (select client_account_id from tb_client_account where  
                        client_id=$1  and account_type_cd=$3 and status_cd = '592' ) 
                        where authorization_id = $2
                        `;

            return util.executeDBQuery(sql,[request.client_id,request.authorization_id,account_type])
                .then(data10 => {
                    var result10 = {};
                    result10 = { isexceed: 3 };
                    return result10;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
        else {
            var result = {};
            result = { isexceed: 3 };
            return result;
        }
    }

    function amtCheck(request, data){
        let isamountcheck = 0;
        if (request.fiscal_category_cd == '7503' || request.fiscal_category_cd == '7502') {
            if (data[0].isexceed == 0) {
                isamountcheck = 1;
            }
            else {
                // total_balance_no >= $1  and 
                if ((data[0].balance[0].total_balance_no) >= (request.costno)) {
                    isamountcheck = 3;
                    request.account_id = data[0].account_id[0].client_account_id;
                }
                else {
                    isamountcheck = 2;
                }
            }
        }
        return isamountcheck;
    }


//list approvel tabs for finance supervisors
purchaseAauthorization.remoteMethod('getpapaymentdetails', {
    accepts : [{
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
        path: '/getpapaymentdetails',
        verb : 'get'
    },
    returns : {
        type : 'string',
        root : true
    }
});

purchaseAauthorization.getpapaymentdetails = (request,reqctx) => {
    let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
    LOGGER.debug((request && request.securityuserid?request.securityuserid: suserid)+"(request && request.securityuserid?request.securityuserid:suserid)");
    var sql ='select * from getpapaymentdetails($1)';
    return util.executeDBQuery(sql, [request.where.authorization_id])
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

 
    purchaseAauthorization.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    purchaseAauthorization.observe('access', (ctx, next) => util.access(ctx, next));
    purchaseAauthorization.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
