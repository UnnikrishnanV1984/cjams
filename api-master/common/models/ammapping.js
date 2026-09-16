'use strict';
const LOGGER = require("log4js").getLogger("ammapping");
const app = require('../../server/server');
const util = require('../utils/utils');
const sqlmsg = '--SQL2222222222-->>>>>';
const errmsg = '---error->>>>';
const datamsg = '----data---' ;
module.exports = function(Ammapping) {
    /**
     * Execute the Count - if count is zero don't execute the listing else
     * return the list also *
     */
    var totalCount;
	Ammapping.list = function(request, reqctx) {
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
        }
        var requestuserinfo = {'token': '', 'email': _email};
        var teamtypekey ;
		return util.getuserinfo(requestuserinfo).then (data => {
            teamtypekey = data.teamtypekey;
			request.where.teamtypekey = teamtypekey;
			if (request.page !== 'undefined') {
				request.skip = (request.page - 1) * request.limit;
			}

			return Ammapping.find(request);
		}).catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
        });
    };

    Ammapping.mappingSave = function(request, reqctx) {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;  
        var isreview = request.isreviewactivity
        var ondemand = request.ondemand
        if (isreview === true) {
            ondemand = false;
        }
        var sql = 'UPDATE Ammapping SET amactivityid=$1,description=$3, name=$4, helptext=$5,isreviewactivity=$6,ondemand =$7 ,workload = $8 WHERE ammappingid =$2';
        LOGGER.debug(sqlmsg + sql);
				return util.executeDBQuery(sql, [request.amactivityid, request.ammappingid, request.description,
					request.name, request.helptext, isreview, ondemand, request.workload])
				.then(data => {
						LOGGER.info(data);
							var ammappingid = request.ammappingid
							if (request.activitytypekey === "Investigation") {
									app.models.Servicerequesttypeconfig.findOne({
											where: {
													and: [{
																	activeflag: true
															},
															{
																	intakeservreqtypeid: request.servicerequestid
															},
															{
																	servicerequestsubtypeid: request.servicerequestsubtypeid
															}
													]
											}
									}, function(err, resp) {
											if (err) {
												throw err;
											} else {
													const objectid = resp.servicerequesttypeconfigid;
													findUpdateInvestigationmapping(request, _securityusersid, objectid);
			}
									})
							} else if (request.activitytypekey === "Allegation") {
						    	const objectid = request.objectid;
								findUpdateInvestigationmapping(request, _securityusersid, objectid);
							}



							var goalarray = request.ammappinggoal
							LOGGER.debug(goalarray + "goal");

									var insertedby = _securityusersid;
									var updatedby = _securityusersid;
									var sql3 = 'UPDATE ammappinggoal SET activeflag = 0,  insertedby = $1, updatedby = $2  WHERE ammappingid = $3';
									LOGGER.debug(sqlmsg + sql3);
									
									util.executeDBQuery(sql3, [insertedby, updatedby, request.ammappingid])
										.then(data1 => {
											LOGGER.info(data1);
										})
										.catch(err => {
											LOGGER.error(err)
											throw err;
										})

										addupdateMappingBygoalarray(goalarray, _securityusersid, ammappingid)


							
									var taskarray = request.ammappingtask

									var sql4 = 'UPDATE ammappingtask SET activeflag = 0,   insertedby = $1, updatedby = $2  WHERE ammappingid = $3';
									LOGGER.debug(sqlmsg + sql4);
																 
									util.executeDBQuery(sql4, [insertedby, updatedby, request.ammappingid])
									.then(data1 => {
											LOGGER.info(data1);
									})
									.catch(err => {
											LOGGER.error(err)
											throw err;
									})
									addupdateMappingBytaskarray(taskarray, _securityusersid, ammappingid)
		return "Success";
				})
				.catch(err => {
						LOGGER.error(err)
						throw err;
				})
    };

		function addupdateMappingBygoalarray(goalarray, _securityusersid, ammappingid){
			if (Array.isArray(goalarray)) {

				goalarray.forEach(element => {

						LOGGER.debug('--array--->>>' + JSON.stringify(element));
						var amgoalid = element.amgoalid;
						var goaltypekey = element.activitygoaltypekey;
						var prioritytypekey = element.activityprioritytypekey;
						var DueDateoffset = element.duedateoffset;
						var helpText = element.helptext;
						var Required = element.required;
						var insertedby = _securityusersid;
						var updatedby = _securityusersid;

						LOGGER.debug('--amgoal---' + amgoalid)

						var sql = 'SELECT * from  ammappinggoal where ammappingid = $1 and amgoalid= $2';
						LOGGER.debug('1111' + sql)
						util.executeDBQuery(sql, [ammappingid, amgoalid])
						.then(data => {
								LOGGER.info(data);
								if (data.length === 0) {
									LOGGER.debug(datamsg+ data.length)
									var sql1 = 'INSERT INTO ammappinggoal (ammappingid,amgoalid,required,helptext,duedateoffset,activitygoaltypekey,activityprioritytypekey,insertedby,updatedby) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)';
									LOGGER.debug(sqlmsg + sql1);
									util.executeDBQuery(sql1, [ammappingid, amgoalid, Required, helpText, DueDateoffset, goaltypekey, prioritytypekey, insertedby, updatedby])
									.then(data1 => {
											LOGGER.info(data1);
									})
									.catch(err => {
											LOGGER.error('>>>>ERROR:', err);
											throw err;
									})
							} else if (data.length > 0) {
									LOGGER.debug(datamsg+ data.length)
									var sql4 = 'UPDATE ammappinggoal SET  activitygoaltypekey =$1, activityprioritytypekey =$2, duedateoffset= $3,  helptext=$4, required = $5, insertedby = $6,updatedby =$7,activeflag = $8 where ammappingid = $9 and amgoalid= $10';
									LOGGER.debug(sqlmsg + sql4);
									var activeflag = 1;
									util.executeDBQuery(sql4, [goaltypekey, prioritytypekey, DueDateoffset, helpText, Required, insertedby, updatedby,activeflag, ammappingid, amgoalid])
									.then(data1 => {
											LOGGER.info(data1);
									})
									.catch(err => {
											LOGGER.error('>>>>ERROR:', err);
											throw err;
									})
							}
						})
						.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
						})
				});

		}
		}

	function addupdateMappingBytaskarray(taskarray, _securityusersid, ammappingid) {
		if (Array.isArray(taskarray)) {

			taskarray.forEach(element => {

				var amtaskid = element.amtaskid;
				var tasktypekey = element.activitytasktypekey;
				var prioritytypekey = element.activityprioritytypekey;
				var DueDateoffset = element.duedateoffset;
				var helpText = element.helptext;
				var Required = element.required;
				var insertedby = _securityusersid;
				var updatedby = _securityusersid;

				var sql2 = 'SELECT * from  ammappingtask where ammappingid = $1 and amtaskid= $2 and activeflag = 1';
				util.executeDBQuery(sql2,[ammappingid, amtaskid])
					.then(data => {
						LOGGER.info(data);
						if (record.length === 0) {
							LOGGER.debug('----data11111---' + record.length)
							var sql3 = 'INSERT INTO ammappingtask (ammappingid,amtaskid,required,helptext,duedateoffset,activitytasktypekey,activityprioritytypekey,insertedby,updatedby) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)';
							LOGGER.debug(sqlmsg + sql2);
							util.executeDBQuery(sql3,[ammappingid,amtaskid,Required,helpText,DueDateoffset,tasktypekey,prioritytypekey,insertedby,updatedby])
								.then(data1 => {
									LOGGER.info(data1);
								})
								.catch(err => {
									LOGGER.error('>>>>ERROR:', err);
									throw err;
								})

						} else if (record.length > 0) {
							LOGGER.debug(datamsg + record.length)
							var sql4 = 'UPDATE ammappingtask SET  activitytasktypekey =$1, activityprioritytypekey =$2, duedateoffset= $3, helptext= $4,required = $5, insertedby = $6,updatedby =$7,activeflag =$8 where ammappingid = $9 and amtaskid= $10';
							LOGGER.debug(sqlmsg + sql4);
							var activeflag = 1;
							LOGGER.debug(activeflag + "var activeflag = 1;");
							util.executeDBQuery(sql4,[tasktypekey,prioritytypekey,DueDateoffset,helpText,Required,insertedby,updatedby,activeflag,ammappingid,amtaskid])
								.then(data1 => {
									LOGGER.info(data1);
								})
								.catch(err => {
									LOGGER.error('>>>>ERROR:', err);
									throw err;
								})
						}
					})
					.catch(err => {
						LOGGER.error('>>>>ERROR:', err);
						throw err;
					})
			});
		}
	}

	function findUpdateInvestigationmapping(request, _securityusersid, objectid) {
		var objecttype = request.activitytypekey
		var insertedby = _securityusersid;
		var updatedby = _securityusersid;
		var ammappingid = request.ammappingid;
		var isreviewactivity = request.isreviewactivity;
		app.models.Investigationmapping.find({
			where: {
				and: [{
					ammappingid: request.ammappingid
				},{
					activeflag: true
				}]
			}
		},function (err,reslt) {
			if (err) { LOGGER.error('>>>>ERROR:', err); throw err; }
			else {
				if (reslt.length > 0) {
					if (reslt[0].objectid === objectid) {
						LOGGER.debug("just updated");
					} else {
						LOGGER.debug(reslt)
						var Investigationmappingid = reslt[0].investigationmappingid
						var sql = 'UPDATE Investigationmapping SET activeflag = 0,insertedby =$1, updatedby = $2 WHERE Investigationmappingid = $3';
						LOGGER.debug('2222' + sql)
						util.executeDBQuery(sql,[insertedby,updatedby,Investigationmappingid])
							.then(data => {
								app.models.Investigationmapping.upsert({
									ammappingid: ammappingid,
									objectid: objectid,
									objecttype: objecttype,
									insertedby: insertedby,
									updatedby: updatedby,
									activeflag: true,
									isreviewactivity: isreviewactivity
								})
							})
							.catch(err1 => {
								LOGGER.error('>>>>ERROR:', err1);
								throw err1;
							})
					}
				}
			}
		})
	}

    Ammapping.mappingAdd = function(request, reqctx) {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        if (request.isreviewactivity === true) {
            request.ondemand = false
        }
        if (request.activitytypekey === "Investigation" &&
            request.servicerequestid !== undefined &&
            request.servicerequestsubtypeid !== undefined) {
            return app.models.Servicerequesttypeconfig.findOne({
                where: {
                    and: [{
                            activeflag: 1
                        },
                        {
                            intakeservreqtypeid: request.servicerequestid
                        },
                        {
                            servicerequestsubtypeid: request.servicerequestsubtypeid
                        }
                    ]
                }
            }).then(resp => {
                if (resp !== null) {
					const objectid = resp.servicerequesttypeconfigid;
					return addAmmappingandInvestigationmapping(request, _securityusersid, objectid);
					} else {
					return "DA configuration is not availabe for selected DA Type and DA Subtype.";
                }
            }).catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        } else if (request.activitytypekey === "Allegation" && request.objectid !== undefined) {
						const objectid = request.objectid;
						return addAmmappingandInvestigationmapping(request, _securityusersid, objectid);
        }
		return Promise.resolve('Invalid request');
	}

	function addAmmappingandInvestigationmapping(request, _securityusersid, objectid) {
		var objecttype = request.activitytypekey
		var insertedby = _securityusersid;
		var updatedby = _securityusersid;
		var ammappingid = '';
		return Ammapping.create(request).then(res => {
			ammappingid = res.ammappingid;
			var isreviewactivity = request.isreviewactivity

			app.models.Ammapping.goalandtask(request,_securityusersid);

			return app.models.Investigationmapping.create({
				ammappingid: ammappingid,
				objectid: objectid,
				objecttype: objecttype,
				insertedby: insertedby,
				updatedby: updatedby,
				isreviewactivity: isreviewactivity
			}).then(() => res);
		}).catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
	}

	Ammapping.goalandtask = function(request, _securityusersid) {
		var goalarray = request.ammappinggoal
		LOGGER.debug(goalarray);
		if (Array.isArray(goalarray)) {

				goalarray.forEach(element => {

						LOGGER.debug('--array--->>>' + JSON.stringify(element));
						var amgoalid = element.amgoalid;
						var goaltypekey = element.activitygoaltypekey;
						var prioritytypekey = element.activityprioritytypekey;
						var DueDateoffset = element.duedateoffset;
						var helpText = element.helptext;
						var Required = element.required;
						var insertedby = _securityusersid;
						var updatedby = _securityusersid;

						LOGGER.debug('--amgoal---' + amgoalid)

						var sql = 'INSERT INTO ammappinggoal (ammappingid,amgoalid,required,helptext,duedateoffset,activitygoaltypekey,activityprioritytypekey,insertedby,updatedby) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)';
						LOGGER.debug(sqlmsg + sql);
						util.executeDBQuery(sql, [ammappingid, amgoalid, Required, helpText, DueDateoffset, goaltypekey, prioritytypekey, insertedby, updatedby])
						.then(data => {
								LOGGER.info(data);
						})
						.catch(err => {
								LOGGER.error(err)
								throw err;
						})
				});

		}
		var taskarray = request.ammappingtask

		if (Array.isArray(taskarray)) {
				LOGGER.debug(taskarray);
				taskarray.forEach(element => {

						var amtaskid = element.amtaskid;
						var tasktypekey = element.activitytasktypekey;
						var prioritytypekey = element.activityprioritytypekey;
						var DueDateoffset = element.duedateoffset;
						var helpText = element.helptext;
						var Required = element.required;
						var insertedby = _securityusersid;
						var updatedby = _securityusersid;

						var sql1 = 'INSERT INTO ammappingtask (ammappingid,amtaskid,required,helptext,duedateoffset,activitytasktypekey,activityprioritytypekey,insertedby,updatedby) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)';
						LOGGER.debug(sqlmsg + sql1);
						util.executeDBQuery(sql1, [ammappingid, amtaskid, Required, helpText, DueDateoffset, tasktypekey, prioritytypekey, insertedby, updatedby])
						.then(data => {
								LOGGER.info(data);
						})
						.catch(err => {
								LOGGER.error(err)
								throw err;
						})
				});
		}
}

	Ammapping.updatemapping = (id) => {

		var sql = 'UPDATE Ammapping SET activeflag=0 WHERE ammappingid = $1';
		var params = [id];

		return util.executeDBQuery(sql, params)
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}

    Ammapping.beforeRemote('list', function(ctx, data, next) {

        if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {

            Ammapping.count({
                "activeflag": 1,
                "activitytypekey": "Allegation"
            }, function(err, count) {

                if (err) {
                    throw err;
                }
                totalCount = count;

            });

        }

        next();
    });

    Ammapping.afterRemote('list', function(ctx, resultset, next) {
        if (ctx.result) {
            ctx.result = {
                'data': resultset,
                'count': totalCount
            };
        }
        next();
    });

    Ammapping.remoteMethod('list', {
        accepts: [{
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true},
            {arg: 'reqctx', type: 'object',
			http: {source: 'context'}}],
        http: {
            verb: 'get'
        },
        returns: {
            type: 'string',
            root: true
        }
    });

    Ammapping.remoteMethod(
        'mappingAdd', {
            http: {
                path: '/mappingAdd',
                verb: 'post'
            },
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body'
                }
            }, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );

    Ammapping.remoteMethod(
        'mappingSave', {
            http: {
                path: '/mappingSave',
                verb: 'post'
            },
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body'
                }
            }, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
            returns: {
                type: 'object',
                root: true
            }
        }
	);

	Ammapping.remoteMethod('updatemapping', {
		accepts:
			{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
		http: { "verb": "delete", "path": "/delete/:id" },
		returns: {
			type: 'Object',
			root: true
		}
	});

    Ammapping.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Ammapping.observe('access', (ctx, next) => util.access(ctx, next));
    Ammapping.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};