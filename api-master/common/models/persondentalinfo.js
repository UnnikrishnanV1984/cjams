'use strict';
const LOGGER = require("log4js").getLogger("persondentalinfo");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Persondentalinfo) {

    Persondentalinfo.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
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
            type : 'string',
            root : true
        }
    });

    Persondentalinfo.remoteMethod('persondentalinfodelete', {
        http: { 
                path: '/persondentalinfodelete/:id',
                verb: 'delete'
              },
		accepts:
			  {
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });

    Persondentalinfo.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		} 
        request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
        if(request.persondentalinfoid== null || request.persondentalinfoid == undefined)
        {
            return Persondentalinfo.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Persondentalinfo.updateAll({persondentalinfoid:request.persondentalinfoid},request);
        }
    };

    Persondentalinfo.persondentalinfodelete = (id) => {
		var sql = 'update persondentalinfo set activeflag = 0 WHERE persondentalinfoid =\''+id+'\'';
        return util.executeDBQuery(sql, []).then(data => {
			 return data;
	    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    
    Persondentalinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Persondentalinfo.observe('access', (ctx, next) => util.access(ctx, next));
    Persondentalinfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
