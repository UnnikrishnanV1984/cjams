'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestdispositioncode");
var app = require('../../server/server');
var uuid = require('node-uuid');
const util = require('../utils/utils');
const pdf = require('../models/pdf');

module.exports = function(Intakeservicerequestdispositioncode) {
   var totalCount;
   var _ipaddress;
	 var _logstatus,_logdisp,_dateseen,_summary,_location; /* Added for audit log */
   
	Intakeservicerequestdispositioncode.Add = function (request, reqctx) {
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
		LOGGER.debug(request);
		var userid = _securityusersid;
		var dispstatus = '';
		const msg = getAuditMsg(request);
		_location = msg._location;
		_summary = msg._summary;
		const notiMsg = msg.notiMsg;

		if (util.isNullorEmpty(request.disposition)) {
			_dateseen = request.disposition.dateseen;
			/* disposition description taken for log  */
			app.models.Servicerequesttypeconfigdispositioncode.findOne(
				{
					where: { servicerequesttypeconfigiddispostionid: request.disposition.dispostionid },
					fields: ['description']
				}).then(data => {
					LOGGER.debug(data.description + "data")
					_logdisp = data.description;
				})
				.catch(err => err);


			var serviceid = request.disposition.intakeserviceid;
			var statustypeid = request.disposition.intakeserreqstatustypeid;
			return app.models.Intakeserreqstatustype.find({
				where: {
					intakeserreqstatustypeid: statustypeid
				}
			}).then(result => {
				if (result.length > 0) {
					dispstatus = result[0].intakeserreqstatustypekey;
					_logstatus = result[0].description;//Added for audit log
				}

				request.disposition.activeflag = true;
				request.disposition.intakeservicerequestdispositioncodeid = uuid();
				request.disposition.insertedby = userid;
				request.disposition.updatedby = userid;
				request.disposition.servicerequesttypeconfigiddispostionid = request.disposition.dispostionid;
				return Intakeservicerequestdispositioncode.create(request.disposition)
					.then(res => {
						var intakeservicerequestdispositioncodeid =	res?.intakeservicerequestdispositioncodeid || null;
						const sqlquery = `update routing set activeflag=0 where objectid in
						(select IntakeServiceRequestDispositionCodeid :: character varying from  IntakeServiceRequestDispositionCode
						where IntakeServiceId= $1)`;

						return util.executeDBQuery(sqlquery,[serviceid])
						.then(data => {
							if ( dispstatus.toLowerCase() == "closed" || dispstatus.toLowerCase() == "completed" ) {

								var comments = '';
								var status = 15;
								request.bmanualrouting = true;
								var isservicecase = 0;

								var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';

								return util.executeDBQuery(sql,[intakeservicerequestdispositioncodeid,userid,'INDR',status,comments,request.disposition.supervisorid,true,false,false,notiMsg,'',serviceid,'',isservicecase])
									.then(_data => {
										const caseid = serviceid;
										var nofiticationJson = {};
										nofiticationJson.securityusersid = _securityusersid;
										nofiticationJson.usernotificationtypekey = "System";
										nofiticationJson.objectid = caseid;
										nofiticationJson.subject = 'Diposition status changed to "' + dispstatus + '"';
										nofiticationJson.priorityleveltypekey = "Normal";
										nofiticationJson.body = 'Diposition status changed to "' + dispstatus + '"';
										app.models.Usernotification.Add(nofiticationJson, reqctx);
										return { data: { res, status: 200, message: "Successfully added" } };
									});
							}
							return data;
						});
					});
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		}
       return Promise.resolve({ data: { status: 400, message: 'Invalid request' } });
   };

   function getAuditMsg(request){
	//Added for audit log
	if (util.isNullorEmpty(request.investigation)) {
		_summary = request.investigation.summary;
		_location = request.investigation.filelocdesc;
	}

	return {
		notiMsg: request.disposition.notifymsg?request.disposition.notifymsg:'Submitted for Disposition Review ',
		_summary,
		_location
	}
   }

    Intakeservicerequestdispositioncode.GetHistory = async function(data){

		var pageno =(data.page - 1) * data.limit

		var sql = 'select * from getdispositionhistory($1,$2,$3)';
		LOGGER.debug(sql);

		try {
			const _data = await util.executeDBQuery(sql, [data.where.servicerequestid,pageno,data.limit]);
			if (_data.length > 0) {
				totalCount = _data[0].totalcount;
			}
			return _data;
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}
	};
	Intakeservicerequestdispositioncode.afterRemote('GetHistory', function(ctx, data, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : data,
				'count' : totalCount
			};
		}
		next();
    });
    Intakeservicerequestdispositioncode.GetDispositon = async function(data){

		var sql = 'select * from getdisposition($1)';
		LOGGER.debug(sql);

		try {
			const data1 = await util.executeDBQuery(sql, [data.where.servicerequestid]);
			return data1[0];
		} catch (err) {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		}
	};

	Intakeservicerequestdispositioncode.remoteMethod('Add', {
		accepts : [{
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'body'
			},
			required : true
		}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
		http : {
			verb : 'post'
		},
		returns : {
			type : 'string',
			root : true
		}
    });
    Intakeservicerequestdispositioncode.remoteMethod('GetHistory', {
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
			type : 'object',
			root : true
		}
    });
    Intakeservicerequestdispositioncode.remoteMethod('GetDispositon', {
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
			type : 'object',
			root : true
		}
	});


	Intakeservicerequestdispositioncode.remoteMethod('getdispositionstatus', {
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
			type : 'object',
			root : true
		}
	});

	Intakeservicerequestdispositioncode.getdispositionstatus = (request) =>{
		/* DAtypeid and subtypeid hardcoded temporarily (for ui implementation )
			datype: childprotectectionservice
			subtype: class1
		*/
		var subtypeid ='00000000-0000-0000-0000-000000000000';
		if (request.where.intakeservreqtypeid!= request.where.servicerequestsubtypeid)
		{
			subtypeid =request.where.servicerequestsubtypeid;
		}
		return app.models.Servicerequesttypeconfig.findOne({
			fields:['servicerequesttypeconfigid'],
			where:{
				intakeservreqtypeid:request.where.intakeservreqtypeid,
				//servicerequestsubtypeid:request.where.servicerequestsubtypeid
				//intakeservreqtypeid:"247a8b26-cdee-4ce8-b36e-b37e49fd0103",
				servicerequestsubtypeid:subtypeid
			}
		}).then(data =>{
			 var res = data.servicerequesttypeconfigid;

			 return app.models.Intakeserreqstatustype.find({
				fields:['intakeserreqstatustypekey','description','intakeserreqstatustypeid'],
				include:{
					relation:'servicerequesttypeconfigdispositioncode',
					where:{
                        servicerequesttypeconfigid:res
					},
					scope:{
						where:{
					 	servicerequesttypeconfigid:res,
						},
						fields:[ 'servicerequesttypeconfigdispositionid','servicerequesttypeconfigid','dispositioncode','description','intakeserreqstatustypeid']
					}
				 }
				 })

		}).then(data =>{
		   return data;
		}).catch(err => err)
  }
	// Added for AuditLog
	Intakeservicerequestdispositioncode.observe('after save', function (ctx, next) {
		var logJson ={
			"data": {
				"intialseen": "",
				"status": "",
				"disposition": "",
				"summary": "",
				"filelocation": "",
				"createdby": "",
				"createadon": ""
			}
		}
		var description,intakeserviceid,referenceid,Servicerequestnumber,isnew,isdelete,isedit;
		var logtypekey = "DP";

		if (ctx.isNewInstance){
			 isnew = true;
			description = "Dispostion updated with status: "+ _logstatus+ " and  type: "+ _logdisp +" for DA#";
			intakeserviceid = ctx.instance.intakeserviceid;
			referenceid  = ctx.instance.intakeservicerequestdispositioncodeid;
			logJson.data.intialseen= _dateseen;
			logJson.data.status = _logstatus;
			logJson.data.disposition  = _logdisp;
			logJson.data.summary= _summary;
			logJson.data.filelocation= _location;
			logJson.data.createdby=app.currentUser.email;
			logJson.data.createadon=ctx.instance.insertedon;
		}
		var newadd = {
			"description":description,
			"logtypekey":logtypekey ,
			"intakeserviceid": intakeserviceid,
			"referenceid": referenceid,
			"servicerequestnumber":Servicerequestnumber,
			"metadata":logJson,
			"ipaddress":_ipaddress,
			"isnew":isnew,
			"isedit":isedit,
			"isdelete":isdelete
		}
		// Auditlog Recording Added here
		app.models.Auditlog.createlogdetails(newadd);
		next();

})

