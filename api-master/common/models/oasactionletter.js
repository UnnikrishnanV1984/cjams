'use strict';
const LOGGER = require("log4js").getLogger("oasactionletter");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Oasactionletter) {
  
    Oasactionletter.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Oasactionletter.observe('access', (ctx, next) => util.access(ctx, next));
    Oasactionletter.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    Oasactionletter.remoteMethod('add', {
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

    Oasactionletter.add =function(request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const vsecurityusersid = (request.v_securityusersid ? request.v_securityusersid : _securityusersid);
        const prs=[];
        return Oasactionletter.create({
            intakeserviceid : request.intakeserviceid,
            countyid:request.countyid,
            comarvalues:request.comarvalues,
            immediateaction:request.immediateaction,
            notice:request.notice,
            effectivedate:request.effectivedate,
            workername:request.workername,
            insertedby: vsecurityusersid,
            updatedby: vsecurityusersid
        }).then(res=>{
            var oasactionletterid=res.oasactionletterid;
            if(Array.isArray(request.program)){
                request.program.map(programkey =>{
                    prs.push(app.models.Oasactionletterprogramactionconfig.create({
                        oasactionletterid : oasactionletterid,
                      programtypekey : programkey.programtypekey,
                      actiontypekey : request.actiontypekey,
                      insertedby: vsecurityusersid,
                      updatedby: vsecurityusersid
                    })
                    )
                  });

            }
            LOGGER.debug(prs);
            return Promise.all(prs);

            
        })
    }
    Oasactionletter.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
            path: '/list',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Oasactionletter.list =(request)=>{
        return Oasactionletter.find({
            where: { intakeserviceid: request.where.intakeserviceid },
            fields:['oasactionletterid','countyid','intakeserviceid','comarvalues','immediateaction','notice','workername','effectivedate','dhhreport','activeflag'],
            include: [{
                relation: 'oasactionletterprogramactionconfig',
                scope:{
                    fields:['oasactionletterid','programtypekey','actiontypekey']
                    
                }
            }]
        })

    }
        


}
