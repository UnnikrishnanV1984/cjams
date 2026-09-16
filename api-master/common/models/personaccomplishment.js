'use strict';
const LOGGER = require("log4js").getLogger("personaccomplishment");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personaccomplishment) {

    Personaccomplishment.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},
            {
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

    Personaccomplishment.remoteMethod('personaccomplishmentdelete', {
        http: { 
                path: '/personaccomplishmentdelete/:id',
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

    Personaccomplishment.remoteMethod('list', {
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

    Personaccomplishment.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		} 
        request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
             
        if(request.personaccomplishmentid== null || request.personaccomplishmentid == undefined)
        {
            return Personaccomplishment.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personaccomplishment.updateAll({personaccomplishmentid:request.personaccomplishmentid},request);
        }
    };

    Personaccomplishment.personaccomplishmentdelete = (id) => {
		var sql = 'update personaccomplishment set activeflag = 0 WHERE personaccomplishmentid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personaccomplishment.list = request => {
        let gPersonaccomplishment = [];
        const personid  = request.where.personid;
        return Personaccomplishment.find({
            where: {personid: personid},
            include: [{
                relation: 'highestgrade',
                scope: {
                    fields: ['highestgradetypekey', 'typedescription','ishighergrade','displayorder']
                }
            }]
        })
        .then(data => {
            gPersonaccomplishment = JSON.parse(JSON.stringify(data));
            return Promise.all(gPersonaccomplishment);
        })
        .then(data => data)
        .catch(err => util.logError(err));
      };

    Personaccomplishment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personaccomplishment.observe('access', (ctx, next) => util.access(ctx, next));
    Personaccomplishment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
