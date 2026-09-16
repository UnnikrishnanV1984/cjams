'use strict';
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var app = require('../../server/server');
const util = require('../utils/utils');


module.exports = function (Intakeservreqdispclosingcodeconfig) {
  
  Intakeservreqdispclosingcodeconfig.remoteMethod('add', {
    http: {
            path: '/add',
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
    

Intakeservreqdispclosingcodeconfig.add  = (request, reqctx, res)=>{
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    var resintakeservicerequestdispositioncodeid=res;
           
    return Intakeservreqdispclosingcodeconfig.create({
        intakeservicerequestdispositioncodeid:resintakeservicerequestdispositioncodeid,
        closingcodetypekey:request.disposition.closingcodetypekey,
        issupport:request.disposition.issupport,          
        supporttypekey:request.disposition.supporttypekey,        
        insertedby : (request && request.securityuserid?request.securityuserid: _securityusersid),
         updatedby : (request && request.securityuserid?request.securityuserid: _securityusersid),
         insertedon: new Date().toLocaleString(),
         updatedon: new Date().toLocaleString()
    });
};


    
    
    Intakeservreqdispclosingcodeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqdispclosingcodeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqdispclosingcodeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
        


}