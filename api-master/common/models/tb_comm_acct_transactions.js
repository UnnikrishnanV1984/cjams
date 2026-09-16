'use strict';
const LOGGER = require("log4js").getLogger("tb_comm_acct_transactions");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
var email = require('../models/email');

module.exports = function (Tb_comm_acct_transactions) {

    //spi13-s4 add account transation by venkatesh - 17-1-19

    Tb_comm_acct_transactions.remoteMethod('addCommAccountTransaction', {
        http: {
                path: '/addCommAccountTransaction',
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

    
    Tb_comm_acct_transactions.addCommAccountTransaction = function (request, reqctx) {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        var comm_accid;
        var v_comm_account_id = request.comm_account_id;
        var result = {};
        request.create_user_id = suserid;
        request.update_user_id = suserid;
        let sql = "select * from sp_check_comm_intrest($1,$2)";
        return util.executeDBQuery(sql, [v_comm_account_id, request.interest_start_dt])
            .then(data => {
                LOGGER.info(data);
                return data;
            }).then(data => {
                if (data.length > 0) {
                    if (data[0].sp_check_comm_intrest === true) {
                        result = {
                            "isexists": false
                        };
                        request.create_ts = new Date().toLocaleString();
                        request.update_ts = new Date().toLocaleString();
                        return Tb_comm_acct_transactions.create(request)
                            .then(data1 => {
                                comm_accid = data1.comm_acct_trans_id;
                                let sql1 = "select * from sp_commingled_interest_alloc($1)";

                                return util.executeDBQuery(sql1, [comm_accid])
                                    .then(data2 => {
                                        LOGGER.info(data2);
                                        return data2;
                                    })
                                    .then(data7 => {
                                        //     return new Promise((resolve, reject) => {  
                                        //         var sql;
                                        //         var ds = app.dataSources.hcuewelfare;
                                        //         sql ="update tb_commingled_account set total_balance_no =coalesce (total_balance_no,0)  +  $2 where comm_account_id= $1";
                                        //         ds.connector.execute(sql,[v_comm_account_id,v_total_balance_no],function(err, data){
                                        //         if(err) reject(err);
                                        //         resolve(data);
                                        //         });
                                        // }).then(data => {
                                        let sql2 = "select total_balance_no,concat (p.firstname,' ',p.middlename,' ',p.lastname) childname from TB_CLIENT_ACCOUNT ca join person p on p.cjamspid=ca.client_id "
                                            + " where comm_account_id = $1 ";
                                        return util.executeDBQuery(sql2, [v_comm_account_id])
                                            .then(data3 => {
                                                LOGGER.info(data3);
                                                return data3;
                                            })
                                            .then(data4 => {
                                                if (data4.length > 0 && data4[0].total_balance_no >= 1500) {
                                                    var childname = data4[0].childname;
                                                    let sql8 = "select up.securityusersid, up.email from v_userprofile up  where up.roletypekey = 'FNSFW'"
                                                        + "and up.countyid in (select distinct u.countyid from v_userprofile u where u.securityusersid = '" + suserid + "')";
                                                    return util.executeDBQuery(sql8, [])
                                                        .then(data5 => {
                                                            LOGGER.info(data5);
                                                            return data5;
                                                        })
                                                        .then(data6 => {
                                                            addUserNotification(data6, v_comm_account_id, childname, reqctx);
                                                            return result;
                                                        })
                                                        .catch(err => {
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

    function addUserNotification(data, v_comm_account_id, childname, reqctx) {
        if (data.length > 0) {
            data.forEach(userObj => {
                var nofiticationJson = {};
                nofiticationJson.securityusersid = userObj.securityusersid;
                nofiticationJson.usernotificationtypekey = "System";
                nofiticationJson.objectid = v_comm_account_id;
                nofiticationJson.subject = 'Childs (' + childname + ') Conserved account balance reaches $1500 ';
                nofiticationJson.priorityleveltypekey = "Normal";
                nofiticationJson.body = 'Childs (' + childname + ') Conserved account balance reaches $1500 ';
                app.models.Usernotification.Add(nofiticationJson, reqctx);
                email.SendEmailForFinance(userObj.email, nofiticationJson.subject, nofiticationJson.body);
            });
        }
    }

 //spi13-s4 update account transation by venkatesh - 17-1-19

 Tb_comm_acct_transactions.remoteMethod('updateCommAccountTransaction', {
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
              } ],
		http: { "verb": "patch", "path": "/updateCommAccountTransaction/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});


Tb_comm_acct_transactions.updateCommAccountTransaction = function(id,request,reqctx)
{   let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
request.create_user_id = (request && request.securityuserid?request.securityuserid:suserid);
request.create_ts = new Date().toLocaleString(); 
LOGGER.debug(request.create_user_id);
request.update_user_id = (request && request.securityuserid?request.securityuserid:suserid);
request.update_ts = new Date().toLocaleString(); 
return Tb_comm_acct_transactions.updateAll({comm_acct_trans_id:id}, request)
.then(data => data)
.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

//list comm account details

Tb_comm_acct_transactions.listCommAccountTransaction = (request) => {
    const dataQuery = "select tbcat.comm_acct_trans_id,tbcat.delete_req, tbcat.interest_start_dt, tbcat.interest_end_dt, tbcat.interest_amount_no, tbcat.notes_tx, tbcat.comm_account_id,coalesce(up.fullname,'Finance') as enteredby "
    +" ,(select ins.servicecaseid from tb_commingled_account ca  join tb_client_account tca on tca.comm_account_id=ca.comm_account_id join servicecase ins on ins.servicecasenumber=tca.case_id :: character varying and ins.activeflag=1 where ca.comm_account_id=$1 limit 1) as intakeserviceid "
    +",r.tosecurityusersid,r.fromsecurityusersid,r.routingstatustypeid as statuskey,tbcat.mod_interest_amount_no  from tb_comm_acct_transactions tbcat   "
    +" left join routing r on r.objectid = tbcat.comm_acct_trans_id :: character varying and  eventcode='COMMACCDEL' and r.activeflag=1 left join userprofile up on tbcat.create_user_id = up.securityusersid where tbcat.delete_sw='N' and comm_account_id=$1 order by tbcat.comm_acct_trans_id desc";

    return util.executeDBQuery(dataQuery, [request.where.comm_account_id])
        .then(data => {
            return { data: data };
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

Tb_comm_acct_transactions.remoteMethod('listCommAccountTransaction', {
        accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
        source : 'query'
        },
        required : true
        },
        http : {
        path: '/listCommAccountTransaction',
        verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
        });



//delete comm account

Tb_comm_acct_transactions.editCommAccountTransactionApprove = async (transactionId,request,reqctx) => {
	const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
	var _email = util.getSecurityDetails(request, reqctx).email;
    
    var requestuserinfo = {'token': '', 'email': _email};
    var fullname ;
    await util.getuserinfo(requestuserinfo).then (data => {
        fullname = data.fullname;
    });
    
    return Tb_comm_acct_transactions.updateAll({comm_acct_trans_id:transactionId},{mod_interest_amount_no : request.mod_interest_amount_no, update_ts: new Date().toLocaleString(), update_user_id: new Date().toLocaleString()})
                .then(data => {
                            var status = 45;
                            var notifymsg = 'Error Correction request  Submitted for review';
                            var routeddescription = 'Error Correction request  Submitted for review';
                            var comments = 'Error Correction request Submitted for review';

                            var eventcode='COMMACCDEL';
                           var sql = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';

                            return util.executeDBQuery(sql, [transactionId, suserid, eventcode, status, comments, request.assignedtoid, false, false, false, notifymsg,routeddescription,request.intakeserviceid]).then(data2 =>{
                                    LOGGER.debug(request.assignedtoid);
                                   const sql1 = 'select email from muser where securityusersid=$1 ';
                                   return util.executeDBQuery(sql1,[request.assignedtoid])
                                 .then(data4 => {
                                     if(data4.length>0){
                                     var nofiticationJson ={};
                                        nofiticationJson.securityusersid = request.assignedtoid;
                                     nofiticationJson.usernotificationtypekey="System";
                                     nofiticationJson.objectid=transactionId;
                                     nofiticationJson.subject='Error Correction Request for Commingled Account ('+transactionId+') has been assigned by  "'+fullname+'"';
                                     nofiticationJson.priorityleveltypekey ="Normal";
                                     nofiticationJson.body='Error Correction Request for  Commingled Account ('+transactionId+') has been assigned by  "'+fullname+'"';
                                     app.models.Usernotification.Add(nofiticationJson,reqctx);
                                     email.SendEmailForFinance(data4[0].email,nofiticationJson.subject,nofiticationJson.body);
                                     }
                                return data4;
                            });
                            })     
                        }) 
    
         //   return data;
};

Tb_comm_acct_transactions.remoteMethod('editCommAccountTransactionApprove', {
   //
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
              } ],
		http: { "verb": "POST", "path": "/editCommAccountTransactionApprove/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});
    

Tb_comm_acct_transactions.editCommAccountTransaction = async (transactionId,request,reqctx) => {
    var _email = util.getSecurityDetails(request, reqctx).email; 
    var requestuserinfo = {'token': '', 'email': _email};
    var fullname ;
    await util.getuserinfo(requestuserinfo).then (data => {
        fullname = data.fullname;
    });
        // return Tb_comm_acct_transactions.updateAll({comm_acct_trans_id:transactionId}, {"delete_sw":"Y"})
        // .then(data =>
        //     {
    const dataQuery = "select * from updatecommingledaccount($1)";
    return util.executeDBQuery(dataQuery, [transactionId])
    .then(data => ({ data: data }))
    .then (data=> {
        const dataQuery1 = "update routing set activeflag =0 where objectid= $1  :: character varying and eventcode='COMMACCDEL' and routingstatustypeid=53";
    return util.executeDBQuery(dataQuery1, [transactionId])
    .then(data1 => ({ data: data1 }))
.then (data2=> {
    const dataQuery2 = "update routing set routingstatustypeid=53 where objectid= $1  :: character varying and eventcode='COMMACCDEL'";
		return util.executeDBQuery(dataQuery2, [transactionId])
    .then(data3 => {
        LOGGER.info(data3);
        return { data: data3 };
    })
    .then (data4 => 
	{
			LOGGER.debug(request.assignedtoid);
		 const sql = 'select email from muser where securityusersid=$1 ';
		 return util.executeDBQuery(sql,[request.fromsecurityusersid])
		 .then(data5 => {
				 LOGGER.info(data5);
				 return data5;
		 })
         .then(data6 => {
             if(data6.length>0){
             var nofiticationJson ={};
                nofiticationJson.securityusersid = request.fromsecurityusersid;
             nofiticationJson.usernotificationtypekey="System";
             nofiticationJson.objectid=transactionId;
             nofiticationJson.subject='Error Correction Request for Commingled Account ('+transactionId+') has been approved by  "'+fullname+'"';
             nofiticationJson.priorityleveltypekey ="Normal";
             nofiticationJson.body='Error Correction Request for  Commingled Account ('+transactionId+') has been approved by  "'+fullname+'"';
             app.models.Usernotification.Add(nofiticationJson,reqctx);
             email.SendEmailForFinance(data6[0].email,nofiticationJson.subject,nofiticationJson.body);
             }
        return data6;
    })
		.catch(err => {
			LOGGER.error(err);
			return err;
		});
    })
		.catch(err => {
			LOGGER.error(err);
			return err;
		})
    })
})

         //   })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

Tb_comm_acct_transactions.remoteMethod('editCommAccountTransaction', {
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
    http: { "verb": "POST", "path": "/editCommAccountTransaction/:id" },
    returns: {
        type: 'Object',
        root: true
    }
});

    

Tb_comm_acct_transactions.rejectErrorCrct = (transactionId,request) => {
    const dataQuery = "update routing set remarks='Denied' ,activeflag=1,routingstatustypeid ='63',routeddescription =$2 where objectid=$1 ::character varying and activeflag = 1 and eventcode ='COMMACCDEL'";
    return util.executeDBQuery(dataQuery, [transactionId,request.reason_tx])
    .then(data => {
        return { data: data };
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};


Tb_comm_acct_transactions.remoteMethod('rejectErrorCrct', {
   
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
        }],
    http: { "verb": "POST", "path": "/rejectErrorCrct/:id" },
    returns: {
        type: 'Object',
        root: true
    }
});

//error correction dashboard 
Tb_comm_acct_transactions.remoteMethod('errorCorrectionDashboard', {
        http: {
                path: '/errorCorrectionDashboard',
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

Tb_comm_acct_transactions.errorCorrectionDashboard = function(request,reqctx)
{   let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    const dataQuery = "select * from error_correction_dashboard ($1,$2,$3,$4,$5)";
    return util.executeDBQuery(dataQuery, [request.routingstatustypeid,(request && request.securityuserid?request.securityuserid: suserid),request.page,request.limit,request.statusval])
        .then(data => {
            return { data: data };
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

Tb_comm_acct_transactions.remoteMethod('childAccountExists', {
    http: {
            path: '/childAccountExists',
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

Tb_comm_acct_transactions.childAccountExists = function(request,reqctx)
{ let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
const dataQuery6 = "select * from error_correction_dashboard ($1,$2,$3,$4,$5)";
return util.executeDBQuery(dataQuery6, [request.routingstatustypeid,(request && request.securityuserid?request.securityuserid: suserid),request.page,request.limit,request.statusval])
    .then(data => {
        return { data: data };
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}



Tb_comm_acct_transactions.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Tb_comm_acct_transactions.observe('access', (ctx, next) => util.access(ctx, next));
Tb_comm_acct_transactions.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};