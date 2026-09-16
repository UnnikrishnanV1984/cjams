'use strict';
const LOGGER = require("log4js").getLogger("intakeservreqguradmeetingconfig");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Intakeservreqguradmeetingconfig) { 


    Intakeservreqguradmeetingconfig.remoteMethod(
        'add',
        {
            http: {
                path: '/add',
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

    
    Intakeservreqguradmeetingconfig.add= (request, reqctx) =>{
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
            LOGGER.debug(request.guardinshipmeetingid+"guardinshipmeetingid");
            return app.models.Intakeservreqguradmeetingconfig.find({
                where :{
                    and: [{activeflag:1},{guardinshipmeetingid: request.guardinshipmeetingid},{intakeserviceid:request.intakeserviceid}]
                  }
            }).then(result =>{
                if(result.length==0){
                    return app.models.Intakeservreqguradmeetingconfig.create({
                        guardinshipmeetingid:request.guardinshipmeetingid,
                        intakeserviceid:request.intakeserviceid,
                         insertedby:_securityusersid,
                         updatedby:_securityusersid
                        }).then(res=>{
                            return Intakeservreqguradmeetingconfig.updateguardianshipmeeting(request, _securityusersid);
                        })
                   
                }else{
                   
                    return Intakeservreqguradmeetingconfig.updateguardianshipmeeting(request, _securityusersid);    
                }
            })
               
    }

    Intakeservreqguradmeetingconfig.updateguardianshipmeeting= (request, _securityusersid) =>{

        const prs = [];
        return app.models.Guardinshipmeeting.updateAll({
            guardinshipmeetingid:request.guardinshipmeetingid},
            {
                countyid:request.countyid,
                dateofmeeting:request.dateofmeeting,
                starttime:request.starttime,
                endtime:request.endtime,
                meetingstatus:request.meetingstatus,
                meetingtype:request.meetingtype,            
                updatedby:_securityusersid
                  

          }
        ).then(respo => {
     
            if (Array.isArray(request.guardinmeetingboardmembers)) {
                request.guardinmeetingboardmembers.map(boarmembers => {
                    if(boarmembers.guardinmeetingboardmembersid!= null && boarmembers.guardinmeetingboardmembersid!= undefined && boarmembers.guardinmeetingboardmembersid!= ''){
                        var guardinmeetingboardmembersid=boarmembers.guardinmeetingboardmembersid;
                        LOGGER.debug(guardinmeetingboardmembersid+"guardinmeetingboardmembersid")
                        prs.push(
                            app.models.Guardinmeetingboardmembers.updateAll({guardinmeetingboardmembersid:guardinmeetingboardmembersid},
                                {
                                guardinshipmeetingid:request.guardinshipmeetingid,                     
                                boardmembertype:boarmembers.boardmembertype,
                                firstname:boarmembers.firstname,
                                lastname:boarmembers.lastname,
                                email:boarmembers.email,
                                phoneno:boarmembers.phoneno,                                    
                                updatedby:_securityusersid
                            })
                        )
                    }else{
                    prs.push(app.models.Guardinmeetingboardmembers.create({
                        guardinshipmeetingid:request.guardinshipmeetingid,
                        boardmembertype: boarmembers.boardmembertype,
                        firstname: boarmembers.firstname,
                        lastname: boarmembers.lastname,
                        email: boarmembers.email,
                        phoneno: boarmembers.phoneno,
                        insertedby: _securityusersid,
                        updatedby:_securityusersid
                    }).catch(err => LOGGER.error(err))
                    )}

                });
            }
            return Promise.all(prs);
        
        }).catch(err => util.logError(err));
    
    }


    Intakeservreqguradmeetingconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqguradmeetingconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqguradmeetingconfig.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));    
}    

