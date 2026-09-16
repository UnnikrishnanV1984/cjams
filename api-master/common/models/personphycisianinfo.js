'use strict';
const LOGGER = require("log4js").getLogger("personphycisianinfo");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function(Personphycisianinfo) {  

    Personphycisianinfo.remoteMethod('addupdate', {
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

    Personphycisianinfo.remoteMethod('personphycisianinfodelete', {
        http: { 
                path: '/personphycisianinfodelete/:id',
                verb: 'delete'
              },
		accepts:
			  [{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
        {
          arg: 'reqctx',
          type: 'object',
          http: {
            source: 'context'
        }}],
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });

    Personphycisianinfo.addupdate = function(request, reqctx)
    { 
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
      
      request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
      
        if(request.personphycisianinfoid== null || request.personphycisianinfoid == undefined)
        {
            return Personphycisianinfo.create(request).then(res => {
                return res;
            });
        }
        else
        {
          return Personphycisianinfo.updateAll({personphycisianinfoid:request.personphycisianinfoid},request);
        }
    };

    Personphycisianinfo.personphycisianinfodelete = (id,reqctx) => {
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
		var sql = 'update personphycisianinfo set updatedby = \''+suserid+'\' , updatedon = now(),activeflag = 0 WHERE personphycisianinfoid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personphycisianinfo.remoteMethod('listpersonphycisianinfo', {
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

    Personphycisianinfo.listpersonphycisianinfo = request => {
        const personid = request.where.personid;
        const pageno = request.page;
        const pagesize = request.limit;
        const sortcolumn = request.sortcolumn;
        const sortorder = request.sortorder;
          const sql = 'select * from listpersonphycisianinfo($1, $2, $3, $4, $5)';
          return util.executeSecondaryNodeDBQuery(sql, [personid, pageno, pagesize, sortcolumn, sortorder])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      };

      Personphycisianinfo.remoteMethod('getproviderinfo', {
        http: {
            path: '/getproviderinfo',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Personphycisianinfo.getproviderinfo  =(request)=> {
        var page = request.page;
        var limit = request.limit;
        var totalcount = 0;
        var sql = 'select * from getproviderinfofilter($1, $2, $3)';
		
		return util.executeSecondaryNodeDBQuery(sql, [request.where, page, limit ])
		.then(data => {
                    if (data!==null && data.length>0) {totalcount= data[0].totalcount;}
                    var result;
                    result = {
                        'data' : data,
                        'count' : totalcount
                    };
					return result; }
		)
		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personphycisianinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personphycisianinfo.observe('access', (ctx, next) => util.access(ctx, next));
    Personphycisianinfo.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PPHYI',
    (ctx.isNewInstance || (ctx.instance && ctx.instance.personid)) ? ctx.instance.personid : ctx.where.personid));
    Personphycisianinfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}