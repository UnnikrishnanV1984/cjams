'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Adoptioncaserevision) { 

    Adoptioncaserevision.remoteMethod('createraterevision', {
        http: {
            path: '/createraterevision',
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
  
    Adoptioncaserevision.createraterevision = async (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
        var securityusersid = _securityusersid;
        var now = new Date();
        request.insertedby = securityusersid;
        request.updatedby = securityusersid;
        request.insertedon = now;
        request.updatedon = now;
        request.status = 'Review';
  
        if (!request.adoptionagreementrateid) {
            var genid = "select * from gen_random_uuid()"; //@TM: use generated rate id if unavailable
            const rateid = await util.executeDBQuery(genid, []);
            var generatedId = JSON.parse(JSON.stringify(rateid));
            request.adoptionagreementrateid = generatedId[0].gen_random_uuid;
        }
  
        if (request.adoptionagreementrateid) {
            // De-activate any existing review/incomplete records
            var revision = "update adoptioncaserevision"
            +" set activeflag = 0"
            +" where adoptionagreementrateid = \'"+request.adoptionagreementrateid+"\'"
            +" and activeflag = 1"
            +" and (approvalstatustypekey = '3045' or approvalstatustypekey ='3046' or approvalstatustypekey is null)";
            return util.executeDBQuery(revision, []).then(() => "success").then( res => {
                if (res === "success") {
                // Create revision - Rate record should be created only after approval
                return Adoptioncaserevision.create(request).then(data => {
                    return data;
                });
                } else {
                return Promise.resolve('Unable to create revision!');
                }
            });
        }
    }
  
    Adoptioncaserevision.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptioncaserevision.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptioncaserevision.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));    
}
