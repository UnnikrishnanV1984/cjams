'use strict';
const LOGGER = require("log4js").getLogger("personmedicpshychotropic");
const loopback = require('loopback');
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Personmedicpshychotropic) {	
    
    Personmedicpshychotropic.remoteMethod('addupdate', {
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

    Personmedicpshychotropic.remoteMethod('personmedicpshychotropicdelete', {
        http: { 
                path: '/personmedicpshychotropicdelete/:id',
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

    Personmedicpshychotropic.remoteMethod('list', {
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
    Personmedicpshychotropic.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		
		request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
	  
        if(request.personmedicpshychotropicid== null || request.personmedicpshychotropicid == undefined)
        {
            request.medicationcomments = request.comments;
            return Personmedicpshychotropic.create(request).then(res => {
                return res;
            });
        }
        else
        {
          request.medicationcomments = request.comments;
          return Personmedicpshychotropic.updateAll({personmedicpshychotropicid:request.personmedicpshychotropicid},request);
        }
    };

    Personmedicpshychotropic.personmedicpshychotropicdelete = (id) => {
		var sql = 'update personmedicpshychotropic set activeflag = 0 WHERE personmedicpshychotropicid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personmedicpshychotropic.list = request => {
        let gPersonmedicpshychotropic = [];
        const personid  = request.where.personid;
        return Personmedicpshychotropic.find({
            where: {personid: personid},
            include: [{
                relation: 'informationsourcetype',
                scope: {
                    fields: ['informationsourcetypekey', 'description']
                }
            },{
                relation: 'prescriptionreasontype',
                scope: {
                    fields: ['prescriptionreasontypekey', 'description']
                }
            }]
        })
        .then(data => {
            gPersonmedicpshychotropic = JSON.parse(JSON.stringify(data));
            return Promise.all(gPersonmedicpshychotropic);
        })
        .then(data => data)
        .catch(err => util.logError(err));
      };

    Personmedicpshychotropic.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personmedicpshychotropic.observe('access', (ctx, next) => util.access(ctx, next));
    Personmedicpshychotropic.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
