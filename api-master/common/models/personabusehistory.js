'use strict';
const LOGGER = require("log4js").getLogger("personabusehistory");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personabusehistory) {

    Personabusehistory.remoteMethod('addupdate', {
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

    Personabusehistory.remoteMethod('personabusehistorydelete', {
        http: { 
                path: '/personabusehistorydelete/:id',
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

    Personabusehistory.remoteMethod('list', {
        http: {
              path: '/list',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
      });

    Personabusehistory.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		} 
        request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
             
        if(request.personabusehistoryid== null || request.personabusehistoryid == undefined)
        {
            return Personabusehistory.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personabusehistory.updateAll({personabusehistoryid:request.personabusehistoryid},request);
        }
    };

    Personabusehistory.personabusehistorydelete = (id) => {
		var sql = 'update personabusehistory set activeflag = 0 WHERE personabusehistoryid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personabusehistory.list = request =>{
        const personid  = request.where.personid;
        return app.models.Personabusehistory.find(
            {where:{personid:personid}
           })
           .then(data=>{
               return data;
           })
    };
    
    Personabusehistory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personabusehistory.observe('access', (ctx, next) => util.access(ctx, next));
    Personabusehistory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
