'use strict';
const LOGGER = require("log4js").getLogger("adoptioncasedisposition");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');
module.exports = function (Adoptioncasedisposition) {

	Adoptioncasedisposition.remoteMethod('add', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		}, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
		http: {
			verb: 'post'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	Adoptioncasedisposition.add = function (request, reqctx) {
		let _securityusersid = undefined;
        if(reqctx?.req?.headers?.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
		var userid = (request?.securityuserid ? request.securityuserid : _securityusersid);

		if (request.disposition != null && request.disposition !== undefined) {

			var assignsecurityuserid = request.disposition.assignsecurityuserid;
			var servicecaseid = request.disposition.adoptioncaseid;
			request.disposition.activeflag = true;
			request.disposition.insertedby = userid;
			request.disposition.updatedby = userid;
			return Adoptioncasedisposition.create(request.disposition)
				.then(res => {
					var adoptioncasedispositionid = res.adoptioncasedispositionid;

					var comments = '';
					var notifymsg = '';
					var routeddescription = '';
					var status = 15;

					var qry = 'SELECT * FROM routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
					return util.executeDBQuery(qry, [adoptioncasedispositionid, userid, 'ACDR', status, comments, assignsecurityuserid, false, false, false, notifymsg, routeddescription, servicecaseid, '', 1])
						.then(result => res);
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
		}
		return Promise.resolve('Invalid request');
	};
	

	Adoptioncasedisposition.getadoptioncasedisposition = (request) => {
		var sql = 'select * from getadoptioncasedisposition($1,$2,$3)';
		return util.executeDBQuery(sql, [request.where.adoptioncaseid, request.page, request.limit])
			.then(data => data[0].getadoptioncasedisposition)
			.then(data => {
				return data
			}).catch(err => util.logError(err));
	  }
	
	  Adoptioncasedisposition.remoteMethod('getadoptioncasedisposition', {
		accepts: {
		  arg: 'filter',
		  type: 'Object',
		  http: {
			source: 'query'
		  },
		  required: true
		},
		http: {
		  verb: 'get'
		},
		returns: {
		  type: 'string',
		  root: true
		}
	  });

	Adoptioncasedisposition.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Adoptioncasedisposition.observe('access', (ctx, next) => util.access(ctx, next));
	Adoptioncasedisposition.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
