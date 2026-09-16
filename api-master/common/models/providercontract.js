'use strict';
const LOGGER = require("log4js").getLogger("providercontract");
var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Providercontract) {

  Providercontract.getprovidercontracts =function(request){
    var providerid = request.where.provider_id;

    var sql = 'SELECT * FROM tb_provider_contracts where provider_id= $1';

    return util.executeDBQuery(sql, [providerid])
      .then(data => ({data : data}))
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
	};

	Providercontract.remoteMethod(
    'getprovidercontracts', 
    {
      accepts : {
        arg : 'data',
        type : 'object',
        http : {
          source : 'body'
        },
      },
      http: {
        path: '/getprovidercontracts',
        verb: 'POST'
      },
      returns : {
        type : 'object',
        root : true
      }
    }
    );



    // 2
    Providercontract.getproviderlicenserates =function(request){
      var providerid = request.where.provider_id;
        var sql = 'SELECT * FROM tb_provider_rates_master where provider_id= $1 order by provider_rate_id desc';
        return util.executeDBQuery(sql, [providerid])
          .then(data => ({data : data}))
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
    };
  
    Providercontract.remoteMethod(
      'getproviderlicenserates', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getproviderlicenserates',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
    );


    // 3
    // For contract license type
    Providercontract.getproviderlicensetyperates =function(request){
      var providerid = request.where.provider_id;
      var licenseType = request.where.license_type

      var sql = 'SELECT * FROM tb_provider_rates_master where provider_id= $1 and license_type=$2';

      return util.executeDBQuery(sql, [providerid, licenseType])
        .then(data => ({data : data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
    
    Providercontract.remoteMethod(
      'getproviderlicensetyperates', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getproviderlicensetyperates',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
    );


    // 4
    Providercontract.getproviderlicenseinformation =function(request){
      var providerid = request.where.provider_id;
     var sql = 'select tpl.license_no, tpl.license_level, tpl.license_type, (select value_tx from tb_picklist_values where picklist_type_id=286 and trim(picklist_value_cd)=trim(tpl.license_status_cd)) as license_status_cd, tpl.site_id, tp.provider_nm, tp.provider_category_cd, tp.adr_work_phone_tx, tcp.contract_id, tcp.program_status_cd from tb_provider_licensing tpl join tb_provider tp on tpl.site_id = tp.provider_id left join tb_contract_program tcp on tpl.license_no = tcp.license_no where tpl.provider_id=$1'

      return util.executeDBQuery(sql, [providerid])
        .then(_data => ({data : _data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
      
    Providercontract.remoteMethod(
      'getproviderlicenseinformation', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getproviderlicenseinformation',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
    );


    // 5
    Providercontract.addproviderlicenserates =function(request,reqctx){
      let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
      request.create_ts=new Date();
      request.create_user_id =(request && request.securityuserid?request.securityuserid:suserid);
        request.update_user_id =(request && request.securityuserid?request.securityuserid:suserid);
      var newJsonDataStringyfied = JSON.stringify(request)
      LOGGER.debug(newJsonDataStringyfied);
      if (request!=null && request!=undefined)
      {
      var addprovref = 'select * from addproviderlicenserates($1)';
      return util.executeDBQuery(addprovref, [newJsonDataStringyfied])
        .then(data => data)
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
      }
        return Promise.resolve('Invalid request');
    };

    Providercontract.remoteMethod(
          'addproviderlicenserates', 
                {
                  http: {
                      path: '/addproviderlicenserates',
                      verb: 'post'
                  },
                  accepts : [ {arg : 'data',type : 'object',
                      http : {source : 'body'}},{
                        arg: 'reqctx',
                        type: 'object',
                        http: {source: 'context'}
                      }  ],   
                  returns: {
                    type : 'object',
                  root : true
                  }
                  }
        );


  // 6
    Providercontract.addprovidercontractrates =function(request,reqctx){
      let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
      request.create_ts=new Date();
      request.create_user_id =(request && request.securityuserid?request.securityuserid:suserid);
        request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
      var newJsonDataStringyfied = JSON.stringify(request)
      LOGGER.debug(newJsonDataStringyfied);
      if (request!=null && request!=undefined)
      {
        var addprovref = 'select * from addupdateprovprogramrates($1)';
        return util.executeDBQuery(addprovref, [newJsonDataStringyfied])
          .then(_data => _data)
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      }
        return Promise.resolve('Invalid request');
    };
              
    Providercontract.remoteMethod(
        'addprovidercontractrates', 
              {
                http: {
                    path: '/addprovidercontractrates',
                    verb: 'post'
                },
                accepts : [ {arg : 'data',type : 'object',
                    http : {source : 'body'}},{
                      arg: 'reqctx',
                      type: 'object',
                      http: {source: 'context'}
                    }  ],   
                returns: {
                  type : 'object',
                root : true
                }
              }
      );


  // 7
  Providercontract.getprovidercontractrates =function(request){
      var providerid = request.where.provider_id;
      var sql = 'SELECT * FROM tb_prov_program_rates where program_id= $1 order by program_rate_id desc';
      return util.executeDBQuery(sql, [providerid])
        .then(data => ({data : data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    } ;
  
    Providercontract.remoteMethod(
      'getprovidercontractrates', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getprovidercontractrates',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
    );      
      

  // 8
    Providercontract.addprovidercontractlicenseservices =function(request,reqctx){
      let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
      request.create_ts= new Date();
      request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);

      var newJsonDataStringyfied = JSON.stringify(request)
      LOGGER.debug(newJsonDataStringyfied);
      if (request!=null && request!=undefined)
      {
        var addprovservices = 'select * from addprovidercontractlicenseservices($1)';
        return util.executeDBQuery(addprovservices, [newJsonDataStringyfied])
          .then(data => data)
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      }
        return Promise.resolve('Invalid request');
    };
              
    Providercontract.remoteMethod(
          'addprovidercontractlicenseservices', 
                {
                  http: {
                      path: '/addprovidercontractlicenseservices',
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
                    type : 'object',
                  root : true
                  }
                  }
        );


  // 9
    Providercontract.getprovidercontractlicenseservices =function(request){
      var providerid = request.where.provider_id;
      var programId = request.where.program_id;

      var sql = 'SELECT ts.service_nm,* FROM tb_provider_services tps join tb_services ts on tps.service_id = ts.service_id where tps.provider_id=$1 and tps.program_id=$2 order by provider_service_id desc';

      return util.executeDBQuery(sql, [providerid,programId])
        .then(data => ({data : data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
  
    Providercontract.remoteMethod(
      'getprovidercontractlicenseservices', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getprovidercontractlicenseservices',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
      );

    
  // 10
    Providercontract.getpicklistvaluesbytypeid =function(request){
      var picklistTypeId = request.where.picklist_type_id;
      var sql = 'SELECT * from tb_picklist_values where picklist_type_id=$1';

      return util.executeDBQuery(sql, [picklistTypeId])
        .then(data => ({data : data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
  
    Providercontract.remoteMethod(
      'getpicklistvaluesbytypeid', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getpicklistvaluesbytypeid',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
      );


    // 11
    Providercontract.addcontractchildcharacteristics =function(request,reqctx){
      let suserid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        suserid = reqctx.req.headers.securityusersid
      }
      request.create_ts= new Date();
      request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);

      var newJsonDataStringyfied = JSON.stringify(request)
      LOGGER.debug(newJsonDataStringyfied);
      if (request!=null && request!=undefined)
      {
        var addcontractchar = 'select * from addcontractchildcharacteristics($1)';
      return util.executeDBQuery(addcontractchar, [newJsonDataStringyfied])
        .then(data1 => data1)
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
      }
        return Promise.resolve('Invalid request');
    };
                      
    Providercontract.remoteMethod(
          'addcontractchildcharacteristics', 
                {
                  http: {
                      path: '/addcontractchildcharacteristics',
                      verb: 'post'
                  },
                  accepts : [ {arg : 'data',type : 'object',
                      http : {source : 'body'}},{
                        arg: 'reqctx',
                        type: 'object',
                        http: {source: 'context'}
                      } ],   
                  returns: {
                    type : 'object',
                  root : true
                  }
                  }
        );
        

  // 12
    Providercontract.getcontractchildcharacteristics =function(request){
      var picklistTypeId = request.where.picklist_type_id;
      var programId = request.where.program_id;
      var providerId= request.where.provider_id;

      var sql = 'SELECT * from tb_provider_picklist where provider_id=$1 and program_id=$2 and picklist_type_id=$3';

      return util.executeDBQuery(sql, [providerId,programId,picklistTypeId])
        .then(data => ({data : data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
                          
    Providercontract.remoteMethod(
      'getcontractchildcharacteristics', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getcontractchildcharacteristics',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
    );

    Providercontract.deletecontractchildcharacteristics =function(request){
      var picklistTypeId = request.where.picklist_type_id;
      var providerId= request.where.provider_id;

      var sql = 'delete from tb_provider_picklist where provider_id=$1 and provider_picklist_id=$2';

      return util.executeDBQuery(sql, [providerId,picklistTypeId])
        .then(data => ({data : data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
                          
    Providercontract.remoteMethod(
      'deletecontractchildcharacteristics', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/deletecontractchildcharacteristics',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
    );


    

  /***
   * APIs for contracts at Provider Level
   * 
  ***/
  Providercontract.addprovidercontractwithlicensetypes =function(request,reqctx){
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    request.create_ts= new Date();
    request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);

    // Update sending because of Null constraint on the DB columns
    request.update_ts= new Date();
    request.update_user_id = (request && request.securityuserid?request.securityuserid: suserid);

    var newJsonDataStringyfied = JSON.stringify(request)

    LOGGER.debug(newJsonDataStringyfied);
    if (request!=null && request!=undefined)
    {
      var addprovservices = 'select * from addprovidercontractwithlicensetypes($1)';
      return util.executeDBQuery(addprovservices, [newJsonDataStringyfied])
        .then(data => data)
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    }
      return Promise.resolve('Invalid request');
  };

  Providercontract.remoteMethod(
      'addprovidercontractwithlicensetypes', 
            {
              http: {
                  path: '/addprovidercontractwithlicensetypes',
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
                type : 'object',
              root : true
              }
             }
    );

  Providercontract.getprovidercontractwithlicensetypes =function(request){
      var providerId= request.where.provider_id;

      var sql = 'SELECT  tpc.*, json_agg((SELECT x FROM (SELECT tcp.program_id, tcp.license_no, tpl.license_level, tpl.license_type, tpl.site_id) AS x)) AS contract_license_types FROM tb_provider_contracts tpc LEFT JOIN tb_contract_program tcp ON tpc.contract_id = tcp.contract_id LEFT JOIN tb_provider_licensing tpl on tpl.license_no = tcp.license_no where tpc.provider_id = $1 GROUP BY tpc.contract_id'
      return util.executeDBQuery(sql, [providerId])
        .then(data => ({data : data}))
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };
    
    Providercontract.remoteMethod(
      'getprovidercontractwithlicensetypes', 
      {
        accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
        },
        http: {
          path: '/getprovidercontractwithlicensetypes',
          verb: 'POST'
        },
        returns : {
          type : 'object',
          root : true
        }
      }
    );


  /***
   * APIs for managing the contract license types
   * 
  ***/
 Providercontract.addprovidercontractinfo =function(request,reqctx){
  let suserid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    suserid = reqctx.req.headers.securityusersid
  }
  request.create_ts= new Date();
  request.create_user_id = (request && request.securityuserid?request.securityuserid: suserid);

  // Update sending because of Null constraint on the DB columns
  request.update_ts= new Date();
  request.update_user_id = (request && request.securityuserid?request.securityuserid: suserid);

  var newJsonDataStringyfied = JSON.stringify(request)

  LOGGER.debug(newJsonDataStringyfied);
  if (request!=null && request!=undefined)
  {
    var addcontractinfo = 'select * from addprovidercontractinfo($1)';
    return util.executeDBQuery(addcontractinfo, [newJsonDataStringyfied])
      .then(data2 => data2)
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }
    return Promise.resolve('Invalid request');
};

Providercontract.remoteMethod(
    'addprovidercontractinfo', 
          {
            http: {
                path: '/addprovidercontractinfo',
                verb: 'post'
            },
           accepts : [ {arg : 'data',type : 'object',
               http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }  ],   
            returns: {
              type : 'object',
            root : true
            }
           }
  );

    

  // Default
  Providercontract.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Providercontract.observe('access', (ctx, next) => util.access(ctx, next));
  Providercontract.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
