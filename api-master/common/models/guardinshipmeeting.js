'use strict';
const LOGGER = require("log4js").getLogger("guardinshipmeeting");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Guardinshipmeeting) { 



    Guardinshipmeeting.dashboardlist= (request) =>{
        
        var page = request.where.page;
        var limit = request.where.limit;
        var startdate=request.where.startdate;
        var enddate=request.where.enddate;
        var meetingstatus=request.where.meetingstatus;
        var meetingdate=request.where.meetingdate;
        
        var Totalcount = 0;
    
        const sql = 'Select * from getguardianshipdashboard($1,$2,$3,$4,$5,$6)';
        return util.executeSecondaryNodeDBQuery(sql, [startdate,enddate,meetingdate,meetingstatus,page,limit])
            .then(data => {
                if (data!=null && data.length > 0) {Totalcount = data[0].totalcount;}
                var result;
                result = {
                  'data': data,
                  'count': Totalcount
                };
                return result;
            })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      }
    
      Guardinshipmeeting.remoteMethod(
        'dashboardlist',
        {
            http: {
                path: '/dashboardlist',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );

    Guardinshipmeeting.remoteMethod(
        'addUpdate',
        {
            http: {
                path: '/addUpdate',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
            }, {
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


    Guardinshipmeeting.addUpdate= (request, reqctx) =>{
      const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
      const prs =[];
         var guardinmeetingboardmembers=request.guardinmeetingboardmembers;
         var  respguardinshipmeetingid = null;


    if(request.guardinshipmeetingid === undefined || request.guardinshipmeetingid === null)
    
    {

        return  Guardinshipmeeting.create({
            countyid:request.countyid,
            dateofmeeting:request.dateofmeeting,
            starttime:request.starttime,
            endtime:request.endtime,
            meetingstatus:request.meetingstatus,
            meetingtype:request.meetingtype,            
            insertedby: _securityusersid,
            updatedby: _securityusersid           
            }).then(data =>{

                respguardinshipmeetingid = data.guardinshipmeetingid;
    
                if(Array.isArray(guardinmeetingboardmembers)){
                    guardinmeetingboardmembers.forEach(guardinmeetingboardmember =>{
                      prs.push(
                          app.models.Guardinmeetingboardmembers.create({
      
                         guardinshipmeetingid:respguardinshipmeetingid,                     
                         boardmembertype:guardinmeetingboardmember.boardmembertype,
                         firstname:guardinmeetingboardmember.firstname,
                         lastname:guardinmeetingboardmember.lastname,
                         email:guardinmeetingboardmember.email,
                         phoneno:guardinmeetingboardmember.phoneno,                                      
                          insertedby: _securityusersid,
                          updatedby: _securityusersid
                          })
                      )
                  });
              }
              return Promise.all(prs);
      
              }).then(data=>{               

               return app.models.Intakeservreqguradmeetingconfig.create({
                guardinshipmeetingid:respguardinshipmeetingid,
                intakeserviceid:request.intakeserviceid,
                insertedby: _securityusersid,
                updatedby: _securityusersid
                })
             })
    }
    else
    {
        
        return app.models.Intakeservreqguradmeetingconfig.updateguardianshipmeeting(request);

    }
        
 
      }

      
   Guardinshipmeeting.list= (request) =>{
        var intakeserviceid=request.where.intakeserviceid;
       
        var pageno = request.page;
        var pagesize = request.limit;
        
        var totalcount = 0;
    
        const sql = 'Select * from getguardianshipmeeting($1,$2,$3)';

        return util.executeSecondaryNodeDBQuery(sql, [intakeserviceid, pageno, pagesize])
            .then(data => {
                  if (data!==null && data.length>0) {totalcount= data[0].totalcount;}
                 
                  var result;
                  result = {
                      'data' : data,
                      'count' : totalcount
                  };
                  LOGGER.debug(result)
                  return result;
              })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      }
      Guardinshipmeeting.remoteMethod('list', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
            path:'/list',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });
     Guardinshipmeeting.existingGuardianshipMeeting= (request) =>{
        var dateofmeeting=request.where.dateofmeeting;
       
        var pageno = request.page;
        var pagesize = request.limit;
        
        var totalcount = 0;
    
        const sql = 'Select * from existingguardianshipmeeting($1,$2,$3)';

        return util.executeSecondaryNodeDBQuery(sql, [dateofmeeting, pageno, pagesize])
            .then(data => {
                  if (data!==null && data.length>0) {
                    totalcount= data[0].totalcount;
                  }
                 
                  var result;
                  result = {
                      'data' : data,
                      'count' : totalcount
                  };
                  return result;
              })
           .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      }
      Guardinshipmeeting.remoteMethod('existingGuardianshipMeeting', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
            path:'/existingguardianshipmeeting',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });

    Guardinshipmeeting.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Guardinshipmeeting.observe('access', (ctx, next) => util.access(ctx, next));
    Guardinshipmeeting.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    
