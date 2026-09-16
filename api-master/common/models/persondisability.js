'use strict';
const LOGGER = require("log4js").getLogger("persondisability");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Persondisability) {


    Persondisability.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
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


   
    Persondisability.addupdate = (request, reqctx)=>{  
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;

        if(request.persondisabilityid== null || request.persondisabilityid == undefined)
        {

        if(request.isnew== null || request.isnew == undefined)
        {

            Persondisability.updateAll(
                {disabilitytypekey:request.disabilitytypekey,personid:request.personid},
                {
                   activeflag:0,
                   updatedby: _securityusersid      
                })

        }
            return Persondisability.create({

                personid:request.personid,
                disabilityconditiontypekey:request.disabilityconditiontypekey,
                disabilityflag:request.disabilityflag,
                startdate:request.startdate,
                enddate:request.enddate,
                evaluationdate:request.evaluationdate,
                evaluatorname:request.evaluatorname,
                comments:request.comments,     
                existingcondition :request.existingcondition,
                previouscondition:request.previouscondition,
                doesnotapply:request.doesnotapply,          
                expungementflag:request.expungementflag,
                disabilitytypekey:request.disabilitytypekey,
                specialkey:request.specialkey,
                hygienekey:request.hygienekey,
                diagnoiseddisabilitynotes:request.diagnoiseddisabilitynotes,   
                startdateunknown:request.startdateunknown,      
                insertedby: _securityusersid,
                updatedby: _securityusersid,        
                selectdisability:request.selectdisability            
    
            }).then(data => {
               return data;
        })
    }
        else
        {

             return Persondisability.updateAll(
            {persondisabilityid:request.persondisabilityid},
            {
                personid:request.personid,
                disabilityconditiontypekey:request.disabilityconditiontypekey,
                disabilityflag:request.disabilityflag,
                startdate:request.startdate,
                enddate:request.enddate,
                evaluationdate:request.evaluationdate,
                evaluatorname:request.evaluatorname,
                comments:request.comments,
                existingcondition :request.existingcondition,
                previouscondition:request.previouscondition,
                doesnotapply:request.doesnotapply,                     
                expungementflag:request.expungementflag,
                disabilitytypekey:request.disabilitytypekey,
                specialkey:request.specialkey,
                hygienekey:request.hygienekey,
                diagnoiseddisabilitynotes:request.diagnoiseddisabilitynotes,
                startdateunknown:request.startdateunknown,                       
                updatedby:_securityusersid,
                selectdisability:request.selectdisability 
                
        }).then(res=>{
            return  request;
        }).catch(err => util.logError(err));
        }        
        
}

Persondisability.remoteMethod('delete', {
    http: {
            path: '/delete',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}},  {
            arg: 'reqctx',
            type: 'object',
            http: {
              source: 'context'
            }
          } ],
    returns: {
        type : 'string',
        root : true
    }
});

Persondisability.delete = function(request, reqctx)
{  
    var persondisabilityid = request.persondisabilityid;
    LOGGER.debug(persondisabilityid)
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
 
        return Persondisability.updateAll({persondisabilityid:persondisabilityid}, {activeflag:0, updatedby: request && request.securityuserid?request.securityuserid: _securityusersid}).then(data => {
            return data;
        }).catch(err => util.logError(err));

    
  
};           
               


    Persondisability.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Persondisability.observe('access', (ctx, next) => util.access(ctx, next));
    Persondisability.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PDISADDUP',
    ctx.isNewInstance?ctx.instance.personid:ctx.data.personid));
    Persondisability.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};