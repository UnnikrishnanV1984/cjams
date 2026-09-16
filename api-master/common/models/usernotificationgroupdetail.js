'use strict';
const LOGGER = require("log4js").getLogger("usernotificationgroupdetail");
const util = require('../utils/utils');

module.exports = function(Usernotificationgroupdetail) {

	
	Usernotificationgroupdetail.addupdate = function (request,reqctx) {

		//Pre-request
		//Step 1: Get this parameter usernotificationgroupid,teammemberid,userid
		//Update all existing active flag to Zero
		//User Create or insert method to action
		//Check the trigger function on effective date and expiredate
		LOGGER.debug('Coming')

		const _securityusersid = util.getSecurityDetails(request,reqctx).securityuserid;

		if (request.usernotificationgroupid !== 'undefined') {
			LOGGER.debug('id' + request.usernotificationgroupid)

			var teammemberarray = request.teammemberid;

			return Usernotificationgroupdetail.find({ where: { and: [{ usernotificationgroupid: request.usernotificationgroupid }] } })
				.then(records => {
					if (records.length > 0) {
						LOGGER.debug('check true');
						var sql = 'UPDATE usernotificationgroupdetail SET activeflag=0 WHERE usernotificationgroupid =\'' + request.usernotificationgroupid + '\'';
						LOGGER.debug('sss---->' + sql)
						LOGGER.debug('wwww---->' + request.activeflag)
						util.executeDBQuery(sql,[])
						.then(data => {
							LOGGER.info(data);
						})
						.catch(err1 => {
							LOGGER.error('>>>>ERROR:', err1);
							throw err1;
						})
						return Usernotificationgroupdetail.updateAll({ usernotificationgroupid: request.usernotificationgroupid },{ activeflag: 0,updatedby: _securityusersid })
							.then(res => {
								addUpdateusernotificationgroupdetail(teammemberarray, request);
							});
						// no matching records exist!
					} else if (records == 0) {
						LOGGER.debug('newrecord--->>>>>>>')

						LOGGER.debug('-----' + (Array.isArray(teammemberarray)))
						if (Array.isArray(teammemberarray)) {
							teammemberarray.forEach(element => {
								var tempid = element;
								LOGGER.debug("tempid--->" + tempid);

								var sql4 = 'INSERT INTO usernotificationgroupdetail (usernotificationgroupid,teammemberid,activeflag,effectivedate) VALUES ($1,$2,$3,$4)';
								LOGGER.debug('--SQL2222222222-->>>>>' + sql4);
								var activeflag = 1;
								util.executeDBQuery(sql4,[request.usernotificationgroupid,tempid,activeflag,request.effectivedate])
									.then(data => {
										LOGGER.info(data);
										return data;
									})
									.catch(err3 => {
										LOGGER.error('>>>>ERROR:', err3);
										throw err3;
									})
							});
						}
					}
				})
				.then(() => "Success")
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
		}
		return Promise.resolve('Invalid request');
	};

	function addUpdateusernotificationgroupdetail(teammemberarray, request){
		if (Array.isArray(teammemberarray)) {
			teammemberarray.forEach(element => {
				LOGGER.debug('---element---->>>>>>>>' + element)
				var tempid = element;
				LOGGER.debug("tempid--->" + tempid);
				var sql1 = "select * from usernotificationgroupdetail WHERE usernotificationgroupid =$1 AND teammemberid =$2";
				LOGGER.debug('====>>>>' + sql1)
				return util.executeDBQuery(sql1,[request.usernotificationgroupid,tempid])
					.then(results => {
						LOGGER.debug('----->>>>>>>' + results);
						if (results.length > 0) {
							LOGGER.debug('-----inside---->>>>>>>---' + tempid)
							var sql2 = 'UPDATE usernotificationgroupdetail SET activeflag=1 WHERE usernotificationgroupid =$1 AND teammemberid =$2';
							LOGGER.debug('--SQL111111111-->>>>>' + sql2);
							LOGGER.debug('value----->>>>>>' + sql2);
							return util.executeDBQuery(sql2,[request.usernotificationgroupid,tempid])
								.then(data => {
									LOGGER.info(data);
								})
								.catch(err => {
									LOGGER.error(err)
									throw err;
								})
						} else if (results.length == 0) {
							var sql3 = 'INSERT INTO usernotificationgroupdetail (usernotificationgroupid,teammemberid,activeflag,effectivedate) VALUES ($1,$2,$3,$4)';
							LOGGER.debug('--SQL2222222222-->>>>>' + sql3);
							var activeflag = 1;
							return util.executeDBQuery(sql3,[request.usernotificationgroupid,tempid,activeflag,request.effectivedate])
								.then(data => {
									LOGGER.info(data);
								})
								.catch(err => {
									LOGGER.error(err);
									throw err;
								})
						} 
					})
					.catch(err => {
						LOGGER.error(err);
						throw err;
					})

			});
		}
	}
	
	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	var totalCount;
	Usernotificationgroupdetail.list = function(request) {

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		return Usernotificationgroupdetail.find(request);

	};

	Usernotificationgroupdetail.beforeRemote('list', function(ctx, data, next) {

		if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && 
				JSON.parse(ctx.req.query.filter).page === 1) {

			Usernotificationgroupdetail.count(function(err, count) {

				if (err) {
					throw err;
				}
				totalCount = count;

			});

		}

		next();
	});

	Usernotificationgroupdetail.afterRemote('list', function(ctx, resultset,
			next) {
		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Usernotificationgroupdetail.remoteMethod('list', {
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
	
	Usernotificationgroupdetail.remoteMethod(
			'addupdate', 
				    {
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
							  } ],   
				      returns: {
				    	  type : 'object',
							root : true
				      }
				     }
		);

		Usernotificationgroupdetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Usernotificationgroupdetail.observe('access', (ctx, next) => util.access(ctx, next));
		Usernotificationgroupdetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
	 
};
