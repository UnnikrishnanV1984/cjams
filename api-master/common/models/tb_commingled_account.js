'use strict';
const LOGGER = require("log4js").getLogger("tb_commingled_account");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Tb_commingled_account) {
   
    Tb_commingled_account.getCommingledList=(request)=>{

        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;
        var sql= 'select * from get_commingled_account_details($1,$2,$3)';
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
    Tb_commingled_account.remoteMethod('getCommingledList', {
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
    
//insert commingled account

Tb_commingled_account.addCommingledAccounts = (addcommingledaccounts,reqctx) => {
    const suserid = util.getSecurityDetails(addcommingledaccounts, reqctx).securityuserid || '';
    var sql;
    sql ="select count(1) as account_count from tb_commingled_account where lower(bank_nm) = lower($1)  and lower(account_no) = lower($2) ;";
    return util.executeDBQuery(sql,[addcommingledaccounts.bankNm,addcommingledaccounts.accountNo]).then(data =>{
        if(data.length >0)
        {
            if(data[0].account_count == 0)
            {
    const dataQuery = 'INSERT INTO tb_commingled_account (bank_nm, account_no, open_dt, close_dt, county_cd, total_balance_no, create_user_id, update_user_id, delete_sw, approval_status_cd,create_ts) values ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)';

    var insertedby = suserid;
    var updatedby = suserid;
    LOGGER.error('user id>>', insertedby, app.currentUser);
    return util.executeDBQuery(dataQuery, [
        addcommingledaccounts.bankNm,
        addcommingledaccounts.accountNo,
        addcommingledaccounts.openDt,
        addcommingledaccounts.closeDt,
        addcommingledaccounts.countyCd,
        addcommingledaccounts.totalBalanceNo, insertedby, updatedby,
        addcommingledaccounts.deleteSw,
        addcommingledaccounts.approvalStatusCd,
        new Date().toLocaleString()  
    ])
    .then(result => {
        LOGGER.info(result);
        return result;
    })
    .then(result => {
            return {
                data : result ,
                isaccountexists : false
            };

    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}
else
{
    return {
        isaccountexists : true
              };
            }
        }

    
})
};
Tb_commingled_account.remoteMethod('addCommingledAccounts', {
    http: {
        path: '/addCommingledAccounts',
        verb: 'post'
    },
    accepts:[ {
        arg: 'addcommingledaccounts',
        type: 'object',
        http: {
            source: 'body'
        }
    },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
    returns: {
        arg: 'UserToken',
        type: 'Object'
    }

});

//delete api

Tb_commingled_account.deleteCommingledAccount =(deletecommingledaccount) => {
    const dataQuery = 'delete from tb_commingled_account where comm_account_id=$1';

    return util.executeDBQuery(dataQuery,[deletecommingledaccount.commAccountId])
      .then(data => {
          return {data : data};
        })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };
                        
  Tb_commingled_account.remoteMethod('deleteCommingledAccount', 
    {
      accepts : {
        arg : 'data',
        type : 'object',
        http : {
          source : 'body'
        },
      },
     http: {
        path: '/deleteCommingledAccount',
        verb: 'POST'
      },
      returns : {
        type : 'object',
        root : true
      }
    }
  );

 //update commingled account
	Tb_commingled_account.updateCommingledAccounts = (updatecommingledaccounts) => {

		var sql;
		sql = "select count(1) total_acc from tb_client_account where comm_account_id =$1 and status_cd ='3564' and round(total_balance_no,0) != 0";
		return util.executeDBQuery(sql,[updatecommingledaccounts.commAccountId]).then(data => {
			if (data.length > 0) {
				var is_childacc_exist = false;
				if (updatecommingledaccounts.approvalStatusCd === '3565' && data[0].total_acc !== 0) {
					is_childacc_exist = true;
				}


				if (!is_childacc_exist) {

					const dataQuery = `UPDATE tb_commingled_account SET
															bank_nm= $1,
															account_no= $2,
															open_dt= $3,
															close_dt=$4,
															county_cd=$5,
															delete_sw=$6,
															approval_status_cd=$7
															WHERE comm_account_id=$8`;
						return util.executeDBQuery(dataQuery,[updatecommingledaccounts.bankNm,
							updatecommingledaccounts.accountNo,
							updatecommingledaccounts.openDt,
							updatecommingledaccounts.closeDt,
							updatecommingledaccounts.countyCd,
							updatecommingledaccounts.deleteSw,
							updatecommingledaccounts.approvalStatusCd,
							updatecommingledaccounts.commAccountId])
						.then(result => {
							let data1;
							data1 = {
								'data': result,
								'ischildexist': false
							};
							LOGGER.debug('success');
							LOGGER.debug(data1,'result');
							return data1;
						})
					.then(result => result)
					.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })
				}
				else {
					let data1;
					data1 = {
						'ischildexist': true
					};
					return data1;
				}
			}

		});
	};

Tb_commingled_account.remoteMethod('updateCommingledAccounts', {
    http: {
        path: '/updateCommingledAccounts',
        verb: 'put'
    },
    accepts: {
        arg: 'updatecommingledaccounts',
        type: 'object',
        http: {
            source: 'body'
        }
    },
    returns: {
        arg: 'UserToken',
        type: 'Object'
    }
    
});
 
    Tb_commingled_account.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_commingled_account.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_commingled_account.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