Intakeservicerequestdispositioncode.beforeRemote('Add', function(ctx, data, next) {
	if (ctx.req) {
		_ipaddress = ctx.req.connection.remoteAddress;
	}
	next();
});



Intakeservicerequestdispositioncode.remoteMethod('getReportCPSIntake', {

	http: {
		path: '/getreportcpsintake',
		verb: 'post'
	},
	accepts: [{
			arg: 'data',
			type: 'Object',
			http: {
				source: 'body'
			}
		},
		{
			arg: 'res',
			type: 'object',
			'http': {
				source: 'res'
			}
		}

	],
	returns: {
		arg: 'data',
		type: 'Object'
	}
})

Intakeservicerequestdispositioncode.getReportCPSIntake = (request,res) =>{
	return Promise.resolve(pdf.cpsIntakeReportPDF(request));
}




Intakeservicerequestdispositioncode.remoteMethod('getstatuslist', {
  accepts : [{
    arg : 'filter',
    type : 'Object',
    http : {
      source : 'query'
    },
    required : true
  },
  {arg: 'reqctx', type: 'object',
			http: {source: 'context'}}],
  http : {
    verb : 'get'
  },
  returns : {
    type : 'object',
    root : true
  }
});

Intakeservicerequestdispositioncode.getstatuslist = async (request, reqctx) =>{
	var _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
		}  
    var requestuserinfo = {'token': '', 'email': _email};
	var sroletypekey ;
	await util.getuserinfo(requestuserinfo).then (data => {
	  sroletypekey = data.roletypekey;
	});  
        const auditLogQuery = "select * from listdastatusbydatypesubtype($1, $2, $3);";
	return util.executeSecondaryNodeDBQuery(auditLogQuery, [request.where.intakeservreqtypeid, request.where.servicerequestsubtypeid, sroletypekey])
    .then(data => { return data; })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
};


