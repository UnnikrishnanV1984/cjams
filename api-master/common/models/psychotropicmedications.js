'use strict';
const LOGGER = require("log4js").getLogger("psychotropicmedications");
let app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
let config = require('../../server/config.json');
const email = require('../models/email');

module.exports = function (psychotropicmedications){

    
        psychotropicmedications.addpsychotropicmedications =function(request,reqctx){
          let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }

      request.user_id = (request && request.securityuserid?request.securityuserid: suserid);

      if (request!=null && request!=undefined)
      {
        let sql = 'select * from addpsychotropicmedications($1)';
        return util.executeDBQuery(sql, [request])
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      }
        return Promise.resolve('failure');
    };
              
    psychotropicmedications.remoteMethod(
          'addpsychotropicmedications', 
                {
                  http: {
                      path: '/addpsychotropicmedications',
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

  
        psychotropicmedications.remoteMethod('psychotropicdelete', {
          http: { 
                  path: '/psychotropicdelete/:id',
                  verb: 'delete'
                },
      accepts:
         [ {
          arg: 'id',
          type: 'string',
          required: true,
          http: { source: 'path' }
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          returns: 
               {
            type: 'Object',
            root: true
           }
      });
      
      psychotropicmedications.psychotropicdelete = (id,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        let sql = 'update psychotropicmedications set activeflag = 0,updatedby=$1,updatedon=now()  WHERE personmedicpshychotropicid =\''+id+'\'';
        let params = [suserid];
        return util.executeDBQuery(sql, params)
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
        };
        

        psychotropicmedications.remoteMethod('psychotropicdreftdelete', {
          http: { 
                  path: '/psychotropicodreftdelete/:id',
                  verb: 'delete'
                },
      accepts:
         [ {
          arg: 'id',
          type: 'string',
          required: true,
          http: { source: 'path' }
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          returns: 
               {
            type: 'Object',
            root: true
           }
      });
      
      psychotropicmedications.psychotropicdreftdelete = (id,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
        let sql = 'UPDATE cjams.routing SET activeflag = 0 , updatedon=now(),updatedby =$2  WHERE routingstatustypeid = 904 AND eventcode = \'PSY\' AND objectid = $1';
        let params = [id,suserid];
        return util.executeDBQuery(sql, params)
          .then(data => {
            return data;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
        };

        psychotropicmedications.getpsychotropichistory = function (request) {

          let sql = "select * from getpsychotropichistory($1)";

        let psychotropicid =request.where.psychotropicid ? request.where.psychotropicid : null
          let params = [psychotropicid];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        psychotropicmedications.remoteMethod('getpsychotropichistory', {
          accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          },
          http: {
            path: '/getpsychotropichistory',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });
        psychotropicmedications.getpsychotropicdetails = function (request) {

          let sql = "select ps.*,(select  json_agg(uploadfile)  from (select * from documentproperties dp where dp.additionalobjectid=ps.psychotropicid::character varying" +
            "and dp.additionalobjecttype='psychotropicmedications' and dp.activeflag=1) as uploadfile) as  uploadfile from cjams.psychotropicmedications ps"+
            "where ps.psychotropicid=$1 and ps.activeflag =1  ";

        let psychotropicid =request.where.psychotropicid ? request.where.psychotropicid : null
          let params = [psychotropicid];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        psychotropicmedications.remoteMethod('getpsychotropicdetails', {
          accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          },
          http: {
            path: '/getpsychotropicdetails',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        psychotropicmedications.getpsychotropiclist = function (request,reqctx) {
          let _securityusersid = undefined;
          if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            _securityusersid = reqctx.req.headers.securityusersid;
          }  
          let securityusersid = (request && request.where.securityusersid ? request.where.securityusersid: _securityusersid);
          let roletypekey= request.where.roletypekey?request.where.roletypekey:null;
          let filterdatetype =request.where.filterdatetype?request.where.filterdatetype:null;
          let searchobj =request.where.searchobj ?request.where.searchobj:null;
      let sortorder= request.where.sortorder?request.where.sortorder:null;
     let sortcolumn= request.where.sortcolumn?request.where.sortcolumn:null;
     let selectedSecurityusersid =request.where.selectedsecurityusersid?request.where.selectedsecurityusersid:null;
     let tabselected = request.where.tabselected?request.where.tabselected:null;
          let sql = 'select * from psychotropicscreenindashboard($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) ';
          let params = [securityusersid,roletypekey,filterdatetype, request.where.pagenumber, request.where.limit,sortcolumn,sortorder,searchobj,selectedSecurityusersid,tabselected];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };

        psychotropicmedications.getothercurrentmedication = function (request) {

          let sql = "select * from getothercurrentmedication($1,$2,$3)";

        let psychotropicid =request.where.psychotropicid ? request.where.psychotropicid : null
        let personid =request.where.personid ? request.where.personid : null
        let caseid =request.where.caseid ? request.where.caseid : null
          let params = [psychotropicid,personid,caseid];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        psychotropicmedications.remoteMethod('getothercurrentmedication', {
          accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          },
          http: {
            path: '/getothercurrentmedication',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        psychotropicmedications.remoteMethod('getpsychotropiclist', {
          accepts:[ {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          http: {
            path: '/getpsychotropiclist',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        psychotropicmedications.getpsychotropicroutinguserlist = function (request,reqctx) {
          let _securityusersid = undefined;
          if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
            _securityusersid = reqctx.req.headers.securityusersid;
          }  
          let securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
          let roletypekey= request.where.roletypekey?request.where.roletypekey:null;
          let sql = 'select * from cjams.psychotropicroutinguserlist($1,$2) ';
          let params = [securityusersid,roletypekey];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        psychotropicmedications.getpsychotropic = function (request) {

          let sql= "select * from psychotropicmedications where psychotropicid =$1 ";
        let psychotropicid =request.where.psychotropicid ? request.where.psychotropicid : null
          let params = [psychotropicid];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        psychotropicmedications.remoteMethod('getpsychotropic', {
          accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          },
          http: {
            path: '/getpsychotropic',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });


        psychotropicmedications.remoteMethod('getpsychotropicroutinguserlist', {
          accepts:[ {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
          http: {
            path: '/getpsychotropicroutinguserlist',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });


  psychotropicmedications.remoteMethod('personmedicallist', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });


  psychotropicmedications.personmedicallist = function (request) {
    const personid = request.where.personid;
    let sql = `select * from cjams.psychotropicpersonmedicallist($1)`;
    let params = [personid];
    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };
      

        psychotropicmedications.getcasenumberpsychotropic = function (request) { //NOSONAR

          let sql= "select * from cjams.getcasenumberpsychotropic($1)";
        let caseworkerid =request.where.securityusersid ? request.where.securityusersid : null
          let params = [caseworkerid];
          return util.executeDBQuery(sql, params)
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

        };
      
        psychotropicmedications.remoteMethod('getcasenumberpsychotropic', {
          accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
              source: 'query'
            },
            required: true
          },
          http: {
            path: '/getcasenumberpsychotropic',
            verb: 'get'
          },
          returns: {
            type: 'Object',
            root: true
          }
        });

        psychotropicmedications.remoteMethod('psychotropicrouting', {
          http: {
                  path: '/psychotropicrouting',
                  verb: 'post'
          },
          accepts : [ {arg : 'data',type : 'object',
              http : {source : 'body'}}, {
                  arg: 'reqctx',
                  type: 'object',
                  http: {source: 'context'}
                } ],
          returns: {
              type : 'string',
              root : true
          }
      });
      
      psychotropicmedications.psychotropicrouting = (request, reqctx) => {
        let securityusersid = getSecurityUserId(request, reqctx);
        request.fromsecurityusersid = securityusersid;
        normalizeRequestData(request);
        let apiurl=reqctx?.req?.headers?.origin ? reqctx?.req?.headers?.origin :null;
        let sql = 'select * from cjams.psychotropicrouting($1)';
        return util.executeDBQuery(sql, [request]).then( (data)=>{
          if (isReviewCoordinator(request)) {
            getpsychotropicmails(request.tosecurityusersid, apiurl,request?.statustext,request?.psychotropicid ,'psychotropic',securityusersid);
          } else if(request?.statustext === 'psychotropic_return' || request?.statustext === 'psychotropic_approve' || request?.statustext === 'psychotropic_reject') {
            getpsychotropicmails(request.securityusersid, apiurl,request?.statustext,request?.psychotropicid ,'psychotropic',securityusersid);
          }
          resolve(data);
        }).catch((err) => {
          LOGGER.error(err);
        });
      };
      
      function getSecurityUserId(request, reqctx) {
        if (request?.securityuserid) {
          return request.securityuserid;
        }
        return reqctx?.req?.headers?.securityusersid;
      }
      
      function normalizeRequestData(request) {
        request.casenumber = request.casenumber || '';
        request.clientname = request.clientname || '';
        request.pid = request.pid || '';
      }
      
      
      function isReviewCoordinator(request) {
        return request?.statustext === 'reviewcoordinator_to_pharmacist' ||  request?.statustext === 'psychotropic_return_reviewcoordinator' ||
               request?.statustext === 'reviewcoordinator_to_psychiatrist' || request?.statustext === 'psychotropic_initial_submission' || 
               request?.statustext === 'return_to_reviewcoordinator' || request?.statustext === 'pharmacist_to_psychiatrist' || 
               request?.statustext === 'psychiatrist_to_pharmacist';
      }

  async function getpsychotropicmails(request,apiurl,statustext,objectid,objecttype,securityusersid) {
    let sql = '';
    let params = [];
    if(statustext === 'reviewcoordinator_to_pharmacist' || statustext === 'reviewcoordinator_to_psychiatrist' || statustext === 'pharmacist_to_psychiatrist' || statustext === 'psychiatrist_to_pharmacist'){
      sql = 'select email from userprofile  where securityusersid =$1';
      params = [request];
    }
    if(statustext === 'psychotropic_initial_submission' || statustext === 'psychotropic_return_reviewcoordinator' || statustext === 'return_to_reviewcoordinator'){
       sql = "select settingvalue from settings where settingname = 'psychotrophic_coordinators_group_email' and activeflag = 1";
    }

    if(statustext === 'psychotropic_return' || statustext === 'psychotropic_approve' || statustext === 'psychotropic_reject') {
      sql = `select up.email,concat_ws(' ', coalesce(up.firstname,null),coalesce(up.middlename,null),coalesce(up.lastname,null) ):: character varying as caseworkername,p.cjamspid,concat_ws(' ', coalesce(p.firstname,null),coalesce(p.middlename,null),coalesce(p.lastname,null) ):: character varying as clientname,(select sup.email from userprofile sup
      where sup.securityusersid = up.supervisorid and sup.activeflag = 1) AS supervisoremail from userprofile up inner join psychotropicmedications ps on up.securityusersid = ps.insertedby inner join person p on p.personid=ps.personid where ps.psychotropicid = $1 and ps.activeflag=1`;
      params = [objectid];
    }
    try {
      const data = await util.executeDBQuery(sql, params);
      let recipients = getRecipients(data, statustext);
      if(recipients){
        if(statustext === 'psychotropic_return' || statustext === 'psychotropic_approve' || statustext === 'psychotropic_reject') {
          await sendemailnotificationforuser(recipients, apiurl, objectid, objecttype,securityusersid,data,statustext);
        } else {
          await sendreturnemailnotification(recipients, apiurl, objectid, objecttype,securityusersid);
        }
      }
      return data;
    } catch(err12) {
      LOGGER.error(err12);
      return err12;
    }
  }

  function getRecipients(data, statustext){
    let recipients =''
      if (data) {
        if(statustext === 'psychotropic_return' || statustext === 'psychotropic_approve' || statustext === 'psychotropic_reject') {
          if(data.length > 0) {
            const row = data?.[0];
            recipients = [row.email, row.supervisoremail].join(',');
          }
        }
        if (statustext === 'psychotropic_initial_submission' || statustext === 'psychotropic_return_reviewcoordinator' || statustext === 'return_to_reviewcoordinator') {
          recipients = data.map(row => row.settingvalue).join(';');
        }
        if (statustext === 'reviewcoordinator_to_pharmacist' || statustext === 'reviewcoordinator_to_psychiatrist' || statustext === 'pharmacist_to_psychiatrist' || statustext === 'psychiatrist_to_pharmacist') {
          recipients = data.map(row => row.email).join(';');
        }
      }
      return recipients;
  }

  function sendreturnemailnotification(request,apiurl,objectid, objecttype,securityusersid) {
      const psychotropicQuery = "select settingvalue from settings where settingname = 'psychotropic_cjams'";
      return util.executeDBQuery(psychotropicQuery, [])
          .then(result => {
          const clicklogin = result[0].settingvalue; // Assuming result is a string with the login URL
          const subject ='Psychotropic Medication Review';
          const body ='<html style="color:black !important">Hi,<br/>'+
          "Psychotropic Medication Review requested for a client in CJAMS. Please login to the CJAMS system to review and take action." +
          '<br/> Click here to login: <a href=' + clicklogin + '>CJAMS</a>. <br/>' +
          "<br/>This is a system generated email, please do not respond. <br/> <br/> -- <br/>CJAMS</html>";  
            email.SendEmailPshychotropic(request, subject, body,apiurl,objectid, objecttype,securityusersid);
            return 'success';
      })
      .catch(error => {
          LOGGER.error('Error executing query:', error);
          return 'failure';
      });
  }

  function sendemailnotificationforuser(request,apiurl,objectid, objecttype,securityusersid,data,statustext) {
    const psychotropicQuery = "select settingvalue from settings where settingname = 'psychotropic_cjams'";
    return util.executeDBQuery(psychotropicQuery, [])
        .then(result => {
          let body = '';
          if(data.length > 0) {
            const row = data?.[0];
            const clicklogin = result[0].settingvalue; // Assuming result is a string with the login URL
            const subject ='Psychotropic Medication Secondary Review';
    
            if(statustext === 'psychotropic_return'){
              body = '<html style="color:black !important">Hi '+ row.caseworkername +', <br/>'+
              '<br/>Psychotropic Medication Secondary Review for the client <strong>CJAMS PID#: '+ row.cjamspid +' ('+ row.clientname+')</strong> is now returned to the worker <strong>'+row.caseworkername+'</strong>. Please login to the CJAMS system to review and take action.<br/>'+              
              '<br/>Click here to login: <a href='+clicklogin+'>CJAMS Login</a>. <br/>'+
              '<br/>This is a system generated email, please do not respond.<br/> <br/> -- <br/>CJAMS</html>';
            } else if(statustext === 'psychotropic_approve' || statustext === 'psychotropic_reject'){
              const statusdata = returnstatus(statustext);
              body = '<html style="color:black !important">Hi '+row.caseworkername+', <br/>'+
              '<br/>Psychotropic Medication Secondary Review for the client <strong>CJAMS PID#: '+row.cjamspid+' ('+row.clientname+')</strong> is '+statusdata+'. Please login to the CJAMS system to review and take action.<br/>'+
              '<br/>Click here to login: <a href='+clicklogin+'>CJAMS Login</a>. <br/>'+
              '<br/>This is a system generated email, please do not respond.<br/> <br/> -- <br/>CJAMS</html>';
            }
            email.SendEmailPshychotropic(request, subject, body,apiurl,objectid, objecttype,securityusersid);
          }
        return 'success';
    })
    .catch(error => {
        LOGGER.error('Error executing query:', error);
        return 'failure';
    });
  }

  psychotropicmedications.remoteMethod('getUserdetailsById', {
    accepts: [{
        arg: 'filter',
        type: 'object',
        http: {
            source: 'query'
        }
    }],
    http: {
      path: '/getUserdetailsById',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  psychotropicmedications.getUserdetailsById = function (request) {

    let sql= `select up.securityusersid,up.fullname,up.firstname,up.lastname,up.roletypekey from v_userprofile up where up.securityusersid = $1`;
    let params = [request.where.id];
    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

    psychotropicmedications.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    psychotropicmedications.observe('access', (ctx, next) => util.access(ctx, next));
    psychotropicmedications.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}

function returnstatus(statustext) {
  return statustext === 'psychotropic_approve' ? 'Approved' : 'Rejected';
}