'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Placementleavereturn) {    
    Placementleavereturn.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Placementleavereturn.addupdate = function(request)
    {
        if(request.departeddate !== undefined && request.departeddate !== null){
            app.models.Placement.updateAll({placementid:request.placementid},{lrstatus:'leave',istempplacement:request.istempplacement})
        }
        if(request.actualreturndate !== undefined && request.actualreturndate !== null){
            app.models.Placement.updateAll({placementid:request.placementid},{lrstatus:'open'})
        }
        
        
        if(request.placementleavereturnid !== undefined && request.placementleavereturnid !== null) {
            return app.models.Placementleavereturn.updateAll(request);
        } else {
            return app.models.Placementleavereturn.create(request);
        }
    };
   
    Placementleavereturn.remoteMethod('getvalues', {
                                http: {
                                    path: '/getvalues',
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

                            Placementleavereturn.getvalues =(request)=> {
                                var sql = "select * from placementleavereturn where placementleavereturnid=$1";

                                return util.executeDBQuery(sql, [request.where.placementleavereturnid])
                                .then(data => data)
                                .catch(err => util.logError(err));
            
                            };
                            Placementleavereturn.remoteMethod('leavetype', {
                                http: {
                                    path: '/leavetype',
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

                            Placementleavereturn.leavetype =(request)=> {
                                var sql = "select value_text,description from referencevalues where referencetypeid='5'";

                                return util.executeDBQuery(sql, [])
                                .then(data => data)
                                .catch(err => util.logError(err));
            
                            };

                            Placementleavereturn.remoteMethod('list', {
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
                        
                            Placementleavereturn.list =(request)=> {
                                var sql = "select * from placementleavereturn where placementid=$1 order by effectivedate desc";

                                return util.executeDBQuery(sql, [request.where.placementid])
                                .then(data => data)
                                .catch(err => util.logError(err));
            
                            };
                
                        

                     
            
    
    
    
                Placementleavereturn.observe('before save', (ctx, next) => util.beforesave(ctx, next));
                Placementleavereturn.observe('access', (ctx, next) => util.access(ctx, next));
                Placementleavereturn.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    