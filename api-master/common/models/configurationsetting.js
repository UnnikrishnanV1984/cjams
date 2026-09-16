'use strict';
const LOGGER = require("log4js").getLogger("configurationsetting");
const util = require('../utils/utils');

module.exports = function(Configurationsetting) {

	Configurationsetting.allegationconfiguration = function(request, reqctx){
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;

		if(request.name !== 'undefined'){

			return Configurationsetting.find({where: {and: [{name: request.name}]}})
    .then(records => {
		var myvalue = "";
		myvalue = getmyvalue(request);
        if(records.length>0) {
        	LOGGER.debug('check true');

        	return Configurationsetting.updateAll({name:request.name}, {value:myvalue, updatedby: _securityusersid});
            // no matching records exist!
        } else if (records.length===0){
        	return Configurationsetting.upsert({category:request.category,name:request.name,value:myvalue});
        }
    })
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });

}

		return Promise.resolve('Invalid request');
	};

	function getmyvalue(request){
		var templateid = request.assesssmenttemplateid;
		var myvalue = "";
		if(templateid != null){
			for(var i=0; i<templateid.length; i++){
				if(myvalue.length>0)
					{
						if(i == templateid.length -1)
						{myvalue = myvalue + templateid[i] 
							}else
							{myvalue = myvalue + templateid[i] + ','}
					}else
						{
						myvalue = templateid[i]+',';
						}
			}
		}
		return myvalue;
	}
	
	
	Configurationsetting.list = function(request) {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;

			}

		return Configurationsetting.find(request);

		};
	
	
	
	Configurationsetting.remoteMethod(
			'allegationconfiguration', 
				    {
				      http: {
				      		path: '/allegationconfiguration',
				      		verb: 'post'
				      },
				     accepts : [ {arg : 'data',type : 'object',
				     		http : {source : 'body'}}, {
								arg: 'reqctx',
								type: 'object',
								http: {
								  source: 'context'
								}
							  } ],   
				      returns: {
				    	  type : 'object',
							root : true
				      }
				     }
		);
	Configurationsetting.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});
	
	Configurationsetting.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Configurationsetting.observe('access', (ctx, next) => util.access(ctx, next));
	Configurationsetting.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
