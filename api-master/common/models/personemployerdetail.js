'use strict';
const LOGGER = require("log4js").getLogger("personemployerdetail");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Personemployerdetail) {
    
    Personemployerdetail.remoteMethod('addupdate', {
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

    Personemployerdetail.remoteMethod('personemployerdetaildelete', {
        http: { 
                path: '/personemployerdetaildelete/:id',
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

    Personemployerdetail.remoteMethod('list', {
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

    Personemployerdetail.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
			
		request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
	  
        if(request.personemployerdetailid== null || request.personemployerdetailid == undefined)
        {
            return Personemployerdetail.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personemployerdetail.updateAll({personemployerdetailid:request.personemployerdetailid},request);
        }
    };

    Personemployerdetail.personemployerdetaildelete = (id) => {
		var sql = 'update personemployerdetail set activeflag = 0 WHERE personemployerdetailid =\''+id+'\'';
        return util.executeDBQuery(sql, []).then(data => {
			 return data;
	    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personemployerdetail.list = request =>{
        const personid  = request.where.personid;
        return app.models.Personemployerdetail.find(
            {where:{personid:personid}
           })
           .then(data=>{
               return data;
           })
    };

    Personemployerdetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personemployerdetail.observe('access', (ctx, next) => util.access(ctx, next));
    Personemployerdetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
