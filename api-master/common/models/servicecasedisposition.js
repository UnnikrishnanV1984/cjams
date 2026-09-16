'use strict';
const LOGGER = require("log4js").getLogger("servicecasedisposition");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');
module.exports = function (Servicecasedisposition) {

	Servicecasedisposition.remoteMethod('add', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		}
		,{
					arg: 'reqctx',
					type: 'object',
					http: {source: 'context'}
				  } ],
		http: {
			verb: 'post'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	Servicecasedisposition.add = function (request,reqctx) {
		const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
		var userid = suserid;
		var comments = '';

		if (request.disposition != null && request.disposition != undefined) {

			var servicecaseid = request.disposition.servicecaseid;
			var sql = 'select * from updateservicecasedispositionrouting($1,$2,$3,$4);'
			
			return util.executeDBQuery(sql, [servicecaseid,request.disposition.intakeserreqstatustypekey,request.disposition.dispositioncode,userid])
			.then(data => {
				return data;
			})
			.then(data => {
					var supervisorid = request.disposition.supervisorid;
					comments = util.nullcheck(request.disposition.reviewcomments);
					request.disposition.activeflag = true;
					request.disposition.insertedby = userid;
					request.disposition.updatedby = userid;
					request.disposition.comments = comments;
					return Servicecasedisposition.create(request.disposition)
					.then(res => {

					var servicecasedispositionid = null;
					if (res) {
						servicecasedispositionid = res.servicecasedispositionid;
					}

					var notifymsg = '';
					var routeddescription = '';
					var status = 15;
					var routingrole = 'CWCW';

					var qry = 'SELECT * FROM routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14, $15)';
					return util.executeDBQuery(qry, [servicecasedispositionid, userid, 'SCDR', status, comments, supervisorid, false, false, false, notifymsg, routeddescription, servicecaseid, '', 1,routingrole])
					.then(result => {
						return res;
					});

				});
			})
			.catch(err => {
				LOGGER.error(err);
				return err;
			});
		}
		return Promise.resolve('Invalid request');
	};

	Servicecasedisposition.remoteMethod('reopenservicecase', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		}
		,{
					arg: 'reqctx',
					type: 'object',
					http: {source: 'context'}
				  } ],
		http: {
			verb: 'post'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	Servicecasedisposition.reopenservicecase = (request,reqctx) => {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 

		request.userid = (request && request.securityuserid?request.securityuserid: suserid);

		var sql = "SELECT * FROM reopenservicecase($1::json)"
		return util.executeDBQuery(sql, [request])
		.then(data => {
			LOGGER.debug(data);
			if(data[0].success) {
				return data[0];
			} else {
				return {message: 'Please try again later', success : false};
			}
		}).catch(err => util.logError(err));

	};
	
	Servicecasedisposition.savestatusupdate = (servicecaseid,status) => {
		LOGGER.debug(servicecaseid,status ,'Debas')
		var sql = 'update  servicecase set dispositioncode=$1 where servicecaseid=$2';
		return util.executeDBQuery(sql, [status,servicecaseid])
		.then(data => {
			return data
		}).catch(err => util.logError(err));
	  }
	
 
	Servicecasedisposition.getservicecasedisposition = (request) => {
		  var sql = 'select * from getservicecasedisposition($1,$2,$3)';
		  return util.executeSecondaryNodeDBQuery(sql, [request.where.servicecaseid, request.page, request.limit])
		.then(data => {
			return data && data[0] && data[0].getservicecasedisposition ? data[0].getservicecasedisposition : [];
		}).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
	  }
	
	  Servicecasedisposition.remoteMethod('getservicecasedisposition', {
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

	  
	Servicecasedisposition.remoteMethod('caseclosure', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'body'
			},
			required: true
		}
		,{
					arg: 'reqctx',
					type: 'object',
					http: {source: 'context'}
				  } ],
		http: {
			verb: 'post'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	Servicecasedisposition.caseclosure = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		var userid = (request && request.securityuserid?request.securityuserid: suserid);

		var sql = "SELECT * FROM addivecaseclosurereview($1, $2, $3, $4, $5, $6, $7)"
		return util.executeDBQuery(sql, [userid, request.disposition.caseid, request.disposition.objecttype, request.disposition.status, request.disposition.dispostionid, null, request.disposition.casenumber])
		.then(data => {
			LOGGER.debug(data);
			return 'success';
		}).catch(err => util.logError(err));
	};

	Servicecasedisposition.remoteMethod ('getcaseclosure',{
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			path: '/getcaseclosure',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	Servicecasedisposition.getcaseclosure = function(request) {
		var sql = `SELECT
					(select up.fullname from userprofile up where up.securityusersid=iccr.insertedby) as workerName,
					(select up2.fullname from userprofile up2
					inner join routing r on r.objectid = iccr.ivecaseclosurereviewid::character varying and r.routingstatustypeid='203'
					where up2.securityusersid=r.fromsecurityusersid order by r.insertedon desc limit 1) as specialistName,
					(select up2.fullname from userprofile up2
					inner join routing r on r.objectid = iccr.ivecaseclosurereviewid::character varying
					where up2.securityusersid=r.fromsecurityusersid order by r.insertedon desc limit 1) as supervisorName,
					iccr.insertedon,iccr.ivereviewstatus, iccr.insertedby, iccr.updatedon
					FROM ivecaseclosurereview iccr
					where objectid = $1 and iccr.ivereviewstatus not in ('CCR_Reopened') and iccr.activeflag=1 order by iccr.insertedon desc limit 1`;
		var params = [request.where.caseId];

		return util.executeDBQuery(sql, params)
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};


	Servicecasedisposition.remoteMethod('ebpcaseclosuredetails', {
        http: {
            path: '/ebpcaseclosuredetails',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

	Servicecasedisposition.ebpcaseclosuredetails = function(request) {
	var sql = `select count(*) from tb_service_log tsl where tsl.case_id::text = $1 and TSL.end_dt is null and  TSL.delete_sw='N' `;
		var params = [request.where.caseId];

		return util.executeDBQuery(sql, params)
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};


	Servicecasedisposition.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Servicecasedisposition.observe('access', (ctx, next) => util.access(ctx, next));
	Servicecasedisposition.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}