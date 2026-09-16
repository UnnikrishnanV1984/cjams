'use strict';
const LOGGER = require("log4js").getLogger("getdocdetails");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Getdocdetails) {

	Getdocdetails.list  =function(data){
		var Totalcount = 0;
		var datype = '';
		var dasubtype = '';
		var entityroletypekey = '';

		if(data.where.datype !== undefined){
			datype = data.where.datype.like;
		}
		if(data.where.dasubtype !== undefined){
			dasubtype = data.where.dasubtype.like;
		}
		if(data.where.entityroletypekey !== undefined){
			entityroletypekey = data.where.entityroletypekey.like;
		}

		var countPromise;
		 if(data.page == 1){
			var Count = 'select * from getdocdetails_cnt($1, $2, $3)';
			countPromise = util.executeDBQuery(Count, [datype, dasubtype, entityroletypekey])
				.then(_data => {
					Totalcount = _data[0].getdocdetails_cnt;
				});
			} else {
			countPromise = Promise.resolve();
			}


		var sql = 'select * from getdocdetails($1,$2,$3,$4,$5)';
		LOGGER.debug('1111'+sql);
		return countPromise
			.then(() => util.executeDBQuery(sql, [data.page, data.limit, datype, dasubtype, entityroletypekey]))
			.then(_data => {
				return {
				'data' : _data,
				'count' : Totalcount
				};
			})
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

	}
	Getdocdetails.remoteMethod(
			'list', 
				    {
				      http: {
				      		path: '/list',
				      		verb: 'post'
				      },
				     accepts : [ 
				    	   {arg : 'data',type : 'object',
				     		http : {source : 'body'}} ],   
				      returns: {
				    	  type : 'object',
							root : true
				      }
				     }
		);

		Getdocdetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Getdocdetails.observe('access', (ctx, next) => util.access(ctx, next));
		Getdocdetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
