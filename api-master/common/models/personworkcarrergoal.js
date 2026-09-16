'use strict';
const LOGGER = require("log4js").getLogger("personworkcarrergoal");
const loopback = require('loopback');
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Personworkcarrergoal) {
    
    Personworkcarrergoal.remoteMethod('addupdate', {
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
              }],
        returns: {
            type : 'string',
            root : true
        }
    });

    Personworkcarrergoal.remoteMethod('personworkcarrergoaldelete', {
        http: { 
                path: '/personworkcarrergoaldelete/:id',
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

    Personworkcarrergoal.remoteMethod('list', {
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

    Personworkcarrergoal.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		
		request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
	  
        if(request.personworkcarrergoalid== null || request.personworkcarrergoalid == undefined)
        {
            return Personworkcarrergoal.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personworkcarrergoal.updateAll({personworkcarrergoalid:request.personworkcarrergoalid},request);
        }
    };

    Personworkcarrergoal.personworkcarrergoaldelete = (id) => {
		var sql = 'update personworkcarrergoal set activeflag = 0 WHERE personworkcarrergoalid =\''+id+'\'';
        return util.executeDBQuery(sql, []).then(data => {
			 return data;
	    }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personworkcarrergoal.list = request =>{
        const personid  = request.where.personid;
        return app.models.Personworkcarrergoal.find(
            {where:{personid:personid}
           })
           .then(data=>{
               return data;
           })
    };

    Personworkcarrergoal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personworkcarrergoal.observe('access', (ctx, next) => util.access(ctx, next));
    Personworkcarrergoal.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
