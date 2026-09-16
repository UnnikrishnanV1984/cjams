'use strict';
const LOGGER = require("log4js").getLogger("tb_payment_header");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
var email = require('../models/email');

module.exports = function(Tb_payment_header) {

    Tb_payment_header.getancillarypayment = (request) => {
        let newJsonStructure = {};
        newJsonStructure = request.where;
        newJsonStructure.pagenumber = request.page;
        newJsonStructure.pagesize = request.limit;
        var totalcount = 0;

        var sql= 'select * from get_ancillary_payment($1)';
        return util.executeDBQuery(sql,[newJsonStructure])
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
    
    Tb_payment_header.remoteMethod('getancillarypayment', {
        http: {
                path: '/getancillarypayment',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

     Tb_payment_header.getancillarypaymentHeader = (request) => {
        let newJsonStructure = {};
        newJsonStructure = request.where;
        newJsonStructure.pagenumber = request.page;
        newJsonStructure.pagesize = request.limit;
        var totalcount = 0;

        var sql= 'select * from get_ancillary_payment_header($1)';
        return util.executeSecondaryNodeDBQuery(sql,[newJsonStructure])
            .then(data => {
                if (data!==null && data.length>0)
                 {totalcount= data[0].totalcount;
                  
                }
                var result;
                result = {
                    'data' : data,
                    'count' : totalcount,
                  
                };
                return util.encryptresponse(result);
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });      
                
    };
    
    Tb_payment_header.remoteMethod('getancillarypaymentHeader', {
        http: {
                path: '/getancillarypaymentHeader',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });


    Tb_payment_header.getancillaryadjustmentsearch = (request) => {
        let newJsonStructure = {};
        newJsonStructure = request.where;
        newJsonStructure.pagenumber = request.page;
        newJsonStructure.pagesize = request.limit;
        var totalcount = 0;

        var sql= 'select * from get_ancillaryadjustment_payment($1)';
        return util.executeSecondaryNodeDBQuery(sql,[newJsonStructure])
            .then(paymentdata => {
                if (paymentdata !== null && paymentdata.length>0)
                 {totalcount= paymentdata[0].totalcount;
                  
                }
                var result;
                result = {
                    'data' : paymentdata,
                    'count' : totalcount,
                  
                };
                return result;
            })
            .then(data => util.encryptresponse(data))
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });      
                
    };
    
    Tb_payment_header.remoteMethod('getancillaryadjustmentsearch', {
        http: {
                path: '/getancillaryadjustmentsearch',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Tb_payment_header.remoteMethod('getauthorizationpayment', {
        accepts : {
       arg : 'filter',
       type : 'Object',
       http : {
       source : 'query'
       },
       required : true
       },
       http : {
       path: '/getauthorizationpayment',
       verb : 'get'
       },
       returns : {
       type : 'Object',
       root : true
       }
       });
   
   

       Tb_payment_header.getauthorizationpayment = function(request)
{

    const sql = "select * from get_authorization_request($1)";
    return util.executeDBQuery(sql,[request.where.authorizationid])
    .then(data => data)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

Tb_payment_header.remoteMethod('getpaymentdetail', {
    accepts : {
   arg : 'filter',
   type : 'Object',
   http : {
   source : 'query'
   },
   required : true
   },
   http : {
   path: '/getpaymentdetail',
   verb : 'get'
   },
   returns : {
   type : 'Object',
   root : true
   }
   });





   Tb_payment_header.getpaymentdetail = (request) => {
    const pageno = request.page;
    const pagesize = request.limit;
    var totalcount = 0;

    var sql= 'select * from getpaymentancillarydetail($1,$2,$3,$4)';
    return util.executeDBQuery(sql,[request.where.providerid, pagesize, pageno, request.where.countycd])
        .then(data => {
            if (data!==null && data.length>0){
             totalcount= data[0].totalcount;
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



Tb_payment_header.ancillaryadd = function(request,reqctx){
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
       var securityusersid = suserid;
        request.securityusersid = securityusersid;
        LOGGER.debug(securityusersid+"securityusersid")
        var account_type='';
        request.final_fiscal_category_cd=request.final_fiscal_category_cd.trim();
        if(request.final_fiscal_category_cd === '7503')
        {
            account_type = '591';
        }
        else if(request.final_fiscal_category_cd === '7502')
        {
            account_type = '590';
        }
        //check child account amount exceed or not
        var sql = "select * from getchildaccouctexists($1,$2)"
        return util.executeDBQuery(sql,[request.client_id,account_type]).then(data => {
        let result={};
        if(data.length>0)
        {
            var isamountcheck=0;
          isamountcheck = checkamount(request, data)       
            
            if(isamountcheck == 1) //account not exists
            {
                result={};
                result.isexceed=1;
                return result;
            }
            else if(isamountcheck === 5) //account not exists
            {
                result={};
                result.isexceed=5;
                return result;
            }
            else   if(isamountcheck === 2) //account  exists but balance exceeds
            {
                result={};
                result.isexceed=2;
                return result;
            }
            else{

        const ancillarypaymentaddSql = "select * from ancillarypaymentadd($1)";
        return util.executeDBQuery(ancillarypaymentaddSql, [request])
        .then(res => {
            return res;
        })
        .then(res => {
            LOGGER.debug(JSON.stringify(res)+"response");
            var notifymsg = 'Payment Adjustment Forwared to Payment Approval';
            var routeddescription = 'Purchase Adjustment Forwarded to Payment Approval';
            var comments = 'Forwarded to Payment Approval';
            var sql1 = 'select * from routingfinance($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
            return util.executeDBQuery(sql1, [res[0].paymentid, suserid, 'ANPAYADJ', 51, comments, res[0].assignedtoid, false, false, false, notifymsg,routeddescription,res[0].intakeserviceid])
            .then(data3 => {
              result={};
              result={isexceed:3};
              return result;
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })
          }
          )
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
        }
      }
    });

  
};

function checkamount(request, data) {
  let isamountcheck = 0;
  if(request.final_fiscal_category_cd === '7503' || request.final_fiscal_category_cd === '7502')
  {
      if(data[0].isexceed === 0)
      {
          isamountcheck=1;   
      }
      else if(data[0].isfinalcount[0].isfinal > 0)
      {
          isamountcheck=5;   
      }
      else{
          // total_balance_no >= $1  and 
          if(data[0].balance[0].total_balance_no >= request.gross_amount_no)
          {
              isamountcheck=3;   
          }
          else
          {
              isamountcheck=2;
          }
          
      }
  }
  return isamountcheck;
}       

Tb_payment_header.remoteMethod('ancillaryadd', {
    http: {
            path: '/ancillaryadd',
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

Tb_payment_header.remoteMethod('getancillaryadjustmentlist', {
    accepts : {
   arg : 'filter',
   type : 'Object',
   http : {
   source : 'query'
   },
   required : true
   },
   http : {
   path: '/getancillaryadjustmentlist',
   verb : 'get'
   },
   returns : {
   type : 'Object',
   root : true
   }
   });





   Tb_payment_header.getancillaryadjustmentlist = (request) => {
    const pageno = request.page;
    const pagesize = request.limit;
    var totalcount = 0;

    var sql= 'select * from getancillaryadjustmentlist($1,$2,$3,$4)';
    return util.executeDBQuery(sql,[request.where.providerid, pagesize, pageno,request.where.status])
        .then(getancillaryadjustmentlistdata => {
            if (getancillaryadjustmentlistdata !== null && getancillaryadjustmentlistdata.length>0){
             totalcount= getancillaryadjustmentlistdata[0].totalcount;
            }

            var result;
            result = {
                'data' : getancillaryadjustmentlistdata,
                'count' : totalcount
            };
            return result;
})
.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};

Tb_payment_header.remoteMethod('getancillarysupervisorlist', {
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
  }],
   http : {
   path: '/getancillarysupervisorlist',
   verb : 'get'
   },
   returns : {
   type : 'Object',
   root : true
   }
   });





   Tb_payment_header.getancillarysupervisorlist = (request,reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    const pageno = request.page;
    const pagesize = request.limit;
    var totalcount = 0;
    var userid = (request && request.securityuserid?request.securityuserid: suserid);
    var sql= 'select * from getancillarysupervisorlist($1,$2,$3,$4,$5)';
    return util.executeDBQuery(sql,[request.where.providerid, pagesize, pageno,request.where.status,userid])
        .then(getancillarysupervisorlistdata1 => {
            if (getancillarysupervisorlistdata1 !== null && getancillarysupervisorlistdata1.length>0){
             totalcount= getancillarysupervisorlistdata1[0].totalcount;
            }

            var result;
            result = {
                'data' : getancillarysupervisorlistdata1,
                'count' : totalcount
            };
            return result;
})
.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};

           

Tb_payment_header.remoteMethod(
    'getAccountsPayableHeader', {
      accepts: [{
        arg: 'data',
        type: 'AccountsPayables',
        http: {
          source: 'body',
        },
        required: true,
      }],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/getAccountsPayableHeader',
        verb: 'post',
        status: 200,
        errorStatus: 400,
      },
    }
  );
  
  Tb_payment_header.getAccountsPayableHeader = function(data) {
    let newJsonStructure = {};
    newJsonStructure = data.where || {};
    newJsonStructure.pagenumber = data.page;
    newJsonStructure.pagesize = data.limit;

    let sql = '';
    const Totalcount = 0;
    let result;

    // The search json was interpolated into a quoted SQL literal, so a single
    // quote in any of the free-text name filters -- providerlastnm, clientlastnm,
    // providername -- closed the literal early and Postgres raised 42601, which
    // error-logger flattens into a bare 400. Searching for a payee such as
    // O'Brien was enough to break it, and the same hole let arbitrary SQL through.
    // Bind it as a parameter, exactly as get_payment_header_forcase below does;
    // both functions take a single `request json` argument.
    sql = `select * from get_payment_header($1)`;
    return util.executeDBQuery(sql, [JSON.stringify(newJsonStructure)])
      .then(data13 => {
        if (typeof data13 !== 'undefined' && data13?.length > 0) {
          result = {
            data : data13,
            'count': data13[0].totalcount,
          };
        } else {
          result = {
            'data': [],
            'count': Totalcount,
          };
        }
        return result;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

  Tb_payment_header.remoteMethod(
    'getAccountsPayableHeaderForCase', {
      accepts: [{
        arg: 'data',
        type: 'AccountsPayables',
        http: {
          source: 'body',
        },
        required: true,
      }],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/getAccountsPayableHeaderForCase',
        verb: 'post',
        status: 200,
        errorStatus: 400,
      },
    }
  );

  
  Tb_payment_header.getAccountsPayableHeaderForCase = function(data) {
    let newJsonStructure = {};
    newJsonStructure = data.where;
    newJsonStructure.pagenumber = data.page;
    newJsonStructure.pagesize = data.limit;

    let sql = '';
    const Totalcount = 0;
    let result;

    sql = `select * from get_payment_header_forcase($1)`;
    return util.executeDBQuery(sql, [JSON.stringify(newJsonStructure)])
      .then(data14 => {
        if (typeof data14 !== 'undefined' && data14?.length > 0) {
          result = {
            data : data14,
            'count': data14[0].totalcount
          };
        } else {
          result = {
            'data': [],
            'count': Totalcount,
          };
        }
        return result;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };
  
  Tb_payment_header.remoteMethod(
    'getAccountsPayableInfo', {
      accepts: [{
        arg: 'data',
        type: 'AccountsPayable',
        http: {
          source: 'body',
        },
        required: true,
      }],
      returns: {
        arg: 'result',
        type: 'object',
        root: true,
      },
      http: {
        path: '/getAccountsPayableInfo',
        verb: 'post',
        status: 200,
        errorStatus: 400,
      },
    }
  );
  
  Tb_payment_header.getAccountsPayableInfo = function(data) {
    let newJsonStructure = {};
    newJsonStructure = data.where;
    newJsonStructure.pagenumber = data.page;
    newJsonStructure.pagesize = data.limit;

    let sql = '';

    const Totalcount = 0;
    let result;

    sql = `select * from get_payment_header_details($1)`;
    return util.executeDBQuery(sql, [JSON.stringify(newJsonStructure)])
      .then(data16 => {
        if (data16 !== null && typeof data16 !== 'undefined' && data16.length > 0) {
          result = {
            data : data16,
            'count': data16[0].totalcount,
          };
        } else {
          result = {
            'data': [],
            'count': Totalcount,
          };
        }
        return util.encryptresponse(result);
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

  //reject ancillary payment
  Tb_payment_header.rejectbypaymentid = (transactionId, request,reqctx) => {
    const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
    const dataQuery = "update routing set remarks='Rejected' ,activeflag=1,routingstatustypeid ='81',routeddescription =$2 where objectid=$1 ::character varying and activeflag = 1 and eventcode ='ANPAYADJ'";
    return util.executeDBQuery(dataQuery, [transactionId,request.reason_tx])
    .then(data => {
        const dataQuery1 = "update tb_payment_status set payment_status_cd = '1638' ,payment_status_dt =now():: date where payment_id = $1 and delete_sw = 'N' ";
        return util.executeDBQuery(dataQuery1, [transactionId]).then (data1 =>{
            var sql;
            sql ="select r.fromsecurityusersid,mu.email from routing r join muser mu on mu.securityusersid = r.fromsecurityusersid and mu.activeflag =1 where eventcode ='ANPAYADJ' and objectid = $1 :: character varying limit 1";
            return util.executeDBQuery(sql,[transactionId])
            .then(_data => {
                return _data;
            })
            .then(data2 => {

        if(request.fiscal_category_cd === '7503' || request.fiscal_category_cd === '7502' )
        {
          const dataQuery2 =
          `INSERT INTO tb_account_transaction
          (client_account_id ,transaction_type_cd, transaction_source_cd, benefit_start_dt, benefit_end_dt, transaction_amount_no, transaction_dt, credit_debit_sw,
          notes_tx, create_ts,  create_user_id, update_ts, update_user_id, delete_sw,payment_detail_id, authorization_id)
          
          select $1,'5530', '5475', tat.benefit_start_dt, tat.benefit_end_dt , $2, now(),
          'C','',now(),$4,now(),$4,'N',null,$3 
          from tb_account_transaction tat  where tat.authorization_id = $3 and tat.client_account_id = $1 
          and tat.transaction_amount_no = $2`;

          return util.executeDBQuery(dataQuery2, [request.client_account_id,request.gross_amount_no,request.authorization_id,suserid ])
          .then(_data => {
              return { data: _data };
          })
          .then(data17 =>{
                  const dataQuery3 =
                  `update tb_client_account set obligated_for_anc=coalesce 
                  (obligated_for_anc ,0) - 
                  ($2)
                      where client_account_id = $1 ;`;
              return util.executeDBQuery(dataQuery3, [request.client_account_id,parseInt(request.gross_amount_no)])
              .then(_data => {
                  return { data: _data };
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
    else{
        return data2;
    }
         

          
        }) 
        .catch(err => {
          LOGGER.error(err);
          return err;
      })
        })
    })
};




Tb_payment_header.remoteMethod('rejectbypaymentid', {
   
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
http: { "verb": "POST", "path": "/rejectbypaymentid/:id" },
returns: {
  type: 'Object',
  root: true
}
});

//reject ancillary payment-cd
Tb_payment_header.updatePaymentCheckStatus = (transactionId,request,reqctx) => {
  let suserid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    suserid = reqctx.req.headers.securityusersid
  } 
  const dataQuery = "select * from update_payment_check($1,$2,$3,$4)";
  return util.executeDBQuery(dataQuery, [(request && request.securityuserid?request.securityuserid: suserid),transactionId,request.notes,request.check_status])
    .then(data => {
        return { data: data };
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};

Tb_payment_header.remoteMethod('updatePaymentCheckStatus', {
 
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
http: { "verb": "POST", "path": "/updatePaymentCheckStatus/:id" },
returns: {
type: 'Object',
root: true
}
});

Tb_payment_header.getprovidercontract = (request) => {
  let newJsonStructure = {};
  newJsonStructure = request.where;
  newJsonStructure.pagenumber = request.page;
  newJsonStructure.pagesize = request.limit;
  var totalcount = 0;

  var sql= 'select * from getprovidercontract($1)';
  return util.executeSecondaryNodeDBQuery(sql,[newJsonStructure])
    .then(data19 => {
        if (data19?.length>0)
         {totalcount= data19[0].totalcount;
          
        }
        var result;
        result = {
            'data' : data19,
            'count' : totalcount,
          
        };
        return result;
    })
    .then(data => { return data; })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });       
          
};

Tb_payment_header.remoteMethod('getprovidercontract', {
  http: {
          path: '/getprovidercontract',
          verb: 'post'
  },
  accepts : [ {arg : 'data',type : 'object',
      http : {source : 'body'}} ],
  returns: {
      type : 'string',
      root : true
  }
});

Tb_payment_header.remoteMethod('getprovidercontractrate', {
  accepts : {
 arg : 'filter',
 type : 'Object',
 http : {
 source : 'query'
 },
 required : true
 },
 http : {
 path: '/getprovidercontractrate',
 verb : 'get'
 },
 returns : {
 type : 'Object',
 root : true
 }
 });



 Tb_payment_header.getprovidercontractrate = function(request)
{

const sql = "select * from getprovidercontractrate($1,$2,$3)";
return util.executeDBQuery(sql,[request.where.providerid,request.limit,request.page])
.then(data => data)
.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};


Tb_payment_header.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Tb_payment_header.observe('access', (ctx, next) => util.access(ctx, next));
Tb_payment_header.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
