'use strict';
const LOGGER = require("log4js").getLogger("assignedassessment");
const util = require('../utils/utils');
var app = require('../../server/server');
const assessmentstr = 'assessment status changed to "';
const send_notificationsql = 'select * from send_notification($1, $2, $3, $4, $5, $6, $7, $8, $9)';
var updateassessmentsql = "update assignedassessment set activeflag =0 WHERE  assignedassessmentid =$1";

module.exports = function(Assignedassessment) {

	Assignedassessment.reassignassessment = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
		return app.models.Assignedassessment.find({
			where :{
				and: [{activeflag:1},{assessmenttemplateid: request.assessmenttemplateid},{intakeserviceid:request.intakeserviceid}]
			  }
		}).then(data =>{ 
			if (data.length > 0) {
                var assignedassessmentid = data[0].assignedassessmentid;
                var sql = "update assignedassessment set activeflag =0, status='Reassign' WHERE  assignedassessmentid =$1";
                util.executeDBQuery(sql,[assignedassessmentid])
                    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

			    return app.models.Assignedassessment.create({
				    assessmenttemplateid:request.assessmenttemplateid,
                    securityusersid: request.securityusersid,
                    intakeserviceid:request.intakeserviceid,
					status: 'open',
                    insertedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid),
                    updatedby: (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid)
				}).then (result => {
                    var notificationuserid =result.securityusersid;
                    var fromuserid = _securityusersid;
                    var tousersid=result.securityusersid;
                  
                    var objectid=result.intakeserviceid;
                    var subject='assessment is reassigned to "' + request.assessmentname +'"';
                  
                    var body=assessmentstr + result.status +'"';
                    util.executeDBQuery(send_notificationsql,[notificationuserid,fromuserid,tousersid,'System','High',subject,body,objectid,false])
                    .then(_data => {
                        return _data;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        throw err;
                    })
                    return result;
                })
		}})	
	}

	Assignedassessment.assessmentcompleted =(request, reqctx) =>{
        const _securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid; 
		return app.models.Assignedassessment.find({
			where :{
				and: [{activeflag:1},{assessmenttemplateid: request.assessmenttemplateid},{intakeserviceid:request.objectid}]
			  }
		}).then(data =>{ 
			if (data.length > 0) {
		var assignedassessmentid = data[0].assignedassessmentid;
		var sql = updateassessmentsql;
        util.executeDBQuery(sql, [assignedassessmentid])
        .then(_data => {
            return app.models.Assignedassessment.create({
				assessmenttemplateid:request.assessmenttemplateid,
                    securityusersid: request.securityusersid,
                    intakeserviceid:request.objectid,
					status: 'Completed',
                    insertedby: _securityusersid,
                    updatedby: _securityusersid
				})
		.then (result =>{
			if(request.assessmenttemplateid != null && request.objectid != undefined){
				return app.models.Assessment.find({
					where: {
						and: [{activeflag:1},{assessmenttemplateid:request.assessmenttemplateid},{objectid:request.objectid}]
					  }
				}).then(res =>{
							return addorupdateAssessment(request, reqctx);
	})
            }
        })
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        })
	}})
}

	function addorupdateAssessment(request, reqctx) {
		const _securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid; 
		var submissionid = request.submissionid;
		if (util.isNullorEmpty(submissionid)) {
			return app.models.Assessment.updateAll({ submissionid: submissionid }, {
				assessmentsubmissiontypekey: request.assessmentsubmissiontypekey,
				assessmentstatustypekey1: 'Review'
			})
		} else {
			return app.models.Assessment.create({
				assessmenttemplateid: request.assessmenttemplateid,
				securityusersid: request.securityusersid,
				assessmentsubmissiontypekey: request.assessmentsubmissiontypekey,
				objectid: request.objectid,
				insertedby: _securityusersid,
				updatedby: _securityusersid,
				assessmentstatustypekey1: 'Review'

			}).then(resul => {
				return resul;
			});
		}
	}

	Assignedassessment.assessmentreject =(request, reqctx) =>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const securityuserid = (request.securityuserid?request.securityuserid: _securityusersid);
        var assessmenttemplateid = request.assessmenttemplateid;
        var intakeserviceid = request.intakeserviceid;
        var status='Completed'
		return app.models.Assignedassessment.find({
			where: {
                and: [{activeflag:1},{assessmenttemplateid:request.where.assessmenttemplateid},{intakeserviceid:request.intakeserviceid},{status}]
              }
		}).then(data =>{
            var securityusersid = data[0].securityusersid
			if (data.length >0) {
				var assignedassessmentid = data[0].assignedassessmentid;
				var sql = "update assignedassessment set activeflag =0,status='Rejected' WHERE  assignedassessmentid =$1";

				util.executeDBQuery(sql,[assignedassessmentid])
					.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
				return app.models.Assignedassessment.create({
					assessmenttemplateid:assessmenttemplateid,
                        securityusersid: securityusersid,
                        intakeserviceid: intakeserviceid,
						status: 'Reopen'
					}).then(result=>{
                        var notificationuserid =result.securityusersid;
                        var fromuserid = securityuserid;
                        var tousersid=result.securityusersid;
                      
                        var objectid=result.intakeserviceid;
                        var subject='assessment is rejected "' + request.assessmentname +'"';
                      
                        var body=assessmentstr + result.status +'"';
                        util.executeDBQuery(send_notificationsql,[notificationuserid,fromuserid,tousersid,'System','High',subject,body,objectid,false])
                            .then(_data => _data)
                            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
						return result;
					})

			}
		})
				
	}

	Assignedassessment.assessmentcompletedbycw = (request, reqctx) =>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);
        const vsecurityusersid = (request && request.v_securityusersid ? request.v_securityusersid : _securityusersid);
        if(request.assessmenttemplateid != null && request.objectid != undefined){
        return app.models.Assessment.find({
			where :{
				and: [{activeflag:1},{assessmenttemplateid: request.where.assessmenttemplateid},{intakeserviceid: request.objectid}]
			  }
		}).then(data =>{
                    return app.models.Assessment.create({
                        assessmenttemplateid: request.assessmenttemplateid,
							securityusersid: securityuserid,
                            assessmentsubmissiontypekey: request.assessmentsubmissiontypekey,
                            objectid : request.objectid,
                            insertedby: vsecurityusersid,
                            updatedby: vsecurityusersid,
							assessmentstatustypekey1: 'Accepted'
                    }).then(result=>{
                        return result;
                    })
                
        })
    }

        return Promise.resolve('Invalid request');
    }

    Assignedassessment.approvedbycw =(request)=>{
      
        if(request.assessmenttemplateid != null && request.objectid != undefined){
        return app.models.Assessment.find({
			where :{
				and: [{activeflag:1},{assessmenttemplateid: request.assessmenttemplateid},{intakeserviceid: request.objectid}]
			  }
        }).then(data=>{
            var assessmentid =request.assessmentid;
					if(assessmentid !=  null && assessmentid != undefined ){
						return app.models.Assessment.updateAll({assessmentid: assessmentid},{
							assessmentstatustypekey1: 'Submitted'
						}).then(result =>{
                            return 'Success';
                        })
					}
        })
    }

        return Promise.resolve('Invalid request');
    }


	Assignedassessment.remoteMethod('reassignassessment', {
        http: {
                path: '/reassignassessment',
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
	Assignedassessment.remoteMethod('assessmentcompleted', {
        http: {
                path: '/assessmentcompleted',
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
	Assignedassessment.remoteMethod('assessmentreject', {
        http: {
                path: '/assessmentreject',
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

	Assignedassessment.remoteMethod(
		'getusersbyrole',
		{
		  accepts: [{
			arg: 'filter',
			type: 'object',
			required: true
		  }],
		  http: {
			path: '/getusersbyrole',
			verb: 'get'
		  },
		  returns: {
			type: 'Object',
			root: true
		  }
        });
        Assignedassessment.remoteMethod('assessmentcompletedbycw', {
            http: {
                    path: '/assessmentcompletedbycw',
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
	  Assignedassessment.getusersbyrole = (request) =>{
			const roletypekey = request.where.roletypekey;
	
		const sql = 'Select * from getusersbyrole($1)';
	
		return util.executeSecondaryNodeDBQuery(sql, [roletypekey]).then((data) => {
			return data
		}).catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      }

      Assignedassessment.getassessmentdashboard= async (request, reqctx) =>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
        }  
        var requestuserinfo = {'token': '', 'email': _email};
        var sroletypekey ;
        await util.getuserinfo(requestuserinfo).then (data => {
			sroletypekey = data.roletypekey;
		});        

        const sql = 'Select * from getassessmentdashboard($1,$2,$3,$4,$5)';

        return executeAndFormat(sql, request, _securityusersid, sroletypekey)
            .then(data => data)
            .catch(err => util.logError(err));
      }



      Assignedassessment.remoteMethod('getassessmentdashboard', {
        accepts: [{
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        http: {
            path:'/getassessmentdashboard',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });
      Assignedassessment.remoteMethod('approvedbycw', {
        http: {
                path: '/approvedbycw',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],   
        returns: {
            type : 'string',
            root : true
        }
    });
   
    Assignedassessment.getproviderassessmentdashboard= async (request, reqctx) =>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var _email;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
        }  
        var requestuserinfo = {'token': '', 'email': _email};
        var sroletypekey ;
        await util.getuserinfo(requestuserinfo).then (data => {
			sroletypekey = data.roletypekey;
		});  

        const sql = 'Select * from getproviderassessmentdashboard($1,$2,$3,$4,$5)';

            return executeAndFormat(sql, request, _securityusersid, sroletypekey)
            .then(data => data)
            .catch(err => util.logError(err));
      }

      function executeAndFormat(sql, request, _securityusersid, sroletypekey){
        var Totalcount = 0;
        var status = request.where.status;
        var page = request.page;
        var limit = request.limit;
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);

        return util.executeDBQuery(sql, [securityusersid,status,page,limit,sroletypekey])
          .then(data => {
            if (data.length > 0) {
              Totalcount = data.totalcount;
            }
            var result;
            result = {
              'data': data,
              'count': Totalcount
            };
            return result;
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      }



      Assignedassessment.remoteMethod('getproviderassessmentdashboard', {
        accepts: [{
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        http: {
            path:'/getproviderassessmentdashboard',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });
      Assignedassessment.remoteMethod('assessmentcompletedbyproviderapplicant', {
        http: {
                path: '/assessmentcompletedbyproviderapplicant',
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
    
	Assignedassessment.assessmentcompletedbyproviderapplicant = (request, reqctx) => {
		const _securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;
		const _rsecurityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
		if (util.isNullorEmpty(request.intakenumber)) {
			return app.models.Assignedassessment.find({
				where: {
					and: [{ activeflag: 1 }, { assessmenttemplateid: request.assessmenttemplateid }, { intakenumber: request.intakenumber }]
				}
			}).then(data => {
				if (data.length > 0) {
					var assignedassessmentid = data[0].assignedassessmentid;
					var sql = updateassessmentsql;
					util.executeDBQuery(sql, [assignedassessmentid])
					.then(_data => {
							return app.models.Assignedassessment.create({
								assessmenttemplateid: request.assessmenttemplateid,
								securityusersid: request.securityusersid,
								intakenumber: request.intakenumber,
								status: 'Completed',
								insertedby: _securityusersid,
								updatedby: _securityusersid
							})
								.then(res => {
									updateAssessment(request, {
										assessmentsubmissiontypekey: request.assessmentsubmissiontypekey,
										assessmentstatustypekey1: 'Review',
										updatedby: _rsecurityusersid
									});
									createAssessment(request);
								})
					})
					.catch(err => {
							LOGGER.error(err);
					})
				}
			})
		}
		else {
			return app.models.Assignedassessment.find({
				where: {
					and: [{ activeflag: 1 }, { assessmenttemplateid: request.assessmenttemplateid }, { intakeserviceid: request.objectid }]
				}
			}).then(data => {
				if (data.length > 0) {
					var assignedassessmentid = data[0].assignedassessmentid;
					var sql = updateassessmentsql;
					util.executeDBQuery(sql, [assignedassessmentid])
					.then(_data => {
							return app.models.Assignedassessment.create({
								assessmenttemplateid: request.assessmenttemplateid,
								securityusersid: request.securityusersid,
								intakeserviceid: request.objectid,
								status: 'Completed',
								insertedby: _rsecurityusersid,
								updatedby: _rsecurityusersid
							})
								.then(result => {
									if (request.assessmenttemplateid != null && request.objectid != undefined) {
										return app.models.Assessment.find({
											where: {
												and: [{ activeflag: 1 }, { assessmenttemplateid: request.assessmenttemplateid }, { objectid: request.objectid }]
											}
										}).then(res => {
											updateAssessment(request, {
												assessmentsubmissiontypekey: request.assessmentsubmissiontypekey,
												assessmentstatustypekey1: 'Review'
											});
										}).then(result1 => {
											return result1;
										})
									}
								})
					})
					.catch(err => {
							LOGGER.error(err);
					})
				}
			})
		}
	}

	function createAssessment(request){
		const _securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;
		var submissionid = request.submissionid;
		if(!util.isNullorEmpty(submissionid)) {
			return app.models.Assessment.create({
				assessmenttemplateid: request.assessmenttemplateid,
				securityusersid: request.securityusersid,
				assessmentsubmissiontypekey: request.assessmentsubmissiontypekey,
				objectid: request.objectid,
				insertedby: _securityusersid,
				updatedby: _securityusersid,
				assessmentstatustypekey1: 'Review'
			}).then(resul => {
				return resul;
			})
		}
	}

	function updateAssessment(request, data){
		var submissionid = request.submissionid;
		if (submissionid != null && submissionid != undefined) {
			return app.models.Assessment.updateAll({ submissionid: submissionid }, data)
		}
	}

      Assignedassessment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assignedassessment.observe('access', (ctx, next) => util.access(ctx, next));
	Assignedassessment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
	


};