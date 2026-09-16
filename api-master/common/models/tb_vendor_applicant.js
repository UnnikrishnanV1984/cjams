'use strict';
const LOGGER = require("log4js").getLogger("tb_vendor_applicant");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_vendor_applicant) {
    Tb_vendor_applicant.remoteMethod('addupdate', {
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
  
    Tb_vendor_applicant.addupdate = function(request,reqctx)
    { 
      let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }  
            request.create_ts=new Date();
            request.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
            request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
            request.update_ts =new Date();
            request.delete_sw ='N';
            var sql = "select * from addupdatevendorapplicant($1)"
            return util.executeDBQuery(sql, [request])
          .then(res =>{
            return res
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    Tb_vendor_applicant.remoteMethod('getprofileinfo', {
        http: {
            path: '/getprofileinfo',
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

    Tb_vendor_applicant.getvendorprofiledetails = function(request){
          var sql = `select up.displayname as submittedfor,va.status as status,va.vendorid,va.create_ts
          from tb_vendor_applicant va join routing r on va.vendorid=r.objectid
          join userprofile up on r.tosecurityusersid=up.securityusersid
          where vendorid=$1`
          return util.executeDBQuery(sql,[request.where.vendorid])
        .then(res =>{
          return res
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      }

      Tb_vendor_applicant.remoteMethod('getvendorprofiledetails', {
        http: {
            path: '/getvendorprofiledetails',
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

    Tb_vendor_applicant.getprofileinfo = function(request){
            var sql = "select * from getvendorprofileinfo($1)"
            return util.executeDBQuery(sql,[request.where.vendorid])
          .then(res =>{
            return res
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }
        Tb_vendor_applicant.remoteMethod('addupdatepaymentinfo', {
            http: {
                    path: '/addupdatepaymentinfo',
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
      
        Tb_vendor_applicant.addupdatepaymentinfo = function(request,reqctx)
        {  
          let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
                request.create_ts=new Date().toLocaleString();
                request.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                request.update_ts =new Date().toLocaleString();
                request.delete_sw ='N';
                var sql = "select * from addupdatepaymentinfo($1)"
                return util.executeDBQuery(sql, [request])
              .then(res =>{
                return res
              })
              .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        };
        Tb_vendor_applicant.remoteMethod('getdashboardlist', {
            http: {
                path: '/getdashboardlist',
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
    
        Tb_vendor_applicant.getdashboardlist = function(request){
                var sql = "select * from getvendorapplicantlist($1,$2,$3,$4,$5)"
                return util.executeDBQuery(sql,[null,request.where.filter,request.where.sort,request.page,request.limit])
              .then(res =>{
                return res
              })
              .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            }

            Tb_vendor_applicant.remoteMethod('getvendorpaymentinfo', {
                http: {
                    path: '/getvendorpaymentinfo',
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
        
            Tb_vendor_applicant.getvendorpaymentinfo = function(request){
                    var sql = "select * from getvendorpaymentinfo($1)"
                    return util.executeDBQuery(sql,[request.where.vendorapplicantid])
                  .then(res =>{
                    return res
                  })
                  .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                }

                Tb_vendor_applicant.remoteMethod('submitvendorapproval', {
                    http: {
                            path: '/submitvendorapproval',
                            verb: 'post'
                    },
                    accepts : [ {arg : 'data',type : 'object',
                        http : {source : 'body'}}
                        ,{
                          arg: 'reqctx',
                          type: 'object',
                          http: {source: 'context'}
                        }
                       ],
                    returns: {
                        type : 'string',
                        root : true
                    }
                });
              
                Tb_vendor_applicant.submitvendorapproval = function(request,reqctx)
                {  
                  let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
                        request.securityuserid =(request && request.securityuserid?request.securityuserid: suserid);
                        request.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                        request.update_user_id =(request && request.securityuserid?request.securityuserid:suserid);
                        var sql = "select * from submitvendorapproval($1)"
                        return util.executeDBQuery(sql, [request])
                      .then(res =>{
                        return res
                      })
                      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                };
                
                Tb_vendor_applicant.getvendorapprovallist = function(request,reqctx)
                {  
                  let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
                        var req={
                          vendorapplicantid: request.where.vendorapplicantid,
                          vendorid: request.where.vendorid
                        }
                        req.securityuserid =(request && request.securityuserid?request.securityuserid: suserid);
                        req.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                        req.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                        var sql = "select * from getvendorapprovallist($1)"
                        return util.executeDBQuery(sql, [req])
                      .then(res =>{
                        return res
                      })
                      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                };
                Tb_vendor_applicant.remoteMethod('getvendorapprovallist', {
                  http: {
                      path: '/getvendorapprovallist',
                      verb: 'get'
                  },
                  accepts : [ 
                  {
                      arg : 'filter',
                      type : 'object',
                      http : {source : 'query'}
                  },{
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  } ],  
                  returns: {
                      type : 'object',
                      root : true
                  } 
              });

                Tb_vendor_applicant.remoteMethod('getvendorsupervisorlist', {
                    http: {
                        path: '/getvendorsupervisorlist',
                        verb: 'get'
                    },
                    accepts : [ 
                    {
                        arg : 'filter',
                        type : 'object',
                        http : {source : 'query'}
                    },{
                      arg: 'reqctx',
                      type: 'object',
                      http: {source: 'context'}
                    } ],  
                    returns: {
                        type : 'object',
                        root : true
                    } 
                });
            
                Tb_vendor_applicant.getvendorsupervisorlist = function(request,reqctx){
                  
                let suserid = undefined;
                if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                 suserid = reqctx.req.headers.securityusersid
                  } 
                        var securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
                        var sql = "select * from getvendorsupervisorlist($1,$2,$3,$4,$5,$6)"
                        return util.executeDBQuery(sql,[null,request.page,request.limit,securityuserid,request.where.filter,request.where.sort])
                      .then(res =>{
                        return res
                      })
                      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    }

                    Tb_vendor_applicant.remoteMethod('supervisordecision', {
                        http: {
                                path: '/supervisordecision',
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
                  
                    Tb_vendor_applicant.supervisordecision = function(request,reqctx)
                    {  
                      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
                        var d = new Date();
                        var providerId;
                        request.securityuserid = suserid;
                        if (request!=null && request!=undefined)
                        {
                          var apptype = 'providerid'
                          var sql = 'select * from getNextNumber(\'' + apptype + '\')';
                          return util.executeDBQuery(sql, [])
                          .then(data => {
                            providerId = d.getFullYear()+("000" + d.getDay()).slice(-3)+ + ("00000" + data[0].getnextnumber).slice(-5);
                            request.provider_id = providerId;
                            var sql1 = 'select * from updatesupervisordecision($1)';
                            return util.executeDBQuery(sql1,[JSON.stringify(request)]);
                          })
                          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                        }
                        return Promise.resolve('Invalid request');
                    };

                    Tb_vendor_applicant.remoteMethod('closevendor', {
                        http: {
                                path: '/closevendor',
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
                  
                    Tb_vendor_applicant.closevendor = function(request,reqctx)
                    { 
                      let suserid = undefined;
                      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                        suserid = reqctx.req.headers.securityusersid
                      }  
                            request.create_ts=new Date();
                            request.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                            request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                            request.update_ts =new Date();
                            request.delete_sw ='N';
                            var sql = "select * from closevendorapplicant($1)"
                            return util.executeDBQuery(sql, [request])
                          .then(res =>{
                            return res
                          })
                          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    };

                    Tb_vendor_applicant.remoteMethod('managevendor', {
                      http: {
                              path: '/managevendor',
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
                
                  Tb_vendor_applicant.managevendor = function(request,reqctx)
                  {  let suserid = undefined;
                    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                      suserid = reqctx.req.headers.securityusersid
                    } 
                          request.create_ts=new Date();
                          request.securityuserid =(request && request.securityuserid?request.securityuserid: suserid);
                          request.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                          request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                          request.update_ts =new Date();
                          request.delete_sw ='N';
                          var sql = "select * from managevendorapplicant($1)"
                          return util.executeDBQuery(sql, [request])
                        .then(res =>{
                          return res
                        })
                        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                  };

                  Tb_vendor_applicant.remoteMethod('submitclosevendorapproval', {
                    http: {
                            path: '/submitclosevendorapproval',
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
              
                Tb_vendor_applicant.submitclosevendorapproval = function(request,reqctx)
                {  
                  let suserid = undefined;
                      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
                        suserid = reqctx.req.headers.securityusersid
                      } 
                        request.securityuserid =(request && request.securityuserid?request.securityuserid: suserid);
                        request.create_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                        request.update_user_id =(request && request.securityuserid?request.securityuserid: suserid);
                        var sql = "select * from submitclosevendorapproval($1)"
                        return util.executeDBQuery(sql, [request])
                      .then(res =>{
                        return res
                      })
                      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                };
    

    Tb_vendor_applicant.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_vendor_applicant.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_vendor_applicant.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
