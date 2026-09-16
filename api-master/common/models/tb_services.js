'use strict';
const LOGGER = require("log4js").getLogger("tb_services");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_services) {
    
    Tb_services.remoteMethod('getbundledplacementserviceslist', {
        accepts:[ {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    }],
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Tb_services.getbundledplacementserviceslist = request => {
          const sql = 'select * from getbundledplacementserviceslist()';
        return util.executeSecondaryNodeDBQuery(sql, [])
        .then(data => { return data; })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_services.remoteMethod('getplacementstructureslist', {
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

    Tb_services.getplacementstructureslist = request => {
        const structure_service_cd = request.where.structure_service_cd;
        const provider_id = request.where.provider_id;
          const sql = 'select * from getplacementstructureslist($1,$2)';
        return util.executeSecondaryNodeDBQuery(sql,[structure_service_cd,provider_id])
        .then(data => { return data; })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

Tb_services.remoteMethod('getcomarlist', {
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
    Tb_services.getcomarlist = request => {
          const sql = 'select * from tb_services where structure_service_cd = \'P\' and comar_sw = \'Y\'';
          return util.executeDBQuery(sql, [])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    
    Tb_services.remoteMethod('addupdate', {
      http: {
              path: '/addupdate',
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

  Tb_services.addupdate = function(request,reqctx)
  {  let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
      var service_id = request.service_id;
      var insertedon = new Date().toLocaleString();
      var securityusersid= (request && request.securityuserid?request.securityuserid: suserid);
      if (service_id){   
        request.update_user_id = securityusersid;
        request.update_ts = insertedon;
        return Tb_services.updateAll({service_id:service_id},request).then(data => {
            return data;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      }else {
        request.create_user_id = securityusersid;
        request.update_user_id = securityusersid;
       
        return Tb_services.create(request).then(data => {
        return data;
}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        
      }
    
  };


  Tb_services.list = (request) => {
              const pageno = request.page;
              const pagesize = request.limit;
              var totalcount = 0;
     
              var sql= 'select * from gettb_servicelist($1,$2,$3,$4,$5)';
              return util.executeSecondaryNodeDBQuery(sql,[request.where.service_id, pagesize, pageno,request.where.sortcolumn,request.where.sortorder])
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
          .then(data => { return data; })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });       
                      
          };
          
          Tb_services.remoteMethod('list', {
                  accepts : {
                  arg : 'filter',
                  type : 'Object',
                  http : {
                  source : 'query'
                  },
                  required : true
                  },
                  http : {
                  path: '/list',
                  verb : 'get'
                  },
                  returns : {
                  type : 'Object',
                  root : true
                  }
                  });

                  Tb_services.costofcarelist = (request) => {
                    const pageno = request.page;
                    const pagesize = request.limit;
                    var totalcount = 0;
                    var sql= 'select * from getdhs116report($1,$2,$3,$4,$5,$6,$7)';
                    return util.executeDBQuery(sql,[request.where.type,request.where.clientaccountid, pagesize, pageno,request.where.date_sw,request.where.date_from ,request.where.date_to])
                .then(data => {
                              if (data!==null && data.length>0)
                              {totalcount= data[0].totalcount;

                              }
                            var result;
                            result = {
                              'count' : totalcount,
                              'data' : data

                            };
                            return result;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                };
                
                Tb_services.remoteMethod('costofcarelist', {
                        accepts : {
                        arg : 'filter',
                        type : 'Object',
                        http : {
                        source : 'query'
                        },
                        required : true
                        },
                        http : {
                        path: '/costofcarelist',
                        verb : 'get'
                        },
                        returns : {
                        type : 'Object',
                        root : true
                        }
                        });

                  Tb_services.remoteMethod('deleteservice', {
                      http: {
                              path: '/deleteservice',
                              verb: 'post'
                      },
                      accepts : [ {arg : 'data',type : 'object',
                          http : {source : 'body'}} ],
                      returns: {
                          type : 'string',
                          root : true
                      }
                  });

                  Tb_services.deleteservice = function(request)
                  {  
                      var service_id = request.service_id;
                   
                          return Tb_services.updateAll({service_id:service_id}, {"delete_sw":"Y"}).then(data => {
                              return data;
                          }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
              
                      
                    
                  };
  

    Tb_services.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_services.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_services.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}