'use strict';
const LOGGER = require("log4js").getLogger("personhealthpassport");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function(Personhealthpassport) {  

    Personhealthpassport.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
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

    Personhealthpassport.remoteMethod('delete', {
        http: { 
                path: '/delete/:id',
                verb: 'delete'
              },
		accepts:
			 [ {
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
        { arg: 'reqctx',
        type: 'object',
         http: {source: 'context'} }
      ],
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });

    Personhealthpassport.remoteMethod('list', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'body',
      },
      required: true,
    },
      http: {
            verb: 'post',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personhealthpassport.addupdate = function(request, reqctx) {
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
      const securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid); 
        request.updatedby = securityusersid;
        if(request.personhealthpassportid === null || request.personhealthpassportid === undefined) {
            request.insertedby = securityusersid;
            return Personhealthpassport.create(request).then(res => {
                return res;
            });
        } else {
          return Personhealthpassport.updateAll({personhealthpassportid:request.personhealthpassportid},request);
        }
    };

    Personhealthpassport.delete = (id,reqctx) => {
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
        var sql = ` update personhealthpassport
                    set activeflag = 0, updatedby = $2, updatedon = now()
                    where personhealthpassportid = $1; `;
        return util.executeDBQuery(sql, [id, suserid])
        .then(data => {
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Personhealthpassport.list = request => {
        const personid = request.where.personid;
        const pageno = request.page;
        const pagesize = request.limit;
        const sortcolumn = (request.sortcolumn) ? request.sortcolumn : 'createdon';
        const sortorder = (request.sortorder) ? request.sortorder : 'desc' ;
          const sql = 'select * from list_person_healthpassport($1, $2, $3, $4, $5, $6)';
          return util.executeSecondaryNodeDBQuery(sql, [personid, pageno, pagesize, sortcolumn, sortorder, true])
        .then(data => {
            return {code: 200, data : data[0].list_person_healthpassport};
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      };
      
    Personhealthpassport.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personhealthpassport.observe('access', (ctx, next) => util.access(ctx, next));
    Personhealthpassport.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PHLTHINS',
    (ctx.isNewInstance || (ctx.instance && ctx.instance.personid)) ? ctx.instance.personid : ctx.where.personid));
    Personhealthpassport.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}