Intakeservicerequestdispositioncode.remoteMethod('taskvalidationdisposition', {
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
  Intakeservicerequestdispositioncode.taskvalidationdisposition = async (request) =>{
	const intakeserviceid = request.where.intakeserviceid;

	const sql = 'Select * from getintaketaskismandarycount($1)';

	try {
		const data = await util.executeDBQuery(sql, [intakeserviceid]);
		return data[0];
	} catch (err) {
		LOGGER.error('>>>>ERROR:', err);
		throw err;
	}
	}
	

	Intakeservicerequestdispositioncode.remoteMethod('taskcloseddisposition', {
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


		Intakeservicerequestdispositioncode.taskcloseddisposition = async (request) =>{
			const intakeserviceid = request.where.intakeserviceid;

			const sql = 'Select * from getintaketaskclosed($1)';

			try {
				return await util.executeDBQuery(sql, [intakeserviceid]);
			} catch (err) {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			}
			}
			
			Intakeservicerequestdispositioncode.remoteMethod('getclosecasestatusdisposition', {
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
				  type : 'object',
				  root : true
				}
			  });
			  
			  Intakeservicerequestdispositioncode.getclosecasestatusdisposition = async (request) =>{
				  const sql = "select * from getclosecasestatusdisposition($1, $2);";
				  try {
					  return await util.executeDBQuery(sql, [request.where.intakeservreqtypeid, request.where.servicerequestsubtypeid]);
				  } catch (err) {
					  LOGGER.error('>>>>ERROR:', err);
					  throw err;
				  }
			  };


	Intakeservicerequestdispositioncode.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeservicerequestdispositioncode.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeservicerequestdispositioncode.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};