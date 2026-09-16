'use strict';
const LOGGER = require("log4js").getLogger("personhealthexamination");
const loopback = require('loopback');
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Personhealthexamination) {
    
    Personhealthexamination.remoteMethod('addupdate', {
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

    Personhealthexamination.remoteMethod('personhealthexaminationdelete', {
        http: { 
                path: '/personhealthexaminationdelete/:id',
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

    Personhealthexamination.remoteMethod('list', {
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

    Personhealthexamination.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		
		request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
        request.updatedon = new Date().toLocaleString();
        if(request.personhealthexaminationid== null || request.personhealthexaminationid == undefined)
        {
            return Personhealthexamination.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personhealthexamination.updateAll({personhealthexaminationid:request.personhealthexaminationid},request);
        }
    };

    Personhealthexamination.personhealthexaminationdelete = (id) => {
		var sql = 'update personhealthexamination set activeflag = 0, updatedon = now()  WHERE personhealthexaminationid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
        .then(data => {
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Personhealthexamination.list = request => {
        let gPersonhealthexamination = [];
        const personid  = request.where.personid;
        return Personhealthexamination.find({
            where: {personid: personid},
             include: 
             [
                {
                    relation: 'healthprofessiontype',
                    scope: {
                        fields: ['healthprofessiontypekey', 'description']
                    }
                },
               {
                    relation: 'healthdomaintype',
                    scope: {
                        fields: ['healthdomaintypekey', 'description']
                    }
                },
                {
                    relation: 'healthassessmenttype',
                    scope: {
                        fields: ['healthassessmenttypekey', 'description']
                    }
                }           
            ]
        })
        .then(data => {
            gPersonhealthexamination = JSON.parse(JSON.stringify(data));
            return Promise.all(gPersonhealthexamination);
        })
        .then(data => data)
        .catch(err => util.logError(err));
      };

    Personhealthexamination.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personhealthexamination.observe('access', (ctx, next) => util.access(ctx, next));
    Personhealthexamination.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
