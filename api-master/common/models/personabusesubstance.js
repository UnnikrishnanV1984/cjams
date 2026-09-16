'use strict';
const LOGGER = require("log4js").getLogger("personabusesubstance");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const moment = require('moment');

const withCount = rows => ({
    'data': rows,
    'count': (rows !== null && rows.length > 0) ? rows[0].totalcount : 0
});

module.exports = function(Personabusesubstance) {

    Personabusesubstance.remoteMethod('addupdate', {
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
            }],
        returns: {
            type : 'string',
            root : true
        }
    });

    Personabusesubstance.remoteMethod('personabusesubstancedelete', {
        http: { 
                path: '/personabusesubstancedelete/:id',
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

    Personabusesubstance.remoteMethod('list', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personabusesubstance.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		} 
        request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
             

        if(request.personabusesubstanceid== null || request.personabusesubstanceid == undefined)
        {
            return Personabusesubstance.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personabusesubstance.updateAll({personabusesubstanceid:request.personabusesubstanceid},request);
        }
    };

    Personabusesubstance.personabusesubstancedelete = (id) => {
		var sql = 'update personabusesubstance set activeflag = 0 WHERE personabusesubstanceid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personabusesubstance.list = request => {
      const personid = request.where.personid;
      if (request.page !== 'undefined') {
          request.skip = (request.page - 1) * request.limit;
      }
      var limit = request.limit;
      var sql = 'select count(1) over() as totalcount,* from personabusesubstance where activeflag=1 and personid=$1 limit $2 offset $3';

      return util.executeDBQuery(sql, [personid, limit, request.skip])
          .then(withCount)
          .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  }

  Personabusesubstance.remoteMethod('behavesubstancelist', {
    accepts: {
  arg: 'filter',
  type: 'Object',
  http: {
    source: 'query',
  },
  required: true,
},
  http: {
        verb: 'get',
    },
    returns: {
        type: 'Object',
        root: true,
    },
});

Personabusesubstance.behavesubstancelist = request => {
  if (request.page !== 'undefined') {
      request.skip = (request.page - 1) * request.limit;
  }
  var limit = request.limit;
  var sql = 'select * from getbehavioursubstancefilter($1,$2,$3)';

  return util.executeSecondaryNodeDBQuery(sql, [request.where, request.page,limit])
      .then(withCount)
      .catch(err => LOGGER.error(err));
}



    Personabusesubstance.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personabusesubstance.observe('access', (ctx, next) => util.access(ctx, next));
    Personabusesubstance.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PABUSE',
    ctx.isNewInstance?ctx.instance.personid:ctx.data.personid));
    Personabusesubstance.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};