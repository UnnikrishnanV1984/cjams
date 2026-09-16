'use strict';
const LOGGER = require("log4js").getLogger("progressnote");
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
var email = require('../models/email');
const pdf = require('../models/pdf');
var config = require('../../server/config.json');

const updateeligibilityperiodsql = "update tb_eligibility_period set progressnoteid = $1 where eligibility_period_id = $2";

module.exports = function (Progressnote) {

	Progressnote.list = function (data) {

		var sql = 'select * from getannuallisting($1,$2)'

		return util.executeDBQuery(sql, [data.page,data.limit])
			.then(data1 => {
				return data1[0].getannuallisting[0];
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};


	//if count is zero don't execute the listing else
	//list remote method
	Progressnote.remoteMethod('list', {
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

	Progressnote.getcurrentdaysrecordingdtlsrpt = function (data) {
		var sql = 'select * from getcurrentdaysrecordingdtls()';
		return util.executeDBQuery(sql, [])
			.then(data1 => {
				return data1;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Progressnote.validatecontactnote = function (request) {
		var sql = 'select * from validatecontactnote(date($1),$2,$3)';
		return util.executeDBQuery(sql,[request.contactdate,request.servicecaseid,request.personids])
			.then(data2 => {
				return data2;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Progressnote.remoteMethod('validatecontactnote', {
		accepts: {
		  arg: 'data',
		  type: 'Object',
		  http: {
			source: 'body'
		  }
		},
		http: {
		  path: '/validatecontactnote',
		  verb: 'post'
		},
		returns: {
		  type: 'string',
		  root: true
		}
	  });

	Progressnote.getprogressnote = (request) => {
		return app.models.Progressnotetype.findOne({
			where: { progressnotetypekey: request.progressnotetypekey },
			fields: ['progressnotetypeid']
		}
		).then(data => {
			const res = data.progressnotetypeid;
			request.progressnotetypeid = res;
			return Progressnote.addRecordings(request);
		})
			.catch(err => err)
	}

	Progressnote.getRecordingsive = (request) => {
		const entitytypeid = request.entitytypeid;
		const entitytype = request.entitytype;
		const progressnoteid = request.progressnoteid;
		if(progressnoteid == null || progressnoteid == undefined) {
         const sql = `select progressnoteid,progressnotetypeid,description,entitytype,entitytypeid from progressnote
		 				where entitytypeid = $1 and entitytype = $2 order by updatedon`;
		 return util.executeDBQuery(sql,[entitytypeid, entitytype])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		} else {
			const sql = `select progressnoteid,progressnotetypeid,description,entitytype,entitytypeid from progressnote
							where entitytypeid = $1 and entitytype = $2 and progressnoteid = $3`;
		 return util.executeDBQuery(sql,[entitytypeid, entitytype, progressnoteid])
			.then(data3 => {
				return data3;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		}

	}

	Progressnote.remoteMethod('addRecordingsive', {
		accepts: [{
		  arg: 'data',
		  type: 'Object',
		  http: {
			source: 'body'
		  }
		},{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
		http: {
		  path: '/addrecordingsive',
		  verb: 'post'
		},
		returns: {
		  type: 'string',
		  root: true
		}
	  });

	  Progressnote.addRecordingsive = (request,reqctx) => {
		const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
		const progressnoteid = request.progressnoteid;
		const progressnotetypeid = request.progressnotetypeid;
		const description = request.description;
		const entitytypeid = request.entitytypeid;
		const entitytype = request.entitytype;
		const insertedby = suserid;
		const eligilityperiodid = request.eligilityperiodid;
		const eligibilityprogressnoteid = request.eligibilityprogressnoteid;
		let sqlforprogressnote = `insert into progressnote (progressnotetypeid,description,entitytype,entitytypeid,insertedby,insertedon,updatedby,updatedon) 
													   values($1,$2,$3,$4,$5,now(),$6,now()) returning progressnoteid`;	
		const sqlforeligibilityperiod = updateeligibilityperiodsql;	

		if(progressnoteid == null || progressnoteid == undefined){
			return util.executeDBQuery(sqlforprogressnote,[progressnotetypeid,description,entitytype,entitytypeid,insertedby,insertedby])
			.then(data => {
				return data;
			})
			.then(res =>{
				return util.executeDBQuery(sqlforeligibilityperiod, [res[0].progressnoteid, eligilityperiodid])
					.then(() => 'Sucess');
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});

	} else if (progressnoteid != null && (eligibilityprogressnoteid === null || eligibilityprogressnoteid === undefined)){
		return util.executeDBQuery(sqlforprogressnote,[progressnotetypeid,description,entitytype,entitytypeid,insertedby,insertedby])
		.then(data => {
			LOGGER.info(data);
			return data;
		})
		.then(resp =>{
		 return util.executeDBQuery(sqlforeligibilityperiod, [resp[0].progressnoteid, eligilityperiodid])
				.then(() => 'Sucess');
	 })
	 .catch(err => {
		LOGGER.error('>>>>ERROR:', err);
		throw err;
	});

	} else {
			sqlforprogressnote = "update progressnote set description = $1,updatedby = $2,updatedon = now() where progressnoteid = $3";
			
			return new Promise((resolve, reject) => {
				var narrativeupdate = [updatefostercarenarrative(sqlforprogressnote,[description,insertedby,progressnoteid]) ,
									   updatefostercarenarrative(sqlforeligibilityperiod, [progressnoteid, eligilityperiodid])];
			  
				Promise.all(narrativeupdate).then(function(values) {
					resolve(values);
				}).catch(error => { 
					LOGGER.error(error.message)
					reject(error);
				  });
		
		})
	}
}

	const updatefostercarenarrative = (sql, params) => {
		return util.executeDBQuery(sql, params)
			.then(() => {
				return 'Success';
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	  };


	Progressnote.remoteMethod('getRecordingsive', {
		accepts: {
		  arg: 'data',
		  type: 'Object',
		  http: {
			source: 'body'
		  }
		},
		http: {
			path: '/getrecordingsive',
			verb: 'post'
		  },
		returns: {
		  type: 'string',
		  root: true
		}
	  });

	// savecontactnotes assigns these payload fields straight into length-bounded
	// plpgsql variables (v_locationname is varchar(50), v_contactname varchar(256),
	// and so on), and a plpgsql assignment that is too long raises 22001 rather
	// than truncating. That error is rethrown below, error-logger rewrites it to
	// status 400, and notes.component only shows "Contact notes was not saved
	// successfully. Please try again later." -- so a caseworker whose "Other
	// location name" ran past 50 characters loses the whole note and no retry can
	// ever succeed. None of the fields here carry case documentation (the
	// narrative is `description`, a text column), so clamping the value is
	// strictly better than dropping the note. Deliberately NOT clamped:
	// progressnotereasontypekey/mioptions (comma-joined key lists -- a cut would
	// leave a half key) and the varchar(500) contacttrialvisit narratives, which
	// are bounded in the UI instead so nothing written is silently discarded.
	const SP_TEXT_LIMITS = {
		locationname: 50,
		contactname: 256,
		contactemail: 256,
		contactphone: 32,
		totaltime: 50,
		traveltime: 50
	};

	function clampSpTextFields(payload) {
		Object.keys(SP_TEXT_LIMITS).forEach(field => {
			const value = payload[field];
			const limit = SP_TEXT_LIMITS[field];
			if (typeof value === 'string' && value.length > limit) {
				LOGGER.warn('addRecordings: ' + field + ' is ' + value.length
					+ ' characters, clamping to ' + limit + ' to fit savecontactnotes');
				payload[field] = value.substring(0, limit);
			}
		});
		return payload;
	}

	/*Adding Recording in the Case Worker*/
  Progressnote.addRecordings = (request,reqctx) => {
	const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
	const securityuserid = suserid;
    var temptitle = request.description;

	const contacttrialvisit = request.contacttrialvisit;
	var titleShrink = undefined;
	if(temptitle != '' && temptitle != null){
		titleShrink = temptitle.substring(0, 51);
	}
	// checkModifiedCustomRequest calls request.entitytypeid.substring() three
	// times without a guard, so a payload missing it threw a TypeError that
	// error-logger flattened into the same anonymous 400. A contact note has
	// nothing to attach to without it, so fail with a logged reason instead.
	if (typeof request.entitytypeid !== 'string' || request.entitytypeid.length === 0) {
		LOGGER.error('>>> addRecordings called without a usable entitytypeid: '
			+ JSON.stringify(request.entitytypeid));
		return Promise.resolve({ message: 'entitytypeid is required to save a contact note' });
	}
	request = checkRequest(request);
    
    var modifiedCustomRequest = {
		"progressnotetypeid": request.progressnotetypeid,
		"progressnotesubtypeid": request.progressnotesubtypeid,
		"title": titleShrink,
		"description": util.removeBizarreCharacters(request.description),
		"entitytype": request.entitytype,
		"entitytypeid": request.entitytypeid,
		"pageurl": request.pageurl,
		"savemode": request.savemode,
		"contactdate": request.contactdate,
		"contactname": request.contactname,
		"progressnotetypekey": request.progressnotetypekey,
		"contactphone": request.contactphone,
		"contactemail": request.contactemail,
		"initiationindicator": request.initiationindicator,
		"attemptindicator": request.attemptindicator,
		"insertedby": securityuserid,
		"documentpropertiesid": request.documentpropertiesid,
		"starttime": request.starttime,
		"endtime": request.endtime,
		"totaltime": request.totaltime,
		"stafftypekey": request.stafftype,
		"instantresults": request.instantresults,
		"contactstatus": request.contactstatus,
		"drugscreen": request.drugscreen,
		"progressnotepurposetypekey": request.progressnotepurposetypekey,
		"traveltime": request.traveltime,
		"progressnotereasontypekey": request.progressnotereasontypekey,
		"locationname": request.locationname,
		"isintake" : 'N',
		"otherpersonname":request.others,
		"uploadedfile":request.uploadedfile,
		"focusperson" : [],
		"mioptions":request.mioptions
		}
		modifiedCustomRequest = checkModifiedCustomRequest(modifiedCustomRequest, request)
		// After checkModifiedCustomRequest, since it can overwrite locationname
		// from request.location.
		modifiedCustomRequest = clampSpTextFields(modifiedCustomRequest)

	    const mcRequest = checkModifiedCustomRequestArray(request, modifiedCustomRequest);
		const contactparticipantjson = mcRequest.contactparticipantjson;
		const focuspersonjson = mcRequest.focuspersonjson;
		const progressnoterolejson = mcRequest.progressnoterolejson;
		const progressnotereasonjson = mcRequest.progressnotereasonjson;
		const progressnotereasontypekey = mcRequest.progressnotereasontypekey;
		modifiedCustomRequest.focusperson = {focuspersonjson};

		var sqlquery = 'select * from savecontactnotes($1,$2,$3,$4,$5,$6)';
    if (request.progressnoteid != null && request.progressnoteid != undefined && request.progressnoteid.length != 0) {
		LOGGER.error('>>> REQUEST for EDIT Contact: Contact notes update payload '+JSON.stringify(modifiedCustomRequest));
		modifiedCustomRequest.progressnoteid = request.progressnoteid;
		//	LOGGER.debug("inside if statement")
		return util.executeDBQuery(sqlquery, [JSON.stringify(modifiedCustomRequest), progressnotereasontypekey, JSON.stringify(contactparticipantjson)
			, JSON.stringify(progressnoterolejson) , JSON.stringify(progressnotereasonjson), JSON.stringify(contacttrialvisit)])
		.then(data => {
			LOGGER.error('>>> RESPONSE - for Edit Contact: Contact notes update success '+JSON.stringify(data));
					   let prognoteres = null;
					   prognoteres = cpsresponsetimerupdate(data, request, 'save', suserid);



			   	return prognoteres;
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		})
		}
	else {
		LOGGER.error('>>> REQUEST - for Adding New Contact: Contact notes save update payload '+JSON.stringify(modifiedCustomRequest));
		const contacttrialvisitjson = {};
		return util.executeDBQuery(sqlquery, [JSON.stringify(modifiedCustomRequest), progressnotereasontypekey, JSON.stringify(contactparticipantjson)
			, JSON.stringify(progressnoterolejson) , JSON.stringify(progressnotereasonjson), JSON.stringify(contacttrialvisitjson)])
		.then(data => {
			LOGGER.info('>>> RESPONSE - for New Contact: Contact notes add save success '+JSON.stringify(data));
					   let prognoteres = null;
					   prognoteres = cpsresponsetimerupdate(data, request, 'edit', suserid);

			   	return prognoteres;
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		})
	}
  }

  function cpsresponsetimerupdate(data, request, type, suserid){
	  let prognoteres = null;
	if(data && data.length>0){
		if (request.entitytype && request.entitytype === "intakeservicerequest") {
			var updateResponseTimerSql = "SELECT * FROM cpsresponsetimerupdate($1)";
			util.executeDBQuery(updateResponseTimerSql, [request.entitytypeid])
			.then(data1 => {
				LOGGER.info(data1);
				return data1;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
		}
		if (request.entitytype && request.entitytype === "servicecase") {
			let updateSenUntimelySql = "SELECT * FROM senuntimelyreasoncreteriaupdate($1,$2,$3,$4)";
			util.executeDBQuery(updateSenUntimelySql, [request.entitytypeid,suserid,'contactnote',data[0].progressnoteid])
			.then(data1 => {
				LOGGER.info(data1);
				return data1;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
		}
		prognoteres = data[0];
		createfacetofaceauditlog(prognoteres, request, type, suserid)
		return prognoteres;
	   }
  }

  function createfacetofaceauditlog(prognoteres, request, type, suserid){
	if(type == 'save') {
		// Create Face to Face Audit log
		var sqlstr = "SELECT * FROM createfacetofaceauditlog($1,$2,$3)";
		util.executeDBQuery(sqlstr, [request.progressnoteid, suserid, request.progressnotetypeid])
		.then(data => {
			LOGGER.info('>>> Contact notes update createfacetofaceauditlog success '+JSON.stringify(data));
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		})

		if (request.uploadedfile && request.uploadedfile.length > 0) {
			Progressnote.createAuditlog(request.entitytypeid,request,suserid);
		}
	} else {
		if (prognoteres.progressnoteid) {
			util.auditLogSingleSave(prognoteres.progressnoteid, 'PNOTE', request);
			// Create Face to Face Audit log
			var sqlstr1 = "SELECT * FROM createfacetofaceauditlog($1,$2,$3)";
			util.executeDBQuery(sqlstr1, [prognoteres.progressnoteid, suserid, request.progressnotetypeid])
			.then(data => {
				LOGGER.info(data);
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
			if (request.uploadedfile && request.uploadedfile.length > 0) {
				Progressnote.createAuditlog(request.entitytypeid,request,suserid);
			}
		}
	}
  }

  
  function checkModifiedCustomRequestArray(request, modifiedCustomRequest){
	var contactparticipant = request.contactparticipant;
	var focusperson = request.focusperson;
	var progressnoterole = request.progressnoteroletype;
	var  progressnotereason = request.progressnotereason;

	const contactparticipantjson = [];
	const focuspersonjson = [];
	const progressnoterolejson = [];
	const progressnotereasonjson = [];

	let progressnotereasontypekey = '';
	if (Array.isArray(modifiedCustomRequest.progressnotereasontypekey)) {
		modifiedCustomRequest.progressnotereasontypekey.forEach((progressnote, index) => {
			if(index === 0){
				progressnotereasontypekey =	progressnote;
			}else{
				progressnotereasontypekey = progressnotereasontypekey + ','+progressnote;
			}
		});
	}
	
	if (Array.isArray(contactparticipant)) {
		contactparticipant.forEach(req => {
			contactparticipantjson.push({
					participanttypekey: req.participanttypekey,
					intakeservicerequestactorid: req.intakeservicerequestactorid,
					participantid: req.intakeservicerequestactorid,
					firstname: request.firstname,
					lastname: request.lastname,
					address1: request.address1,
					address2: request.address2,
					city: request.city,
					state: request.state,
					zipcode: request.zipcode,
					email: request.email,
					phonenumber: request.phonenumber
				});
		}
		);
	}

	if (Array.isArray(focusperson)) {
		focusperson.forEach(req => {
			focuspersonjson.push({
					participanttypekey: req.participanttypekey,
					intakeservicerequestactorid: req.intakeservicerequestactorid,
					participantid: req.intakeservicerequestactorid,
					firstname: checkNull(req.firstname),
					lastname: checkNull(req.lastname),
					address1: checkNull(req.address1),
					address2: checkNull(req.address2),
					city: checkNull(req.city),
					state: checkNull(req.state),
					zipcode: checkNull(req.zipcode),
					email: checkNull(req.email),
					phonenumber: checkNull(req.phonenumber)
				});
		}
		);
	}

	if (Array.isArray(progressnoterole)) {
		progressnoterole.forEach(req => {
			progressnoterolejson.push({
					contactroletypekey: req.contactroletypekey
				})
			}
		);
	}

	if (Array.isArray(progressnotereason)) {
		progressnotereason.forEach(progressnotereason1 => {
			progressnotereasonjson.push({
					personid: progressnotereason1.personid,
					name: progressnotereason1.name,
					primaryphoneno: progressnotereason1.primaryphoneno,
					email: progressnotereason1.email,
					relationship: progressnotereason1.relationship
				})
		});
	}
	  return {
		  contactparticipantjson,
		  focuspersonjson,
		  progressnoterolejson,
		  progressnotereasonjson,
		  progressnotereasontypekey
	  }
  }

  function checkNull(value){
	  return value ? value : null;
  }

  function checkModifiedCustomRequest(modifiedCustomRequest, request){
	if(request.location != null && request.location != undefined){
		modifiedCustomRequest.locationname = request.location
	}
	if(request.date != null && request.date != undefined){
		modifiedCustomRequest.starttime = request.date
	}

	if(request.entitytype && request.entitytype === "intakeservicerequest") {
		modifiedCustomRequest.intakeserviceid = isNaN(request.entitytypeid.substring(1,request.entitytypeid.length)) ? request.entitytypeid :null;
	} else {
		modifiedCustomRequest.servicecaseid = isNaN(request.entitytypeid.substring(1,request.entitytypeid.length)) ? request.entitytypeid :null;
	}
		
	if(isNaN(request.entitytypeid.substring(1,request.entitytypeid.length))){
		modifiedCustomRequest.isintake='N';
	} else {
		modifiedCustomRequest.isintake='Y';
	}

	if (Array.isArray(modifiedCustomRequest.mioptions)) {
        modifiedCustomRequest.mioptions = modifiedCustomRequest.mioptions.join(',');
    }
	return modifiedCustomRequest;
  }

  function checkRequest(request){
	if (request.stafftype == null || request.stafftype == undefined) {request.stafftype = null;}
    if (request.instantresults == null || request.instantresults == undefined) {request.instantresults = null;}
    if (request.contactstatus == null || request.contactstatus == undefined) {request.contactstatus = null;}
    if (request.drugscreen == null || request.drugscreen == undefined) {request.drugscreen = null;}
    if (request.progressnotepurposetypekey == null || request.progressnotepurposetypekey == undefined) {request.progressnotepurposetypekey = null;}
	if(request.progressnoteid) {
			util.auditLogSingleSave(request.progressnoteid,'PNOTE',request);
	}
	return request;
  }

  Progressnote.createAuditlog = function (entitytypeid,request,suserid){
		app.models.Auditlog.create({
			logtypekey:'WL018',
			intakeserviceid:null,
			servicerequestnumber:null, 
			referenceid:null, 
			description:'Addendum added to Contact', 
			isnew :false,
			isedit:true,
			isdelete:true,
            insertedby: (request && request.securityusersid? request.securityusersid: suserid),
            updatedby: (request && request.securityusersid? request.securityusersid: suserid), 
			insertedon:new Date(),
			updatedon:new Date(),
			metadata:null,
			ipaddress:null,
			old_id:null,
			modifieddata:null,
			objectid:entitytypeid,
			objecttype: 'ServiceRequest'
		}).catch(err => LOGGER.error(err));
  }  

  Progressnote.remoteMethod('addRecordings', {
    accepts: [{
      arg: 'data',
      type: 'Object',
      http: {
        source: 'body'
      }
    },{
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
	/*Updating Recording in the Case Worker*/
	Progressnote.updateRecordings = (id, data,reqctx) => {
		let suserid = undefined;
        if(reqctx?.req?.headers?.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
	const securityuserid = data.securityuserid ? data.securityuserid : suserid;
    var progressNoteId = id;
    const prs = [];
	data.insertedby = securityuserid;
	var notedetailsrequest = {
		"progressnoteid": progressNoteId,
		"description": data.description,
		"activeflag": 1,
		"updatedby" : securityuserid
	}
    /* 0 - draft save
       1 - Actual save */
    if (data.savemode == 1) {
		return server.models.Progressnotedetail.create(notedetailsrequest)			
        .then(prognotedtlres => prognotedtlres)
        .catch(err => LOGGER.error(err))
    } else {
      var titleShrink = data.description.substring(0, 51);
      return Progressnote.updateAll({progressnoteid:progressNoteId},
        {
          progressnotetypeid: data.progressnotetypeid,
          progressnotesubtypeid: data.progressnotesubtypeid,
          title: titleShrink,
          description: data.description,
          entitytype: data.entitytype,
          entitytypeid: data.entitytypeid,
          pageurl: data.pageurl,
          savemode: data.savemode,
          contactdate: data.contactdate,
          contactname: data.contactname,
          progressnotetypekey: data.progressnotetypekey,
          contactphone: data.contactphone,
		  contactemail: data.contactemail,
		  initiationindicator: data.initiationindicator,
          attemptindicator: data.attemptindicator,
          documentpropertiesid: data.documentpropertiesid,
          starttime: data.starttime,
          endtime: data.endtime,
          stafftypekey: data.stafftype,
          instantresults: data.instantresults,
          contactstatus: data.contactstatus,
          drugscreen: data.drugscreen,
          progressnotepurposetypekey: data.progressnotepurposetypekey,
          traveltime: data.traveltime,
          totaltime: data.totaltime,
          locationname: data.locationname,
          progressnotereasontypekey: data.progressnotereasontypekey,
          updatedby: securityuserid
        }).then(prognoteres => {

          var sql = "SELECT * FROM updateprogressnote($1, $2)";

          return util.executeDBQuery(sql,[progressNoteId, data.insertedby])
          .then(() => {
          if (data.contacttrialvisit) {
            data.contacttrialvisit.progressnoteid =progressNoteId;
            app.models.Contacttrialvisit.updateAll({progressnoteid:progressNoteId},
              {
                issuedesc: data.contacttrialvisit.issuedesc,
                safetydesc: data.contacttrialvisit.safetydesc,
                services_childdesc: data.contacttrialvisit.services_childdesc,
                services_parentdesc: data.contacttrialvisit.services_parentdesc,
                permanencystepdesc: data.contacttrialvisit.permanencystepdesc,
                placementdesc: data.contacttrialvisit.placementdesc,
                educationdesc: data.contacttrialvisit.educationdesc,
                healthdesc: data.contacttrialvisit.healthdesc,
                socialareadesc: data.contacttrialvisit.socialareadesc,
                financialliteracydesc: data.contacttrialvisit.financialliteracydesc,
                familyplanningdesc: data.contacttrialvisit.familyplanningdesc,
                skillissuedesc: data.contacttrialvisit.skillissuedesc,
                transitionplandesc: data.contacttrialvisit.transitionplandesc,
				updatedby: securityuserid
              })
          }


         	return server.models.Progressnotedetail.create(notedetailsrequest)
			});
			})
			.then(prognoterecord => {

				if (Array.isArray(data.contactparticipant)) {
					data.contactparticipant.forEach(req => {
						prs.push(
							app.models.Contactparticipant.create({
								progressnoteid: progressNoteId,
								participanttypekey: req.participanttypekey,
								intakeservicerequestactorid: req.intakeservicerequestactorid,
								participantid: req.intakeservicerequestactorid,
								firstname: req.firstname,
								lastname: req.lastname,
								address1: req.address1,
								address2: req.address2,
								city: req.city,
								state: req.state,
								zipcode: req.zipcode,
								email: req.email,
								phonenumber: req.phonenumber,
								insertedby: securityuserid,
								updatedby: securityuserid
							})
						)
					}
					);

				}
				return Promise.all(prs);
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})
    }

	}
	Progressnote.remoteMethod('updateRecordings', {
		http: {
			path: '/updateRecordings/:id',
			verb: 'patch'
		},
		accepts: [
			{
				arg: 'id',
				type: 'data',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'body' }
			},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  }],
		returns: {
			type: 'object',
			root: true
		}
	});
	// getalldarecordings takes (searchjson json, isexpungementsuperuser integer
	// DEFAULT 0, isexpunged integer DEFAULT 0), and both flags used to be
	// interpolated into quoted SQL literals. The web sends isExpungementSuperUser
	// as parseInt(storage.getItem('IS_EXPUNGED_USER')), which is NaN whenever that
	// session key is absent, and JSON.stringify writes NaN as null -- so the query
	// text became getalldarecordings('{...}', 'null', '0') and Postgres raised
	// 22P02 invalid input syntax for type integer: "null" before reading a row.
	// error-logger rewrites every error to statusCode 400, which is why this
	// arrives as a bare "HttpError 400, No stack trace". Fall back to the
	// procedure's own default of 0 instead of trusting the flag.
	function expungementFlag(value) {
		const flag = parseInt(value, 10);
		return Number.isInteger(flag) ? flag : 0;
	}

	Progressnote.getalldarecording = (id, data) => {
		// `data` is optional and strong-remoting resolves a bare '?data' (no JSON
		// appended) to undefined, so the property reads below threw a TypeError
		// that error-logger flattened into the same undiagnosable 400. The
		// original !data.where guard sat after its first use, and replacing
		// data.where there also left newJsonStructure pointing at undefined.
		if (!data) {
			data = {};
		}
		if (!data.where) {
			data.where = {};
		}

		var newJsonStructure = data.where;
		newJsonStructure["pagenumber"] = data.page;
		// After prod move We will fix the frame work now hard coded to 50
		newJsonStructure["pagesize"] = 10;
		newJsonStructure["servicerequestid"] = id;

		// newJsonStructure is data.where, so one assignment covers both.
		if(!data.where.sortBy && !data.where.sortDir) {
			data.where.sortDir ='desc';
		} else if(!data.where.sortDir) {
			data.where.sortDir ='asc';
		}
		newJsonStructure["nolimit"] = false;

		// Bind all three arguments rather than interpolating them: the search json
		// carries free-text filters, so a single apostrophe closed the literal
		// early and raised 42601 (notes.component.ts strips quotes out of the note
		// filter by hand for exactly this reason), and the same hole let arbitrary
		// SQL through.
		var sql = 'select * from getalldarecordings($1, $2, $3)';

		return util.executeSecondaryNodeDBQuery(sql, [
				JSON.stringify(newJsonStructure),
				expungementFlag(data.where.isExpungementSuperUser),
				expungementFlag(data.where.iscaseexpunged)
			])
			.then(data1 => {
				return {
					'data': data1,
					'count': data1.totalcount
				};
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}
	Progressnote.remoteMethod('getalldarecording',
		{
			http: {
				path: '/getalldarecording/:id',
				verb: 'get'
			},
			accepts: [{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'query' }
			}],
			returns: {
				type: 'object',
				root: true
			}
		}
	);


	
	Progressnote.getcontactslogreport = (request,res) =>{
		return Promise.resolve(pdf.getcontactslogreport(request));
	}

	Progressnote.remoteMethod('getcontactslogreport', {
		http: {
			path: '/getcontactslogreport',
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
	});


	/*Edit View Listing */

	Progressnote.getdarecordingdetails = (id, data) => {

		var record = {};
		return Progressnote.find({
			where: { progressnoteid: id },
			include: [
				{
					relation: 'progressnotetype',
					scope: {
						fields: ['progressnotetypeid', 'progressnotetypekey', 'description']
					}
				},
				{
					relation: 'progressnotesubtype',
					scope: {
						fields: ['progressnotesubtypeid', 'description']
					}
				},
				{
					relation: 'progressnoteactor',
					scope: {
						fields: ['intakeservicerequestactorid'],
						include: {
							relation: 'intakeservicerequestactor',
							scope: {
								fields: ['intakeservicerequestpersontypekey', 'actorid'],
								include: {
									relation: 'actor',
									scope: {
										fields: ['actortype'],
										include: {
											relation: 'Actortype',
											scope: {
												fields: ['typedescription']
											}
										}
									}
								}
							}
						}
					}
				},
				{
					relation: 'progressnotepurposetype',
					scope: {
						fields: ['progressnotepurposetypeid', 'progressnotepurposetypekey', 'description']
					}
				},
				{
					relation: 'documentproperties',
					scope: {
						fields: ['title', 'description', 'filename', 'mime', 's3bucketpathname']
					}
				},
				{
					relation: 'progressnoteroletype',
					scope: {
						fields: ['contactroletypekey']
					}
				},
				{
					relation: 'progressnotedetail',
					scope: {
						include: [{
							relation: 'userprofile',
							scope: { fields: ['securityusersid', 'firstname', 'lastname', 'displayname'] }
						}]
					}
				},
				{
					relation: 'contactparticipant',
					scope: {
						fields: ['participanttypekey','intakeservicerequestactorid','firstname','lastname','address1','address2','city','state','zipcode','email','phonenumber', 'participantid']
					}
				}
			]
		}).then(data3 => {
			record.data = data3;
			return app.models.Progressnotetype.find({
				where: { progressnotetypeid: data3[0].progressnotesubtypeid },

				fields: ['progressnotetypeid', 'progressnotetypekey', 'description']

			})
		})
			.then(result => {
				if (result.length > 0) {
					record.data[0].subtype = result[0];
				}
			}).then(final => {
				var contactroletypekey = record.data[0].contactroletypekey

				return app.models.Contactroletype.find({
					where: { contactroletypekey: contactroletypekey },
					fields: ['contactroletypekey', 'typedescription']
				})
			}).then(finalresult => {
				if (finalresult.length > 0) {
					record.data[0].contactrole = finalresult[0];
				}

				return record

			})
			.catch(err => LOGGER.error(err));
	}
	Progressnote.remoteMethod('getdarecordingdetails',
		{
			http: {
				path: '/getdarecordingdetails/:id',
				verb: 'get'
			},
			accepts: [{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			},
			{
				arg: 'data',
				type: 'object',
				http: { source: 'query' }
			}],
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Progressnote.remoteMethod('getallcontactnoteslist', {
		accepts : {
				arg : 'data',
				type : 'object',
				required : true,
				http : { source: 'query' }
			},
		http: {
			'verb': 'get', 
			'path': '/getallcontactnoteslist'
			},
		returns : {
			type : 'object',
			root : true
			}
	});

	Progressnote.getallcontactnoteslist = function(data) {
		var Totalcount = 0;
		var showCount = false;
		var newJsonStructure = {}
		newJsonStructure = data;
		if(data.page === 1){
			showCount = true;
		}/* else{showCount = false}; */				//SonarQube fix - commented as showCount is already set to false above

		var sql1 = 'select * from getallcontactnoteslist($1)';
		return util.executeDBQuery(sql1, [JSON.stringify(newJsonStructure)])
			.then(data4 => {
				if (data4.length > 0) { Totalcount = data4[0].totalcount; }
				var result = JSON.parse(JSON.stringify(data4));
				result.forEach(x => {
					delete x.totalcount;
				});
				if (showCount) {
					result = {
						'data': result,
						'count': Totalcount
					};
				}
				else {
					result = {
						'data': result
					};
				}
				return result;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Progressnote.remoteMethod('addupdatecontactnotes', {
		http: {
			path: '/addupdatecontactnotes',
			verb: 'post'
		},
		accepts: [{
			arg: 'data', type: 'object',
			http: { source: 'body' }
		}, {
			arg: 'reqctx',
			type: 'object',
			http: { source: 'context' }
		}],
		returns: {
			type: 'string',
			root: true
		}
	});
	
    Progressnote.addupdatecontactnotes = function(request,reqctx)
    { var sql;
		let suserid = undefined;
        if(reqctx?.req?.headers?.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		const securityusersid = request.securityusersid ? request.securityusersid : suserid;
		request.description = util.removeBizarreCharacters(request.description);
        if(request.progressnoteid == null || request.progressnoteid == undefined) {
					request.insertedby = securityusersid;
					request.updatedby = securityusersid;
					request.stafftypekey = request.stafftype;
					request.entitytype = 'intakeservicerequest';
					request.contactroletypekey = null;
					return Progressnote.create(request).then(res => {
						request.progressnoteroletype.map(roletypesres=>{
							app.models.Progressnoteroletype.create({
								progressnoteid:res.progressnoteid,
								contactroletypekey: roletypesres.contactroletypekey,
								insertedby: request.insertedby,
								updatedby: request.updatedby});
						});
						return res;
					});
        } else {

            sql ="update progressnote set activeflag = 0 WHERE progressnoteid =$1";
            return util.executeDBQuery(sql,[request.progressnoteid])
            .then(() => {
                sql ="update progressnoteroletype set activeflag = 0 WHERE progressnoteid =$1";
                return util.executeDBQuery(sql,[request.progressnoteid]);
            })
            .then(() => {
                request.insertedby = securityusersid;
                request.updatedby = securityusersid;
                request.stafftypekey = request.stafftype;
                request.entitytype = 'intakeservicerequest';
                request.contactroletypekey = null;
                delete request.progressnoteid;
                return Progressnote.create(request).then(res => {
                    request.progressnoteroletype.map(roletypesres=>{
                        app.models.Progressnoteroletype.create({
                        progressnoteid:res.progressnoteid,
                        contactroletypekey: roletypesres.contactroletypekey,
                        updatedby: request.updatedby,
                        insertedby: request.insertedby
                    });
                    });
                    return res;
                });
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        }
		};

		Progressnote.sendEmailContact = function(request,reqctx)
    { let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
			var subject='Contact Note '+request.caseNumber;	
			var htmlheader = '<html><head><style> .table-bordered { border: 1px solid #D8D8D8; border-left-width: 0; border-right-width: 0; } </style></head><body>'
			var htmlfooter = '</body></html>'
			var body=htmlheader+request.body.replace('style="display: none "','')+htmlfooter;
			
			//  Insert into Audit table while send mail			
				return app.models.Auditlog.create({
					logtypekey:'WL016',
					intakeserviceid:null,
					servicerequestnumber:null, 
					referenceid:null, 
					description:'Contact Summary Report Generated', 
					isnew :false,
					isedit:true,
					isdelete:true,
					insertedby:(request && request.securityusersid? request.securityusersid: suserid),
					updatedby:(request && request.securityusersid? request.securityusersid: suserid),
					insertedon:new Date(),
					updatedon:new Date(),
					metadata:null,
					ipaddress:null,
					old_id:null,
					modifieddata:null,
					objectid: request.objectid,
					objecttype: request.objecttype
				}).then(data =>{
					return Promise.resolve(email.SendEmail(request.email,subject,body ));
				})

    };
		
		Progressnote.remoteMethod('sendEmailContact', {
			http: {
							path: '/sendemailcontact',
							verb: 'post'
			},
			accepts : [ {arg : 'data',type : 'object',
					http : {source : 'body'}},{
						arg: 'reqctx',
						type: 'object',
						http: {source: 'context'}
					  } ],
			returns: {
					type : 'string',
					root : true
			}
    });
	
	// Get Caseworker list
	Progressnote.getCaseWorkerList = function (data) {

		
		var sql = 'select * from getcaseworkerlistbycaseid($1)'

		return util.executeSecondaryNodeDBQuery(sql, [data.where.entitytypeid])
			.then(data5 => {
				return data5;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Progressnote.remoteMethod('getCaseWorkerList', {
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
			type: 'Object',
			root: true
		}
	});

	Progressnote.auditcontactnotes= (request,reqctx)=>{
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		const securityuserid = (request.securityuserid ? request.securityuserid : suserid);
        const logtype = request.logtype;
        const referenceid = request.referenceid;
		const userid = request.securityusersid ? request.securityusersid : securityuserid;
        const objecttype = request.objectype;
		const objectid = request.objectid;
		const desc = null;
    	var sql = "select * from createpageauditlog($1,$2,$3,$4,$5,$6)";
		return util.executeDBQuery(sql,[userid,logtype, referenceid, objecttype, objectid, desc])
			.then(_data => {
				return _data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};


	Progressnote.remoteMethod('auditcontactnotes', {
		http: {
						path: '/auditcontactnotes',
						verb: 'post'
		},
		accepts : [ {arg : 'data',type : 'object',
				http : {source : 'body'}}

				,{
							arg: 'reqctx',
							type: 'object',
							http: {source: 'context'}
						  }  ],
		returns: {
				type : 'string',
				root : true
		}
    });

	Progressnote.updateQualityCare=(request)=>{
		var sql = "update progressnote set " +
		" qualityofcaretochildtext = $1, " +
		" screeningfortheservicetext=$2, "+
		" adjustmentfostercaretext=$3, " +
		" ischildgotoshool = $4 "+
		" where progressnoteid = $5 ";
        var param = [];
		if(request){
			param.push( request.qualityofcaretochildtext? request.qualityofcaretochildtext:'');
            param.push( request.screeningfortheservicetext? request.screeningfortheservicetext:'');
			param.push( request.adjustmentfostercaretext? request.adjustmentfostercaretext:'');
			param.push( request.ischildgotoshool? request.ischildgotoshool:false);
			if(request.progressnoteid){
				param.push( request.progressnoteid);
			}
		}
       
        return util.executeDBQuery(sql, param)
            .then(data => {
                return {
                    'data' : data,
                };
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });

	};
	
	Progressnote.remoteMethod('updateQualityCare', {
		http: {
						path: '/updateQualityCare',
						verb: 'post'
		},
		accepts : [ {arg : 'data',type : 'object',
				http : {source : 'body'}} ],
		returns: {
				type : 'string',
				root : true
		}
    });

	Progressnote.kinshipcontactnote = (request) => {
		const params = {
			intakeserviceid: request.where.intakeserviceid,
			personid: request.where.personid
		}
		const dataQuery = 'SELECT * FROM findkinshipNavigationServicesContactNote($1)';

		return util.executeDBQuery(dataQuery,[JSON.stringify(params)])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}
	

	Progressnote.remoteMethod('kinshipcontactnote', {
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
			type: 'Object',
			root: true
		}
	});	
	Progressnote.getcaseclosurerecordings = (request) => {
		// Extract the parameter safely
		const entityTypeId = request?.where?.v_entitytypeid || null;

		// FIX: Use Parameterized Query with $1 for PostgreSQL
		const sql = 'SELECT * FROM getcaseclosurerecordings($1)';
		const params = [entityTypeId];

		return util.executeSecondaryNodeDBQuery(sql, params)
			.then(data => {
				return data[0]?.getcaseclosurerecordings;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}

	Progressnote.remoteMethod('getcaseclosurerecordings', {
        accepts : {
            arg : 'filter',
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

	Progressnote.getholidays = async function (request) {
		const sql = 'SELECT * FROM cjams.getholidays()';
		return util.executeSecondaryNodeDBQuery(sql, [])
			.then(data => {
				return data;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Progressnote.remoteMethod('getholidays', {
        http: {
			path: '/getholidays',
			verb: 'get'
		},
        returns : {
            type : 'array',
            root : true
        }
    });

	Progressnote.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Progressnote.observe('access', (ctx, next) => util.access(ctx, next));
	Progressnote.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};
