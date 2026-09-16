'use strict';
const LOGGER = require("log4js").getLogger("investigation");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Investigation) {
		/*GetInvestigationsByServiceRequestId*/
		var totalCount;

		Investigation.srallegations = function(data) {
			var Totalcount = 0;

			var countPromise = data.page == 1
				? util.executeDBQuery('select * from srallegations_cnt($1)', [data.servicerequestnumber])
					.then(_data => { Totalcount = _data[0].srallegations_cnt; })
				: Promise.resolve();

			var sql = 'select * from SRAllegations($1,$2,$3)';
			LOGGER.debug('1111' + sql);
			return countPromise
				.then(() => util.executeDBQuery(sql, [data.servicerequestnumber,data.page,data.limit]))
				.then(_data => {
					return {
						'data' : _data,
						'count' : Totalcount
					};
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
		}
		Investigation.GetInvestigationsByServiceRequestId = function(data){
			return Investigation.find({
					where : {
						activeflag : data.activeFlag,
						intakeserviceid : {inq : data.ServiceRequestIds}
					},
					include: 'Investigationreviewtype',
					skip : data.skip,
					limit : data.limit,
					order : data.order
			})
			.then(res => res)
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};


		Investigation.GetActivityTask = async function(data,reqctx) {
			const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;	 
			var _email;
			if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
				_email = reqctx.req.headers.user_email_captureby_application;
			}  
			var requestuserinfo = {'token': '', 'email': _email};
			var pageno = (data.page - 1) * data.limit
			var securityuserid = _securityusersid;
			var sroletypekey ;
			await util.getuserinfo(requestuserinfo).then (_data => {
			  sroletypekey = _data.roletypekey;
			});  

			if (sroletypekey != null && sroletypekey != undefined &&
				sroletypekey.substring(sroletypekey.length - 2, sroletypekey.length) == 'SP')
				{securityuserid = '';}

			var { sql, params } = returnSqlAndParamsFn(data, pageno, securityuserid);
			 sql = sql + ' LIMIT ' + data.limit + ' offset '  + pageno;
			 
			totalCount = 0;

				return util.executeDBQuery(sql, params)
				.then(_data => {
					totalCount = _data?.[0]?.totalcount ?? 0;
					return _data;
				})
				.catch(err => util.logError(err));
			};

		const aftRemotefn = (ctx, data, next) =>{
			if (ctx.result) {
				ctx.result = {
					'data' : data,
					'count' : totalCount
				};
			}
			next();
		}

		Investigation.afterRemote('GetActivityTask', aftRemotefn);

		Investigation.GetActivityGoal = function(data){
			LOGGER.debug(data);
			var pageno =(data.page - 1) * data.limit

			var sql = 'select * from getactivitygoal($1,$2,$3,$4,$5)';
			LOGGER.debug(sql);
			totalCount = 0;
			  return util.executeDBQuery(sql, [data.where.investigationid,data.where.activitiesid,data.where.goalid,pageno,data.limit])
				.then(_data => {
					if (_data.length>0 ) {totalCount = _data[0].totalcount;}
					return _data;
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
		};
		Investigation.GetTaskSummaryv1 = function(data, reqctx){
			let _securityusersid = undefined;
			if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
			  _securityusersid = reqctx.req.headers.securityusersid;
			}  
			var _email;
			if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
				_email = reqctx.req.headers.user_email_captureby_application;
			}  
			var requestuserinfo = {'token': '', 'email': _email};
			var securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);
			var sroletypekey ;
			return util.getuserinfo(requestuserinfo).then (_data => {
			  sroletypekey = _data?.roletypekey || null;

			  if ( sroletypekey!=null && sroletypekey!=undefined &&
				sroletypekey.substring(sroletypekey.length-2, sroletypekey.length)  =='SP')
				{securityuserid='';}

			  var sql = 'select * from gettasksummary($1,$2)';

			  return util.executeDBQuery(sql,[data.where.investigationid,securityuserid])
				.then(gettasksummarydata => gettasksummarydata);
			}).catch(err => {
				LOGGER.debug(err);
				throw err;
			});
		};

		Investigation.GetTaskSummary = async function(request,reqctx) {
			let _securityusersid = undefined;
			if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
			  _securityusersid = reqctx.req.headers.securityusersid;
			}  
			var _email;
			if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
				_email = reqctx.req.headers.user_email_captureby_application;
			}  
			var requestuserinfo = {'token': '', 'email': _email};
			var securityuserid = (request && request.securityuserid ? request.securityuserid: _securityusersid);
			var sroletypekey ;
			await util.getuserinfo(requestuserinfo).then (data => {
			  sroletypekey = data.roletypekey;
			});  

			if ( sroletypekey!=null && sroletypekey!=undefined && 
				sroletypekey.substring(sroletypekey.length-2, sroletypekey.length)  =='SP')
				{securityuserid='';}

			var sql = 'select * from gettasksummary($1,$2)';
			LOGGER.debug(sql);

				return util.executeDBQuery(sql, [request.where.investigationid,securityuserid])
				.then(data => data)
				.catch(err => util.logError(err));
			};



		Investigation.GetTaskSummary1 = function(data){
			app.models.Activitytaskstatustype.find(
				{
					and: [
		        {activeflag: 1,activitytypekey:'Investigation'}
			  ],
			  groupby:'activitytaskstatuskey',
			   include : {
					relation:'activitytask',
					scope: {
						//fields:['activityid'],
						where :{
						and: [{activeflag:1}]
						}},
						include : {
							relation:'taskactivityid',
							where :{
							 and: [{activeflag:1},{objectid: data.where.objectid}]
						   }
						}
				}
	}, function(err, count) {

				if (err) {
					throw err;
				}
				LOGGER.debug(  count);


				return count;
			});
		};
		Investigation.afterRemote('GetTaskSummary', function(ctx, data, next) {
			if (ctx.result) {
				ctx.result = {
					'data' : data
				};
			}
			next();
		});

		Investigation.afterRemote('GetActivityGoal', aftRemotefn);
		
		Investigation.remoteMethod('GetInvestigationsByServiceRequestId', {
		accepts : [ {
			arg : 'data',
			type : 'object',
			http : {
				source : 'body'
			}
		} ],
		returns : {
			type : 'object',
			root : true
		}
	});

	Investigation.remoteMethod('GetActivityTask', {
		accepts : [{
			arg : 'data',
			type : 'object',
			http : {
				source : 'query'
			},
			required : true
		}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
		http : {
			verb : 'get'
		},
		returns : {
			type : 'object',
			root : true
		}
	});
	Investigation.remoteMethod('GetActivityGoal', {
		accepts : {
			arg : 'data',
			type : 'object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'object',
			root : true
		}
	});
	Investigation.remoteMethod('GetTaskSummary', {
		accepts : [{
			arg : 'data',
			type : 'object',
			http : {
				source : 'query'
			},
			required : true
		}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
		http : {
			verb : 'get'
		},
		returns : {
			type : 'object',
			root : true
		}
	});
Investigation.getinvestigationallegationlist = function(data){
			return Investigation.find({
					where : {
						activeflag : data.where.activeflag,
						intakeserviceid : data.where.intakeserviceid
					},
					include: [{
						relation: "investigationallegation",
					scope: {
                    where: {activeflag: true}
					}}]
			})
			.then(res => res)
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};
Investigation.remoteMethod('getinvestigationallegationlist', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				path :'/getinvestigationallegationlist',
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


	Investigation.remoteMethod('srallegations', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				path :'/srallegations/list',
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'object',
			root : true
		}
	});

Investigation.getinvestigationsummary =(request) =>{

	 var sql = 'SELECT * FROM getinvestigationsummary($1)';

     return util.executeDBQuery(sql,[request.intakeserviceid])
        .then(data => data)
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
}


Investigation.remoteMethod(
	'getinvestigationsummary',
			{
			  http: {
					  path: '/getinvestigationsummary',
					  verb: 'post'
			  },
			 accepts : [ {arg : 'data',type : 'object',
					 http : {source : 'body'}} ],
			  returns: {
				  type : 'object',
					root : true
			  }
			 }
);

Investigation.getcasesummary = (request) => {

	var summarytype = '';

	if(request.where.summarytype != null || request.where.summarytype != undefined){summarytype = request.where.summarytype;}


	var sql = 'SELECT * FROM getcase_summary($1,$2)';

	return util.executeDBQuery(sql, [request.where.intakeserviceid,summarytype])
		.then(data => data)
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
}


Investigation.remoteMethod('getcasesummary',
	{
		http : {
			verb : 'get'
		},
		returns : {
			type : 'Object',
			root : true
		},
		accepts: {
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			}
		}
	});


	Investigation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Investigation.observe('access', (ctx, next) => util.access(ctx, next));
	Investigation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}

function returnSqlAndParamsFn(data, pageno, securityuserid) {
	var sql = 'select * from getactivitytask($1,$2,$3,$4,$5,$6,$7)';
	var params = [data.where.investigationid, data.where.activitiesid,
	data.where.taskid, data.where.taskstatus, pageno, data.limit, securityuserid];
	if (util.isNullorEmpty(data.where.objectid)) {
		sql = 'select * from getservicecasechecklist($1,$2,$3,$4)';
		params = [data.where.objectid, pageno, data.limit, securityuserid];
	}
	if (data.where && data.where.sortBy) {
		sql = sql + ' ORDER BY ' + data.where.sortBy;
		if (data.where.sortDir) {
			sql = sql + ' ' + data.where.sortDir;
		}
		else {
			sql = sql + ' asc';
		}
	}
	else {
		sql = sql + ' ORDER BY duedate asc';
	}
	return { sql, params };
}
