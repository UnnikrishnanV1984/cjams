'use strict';
const LOGGER = require("log4js").getLogger("tb_provider");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
var config = require('../../server/config.json');

module.exports = function(Tb_provider) {

  Tb_provider.remoteMethod('getproviderdetails', {
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

  
  Tb_provider.getproviderdetails = request => {
      const provider_id = request.where.provider_id;
      const sql = 'select concat_ws(\'\', PA.adr_street_no, \' \', PA.adr_street_tx, \' \', PA.adr_street_nm, \' \', PA.adr_city_nm, \' \', PA.adr_state_cd, \' \', PA.adr_zip5_no ) AS provideraddress , * from tb_provider P inner join tb_provider_addresses PA on P.provider_id::text = PA.parent_key_id AND PA.adr_type_cd = \'3357\' AND PA.adr_end_dt IS NULL AND adr_default_sw = \'Y\' where P.provider_id = ($1) order by adr_start_dt desc LIMIT 1 ';
      return util.executeDBQuery(sql, [provider_id])
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

    
Tb_provider.remoteMethod('getproviderguardians', {
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


Tb_provider.getproviderguardians = request => {
  const provider_id = request.where.provider_id;
  const sql = 'select * from getadoptiveparents($1)';
  return util.executeDBQuery(sql, [provider_id])
  .then(data => data)
  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};


    Tb_provider.remoteMethod('fostercareprovidersearch', {
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

    Tb_provider.fostercareprovidersearch=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;
        // fostercareprovidersearch has placement logic and search are limited to CPS Office and RCC
        // and also looking for valid provider with whom child can be placed other hand global search
        // Does not require to have this logic hence
        const sql = getQueryString(request);
        return util.executeSecondaryNodeDBQuery(sql,[JSON.stringify(request.where), pageno, pagesize])
        .then(data => {
              if (data!==null && data.length>0) {totalcount= data[0].totalcount;}
              var result;
              result = {
                  'data' : data,
                  'count' : totalcount
              };
              return util.encryptresponse(result);
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    function getQueryString(request){
      let sql= 'select * from fostercareprovidersearch($1,$2,$3)'; 
        if(request.where && request.where.global){
          sql= 'select * from globalprovidersearch($1,$2,$3)';
        }
         else if(request.where && request.where.adoption){
          sql= 'select * from adoptionprovidersearch($1,$2,$3)';
        }
        else if(request.where && request.where.guardian){
          sql= 'select * from guardianshipprovidersearch($1,$2,$3)';
        }
        return sql;
    }

    Tb_provider.remoteMethod('getcpahomeprovidername', {
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

    Tb_provider.getcpahomeprovidername = request => {
        const provider_parent_id = request.where.provider_parent_id;
        const sql = 'select * from getcpahomeprovidername($1)';
        return util.executeDBQuery(sql, [provider_parent_id])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_provider.remoteMethod('getproviderclientsearch', {
        http: {
                path: '/getproviderclientsearch',
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

    Tb_provider.getproviderclientsearch = function(request,reqctx)
    {   
      let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      } 
 
            var insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            var inputjson = request.where;
            inputjson.enteredby = insertedby;
            inputjson.pagenumber = request.page;
            inputjson.pagesize = request.limit;
          const sql = 'select * from tb_providersearch($1)';
          return util.executeDBQuery(sql, [inputjson])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

        
    Tb_provider.remoteMethod('providerapplicantsearch', {
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

    Tb_provider.providerapplicantsearch=(request)=>{
        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;
        var sql= 'select * from getproviderapplicant($1,$2,$3)';
        return util.executeDBQuery(sql,[request.where.securityusersid, pageno, pagesize])
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

    // to get the provider detail checklist
    Tb_provider.remoteMethod('getproviderchecklistsearch', {
        http: {
                path: '/getproviderchecklistsearch',
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

    Tb_provider.getproviderchecklistsearch = function(request,reqctx)
    {   let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      } 
 
            var insertedby = (request && request.securityuserid?request.securityuserid: suserid);
            var inputjson = request.where;
            inputjson.enteredby = insertedby;
            inputjson.pagenumber = request.page;
            inputjson.pagesize = request.limit;
          const sql = 'select * from tb_provider_checklist_search($1)';
          return util.executeSecondaryNodeDBQuery(sql,[inputjson])
            .then(data => data)
            .then(data => { return data; })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    // to get provider details

    Tb_provider.remoteMethod('getproviderDetailsforReport', {
      http: {
              path: '/getproviderDetailsforReport',
              verb: 'post'
      },
      accepts : [ {arg : 'data',type : 'object',
          http : {source : 'body'}} ],
      returns: {
          type : 'string',
          root : true
      }
  });

    Tb_provider.getproviderDetailsforReport = function(request)
    {  
 
            var inputjson = request.where;
          const sql = 'select * from get_provider_info_forsearch($1)';
          return util.executeDBQuery(sql, [JSON.stringify(inputjson)])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };


    // to get the provider maintainance  detail 
    Tb_provider.remoteMethod('getproviderMaintainancesearch', {
        http: {
                path: '/getproviderMaintainancesearch',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}
          ,{
  arg: 'reqctx',
  type: 'object',
  http: {source: 'context'}
}  ],
        returns: {
            type : 'string',
            root : true
        }
    });

    // get_provider_payment_header declares paymentid, providerid, clientid, zip
    // and taxid as INT and assigns the raw json text straight into them, so any
    // non-numeric value raises 22P02 in Postgres. error-logger turns that into a
    // bare 400 with no indication of which field was at fault, so screen it here.
    const NUMERIC_SEARCH_FIELDS = ['paymentid', 'providerid', 'clientid', 'zip'];

    function badRequest(message) {
      const err = new Error(message);
      err.statusCode = 400;
      return Promise.reject(err);
    }

     Tb_provider.getproviderMaintainancesearch = function(request,reqctx)
    {
      let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }
            // The body arg is not declared required, and util.beforeremote only
            // defaults where/page/limit when the body is present, so a call
            // without one reaches here as undefined -- as the guard below
            // already anticipates. Say so rather than throwing a TypeError.
            if (!request) {
              return badRequest('getproviderMaintainancesearch requires a request body');
            }
            var insertedby = (request && request.securityuserid?request.securityuserid: suserid);

            var inputjson = request.where || {};

            const invalidField = NUMERIC_SEARCH_FIELDS.find(field => {
              const value = inputjson[field];
              return value !== null && value !== undefined && String(value).trim() !== '' &&
                !/^\d+$/.test(String(value).trim());
            });
            if (invalidField) {
              return badRequest(invalidField + ' must be numeric');
            }

            // taxid is only used as a LIKE pattern in the procedure, so search on
            // the digits rather than rejecting the formatted forms the screen
            // permits (the input mask allows '.' and '/', and blocks neither paste
            // nor the dashes in a FEIN or SSN).
            if (inputjson.taxid !== null && inputjson.taxid !== undefined && String(inputjson.taxid).trim() !== '') {
              const taxidDigits = String(inputjson.taxid).replace(/\D/g, '');
              if (taxidDigits === '') {
                return badRequest('taxid must contain at least one digit');
              }
              inputjson.taxid = taxidDigits;
            }

            inputjson.enteredby = insertedby;
            inputjson.pagenumber = request.page;
            inputjson.pagesize = request.limit;
          const sql = 'select * from get_provider_payment_header($1)';
          return util.executeSecondaryNodeDBQuery(sql,[JSON.stringify(inputjson)])
            .then(data =>(data))
            .then(data => { return data; })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };


    Tb_provider.remoteMethod('getFinanceCounty', {
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

    Tb_provider.getFinanceCounty = (request,reqctx )=> {
      let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
          const sql = 'select * from get_county_values($1)';
          return util.executeSecondaryNodeDBQuery(sql,[(request && request.securityuserid?request.securityuserid: suserid)])
        .then(data => { return data; })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_provider.remoteMethod('getConservedBalance', {
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

    Tb_provider.getConservedBalance = request => {
          const sql = 'select * from get_conserved_alert($1,$2,$3)';
        return util.executeSecondaryNodeDBQuery(sql,[request.where.county_cd,request.page,request.limit])
        .then(data => { return data; })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    
    Tb_provider.remoteMethod('updateReleasePayment', {
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

  Tb_provider.updateReleasePayment = request => {
      const sql = 'select * from sp_check_release_payment($1)';
      return util.executeDBQuery(sql, [request.where.provider_id])
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };


  Tb_provider.remoteMethod('updatepaymentwithold', {
    http: {
            path: '/updatepaymentwithold',
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

Tb_provider.updatepaymentwithold = function(request,reqctx)
{  
  let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
        var insertedby = (request && request.securityuserid?request.securityuserid: suserid);
        var inputjson = request;
        inputjson.enteredby = insertedby;
      const sql = 'select * from witholdefthistory($1)';
      return util.executeDBQuery(sql, [inputjson])
    .then(data => data)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};


Tb_provider.remoteMethod('getplacementlist', {
  http: {
          path: '/getplacementlist',
          verb: 'post'
  },
  accepts : [ {arg : 'data',type : 'object',
      http : {source : 'body'}} ],
  returns: {
      type : 'string',
      root : true
  }
});
Tb_provider.getplacementlist = function(data) {
  let newJsonStructure = {};
  newJsonStructure = data.where;
  let sql = '';

  const Totalcount = 0;
  let result;

  sql = `select * from get_placement_details($1)`;
  return util.executeDBQuery(sql, [JSON.stringify(newJsonStructure)])
    .then(_data => {
      if (_data !== null && typeof _data !== 'undefined' && _data.length > 0) {
        result = {
          _data,
          'count': _data[0].totalcount,
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

Tb_provider.remoteMethod(
  'addupdate',
  {
      http: {
          path: '/addupdate',
          verb: 'post'
      },
      accepts: [{arg: 'data', type: 'object',
          http: { source: 'body' }
      },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
          type: 'object',
          root: true
      }
  }
);

Tb_provider.addupdate = function(request, reqctx)
{  
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    request.update_user_id = suserid;
    request.update_ts = new Date().toLocaleString();
    return Tb_provider.updateAll({
      provider_id : request.provider_id
    }, request)
    .then(data => data)
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};
  
    
    Tb_provider.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_provider.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_provider.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}