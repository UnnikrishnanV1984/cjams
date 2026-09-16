'use strict';
const LOGGER = require("log4js").getLogger("tb_client_account");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

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

module.exports = function(Tb_client_account) {
    Tb_client_account.remoteMethod('getchildaccountsdetailslist', {
        accepts:[ {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },{
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

    Tb_client_account.getchildaccountsdetailslist=(request,reqctx)=>{
        let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        LOGGER.debug("entered into method getchildaccountsdetailslist");
        const pageno = request.page;
        const pagesize = request.limit;
        request.where.current_user = (request && request.securityuserid?request.securityuserid: suserid);
        var sql= 'select * from get_child_accounts_details_list($1,$2,$3)';
        return util.executeDBQuery(sql,[JSON.stringify(request.where), pageno, pagesize])
            .then(withCount)
            .catch(logAndRethrow);

    };
    Tb_client_account.remoteMethod('getchilddetailslist', {
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

    Tb_client_account.getchilddetailslist=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
          var sql= 'select * from get_child_details_list($1,$2,$3,$4,$5,$6)';
        return util.executeDBQuery(sql,[JSON.stringify(request.where), pageno, pagesize,request.where.sortorder,request.where.sortcolumn,'dummy'])
            .then(withCount)
            .catch(logAndRethrow);

    };
    Tb_client_account.remoteMethod('addchildaccounts', {
        http: {
                path: '/addchildaccounts',
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

	Tb_client_account.addchildaccounts = function (request,reqctx) {
		const suserid = util.getSecurityDetails(request,reqctx).securityuserid;
		request.create_user_id = suserid;
		LOGGER.debug(request.create_user_id);
		request.update_user_id = suserid;
		var sql = "select count(1) as accountcount  from tb_client_account where client_id = $1 and account_type_cd=$2 and open_dt is not null and close_dt is null and status_cd not in ('593','594')"
		return util.executeDBQuery(sql,[request.client_id,request.account_type_cd])
			.then(data => {
				return data;
			})
			.then(res => {

				return new Promise((resolve,reject) => {
					var courtObj = {};
					courtObj = JSON.parse(JSON.stringify(res));
					if (courtObj.length > 0 && courtObj[0].accountcount == 0)//'590'-Conserved type code--if it is conserved type code, it can be inserted multiple times
					{
						return Tb_client_account.create(request,function (err,res1) {
							if (err) {
								LOGGER.error('error');
							}
							else {
								res1.insertstatus = true;
								resolve(res1);
							}
						})
					}
					else {
						var resstatus = { insertstatus: false,account_type: request.account_type_cd };
						resolve(resstatus);
					}

				})
			}).then(res => {
				return res
			}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; })

		// .then(data => data)
		// .catch(err => util.logError(err));
	}

    Tb_client_account.remoteMethod('updatechildaccounts', 
    {
        http: {
            path: '/updatechildaccounts/:id',
            verb: 'put'
        },
       accepts : [
        {
          arg: 'id',
         type: 'string',
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

Tb_client_account.updatechildaccounts = function(id,request,reqctx)
{  const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
    request.create_user_id = suserid;
   LOGGER.debug(request.create_user_id);
    request.update_user_id = suserid;
    if(request.account_exists_sw == 'Y')
    {
        var sql = "update tb_commingled_account set total_balance_no = coalesce(total_balance_no,0) - coalesce((select total_balance_no from tb_client_account where client_account_id=$1),0) where comm_account_id =  (select comm_account_id from tb_client_account where client_account_id=$1) "
        return util.executeDBQuery(sql, [id])
    .then(data =>{
        if(request.status_cd == '593' && request.total_balance_no != "0.00" && request.total_balance_no != null){
            delete request.status_cd;
        }
    return Tb_client_account.updateAll({client_account_id:id}, request)
    .then(data8 => data8)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    })
    }else
    {
        if(request.status_cd == '593' && request.total_balance_no != "0.00" && request.total_balance_no != null){
            delete request.status_cd;
        }
    return Tb_client_account.updateAll({client_account_id:id}, request)
    .then(data => data)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
}
Tb_client_account.remoteMethod('getCommingledAccountList', {
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

Tb_client_account.getCommingledAccountList=(request)=>{

    const pageno = request.page;
    const pagesize = request.limit;
    var sql= 'select * from get_commingled_account_list($1,$2,$3)';
    return util.executeDBQuery(sql,[JSON.stringify(request.where), pageno, pagesize])
        .then(withCount)
        .catch(logAndRethrow);

};

//get conserved accountdetails

Tb_client_account.remoteMethod('getconservedaccountdetails', {
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

Tb_client_account.getconservedaccountdetails=(request)=>{

    const skip = (request.page - 1) * request.limit;
    const limit = request.limit;
    var sql= 'select * from getconservedaccountdetails($1,$2,$3)';
    return util.executeDBQuery(sql,[JSON.stringify(request.where), skip, limit])
        .then(withCount)
        .catch(logAndRethrow);

};

Tb_client_account.getchild116report = (request) => {
    const pageno = request.page;
    const pagesize = request.limit;

    var sql= 'select * from getchild116report($1,$2,$3)';
    return util.executeDBQuery(sql,[request.where.receivabledetailid, pagesize, pageno])
        .then(withCount)
        .catch(logAndRethrow);

};

Tb_client_account.remoteMethod('getchild116report', {
        accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
        source : 'query'
        },
        required : true
        },
        http : {
        path: '/getchild116report',
        verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
        });

        //list client details for ssi/ssa Tracking

        Tb_client_account.remoteMethod('listSsiSsaClientDetails', {
            http: {
                    path: '/listSsiSsaClientDetails',
                    verb: 'post'
            },
            accepts : [ {arg : 'data',type : 'object',
                http : {source : 'body'}} ],
            returns: {
                type : 'string',
                root : true
            }
        });

        Tb_client_account.listSsiSsaClientDetails=(request)=>{
            const pageno = request.page;
            const pagesize = request.limit;
            var sql= 'select * from sp_ssi_ssa_child_search($1,$2,$3)';
            return util.executeDBQuery(sql,[JSON.stringify(request.where), pageno, pagesize])
                .then(withCount)
                .catch(logAndRethrow);

        };

         //list client details for ssi/ssa Tracking

         Tb_client_account.remoteMethod('addEligibilityEvents', {
            http: {
                    path: '/addEligibilityEvents',
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

        Tb_client_account.addEligibilityEvents=(request,reqctx)=>{
            let suserid = undefined;
            if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
              suserid = reqctx.req.headers.securityusersid
            }
            var sql= 'select * from sp_add_eligibility_events($1,$2)';
            return util.executeDBQuery(sql,[JSON.stringify(request),(request && request.securityuserid?request.securityuserid: suserid)])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

        };

        //sp_list_eligibility_events
        //list client details for ssi/ssa Tracking

        Tb_client_account.remoteMethod('listEligibilityEvents', {
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                source : 'query'
                },
                required : true
                },
                http : {
                path: '/listEligibilityEvents',
                verb : 'get'
                },
                returns : {
                type : 'Object',
                root : true
                }
                });

        Tb_client_account.listEligibilityEvents=(request)=>{
            const pageno = request.page;
            const pagesize = request.limit;
            var sql= 'select * from sp_list_eligibility_events($1,$2,$3)';
            return util.executeDBQuery(sql,[request.where.client_id,pageno,pagesize])
                .then(withCount)
                .catch(logAndRethrow);

        };

        
        Tb_client_account.remoteMethod('listFundingSrcClientDetails', {
            http: {
                    path: '/listFundingSrcClientDetails',
                    verb: 'post'
            },
            accepts : [ {arg : 'data',type : 'object',
                http : {source : 'body'}} ],
            returns: {
                type : 'string',
                root : true
            }
        });

        Tb_client_account.listFundingSrcClientDetails=(request)=>{
            const pageno = request.page;
            const pagesize = request.limit;
            var sql= 'select * from sp_funding_scr_child_search($1,$2,$3)';
            return util.executeDBQuery(sql,[JSON.stringify(request.where), pageno, pagesize])
                .then(withCount)
                .catch(logAndRethrow);

        };

        
        Tb_client_account.remoteMethod('listFundingAllocationMaster', {
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                source : 'query'
                },
                required : true
                },
                http : {
                path: '/listFundingAllocationMaster',
                verb : 'get'
                },
                returns : {
                type : 'Object',
                root : true
                }
                });

        Tb_client_account.listFundingAllocationMaster=(request)=>{
            const pageno = request.page;
            const pagesize = request.limit;
            var sql= 'select * from sp_list_funding_src_alloc($1,$2,$3)';
            return util.executeDBQuery(sql,[JSON.stringify(request.where),pageno,pagesize])
                .then(withCount)
                .catch(logAndRethrow);

        };

        
        Tb_client_account.remoteMethod('listFundingAllocatioHistory', {
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                source : 'query'
                },
                required : true
                },
                http : {
                path: '/listFundingAllocatioHistory',
                verb : 'get'
                },
                returns : {
                type : 'Object',
                root : true
                }
                });

        Tb_client_account.listFundingAllocatioHistory=(request)=>{
            const pageno = request.page;
            const pagesize = request.limit;
            var sql= 'select * from sp_list_funding_src_history($1,$2,$3)';
            return util.executeDBQuery(sql,[request.where.fund_alloc_id,pageno,pagesize])
                .then(withCount)
                .catch(logAndRethrow);

        };

        Tb_client_account.remoteMethod('listSsaTracking', {
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                source : 'query'
                },
                required : true
                },
                http : {
                path: '/listSsaTracking',
                verb : 'get'
                },
                returns : {
                type : 'Object',
                root : true
                }
                });

        Tb_client_account.listSsaTracking=(request)=>{
            const pageno = request.page;
            const pagesize = request.limit;
            var sql= 'select * from get_ssissa_payment($1,$2,$3)';
            return util.executeDBQuery(sql,[request.where.client_id,pageno,pagesize])
                .then(withCount)
                .catch(logAndRethrow);

        };

        
        Tb_client_account.remoteMethod('clientErrorCorrectionDashboard', {
    http: {
            path: '/clientErrorCorrectionDashboard',
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

Tb_client_account.clientErrorCorrectionDashboard = function(request,reqctx)
{  let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
const dataQuery = "select * from error_corr_clientacc_dashboard ($1,$2,$3,$4,$5)";
return util.executeSecondaryNodeDBQuery(dataQuery, [request.routingstatustypeid,(request && request.securityuserid?request.securityuserid: suserid),request.page,request.limit,request.statusval])
    .then(data => {
        return { data: data };
    })
    .then(data => { return data; })
   .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

Tb_client_account.remoteMethod('listClientPaymentSearch', {
    http: {
            path: '/listClientPaymentSearch',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'string',
        root : true
    }
});

Tb_client_account.listClientPaymentSearch=(obj)=>{
    const pageno = obj.page;
    const pagesize = obj.limit;
    var sql= 'select * from getclientpaymentsearch($1,$2,$3)';
    return util.executeDBQuery(sql, [JSON.stringify(obj.where), pageno, pagesize])
        .then(withCount)
        .catch(logAndRethrow);

    };

    Tb_client_account.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_client_account.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_client_account.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
