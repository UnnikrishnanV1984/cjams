'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function(Clientunder5yearsinfo) {

    Clientunder5yearsinfo.remoteMethod('addupdate', {
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

    Clientunder5yearsinfo.addupdate = function(request, reqctx)
    { 
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        if(request.clientunder5yearsinfoid== null || request.clientunder5yearsinfoid == undefined)
        {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            return Clientunder5yearsinfo.create(request)
            .then(res => res)
            .catch(err => util.logError(err));
        }
        else
        {
          request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);  
          return Clientunder5yearsinfo.updateAll({clientunder5yearsinfoid:request.clientunder5yearsinfoid},request)
          .catch(err => util.logError(err));
        }
    };
   

    Clientunder5yearsinfo.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    
    Clientunder5yearsinfo.list = request =>{
      const personid = request.where.personid;
      var page = request.page;
      if (request.page !== 'undefined') {
          request.skip = (request.page - 1) * request.limit;
      }
      var limit = request.limit;
            
            var sql = 'select * from getbirthinfolist($1,$2,$3)';

            return util.executeSecondaryNodeDBQuery(sql,[personid,page,limit])
                .then(data => data)
                .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }
    
    Clientunder5yearsinfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Clientunder5yearsinfo.observe('access', (ctx, next) => util.access(ctx, next));
    Clientunder5yearsinfo.observe('after save',(ctx,next) => {
        const cond = ctx.instance ? ctx.instance.personid : ctx.where.personid;
        util.aftersave(ctx,next,'CU5YII',ctx.isNewInstance ? ctx.instance.personid : cond)
    });
    Clientunder5yearsinfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}