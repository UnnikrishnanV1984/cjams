'use strict';
const LOGGER = require("log4js").getLogger("personeducationvocation");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personeducationvocation) {

    Personeducationvocation.remoteMethod('addupdate', {
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

    Personeducationvocation.remoteMethod('personeducationvocationdelete', {
        http: { 
                path: '/personeducationvocationdelete/:id',
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

    Personeducationvocation.remoteMethod('list', {
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

    Personeducationvocation.addupdate = function(request, reqctx)
    { 
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
   
      request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
      
        if(request.personeducationvocationid== null || request.personeducationvocationid == undefined)
        {
            return Personeducationvocation.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personeducationvocation.updateAll({personeducationvocationid:request.personeducationvocationid},request);
        }
    };

    Personeducationvocation.personeducationvocationdelete = (id) => {
		var sql = 'update personeducationvocation set activeflag = 0 WHERE personeducationvocationid =\''+id+'\'';
        return util.executeDBQuery(sql, []).then(data => {
			 return data;
	    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

      Personeducationvocation.list = request =>{
        const personid  = request.where.personid;
        return app.models.Personeducationvocation.find(
            {where:{personid:personid}
           })
           .then(data=>{
               return data;
           })
    };

    Personeducationvocation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personeducationvocation.observe('access', (ctx, next) => util.access(ctx, next));
    Personeducationvocation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
