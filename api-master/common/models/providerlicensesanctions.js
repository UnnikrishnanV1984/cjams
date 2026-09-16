'use strict';
const LOGGER = require("log4js").getLogger("providerlicensesanctions");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');

module.exports = function(Providerlicensesanctions) {

	Providerlicensesanctions.addlicensesanction= function(request,reqctx){
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		request.where.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var addlicensesanc = 'select * from addlicensesanctioninfo($1)';
		return util.executeDBQuery(addlicensesanc, [JSON.stringify(request.where)])
			.then(data => {
				return {data : data};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};
		
	Providerlicensesanctions.remoteMethod(
		'addlicensesanction', 
				{
					http: {
							path: '/addlicensesanction',
							verb: 'post'
					},
					accepts : [{
						arg : 'data',
						type : 'object',
						http : {
							source : 'body'
						}
					},{
						arg: 'reqctx',
						type: 'object',
						http: {source: 'context'}
					  } ],   
					returns: {
						type : 'object',
						root : true
					}
					}
	);

	Providerlicensesanctions.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerlicensesanctions.observe('access', (ctx, next) => util.access(ctx, next));
	Providerlicensesanctions.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		
};
