'use strict';
const LOGGER = require("log4js").getLogger("placementrelease");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Placementrelease) {    
    Placementrelease.remoteMethod('addvalues', {
        http: {
                path: '/addvalues',
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

    Placementrelease.addvalues = function(request,reqctx)
    { const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        if(request.releasedate !== undefined && request.releasedate !== null && request.releasetime !== undefined && request.releasetime !== null && request.releasereason !== undefined && request.releasereason !== null) {
            var datetime = request.releasedate + ' '+request.releasetime;
            var status = 'closed'
            app.models.Placement.updateAll({placementid:request.placementid},{enddatetime:datetime,exitreasontypekey:request.releasereason,lrstatus:status, updatedby:suserid})
        }
        return app.models.Placementrelease.create(request).then(data => {
            const placementid = data.placementid
            var sql = "select * from getplacementreleaseuserid($1)"
            return util.executeDBQuery(sql, [placementid]).then(res =>{
                  LOGGER.debug("ressss"+res);
                  if(res !== undefined && res !=='' && res !== null){
                  var nofiticationJson ={};
                  var placementvalues =res[0].placementtype ;
                  var providername = placementvalues[0].providername;
                  var providercategorytype = placementvalues[0].providercategorytypekey;
                  var firstname = placementvalues[0].firstname;
                  var lastname = placementvalues[0].lastname;
                  nofiticationJson.objectid = placementvalues[0].intakeserviceid;
                  nofiticationJson.isexternalentity = 'false'
                  nofiticationJson.subject = 'Foster Care - Placement Release'
                  nofiticationJson.priorityleveltypekey = 'High'
                  nofiticationJson.usernotificationtypekey = 'System'
                  nofiticationJson.insertedby = suserid;
                 
                  nofiticationJson.body = firstname + " " + lastname + " has been released from " + providercategorytype + "-" + providername;
                  //LOGGER.debug(intakeserviceid)
                 
                  if(providercategorytype == 'Foster Home'){
                       nofiticationJson.securityusersid = '06d2a113-7766-4c4e-a645-7bcaeb488a32'
                        LOGGER.debug(nofiticationJson)
                        app.models.Usernotification.Add(nofiticationJson,reqctx);
                  }
                return data
                }
              }).then(res =>{
                var sql1 = "select * from sendrestireleasenotification($1,$2)"
                return util.executeDBQuery(sql1, [request.placementid,request.releasedate])
                .then(data1 => {
                    return data1;
                })
                .catch(err => {
                    LOGGER.error(err)
                })
              }

              );
		}).catch(err => util.logError(err));
    };
   
    Placementrelease.remoteMethod('list', {
                                http: {
                                    path: '/list',
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

                            Placementrelease.list =(request)=> {
            
                               
                                var sql = 'select * from getplacementrelease()';

                                return util.executeDBQuery(sql, [])
                                .then(data => data)
                                .catch(err => util.logError(err));
            
                            };
                    Placementrelease.remoteMethod('releasevalues', {
                                http: {
                                    path: '/releasevalues',
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

                            Placementrelease.releasevalues =(request)=> {
            
                               
                                var sql = 'select * from placementrelease where placementid=$1';

                                return util.executeDBQuery(sql, [request.where.placementid])
                                .then(data => data)
                                .catch(err => util.logError(err));
            
                            };
                
                        

                     
            
    
    
    
        Placementrelease.observe('before save', (ctx, next) => util.beforesave(ctx, next));
        Placementrelease.observe('access', (ctx, next) => util.access(ctx, next));
        Placementrelease.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    
