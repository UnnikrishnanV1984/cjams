'use strict';
const LOGGER = require("log4js").getLogger("providerapplicant");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
let config = require('../../server/config.json');
let email = require('../models/email');


module.exports = function (Providerapplicant) {

	Providerapplicant.getproviderapplicant = function (request) {
		var getprovapp = 'select * from getapplicantprograminfo($1)';
		var appid = request.where.applicant_id;
		LOGGER.debug(request.where);
		LOGGER.debug(appid);
		return util.executeDBQuery(getprovapp, [appid])
			.then(data => {
				return { data: data[0].getapplicantprograminfo };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.remoteMethod(
		'getproviderapplicant', {
			http: {
				path: '/getproviderapplicant',
				verb: 'post'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.updateproviderapplnarrative = function (request) {
		var updprovnarr = 'update tb_provider_applicant set narrative = $1 where applicant_id = $2';
		var appid = request.where.provider_applicant_id;
		var narr = request.where.narrative;
		LOGGER.debug(request.where);
		LOGGER.debug(narr, appid);
		return util.executeDBQuery(updprovnarr, [narr, appid])
			.then(data => {
				return { data: data };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.remoteMethod(
		'updateproviderapplnarrative', {
			http: {
				path: '/updateproviderapplnarrative',
				verb: 'PUT'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);
	Providerapplicant.schdapplicantappointment = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var schdappoint = 'select * from schdproviderapppointment($1)';
		return util.executeDBQuery(schdappoint, [request])
			.then(data => {
				LOGGER.debug(data);
				LOGGER.debug(data[0]);
				email.SendProvrefEmail(data[0].schdproviderapppointment, 'Agency provider appointment schedule', "Appointment is scheduled for DATE :" + request.appointment_date + "");
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
	};

	Providerapplicant.remoteMethod(
		'schdapplicantappointment', {
			http: {
				path: '/schdapplicantappointment',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);
	Providerapplicant.getapplappiontment = function (request) {
		var appid = request.applicant_id;
		var getappappoint = 'select * from tb_provider_applicant_appointment where provider_applicant_id =$1 order by create_ts desc';
		return util.executeDBQuery(getappappoint, [appid])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.remoteMethod(
		'getapplappiontment', {
			http: {
				path: '/getapplappiontment',
				verb: 'post'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.getapplicantstaff = function (request) {
		var appid = request.applicant_id;
		var getappstaff = 'select * from tb_provider_applicant_staff where provider_applicant_id =$1';
		return util.executeDBQuery(getappstaff, [appid])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.remoteMethod(
		'getapplicantstaff', {
			http: {
				path: '/getapplicantstaff',
				verb: 'post'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.getapplassigned = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		var eventcode = request.where.appeventcode;
		var userid = (request && request.securityuserid?request.securityuserid: suserid);
		var getappassigned = 'select tpa.prgram, tpa.program_type, tpa.program_name, tpa.contact_email, r.objectid, r.insertedon from routing r join tb_provider_applicant tpa on r.objectid = tpa.applicant_id where r.tosecurityusersid = $1 and r.eventcode = $2';
		return util.executeDBQuery(getappassigned, [userid, eventcode])
			.then(data => {
				return { data: data };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.remoteMethod(
		'getapplassigned', {
			http: {
				path: '/getapplassigned',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			}
			,{
						arg: 'reqctx',
						type: 'object',
						http: {source: 'context'}
					  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.getchecklist = function (request) {
		var applid = request.applicant_id;
		var category = request.category;
		var monitoring_period = request.monitoring_period;
		var monitoring_type = request.monitoring_type;
		var monitoring_year = request.monitoring_year;
		let getclist = 'select * From tb_provider_applicant_checklist where provider_applicant_id = $1 and category = $2';
		let param = [applid, category];
		if(request.from){
			getclist = 'select * From tb_provider_applicant_checklist where provider_applicant_id = $1 and category = $2 and monitoring_type = $3 and monitoring_year = $4 and monitoring_period = $5';			
			param = [applid, category,monitoring_type,monitoring_year,monitoring_period]
		}
		return util.executeDBQuery(getclist, param)
			.then(data => {
				return { data: data };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.gettasklist = function (request) {
		LOGGER.debug(request);
		LOGGER.debug(request.where);
		const tasklist = 'select * from tb_activitytasklist where programname=$1 and agency=$2 and category=$3';
		return util.executeDBQuery(tasklist, [request.where.programname, request.where.agency, request.where.category])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};



	Providerapplicant.remoteMethod(
		'gettasklist', {
			accepts: {
				arg: 'request',
				type: 'object',
				http: {
					source: 'body'
				},
			},
			http: {
				verb: 'post'
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.remoteMethod(
		'getchecklist', {
			http: {
				path: '/getchecklist',
				verb: 'post'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.updatechecklist = function (request,reqctx) {
		const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
		const activitytask = request.task;
		const currentDate = new Date().toLocaleString();
		if (activitytask[0].checklist_id !== null && activitytask[0].checklist_id !== undefined) {
			var prs = [];
			if (Array.isArray(activitytask)) {
				let response = [];
				activitytask.forEach(element => {
					var taskdetails = element;
					if (taskdetails.checklist_id !== null && taskdetails.checklist_id !== undefined) {

						app.models.Updatechecklisttask.updateAll({
							checklist_id: taskdetails.checklist_id
						}, {
							checklist_task: taskdetails.checklist_task,
							commnts: taskdetails.commnts,
							status: taskdetails.status,
							completeddate: taskdetails.completeddate,
							updatedby: suserid,
							updatedon: currentDate
						}).then(function (rest) {
							prs.push(rest);
						});
					}
				})
				return Promise.all(prs).then(function (values) {
					values.map(x => {
						response.push(x);
					});
					LOGGER.info(response);
					return "Success";

				});
			}
		}
		return Promise.resolve('Invalid request');
	};

	Providerapplicant.remoteMethod(
		'updatechecklist', {
			http: {
				path: '/updatechecklist',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			}
			,{
						arg: 'reqctx',
						type: 'object',
						http: {source: 'context'}
					  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);


	Providerapplicant.submitdecision = function (request,reqctx) {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
		var d = new Date();
		const rejMessage = "Dear Applicant, \n\nThe State of Maryland hereby denies your request to become a provider.\n\nBest regards,\nState of Maryland %s";
		const approveMessage = "Dear Applicant, \n\nThank you for contacting us regarding your agencies interest in Maryland's foster care services.\n\nI have compiled the information you have provided and listed it below.\nPlease confirm this information is correct by following the next steps to begin the application process.\n\nAgency Name:    MD Foster Care\nContact:     referralName\nEmail:   %s'\nphone:     xxx\nReferral Type:     xxxx\nReferral Contact:      xxxxx\n\nTo begin the application you will need to log into the portal with the following username and password.You will be promted to the change your password as soon as you log into the portal for security measures.\n\nUsername:xxxxx\nPassword:xxxx\nSTART APPLICATION\n\n\nBest regards,\nState of Maryland";
		var appid = request.where.objectid;
		var appstatus = request.where.status;
		var userid = request.where.tosecurityusersid;
		var providerId;
		request.where.fromsecurityuserid =  suserid;
		request.securityuserid = suserid;
		// To fix
		userid = request.securityuserid;
		const licensePrefix = request.where.fromroleid === "Provider_DJS_SecretaryDesignee" ? "DJS" :"DHS"
		
		request.applicant_id = appid;
		var response;
		var licenseNO;
		LOGGER.debug("final approval", request.where.isfinalapproval)
		var subdecision = 'select * from submitproviderdecision($1)';
		return util.executeDBQuery(subdecision, [request.where])
		.then(data => {
			return data;
		})
		.then(data1 => {
			if (request.where.isfinalapproval) {
				LOGGER.debug("In final approval", request.where.isfinalapproval)
				var updateprovapp = "UPDATE tb_provider_applicant SET  application_status= $1 WHERE applicant_id=$2";
				var getprovapp = 'SELECT application_status, mailing_address, prgram,program_type,program_name,contact_first_nm,contact_last_nm from tb_provider_applicant where applicant_id=$1'
				var getworkeremail = 'select email from userprofile up where up.securityusersid = $1';
				return util.executeDBQuery(updateprovapp, [appstatus, appid])
				.then(data2 => {
					LOGGER.info(data2);
					return data2;
				})
				.then(data3 => {
					response = JSON.parse(JSON.stringify(data3));
					if (appstatus == "Approved") {
						var sql = "select * from getNextNumber('providerid')";
						return util.executeDBQuery(sql,[])
						.then(data4 => {
							return data4;
						})
						.then(data5 => {
							LOGGER.debug(data5, "data of next number");
							providerId = d.getFullYear()+("000" + d.getDay()).slice(-3)+ + ("00000" + data5[0].getnextnumber).slice(-5);
							request.provider_id = providerId;
							LOGGER.debug(request, "request data");
							LOGGER.debug("provider_id", providerId);
							return util.executeDBQuery(getprovapp, [appid])
							.then(data6 => {
								LOGGER.info(data6);
								return data6;
							})
							.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
							})
						}).then(data7 => {
							request.provider_nm = data7.contact_first_nm + data7.contact_last_nm;
							var addprov = 'select * from addprovider($1);'
							return util.executeDBQuery(addprov, [JSON.stringify(request)])
							.then(data8 => {
								return data8;
							})
							.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
							})
						 }).then(data9 => {
							var sql1 = "select * from getNextNumber('providerlicense')";
							return util.executeDBQuery(sql1,[])
							.then(data10 => {
								return data10;
							})
							.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
							})
						 }).then(data11 => {
							LOGGER.debug(data11, "data of next number");
							licenseNO = licensePrefix + d.getFullYear() + ("00" + data11[0].getnextnumber);
						request.license_no = !request.where.licenseNO ? licenseNO : request.where.licenseNO;
						var addprovlicense = 'select * from addprovlicensinginfo($1)';
							return util.executeDBQuery(addprovlicense, [JSON.stringify(request)])
							.then(data12 => {
								return data12;
							})
							.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
							})
						 }).then(data13 => {
							return util.executeDBQuery(getworkeremail, [userid])
							.then(data14 => {
								return data14;
							})
							.then(response1 => {
								email.SendProvrefEmail(response1[0].email, 'Agency Referral Request', approveMessage);
							})
							.catch(err => {
								LOGGER.error('>>>>ERROR:', err);
								throw err;
							})
						})
						.catch(err => {
							LOGGER.error('>>>>ERROR:', err);
							throw err;
						})

					} else if (appstatus == "Rejected") {
						email.SendProvrefEmail(response[0].email, 'Provider Referral status Notification', rejMessage);
					}
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

	};

	Providerapplicant.remoteMethod(
		'submitdecision', {
			http: {
				path: '/submitdecision',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);
	Providerapplicant.assignapplication = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		var fuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var touserid = request.where.tosecurityusersid;
		var toroleid = request.where.toroleid;
		var appid = request.where.objectid;
		var assignapp = 'Update tb_provider_applicant_tier_decision SET tosecurityusersid =$1, toroleid =$2 where fromsecurityusersid = $3 and objectid = $4';
		return util.executeDBQuery(assignapp, [touserid, toroleid, fuserid, appid])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Providerapplicant.remoteMethod(
		'assignapplication', {
			http: {
				path: '/assignapplication',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			}
			,{
						arg: 'reqctx',
						type: 'object',
						http: {source: 'context'}
					  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);
	Providerapplicant.updateapplicantlicenseinfo = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var updatelicensing = 'select * from updateapplicantlicenseinfo($1)';
		return util.executeDBQuery(updatelicensing, [JSON.stringify(request)])
			.then(data => {
				return { data: data };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Providerapplicant.remoteMethod(
		'updateapplicantlicenseinfo', {
			http: {
				path: '/updateapplicantlicenseinfo',
				verb: 'put'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.getapplicationdecisions = function (request) {
		var applid = request.where.objectid;
		var eventcode = request.where.eventcode;
		var gettierdecision = 'Select * from getapplicationdecisions($1,$2)';
		return util.executeDBQuery(gettierdecision, [eventcode, applid])
			.then(data => {
				return { data: data };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Providerapplicant.remoteMethod(
		'getapplicationdecisions', {
			http: {
				path: '/getapplicationdecisions',
				verb: 'post'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);


	Providerapplicant.gettierdecisions = function (request) {
		var applid = request.where.objectid;
		var eventcode = request.where.eventcode;
		var gettierdecision = 'Select * from getprovapplicanttierdecisions($1,$2)';
		return util.executeDBQuery(gettierdecision, [eventcode, applid])
			.then(data => {
				return { data: data };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Providerapplicant.remoteMethod(
		'gettierdecisions', {
			http: {
				path: '/gettierdecisions',
				verb: 'post'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Providerapplicant.getapplsassgndlist = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
		var userid = (request && request.securityuserid?request.securityuserid: suserid);
		var eventcode = request.where.eventcode;
		var gettierdecision = 'Select up.fullname, patd.fromroleid, patd.objectid, patd.decisiondate, patd.assigneddate, patd.isreviewrequest, patd.remarks, patd.status ,patd.insertedon from tb_provider_assignment_ownership patd join userprofile up on up.securityusersid = patd.fromsecurityusersid  where patd.eventcode = $1 and  patd.tosecurityusersid = $2';
		return util.executeDBQuery(gettierdecision, [eventcode, userid])
			.then(data => {
				return { data: data };
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Providerapplicant.remoteMethod(
		'getapplsassgndlist', {
			http: {
				path: '/getapplsassgndlist',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);
	Providerapplicant.insertcommunicationinfo = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var schdappoint = 'select * from insertprovapplcommunication($1)';
		return util.executeDBQuery(schdappoint, [request])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.remoteMethod(
		'insertcommunicationinfo', {
			http: {
				path: '/insertcommunicationinfo',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
			returns: {
				type: 'object',
				root: true
			}
		}
	);
	Providerapplicant.getcommunicationinfo = function (request) {
		var appid = request.applicant_id;
		var getappcomm = 'select * from tb_provider_applicant_communication where provider_applicant_id =$1 order by create_ts desc';
		return util.executeDBQuery(getappcomm, [appid])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Providerapplicant.remoteMethod(
		'getcommunicationinfo', {
			http: {
				path: '/getcommunicationinfo',
				verb: 'post'
			},
			accepts: {
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},
			returns: {
				type: 'object',
				root: true
			}
		}
	);
	Providerapplicant.addchecklist = function (request,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		request.securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
		var schdappoint = 'select * from insertchecklistvalues($1)';
		return util.executeDBQuery(schdappoint, [request])
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};


	Providerapplicant.remoteMethod(
		'addchecklist', {
			http: {
				path: '/addchecklist',
				verb: 'post'
			},
			accepts: [{
				arg: 'data',
				type: 'object',
				http: {
					source: 'body'
				}
			},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ]
	,
			returns: {
				type: 'object',
				root: true
			}
		}
	);

		

	Providerapplicant.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerapplicant.observe('access', (ctx, next) => util.access(ctx, next));
	Providerapplicant.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
