'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function(Personallchildreninfo) {

    Personallchildreninfo.remoteMethod('addupdate', {
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

    Personallchildreninfo.addupdate = function(request, reqctx)
    { 
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
        if(request.personallchildreninfoid== null || request.personallchildreninfoid == undefined)
        {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.insertedon = new Date().toLocaleString();
            request.updatedon = new Date().toLocaleString();
            return Personallchildreninfo.create(request)
            .then(res => res)
            .catch(err => util.logError(err));
        }
        else
        {
          request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);  
          request.updatedon = new Date().toLocaleString();
          return Personallchildreninfo.updateAll({personallchildreninfoid:request.personallchildreninfoid},request)
          .catch(err => util.logError(err));
        }
    };


    Personallchildreninfo.remoteMethod('list', {
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
    
    Personallchildreninfo.list = request =>{

        var pageno = request.page;
        var pagesize = request.limit;

        const sql = 'select * from getpersonchildreninfo($1, $2, $3)';
        return util.executeDBQuery(sql, [request.where.personid, pageno, pagesize])
            .then(data => data[0].getpersonchildreninfo)
            .catch(err => err);
    }

    
    Personallchildreninfo.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personallchildreninfo.observe('access', (ctx, next) => util.access(ctx, next));
    Personallchildreninfo.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}