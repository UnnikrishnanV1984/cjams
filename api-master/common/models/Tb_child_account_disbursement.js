'use strict';
const LOGGER = require("log4js").getLogger("Tb_child_account_disbursement");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
var email = require('../models/email');
const clientaccountstr = '" (Client Account "';
const assignedbystr = '")  has been assigned by  "';
const finaldisbursementstr = 'Final Disbursement transaction Payment Approval Request for Client Name - "';
const ssdisbursementstr = 'Social Security Disbursement transaction Payment Approval Request for Client Name - "';
const needsdisbursementstr = 'Special Needs Trust Disbursement transaction Payment Approval Request for Client Name - "';
const approvedstr = '")  has been approved by  "';

module.exports = function (Tb_child_account_disbursement) {

    Tb_child_account_disbursement.remoteMethod('add', {
        http: {
            path: '/add',
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
        type : 'string',
        root : true
    }
});


Tb_child_account_disbursement.add = async function(request,reqctx) {   
    const suser = util.getSecurityDetails(request, reqctx);
    const suserid = suser.securityuserid;
    var fullname ;
    var _email = suser.email;
    var requestuserinfo = {'token': '', 'email': _email}; 
    await util.getuserinfo(requestuserinfo).then (data => {
        fullname = data.fullname;
    });
    var v_disbursmentid=0;
    request.securityuserid = suserid;
    request.create_user_name = request.create_user_name? request.create_user_name : fullname;
    request.delete_sw ='N';
    request.create_ts = new Date().toLocaleString();
    var notifymsg = '';
    var routeddescription = '';
    var comments = '';
    if(request.status === 56) //Forwarded to Case Supervisor
    {
        notifymsg = 'Final Disbursement Forwarded to Fiscal Supervisor';
        routeddescription = 'Final Disbursement Forwarded to Fiscal Supervisor';
        comments = 'Forwarded to Fiscal Supervisor';
    }
    var subject='';
    var body='';
    switch(request.service_id) {
        case 101:
            subject = 'Final Disbursement transaction Financial Approval Request for Client Name - "'+ request.client_name+clientaccountstr+request.client_account+assignedbystr+request.create_user_name+'"';
            body = 'Final Disbursement transaction Financial Approval Request for Client Name - "'+ request.client_name+clientaccountstr+request.client_account+assignedbystr+request.create_user_name+'"';
            break;
        case 102:
            subject = 'Social Security Disbursement transaction Financial Approval Request for Client Name - "'+ request.client_name+clientaccountstr+request.client_account+assignedbystr+request.create_user_name+'"';
            body = 'Social Security Disbursement transaction Financial Approval Request for Client Name - "'+ request.client_name+clientaccountstr+request.client_account+assignedbystr+request.create_user_name+'"';
            break;
        case 103:
            subject = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "'+ request.client_name+clientaccountstr+request.client_account+assignedbystr+request.create_user_name+'"';
            body = 'Special Needs Trust Disbursement transaction Financial Approval Request for Client Name - "'+ request.client_name+clientaccountstr+request.client_account+assignedbystr+request.create_user_name+'"';
            break;
    }
return Tb_child_account_disbursement.upsert(request)
.then(data => {
    var eventcode=request.eventcode;
    var sql1 = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
    v_disbursmentid = data.disbursement_id;
    return util.executeDBQuery(sql1, [data.disbursement_id, request.securityuserid, eventcode, request.status, comments, request.assignedtoid, false, false, false, notifymsg,routeddescription,request.intakeserviceid])
    .then(data2=>{
        LOGGER.debug(request.assignedtoid);
        const sql = 'select * from sp_final_disbursment_approve($1,$2,$3,$4) ';
        return util.executeDBQuery(sql,[v_disbursmentid,request.status, request.securityuserid,JSON.stringify(request)])
     .then((data3) => {
        LOGGER.debug(request.assignedtoid);
        const data3Sql = 'select email from muser where securityusersid=$1 ';
        return util.executeDBQuery(data3Sql,[request.assignedtoid])
     .then(data1 => {
    var nofiticationJson ={};
         nofiticationJson.securityusersid = request.assignedtoid;//to whom this notification should be triggered
         nofiticationJson.usernotificationtypekey="System";
         nofiticationJson.objectid=v_disbursmentid;
         nofiticationJson.subject=subject;
         nofiticationJson.priorityleveltypekey ="Normal";
         nofiticationJson.body=body;
         nofiticationJson.insertedby = request.securityuserid;
         nofiticationJson.updatedby = request.securityuserid;
         nofiticationJson.insertedon = new Date().toLocaleString();
         nofiticationJson.updatedon = new Date().toLocaleString();
         nofiticationJson.securityuserid = request.securityuserid;   //useid who is submitting for approval
         app.models.Usernotification.Add(nofiticationJson,reqctx);
         email.SendEmailForFinance(data1[0].email,nofiticationJson.subject,nofiticationJson.body);
    return data1;
});
})   
}).catch((error)=>{
    Logger.error(error); 
});  
})
.catch(err => util.logError(err));
}

Tb_child_account_disbursement.remoteMethod('updateapprovals', {
    http: {
        path: '/updateapprovals',
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
    type : 'string',
    root : true
}
});


Tb_child_account_disbursement.updateapprovals = async function(request,reqctx){   
    const suser = util.getSecurityDetails(request, reqctx);
    const suserid = suser.securityuserid;
    var _email = suser.email;
    var requestuserinfo = {'token': '', 'email': _email}; 
    var fullname ;
    await util.getuserinfo(requestuserinfo).then (data => {
        fullname = data.fullname;
    });
const securityuserid = suserid;
request.securityuserid = securityuserid;
request.create_user_name = request.create_user_name? request.create_user_name : fullname;
request.create_user_id = request.securityuserid;
request.update_user_id = request.securityuserid;
request.create_ts = new Date().toLocaleString();
request.update_ts = new Date().toLocaleString();

         var notifymsg = '';
         var routeddescription = '';
         var comments = '';
    if (request.status === 57) //Forwarded to Case Supervisor
    {
        notifymsg = 'Final Disbursement Forwarded to Payment Approval';
        routeddescription = 'Final Disbursement Forwarded to Payment Approval';
        comments = 'Forwarded to Payment Approval';
    }
    var eventcode=request.eventcode;                      
    var sql1 = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
    return util.executeDBQuery(sql1, [request.disbursement_id, request.securityuserid, eventcode, request.status, comments, request.assignedtoid, false, false, false, notifymsg,routeddescription,request.intakeserviceid])
    .then(data=>{
        LOGGER.debug(request.assignedtoid);
        const sql = 'select * from sp_final_disbursment_approve($1,$2,$3,$4) ';
        return util.executeDBQuery(sql,[request.disbursement_id,request.status, request.securityuserid,JSON.stringify(request)])
     .then(data1 => {
        const data1Sql = 'select email from muser where securityusersid=$1 ';
        LOGGER.debug(request.assignedtoid);
        return util.executeDBQuery(data1Sql, [request.assignedtoid])
         .then(data2 => {
            sendNoti(request, data2, reqctx);
            if(request.status == 58) {
                sendNotification(request, reqctx);
            }
            return data2;
    }).catch((error)=>{
        Logger.error(error); 
    });
});     
})
.catch(err => util.logError(err));
}

function sendNoti(request, data, reqctx) {
    if (data.length > 0) {
        if (request.status === 57) {
            var nofiticationJson = {};
            var subject = '';
            var body = '';
            switch (request.service_id) {
                case 101:
                    subject = finaldisbursementstr + request.client_name + clientaccountstr + request.client_account + '") has been assigned by  "' + request.create_user_name + '"';
                    body = finaldisbursementstr + request.client_name + clientaccountstr + request.client_account + assignedbystr + request.create_user_name + '"';
                    break;
                case 102:
                    subject = ssdisbursementstr + request.client_name + clientaccountstr + request.client_account + assignedbystr + request.create_user_name + '"';
                    body = ssdisbursementstr + request.client_name + clientaccountstr + request.client_account + assignedbystr + request.create_user_name + '"';
                    break;
                case 103:
                    subject = needsdisbursementstr + request.client_name + clientaccountstr + request.client_account + assignedbystr + request.create_user_name + '"';
                    body = needsdisbursementstr + request.client_name + clientaccountstr + request.client_account + assignedbystr + request.create_user_name + '"';
                    break;
            }

            nofiticationJson.securityusersid = request.assignedtoid;
            nofiticationJson.usernotificationtypekey = "System";
            nofiticationJson.objectid = request.disbursement_id;
            nofiticationJson.subject = subject;
            nofiticationJson.priorityleveltypekey = "Normal";
            nofiticationJson.body = body;
            nofiticationJson.insertedby = request.securityuserid;
            nofiticationJson.updatedby = request.securityuserid;

            app.models.Usernotification.Add(nofiticationJson, reqctx);
            email.SendEmailForFinance(data[0].email, nofiticationJson.subject, nofiticationJson.body);
        }
    }
}

function sendNotification(request, reqctx) {

    LOGGER.debug(request.assignedtoid);
    const sql = `select ((select jsonb_agg(x) from (select email,securityusersid from muser where (securityusersid=r.tosecurityusersid or securityusersid in
            (select ri.fromsecurityusersid from routing ri where ri.objectid=r.objectid and ri.eventcode =r.eventcode and ri.routingstatustypeid=56 limit 1)
            ))as x ))  as users from routing r where r.objectid=$1 and r.eventcode ='FINALDIS' and r.routingstatustypeid !=57`;
    return util.executeDBQuery(sql, [request.disbursement_id])
        .then(data => {

            if (data.length > 0 && data[0].users != null) {
                data[0].users.forEach(element => {
                    var nofiticationJson = {};
                    var subject = '';
                    var body = '';
                    switch (request.service_id) {
                        case 101:
                            subject = finaldisbursementstr + request.client_name + clientaccountstr + request.client_account + approvedstr + request.create_user_name + '"';
                            body = finaldisbursementstr + request.client_name + clientaccountstr + request.client_account + approvedstr + request.create_user_name + '"';
                            break;
                        case 102:
                            subject = ssdisbursementstr + request.client_name + clientaccountstr + request.client_account + approvedstr + request.create_user_name + '"';
                            body = ssdisbursementstr + request.client_name + clientaccountstr + request.client_account + approvedstr + request.create_user_name + '"';
                            break;
                        case 103:
                            subject = needsdisbursementstr + request.client_name + clientaccountstr + request.client_account + approvedstr + request.create_user_name + '"';
                            body = needsdisbursementstr + request.client_name + clientaccountstr + request.client_account + approvedstr + request.create_user_name + '"';
                            break;
                    }

                    nofiticationJson.securityusersid = element.securityusersid;
                    nofiticationJson.usernotificationtypekey = "System";
                    nofiticationJson.objectid = request.disbursement_id;
                    nofiticationJson.subject = subject;
                    nofiticationJson.priorityleveltypekey = "Normal";
                    nofiticationJson.body = body;
                    nofiticationJson.insertedby = request.securityuserid;
                    nofiticationJson.updatedby = request.securityuserid;

                    app.models.Usernotification.Add(nofiticationJson, reqctx);

                    email.SendEmailForFinance(element.email, nofiticationJson.subject, nofiticationJson.body);

                });
            }
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });

}



Tb_child_account_disbursement.remoteMethod('listFinalDisbursement', {
    accepts:[ {
  arg: 'filter',
  type: 'Object',
  http: {
    source: 'query',
  },
  required: true,
}
,{
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
        }],
  http: {
        verb: 'get',
    },
    returns: {
        type: 'Object',
        root: true,
    },
});

Tb_child_account_disbursement.listFinalDisbursement=(request,reqctx)=>{
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    const pageno = request.page;
    const pagesize = request.limit;
    var totalcount = 0;
    var sql= 'select * from sp_get_final_disbursement($1,$2,$3,$4,$5)';
    return util.executeSecondaryNodeDBQuery(sql,[(request && request.securityuserid?request.securityuserid: suserid),request.where.status, pageno, pagesize,request.where.dispstatus])
        .then(data => {
            if (data!==null && data.length>0){ totalcount= data[0].totalcount;}
            var result;
            result = {
                'data' : data,
                'count' : totalcount
            };
            return result;
        })
        .then(data => { return data; })
       .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });        
            
};


    
Tb_child_account_disbursement.rejectForDisbursement = (transactionId,request,reqctx) => {
    var fundingdenied =null;
    var paymentdenied =null;
    if(request.rejecttype === 'Funding')
    {
        fundingdenied = '3281';
    }
    else if (request.rejecttype === 'payment')
    {
        fundingdenied = '3047';
        paymentdenied = '3281';
    }
    const dataQuery = "update routing set remarks='Denied' ,activeflag=1,routingstatustypeid ='61',routeddescription =$2 where objectid=$1 ::character varying and activeflag = 1  and eventcode ='FINALDIS'";
    return util.executeDBQuery(dataQuery, [transactionId,request.reason_tx])
    .then(data => {
        const dataQuery1 = "update tb_child_account_disbursement set reason_tx=$2,funding_approval_status = $3, payment_approval_status = $4 where disbursement_id = $1";
        return util.executeDBQuery(dataQuery1, [transactionId,request.reason_tx,fundingdenied,paymentdenied])
        .then(data1 => {
            var sql ="select r.fromsecurityusersid,mu.email from routing r join muser mu on mu.securityusersid = r.fromsecurityusersid and mu.activeflag =1 where eventcode ='FINALDIS' and objectid = $1 :: character varying";
            return util.executeDBQuery(sql, [transactionId])
            .then((resp)=>{
                return resp.length >0 ? resp : [];
            })
            .then(data2 => {
                data2.forEach(userObj=>{
                    var nofiticationJson ={};
                      nofiticationJson.securityusersid = userObj.fromsecurityusersid;
                      nofiticationJson.usernotificationtypekey="System";
                      nofiticationJson.objectid=transactionId;
                      nofiticationJson.subject='Disbursement ('+transactionId+') is Denied';
                      nofiticationJson.priorityleveltypekey ="High";
                      nofiticationJson.body='Disbursement ('+transactionId+') is Denied';

                      app.models.Usernotification.Add(nofiticationJson,reqctx);
                      //email send
                      email.SendEmailForFinance(userObj.email,nofiticationJson.subject,nofiticationJson.body);
                      return request;
                    })
            }).catch((error)=>{
                Logger.error(error);
            });
        })
       // return data;          // SonarQube commented this line as it is not reachable
    })
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });

};


Tb_child_account_disbursement.remoteMethod('rejectForDisbursement', {
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
    http: { "verb": "POST", "path": "/rejectForDisbursement/:id" },
    returns: {
        type: 'Object',
        root: true
    }
});



Tb_child_account_disbursement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Tb_child_account_disbursement.observe('access', (ctx, next) => util.access(ctx, next));
Tb_child_account_disbursement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}