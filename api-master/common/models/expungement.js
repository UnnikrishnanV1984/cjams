'use strict';
const LOGGER = require("log4js").getLogger("expungement");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function(Expungement) {

    Expungement.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
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
            type: 'string',
            root: true
        }
    });
 

    Expungement.addupdate = function (request, reqctx) {
        var securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        var v_expungementid;
    
        if(request.expungementid !== undefined && request.expungementid !== null) {
            return Expungement.updateAll(
                { expungementid: request.expungementid },
                {
                    investigationfindingid: request.investigationfindingid,
                    isunsubstansiated: request.isunsubstansiated,            
                    isindicated: request.isindicated,
                    isremovemaltreator: request.isremovemaltreator,
                    isremoverofindings: request.isremoverofindings,
                    donotexpunge: request.donotexpunge,
                    manualexpunge: request.manualexpunge,
                    unsubstansiateddate: request.unsubstansiateddate,
                    indicateddate: request.indicateddate,
                    removemaltreatordate: request.removemaltreatordate,   
                    resultoflawenforcement: request.resultoflawenforcement, 
                    investigationnarrative:request.investigationnarrative,   
                    investigationfinding: request.investigationfinding,    
                    maltreatmentid: request.maltreatmentid,    
                    appealfinding: request.appealfinding,    
                    finalfinding: request.finalfinding,            
                    insertedby: securityusersid,
                    reason: request.reason,
                    justification: request.justification
                }).then(data => {
     
                v_expungementid = data.expungementid;
                var sql1 = 'UPDATE investigationfinding SET finalfinding= \''+request.finalfinding+'\' WHERE investigationfindingid =\''+request.investigationfindingid+'\'' ;
                util.executeDBQuery(sql1,[])
                .then(_data => {
                    LOGGER.info(_data);
                })
                .catch(err => {
                    LOGGER.error(err)
                    throw err;
                })

                 var sql = 'select * from expungementsave($1,$2)';

                    util.executeDBQuery(sql, [v_expungementid, securityusersid])
                        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                return data;
                    }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
        } else 
        {
       
        return Expungement.create({
            investigationfindingid: request.investigationfindingid,
            isunsubstansiated: request.isunsubstansiated,            
            isindicated: request.isindicated,
            isremovemaltreator: request.isremovemaltreator,
            isremoverofindings: request.isremoverofindings,
            donotexpunge: request.donotexpunge,
            manualexpunge: request.manualexpunge,
            unsubstansiateddate: request.unsubstansiateddate,
            indicateddate: request.indicateddate,
            removemaltreatordate: request.removemaltreatordate,   
            resultoflawenforcement: request.resultoflawenforcement, 
            investigationnarrative:request.investigationnarrative,   
            investigationfinding: request.investigationfinding,    
            maltreatmentid: request.maltreatmentid,    
            appealfinding: request.appealfinding,    
            finalfinding: request.finalfinding,            
            insertedby: securityusersid,
            updatedby: securityusersid,
            reason: request.reason,
            justification: request.justification
        }).then(data => {
 
            v_expungementid = data.expungementid;
            var sql1 = 'UPDATE investigationfinding SET finalfinding= \''+request.finalfinding+'\' WHERE investigationfindingid =\''+request.investigationfindingid+'\'' ;

            util.executeDBQuery(sql1, [])
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });


             var sql = 'select * from expungementsave($1,$2)';

                util.executeDBQuery(sql, [v_expungementid, securityusersid])
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            return data;
                }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
        }
    }

        Expungement.remoteMethod('getexpungement', {
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
                type: 'string',
                root: true
            }
        });
    
        Expungement.getexpungement = request => {
            var pageno = request.page;
            var pagesize = request.limit;
            var investigationfindingid = request.where.investigationfindingid ? request.where.investigationfindingid : null;
            const sql = 'select * from getexpungement($1, $2, $3)';
            return util.executeSecondaryNodeDBQuery(sql, [investigationfindingid,pageno, pagesize]).then(resp => resp)
                .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
        }

        Expungement.remoteMethod('getexpungementreviewstatus', {
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
                type: 'string',
                root: true
            }
        });
    
        Expungement.getexpungementreviewstatus = request => {
            var intakeserviceid = request.where.intakeserviceid ? request.where.intakeserviceid : null;
            const sql = 'select * from getexpungementreviewstatus($1)';
            return util.executeSecondaryNodeDBQuery(sql, [intakeserviceid]).then(resp => resp)
                .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
        }


    Expungement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Expungement.observe('access', (ctx, next) => util.access(ctx, next));
    Expungement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
