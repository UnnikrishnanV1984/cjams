'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function(Personmedication) {

    Personmedication.remoteMethod('addupdate', {
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

    Personmedication.addupdate = function(request, reqctx)
    { 
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
        if(request.personmedicationid== null || request.personmedicationid == undefined)
        {
            request.insertedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);
            return Personmedication.create(request)
            .then(res => res)
            .catch(err => util.logError(err));
        }
        else
        {
          request.updatedby = (request && request.securityuserid?request.securityuserid: _securityusersid);  
          return Personmedication.updateAll({personmedicationid:request.personmedicationid},request)
          .catch(err => util.logError(err));
        }
    };


    Personmedication.remoteMethod('list', {
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
    
    Personmedication.list = request =>{

        var pageno = request.page;
        var pagesize = request.limit;

        const sql = 'select * from getpersonmedication($1, $2, $3)';
        return util.executeDBQuery(sql, [request.where.personid, pageno, pagesize])
           .then(data => data[0].getpersonmedication)
           .catch(err => err);
    }

    
    Personmedication.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personmedication.observe('access', (ctx, next) => util.access(ctx, next));
    Personmedication.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}