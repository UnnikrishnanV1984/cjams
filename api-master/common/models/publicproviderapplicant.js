'use strict';
const LOGGER = require("log4js").getLogger("publicproviderapplicant");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('../models/email');

module.exports = function (Publicproviderapplicant) {


    Publicproviderapplicant.getpublicapplicantaddresses =function(request){
        var applicantId = request.where.applicant_id;


        var sql = 'SELECT array_to_json(array_agg(row_to_json(d))) as addresses from ( SELECT * from tb_provider_applicant_addresses pa join tb_provider_address_mapping pam on pa.address_id = pam.address_id where pam.object_id = $1 ) as d';

        return util.executeDBQuery(sql, [applicantId])
          .then(data => {
              return {data : data};
            })
          .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
      };
                            
      Publicproviderapplicant.remoteMethod(
        'getpublicapplicantaddresses', 
        {
          accepts : {
            arg : 'data',
            type : 'object',
            http : {
              source : 'body'
            },
          },
          http: {
            path: '/getpublicapplicantaddresses',
            verb: 'POST'
          },
          returns : {
            type : 'object',
            root : true
          }
        }
      );

      Publicproviderapplicant.getpublicapplicantByaddressesType =function(request){
        var applicantId = request.where.applicant_id;
        var addressType=request.where.addressType;
        LOGGER.debug(applicantId+"************"+addressType)
        LOGGER.debug("***************************************")
        var sql = "select aa.* from tb_provider_applicant_addresses aa inner join tb_provider_address_mapping am on aa.address_id=am.address_id where am.object_id='"+applicantId+"' and am.address_type='"+addressType+"'";
    LOGGER.debug("*********"+sql+"*****************************")
        return util.executeDBQuery(sql, [])
          .then(data => {
              return {data : data};
            })
          .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
      };


      Publicproviderapplicant.remoteMethod(
        'reopenpublicapplication', 
        {
          accepts : [{
            arg : 'data',
            type : 'object',
            http : {
              source : 'body'
            },
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
          http: {
            path: '/reopenpublicapplication',
            verb: 'POST'
          },
          returns : {
            type : 'object',
            root : true
          }
        }
      );

      Publicproviderapplicant.reopenpublicapplication =function(request,reqctx){
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        var securityuserid = (request && request.securityuserid?request.securityuserid:suserid);
        var sql = "select * from reopenapplication($1,$2,$3)";
        return util.executeDBQuery(sql, [request.where.applicantid,securityuserid,request.where.tosecurityuserid])
          .then(data => {
              return {data : data};
            })
          .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
      };
                            
      Publicproviderapplicant.remoteMethod(
        'getpublicapplicantByaddressesType', 
        {
          accepts : {
            arg : 'data',
            type : 'object',
            http : {
              source : 'body'
            },
          },
          http: {
            path: '/getpublicapplicantByaddressesType',
            verb: 'POST'
          },
          returns : {
            type : 'object',
            root : true
          }
        }
      );

      Publicproviderapplicant.getproviderapplicantservices =function(request){
        var applicantId = request.where.applicant_id;

        var sql = 'SELECT pas.*,s.service_nm, s.structure_service_cd FROM tb_provider_applicant_services pas inner join tb_services s on s.service_id=pas.service_id where applicant_id=$1 order by applicant_service_id desc';

        return util.executeDBQuery(sql, [applicantId])
          .then(data => {
            return {data : data};
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
        };
      
        Publicproviderapplicant.remoteMethod(
        'getproviderapplicantservices', 
        {
          accepts : {
          arg : 'data',
          type : 'object',
          http : {
            source : 'body'
          },
          },
          http: {
          path: '/getproviderapplicantservices',
          verb: 'POST'
          },
          returns : {
          type : 'object',
          root : true
          }
        }
        );
    
        Publicproviderapplicant.addproviderapplicantservices =function(request,reqctx){
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
            var addprovservices = 'select * from addproviderapplicantservices($1)';
            return util.executeDBQuery(addprovservices, [newJsonDataStringyfied])
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });
          }
              return Promise.resolve({ data: null, message: 'Invalid request' });
          };
              
          Publicproviderapplicant.remoteMethod(
            'addproviderapplicantservices', 
                {
                http: {
                  path: '/addproviderapplicantservices',
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
        
      
            Publicproviderapplicant.getproviderapplicanthousehold =function(request){
            var objId = request.where.object_id;

            var sql = 'SELECT * FROM tb_public_provider_applicant_household where object_id=$1 order by create_ts desc';

            return util.executeDBQuery(sql, [objId])
              .then(data => {
                return {data : data};
              })
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              });
            };
          
            Publicproviderapplicant.remoteMethod(
            'getproviderapplicanthousehold', 
            {
              accepts : {
              arg : 'data',
              type : 'object',
              http : {
                source : 'body'
              },
              },
              http: {
              path: '/getproviderapplicanthousehold',
              verb: 'POST'
              },
              returns : {
              type : 'object',
              root : true
              }
            }
            );
    
            Publicproviderapplicant.addproviderapplicanthousehold =function(request,reqctx){
              let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
              request.create_ts= new Date();
              request.create_user_id = (request && request.securityuserid?request.securityuserid:suserid);
              var newJsonDataStringyfied = JSON.stringify(request);
              LOGGER.debug('dheeraj\' s log '+ newJsonDataStringyfied);
              if (request!=null && request!=undefined)
              {
                var addprovservices = 'select * from addproviderapplicanthousehold($1)';
                return util.executeDBQuery(addprovservices, [newJsonDataStringyfied])
                  .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                  });
              }
                  return Promise.resolve({ data: null, message: 'Invalid request' });
              };
                  
              Publicproviderapplicant.remoteMethod(
                'addproviderapplicanthousehold', 
                    {
                    http: {
                      path: '/addproviderapplicanthousehold',
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
            
                Publicproviderapplicant.updateproviderapplicanthousehold =function(request,reqctx){
                  let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }

                  request.securityuserid = (request && request.securityuserid?request.securityuserid:suserid);
                  request.update_user_id = (request && request.securityuserid?request.securityuserid:suserid);
                  var newJsonDataStringyfied = JSON.stringify(request)
                  var updatehousehold = 'select * from addproviderapplicanthousehold($1)';
                  return util.executeDBQuery(updatehousehold, [newJsonDataStringyfied])
                    .catch(err => {
                      LOGGER.error('>>>>ERROR:', err);
                      throw err;
                    });
                };
              
                Publicproviderapplicant.remoteMethod(
                      'updateproviderapplicanthousehold', 
                          {
                            http: {
                                path: '/updateproviderapplicanthousehold',
                                verb: 'POST'
                            },
                            accepts : [{
                              arg : 'data',
                              type : 'object',
                              http : {
                                source : 'body'
                              }
                            }


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

                    Publicproviderapplicant.deletehouseholdmember =function(request){
                      var householdmemberId= request.where.household_member_id;

                      var deletehousehold = 'delete from tb_public_provider_applicant_household where household_member_id=$1';

                      return util.executeDBQuery(deletehousehold, [householdmemberId])
                        .then(data => {
                          return {data : data};
                        })
                        .catch(err => {
                          LOGGER.error('>>>>ERROR:', err);
                          throw err;
                        });
                      };
                                
                      Publicproviderapplicant.remoteMethod(
                      'deletehouseholdmember', 
                      {
                        accepts : {
                        arg : 'data',
                        type : 'object',
                        http : {
                          source : 'body'
                        },
                        },
                        http: {
                        path: '/deletehouseholdmember',
                        verb: 'POST'
                        },
                        returns : {
                        type : 'object',
                        root : true
                        }
                      }
                      );       
    
      Publicproviderapplicant.addapplicantchildcharacteristics =function(request,reqctx){
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
          var addapplicantchar = 'select * from addapplicantchildcharacteristics($1)';
          return util.executeDBQuery(addapplicantchar, [newJsonDataStringyfied])
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
        }
          return Promise.resolve({ data: null, message: 'Invalid request' });
      };
                        
      Publicproviderapplicant.remoteMethod(
            'addapplicantchildcharacteristics', 
                  {
                    http: {
                        path: '/addapplicantchildcharacteristics',
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
          
          Publicproviderapplicant.getapplicantchildcharacteristics =function(request){
            var picklistTypeId = request.where.picklist_type_id;
            var applicantId= request.where.applicant_id;

            var sql = 'SELECT * from tb_provider_picklist where provider_id=$1 and picklist_type_id=$2';

            return util.executeDBQuery(sql, [applicantId,picklistTypeId])
              .then(data => {
                  return {data : data};
                })
              .catch(err => {
                  LOGGER.error('>>>>ERROR:', err);
                  throw err;
                });
          };
                                
          Publicproviderapplicant.remoteMethod(
            'getapplicantchildcharacteristics', 
            {
              accepts : {
                arg : 'data',
                type : 'object',
                http : {
                  source : 'body'
                },
              },
              http: {
                path: '/getapplicantchildcharacteristics',
                verb: 'POST'
              },
              returns : {
                type : 'object',
                root : true
              }
            }
          );
          Publicproviderapplicant.deleteapplicantchildcharacteristics =function(request){
            var picklistTypeId = request.where.picklist_type_id;
            var applicantId= request.where.applicant_id;

            var sql = 'delete from tb_applicant_child_characteristics where applicant_id=$1 and applicant_child_characteristics_id=$2';

            return util.executeDBQuery(sql, [applicantId,picklistTypeId])
              .then(data => {
                  return {data : data};
                })
              .catch(err => {
                  LOGGER.error('>>>>ERROR:', err);
                  throw err;
                });
          };
                                
          Publicproviderapplicant.remoteMethod(
            'deleteapplicantchildcharacteristics', 
            {
              accepts : {
                arg : 'data',
                type : 'object',
                http : {
                  source : 'body'
                },
              },
              http: {
                path: '/deleteapplicantchildcharacteristics',
                verb: 'POST'
              },
              returns : {
                type : 'object',
                root : true
              }
            }
          );


          Publicproviderapplicant.approvepublicproviderapplication =function(request,reqctx){
            const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
            var d = new Date();
            var providerId;
            request.securityuserid = suserid;
            if (request!=null && request!=undefined)
            {
              var apptype = 'providerid'
              var sql = 'select * from getNextNumber(\'' + apptype + '\')';
              return util.executeDBQuery(sql, []).then(data => {
                providerId = d.getFullYear()+("000" + d.getDay()).slice(-3)+ + ("00000" + data[0].getnextnumber).slice(-5);
                request.provider_id = providerId;
                var sql1 = 'select * from approvepublicproviderapplication($1)';
                return util.executeDBQuery(sql1, [JSON.stringify(request)]);
              })
              .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
              })
            }
              return Promise.resolve({ data: null, message: 'Invalid request' });
          };
                    
    Publicproviderapplicant.remoteMethod(
      'approvepublicproviderapplication', 
            {
              http: {
                  path: '/approvepublicproviderapplication',
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

    Publicproviderapplicant.getassignedlist = function (request,reqctx) {
      let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
      var userid = (request && request.securityuserid?request.securityuserid: suserid);
      var requesttype = request.where.requesttype;
      var objectid = request.where.objectid;
      var status = request.where.application_status;
      var jurisdiction = request.where.jurisdiction;
      var query = '';
      var params = [];

      if (requesttype === 'dashboard') {
        // Get all applications assigned to a specific user
        query = 'select * from getdashboarddetails($1,$2)';
        params.push(userid);
        params.push(status);
      } else if (requesttype === 'assigneduserslog') {
        // Get all user assignments for a specific application
        query = 'select * from getassigneddashboardlist($1)';
        params.push(objectid);
      } else if (requesttype === 'jurisdiction') {
        // Get all user assignments for a specific application
        query = 'select * from getjurisdictiondetails($1,$2,$3,$4)';
        params.push(status);
        params.push(jurisdiction);
        params.push(request.page);
        params.push(request.limit);
      }
      LOGGER.debug("query", query);
      LOGGER.debug("params");
      return util.executeDBQuery(query, params)
        .then(data => {
          return { data: data };
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };


    

    Publicproviderapplicant.remoteMethod(
      'getassignedlist', {
        http: {
          path: '/getassignedlist',
          verb: 'post'
        },
        accepts: [{
          arg: 'data',
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
          type: 'object',
          root: true
        }
      }
    );

    Publicproviderapplicant.updatepersondata = function (request,reqctx) {
      let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 

      var userid = (request && request.securityuserid?request.securityuserid: suserid);
      var requesttype = request.where.type;
      var objectid = request.where.objectid;
      var query = '';


      if (requesttype === 'inquiry') {
        query = 'select * from updateinquiryperson($1,$2,$3)';
      } else if (requesttype === 'application') {
        query = 'select * from updateapplicationperson($1,$2,$3)';
      } else if (requesttype === 'provider') {
        query = 'select * from updateproviderperson($1,$2,$3)';
      }
      return util.executeDBQuery(query, [objectid,requesttype,userid])
        .then(data => {
          return { data: data };
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    };


    

    Publicproviderapplicant.remoteMethod(
      'updatepersondata', {
        http: {
          path: '/updatepersondata',
          verb: 'post'
        },
        accepts: [{
          arg: 'data',
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
          type: 'object',
          root: true
        }
      }
    );

    Publicproviderapplicant.publicproviderapplicantRouting = function (request,reqctx) {
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
      var userid = suserid;
      var applicantId=request.objectid;
      var toUserID=request.tosecurityusersid;
      var eventcode=request.eventcode;
      var typeofobj=request.typeofobj
      //status = 15
      var nofitymsg = 'Public provider application Submitted for review';
      LOGGER.debug(nofitymsg);
       if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "rejected") {
      //status = 17
         nofitymsg = 'Public provider application Rejected ';
       }
       else if (request && request.approvalstatustypekey && request.approvalstatustypekey.toLowerCase() == "accepted") {
      //status = 16
         nofitymsg = 'Public provider application Approved ';
       }
      LOGGER.debug(nofitymsg);
      var routingstatustypeid = request.routingstatustypeid;
      if (!routingstatustypeid){
        routingstatustypeid = 15;
      }
      
      if(!applicantId){
        applicantId ='';
      }

      if(!toUserID){
        toUserID='';
      }

      if(!eventcode){
        eventcode='';
      }

      if(!typeofobj){
        typeofobj='';
      }
      
      var sql = 'select * from publicproviderrouting($1,$2,$3,$4,$5,$6,$7,$8)';
      LOGGER.debug(sql);
      return util.executeDBQuery(sql, [applicantId, userid,toUserID, routingstatustypeid,eventcode, nofitymsg,request.comments,typeofobj])
        .then(data => {
          return { data: data };
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    }

    Publicproviderapplicant.remoteMethod(
      'publicproviderapplicantRouting', {
        http: {
          path: '/publicproviderapplicantrouting',
          verb: 'post'
        },
        accepts: [{
          arg: 'data',
          type: 'object',
          http: {
            source: 'body'
          }
        }
        ,{
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  } ],
        returns: {
          type: 'object',
          root: true
        }
      }
    );
  
    
  
    Publicproviderapplicant.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Publicproviderapplicant.observe('access', (ctx, next) => util.access(ctx, next));
    Publicproviderapplicant.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
