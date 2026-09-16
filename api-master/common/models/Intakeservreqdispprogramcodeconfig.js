'use strict';
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var app = require('../../server/server');
const util = require('../utils/utils');


module.exports = function (Intakeservreqdispprogramcodeconfig) {
  
  Intakeservreqdispprogramcodeconfig.remoteMethod('add', {
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
    


      Intakeservreqdispprogramcodeconfig.add  = (request, reqctx, res)=>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
       var  programcode = request.disposition.programcode;
       var resintakeservicerequestdispositioncodeid=res;
       const prs =[];

       if (request.disposition.programcode !=null  && request.disposition.programcode !== undefined) 
       {

        if(Array.isArray(programcode)){
            programcode.forEach(pc =>{
              prs.push(
                  app.models.Intakeservreqdispprogramcodeconfig.create({

                  intakeservicerequestdispositioncodeid:resintakeservicerequestdispositioncodeid,                     
                  programcodetypekey:pc.programcodetypekey,                                
                  insertedby:securityusersid,
                  updatedby:securityusersid
                  })
              )
          });
      }
      return Promise.all(prs);
    }
    return Promise.resolve('Invalid request');
}


    
    
    Intakeservreqdispprogramcodeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqdispprogramcodeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqdispprogramcodeconfig.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
        


}