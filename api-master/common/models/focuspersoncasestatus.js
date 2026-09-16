'use strict';
const LOGGER = require("log4js").getLogger("focuspersoncasestatus");
const util = require('../utils/utils');
var app = require('../../server/server');
var server = require('../../server/server');

module.exports = function(Focuspersoncasestatus) {

    Focuspersoncasestatus.remoteMethod('addtask', {
        http: {
                path: '/addtask',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
              } ],   
        returns: {
            type : 'object',
            root : true
        }
	});

    Focuspersoncasestatus.addtask = function(request, reqctx)
    {
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }
        var securityuserid = request && request.securityuserid?request.securityuserid:_securityusersid;
        var sql = "select * from savefocuspersoncasestatus($1,$2,$3,$4,$5,$6,$7,$8)"
        LOGGER.debug(request.closenotes)
        return util.executeDBQuery(sql, [request.personid,request.intakeserviceid,request.intakenumber,request.focuspersonstatustypekey,request.status,securityuserid,request.opennotes,request.closenotes])
          .then(res =>{
            return res
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
    };

 
	Focuspersoncasestatus.list = function(request) {

        var sql = "select * from listfocuspersoncasestatus($1,$2,$3,$4,$5,$6)"

        return util.executeDBQuery(sql, [request.where.intakeserviceid,request.where.intakenumber,request.where.personid,request.where.status,request.page,request.limit])
          .then(res =>{
            return res
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });

	};

	

	Focuspersoncasestatus.remoteMethod('list', {
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
    
    Focuspersoncasestatus.distinctlist = function(request) {

        LOGGER.debug(request.where.intakeserviceid,request.intakenumber,request.personid)
        var sql = "select * from distinctlistfocuspersoncasestatus($1)"

        return util.executeDBQuery(sql, [request.where.personid])
          .then(res =>{
            return res
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });

	};

	

	Focuspersoncasestatus.remoteMethod('distinctlist', {
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
	
	


 



   
        
    Focuspersoncasestatus.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Focuspersoncasestatus.observe('access', (ctx, next) => util.access(ctx, next));
    Focuspersoncasestatus.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
