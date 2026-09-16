'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestReferral");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Intakeservicerequestreferral) {
		
	var totalCount;
	var ipaddress; // for audit log;
	Intakeservicerequestreferral.list = function(request) {
		if (request.page !== undefined) {
			request.skip = (request.page - 1) * request.limit;

		}

		return Intakeservicerequestreferral.find(request)
		.then(res => res)
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});

	};

	Intakeservicerequestreferral.getReferralTypeSubType = referredto => {
		return app.models.Refferedtotype.findById(referredto, {
			fields: ['referredtotypekey', 'intakeservreqtypeid', 'servicerequestsubtypeid'],
		})
		.then(resp => { return JSON.parse(JSON.stringify(resp));})
		.catch(err => util.logError(err));
	};

	Intakeservicerequestreferral.getStatusDisposition = () => {
		return app.models.Intakeserreqstatustype.find({
			where: {intakeserreqstatustypekey: 'New'},
			fields: ['intakeserreqstatustypeid'],
			include: {
				relation: 'servicerequesttypeconfigdispositioncode',
				scope: {
					where: {dispositioncode: 'Approved'},
					fields: ['intakeserreqstatustypeid', 'servicerequesttypeconfigiddispostionid']
				}
			}
		})
		.then(resp => {
			const data = JSON.parse(JSON.stringify(resp));
			if(data.length > 0)
				{return data[0];}
		})
		.catch(err => util.logError(err));
		
	};

	const setupNewReferralIntakeObj = (request, _securityusersid) => {
		let gIntakeNum = '';
		const gIntakeserviceId = request.intakeserviceid;
		let gFocusPerson = {};
		let gIntakeservreqtypeid = '';
		let gServicerequestsubtypeid = '';
		let gStatusId = '';
		let gDispositionId = '';

		return app.models.Intakeservicerequest.getIntakeNum(gIntakeserviceId)
		.then(intakeNum => {
			gIntakeNum = intakeNum;
			const prs = [];
			prs.push(app.models.Intakeservicerequestactor.getFocusPerson(gIntakeserviceId));
			prs.push(Intakeservicerequestreferral.getReferralTypeSubType(request.referredto));
			prs.push(Intakeservicerequestreferral.getStatusDisposition());			 //SonarQube fix - removed this unused assignent
			prs.push(app.models.Userprofile.find({
				where: {securityusersid: _securityusersid},
				fields: ['securityusersid', 'displayname']
			}));

			prs.push(app.models.Intakeservicerequestinputtype.find({
				where: {intakeservreqinputtypekey: 'Other'},
				fields: ['intakeservreqinputtypeid']
			}));

			var sql = "select * from getnextdanumber('servicerequestauthorizationnumber')";
			prs.push(util.executeDBQuery(sql, []));
			prs.push(app.models.Intakeservicerequestinputsource.find({
				where: {intakeservreqinputsourcekey: 'Other Services'},
				fields: ['intakeservreqinputsourceid']
			}));

			return Promise.all(prs);
		
		})
		.then(resp => {
			const data = JSON.parse(JSON.stringify(resp));
			gFocusPerson = data[0];
			let personaddressid = '';
			let address = '';
			let address2 = '';
			let city = '';
			let state = '';
			let zipcode = '';
			let county = '';
			let dangeraddress = '';
			let dangerreason = '';
			if(gFocusPerson.personaddress.length> 0){
				let personaddress =  gFocusPerson.personaddress[0];
				personaddressid = personaddress.personaddressid;
				address = personaddress.address;
				address2 = personaddress.address2;
				city = personaddress.city;
				state = personaddress.state;
				zipcode = personaddress.zipcode;
				county = personaddress.county;
				dangeraddress = personaddress.danger ? 'Yes' : 'No';
				dangerreason = personaddress.dangerreason;
			}

			const referralTypeSubType = data[1];
			gIntakeservreqtypeid = referralTypeSubType.intakeservreqtypeid;
			gServicerequestsubtypeid = referralTypeSubType.servicerequestsubtypeid;

			const details = getDetails(data);
			
			gStatusId = details.gStatusId;
			gDispositionId = details.gDispositionId;
			const displayName = details.displayName;
			const intakeSource = details.intakeSource;
			const newIntakeNum = details.newIntakeNum;
			const inputSource = details.inputSource;

			const newReferralIntakeObj = {};
			newReferralIntakeObj.General = {
				Time: new Date(),
				IntakeNumber: newIntakeNum,
				Source: intakeSource,
				InputSource:inputSource,
				RecivedDate: new Date(),
				CreatedDate: new Date(),
				Author: displayName,
				Narrative: request.referralnote
			};
			newReferralIntakeObj.Person = [{
				"Firstname": gFocusPerson.firstname,
				"Pid": gFocusPerson.personid,
				"Role": gFocusPerson.actortype,
				"Lastname": gFocusPerson.lastname,
				"Middlename": gFocusPerson.middlename,
				"Race": [gFocusPerson.racetypekey],
				"PrimaryPhoneNumber": "",
				"AddressId": personaddressid,
				"Address": address,
				"Address2": address2,
				"City": city,
				"State": state,
				"Zip": zipcode,
				"County": county,
				"Dangerous": gFocusPerson.dangerlevel === 1 ? 'Yes': 'No',
				"DangerousWorkerReason": "D _ Person",
				"DangerousAddress": dangeraddress,
				"DangerousAddressReason": dangerreason,
				"RoutingAddress": "1"

			}];
			newReferralIntakeObj.DAType = {
				DATypeDetail: [{
					DaTypeKey: gIntakeservreqtypeid,
					DasubtypeKey: gServicerequestsubtypeid,
					personid: '',
					DAStatus: gStatusId,
					DADisposition: [gDispositionId],
					CancelReason: [null],
					CancelDescription: [null],
					Summary: [''],
					ServiceRequestNumber: newIntakeNum
			}]};
			newReferralIntakeObj.CrossReferences = [{
				"CrossRefDA": gIntakeNum,
				"ReasonsofCrossref": "Referral",
				"Assighnedto": displayName,
				//"DAType": "CAN",
				//"DASubType": "Class II",
				"CrossRefwith": newIntakeNum,
				"CrossRefDAID": request.intakeserviceid
			}];
			newReferralIntakeObj.Allegations = [];

			return newReferralIntakeObj;
		})
		.catch(err => util.logError(err));
	};

	function getDetails(data){
		let gStatusId = '';
		let gDispositionId = '';
		const statusDisposition = data[2];
			if(statusDisposition) {
				gStatusId = statusDisposition.intakeserreqstatustypeid;

				if(statusDisposition.servicerequesttypeconfigdispositioncode && statusDisposition.servicerequesttypeconfigdispositioncode.length > 0)
					{gDispositionId = statusDisposition.servicerequesttypeconfigdispositioncode[0].servicerequesttypeconfigiddispostionid;}
			}

			const userProfile = data[3];
			let displayName = '';

			if(userProfile.length > 0)
				{displayName = userProfile[0].displayname;}

			const intakeSourceData = data[4];
			let intakeSource = '';
			if(intakeSourceData.length > 0)
				{intakeSource = intakeSourceData[0].intakeservreqinputtypeid;}

			const newIntakeNumObj = data[5];
			let newIntakeNum = '';
			if(newIntakeNumObj.length > 0)
				{newIntakeNum = newIntakeNumObj[0].getnextdanumber;}

			const inputSourceData = data[6];
			let inputSource ='';
			if(inputSourceData.length > 0){
				inputSource = inputSourceData[0].intakeservreqinputsourceid;
			}
			return {
				gStatusId: gStatusId,
				gDispositionId: gDispositionId,
				displayName: displayName,
				intakeSource: intakeSource,
				newIntakeNum: newIntakeNum,
				inputSource: inputSource
			}
	}

	Intakeservicerequestreferral.add = (request, reqctx) => {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		let gIntakeObj = {};
		return setupNewReferralIntakeObj(request, _securityusersid)
		.then(newReferralIntakeObj => {
			newReferralIntakeObj.securityuserid = request.securityuserid;
			return app.models.Intakedastaging.completeIntakeInternal(newReferralIntakeObj, _securityusersid);
		})
		.then(data => {
			gIntakeObj = data;
			return app.models.Intakeservicerequest.routedaInternal({where: {servicerequestnumber: data.responseservicereqnum}});
			
			
		})
		.then(data => {
			request.danumber = gIntakeObj.responseservicereqnum;
			request.assignedto = data.caseworker_name;
			return Intakeservicerequestreferral.create(request);
		})
		.then(data => data)
		.catch(err => util.logError(err));
	};

	Intakeservicerequestreferral.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],   
        returns: {
            type : 'object',
            root : true
        }
    });
	
	
	
	Intakeservicerequestreferral.beforeRemote('list', function(ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== undefined && JSON.parse(ctx.req.query.filter).page === 1) {

			 if (JSON.parse(ctx.req.query.filter).where !== undefined && JSON.parse(ctx.req.query.filter).where.intakeserviceid !== undefined 
			 	&& JSON.parse(ctx.req.query.filter).where.activeflag !== undefined) {

				    LOGGER.debug(":: Inside :: ");
				    Intakeservicerequestreferral.count( {and:[{intakeserviceid:JSON.parse(ctx.req.query.filter).where.intakeserviceid},
															  {activeflag:JSON.parse(ctx.req.query.filter).where.activeflag}]}, function(err, count) {

				     if (err) {
				      throw err;
				     }
				     totalCount = count;
				     LOGGER.debug(count);
				    });

				   }else {

					   Intakeservicerequestreferral.count({}, function(err, count) {

				     if (err) {
				      throw err;
				     }
				     totalCount = count;

				    });
				    
				   } 

		}

		next();
	});

	Intakeservicerequestreferral.afterRemote('list', function(ctx, resultset, next) {

		if (ctx.result) {
			ctx.result = {
				'data' : resultset,
				'count' : totalCount
			};
		}
		next();
	});

	Intakeservicerequestreferral.remoteMethod('list', {
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

   //Added for auditlog
	Intakeservicerequestreferral.observe('after save', function (ctx, next) {
		var description,intakeserviceid,referenceid,_ipaddress,Servicerequestnumber,isnew,isdelete,isedit;
		var logJson ={
			"data": {
				"reason": "",
				"disposition": "",
				"status": "",
				"assignedto": "",
				"referralnote": "",
				"referraldate": "",
				"createdby": "",
				"createadon": ""
			}
		}
		var logtypekey = "RF";

		if (ctx.isNewInstance){
			  isnew = true;
			intakeserviceid = ctx.instance.intakeserviceid;
			referenceid = ctx.instance.referralid;
			description =  "Referral added with reason: "+ ctx.instance.reason + " and disposition: "+ctx.instance.disposition+" for DA#";
			logJson.data.reason =   ctx.instance.reason;
			logJson.data.status =   ctx.instance.status;
			logJson.data.disposition =  ctx.instance.disposition;
			logJson.data.referralnote =ctx.instance.referralnote;
			logJson.data.createdby = app.currentUser.email;
			logJson.data.createadon = ctx.instance.insertedon;
			logJson.data.assignedto= ctx.instance.assignedto;
			logJson.data.referraldate = ctx.instance.effectivedate;
		}
		var newadd = {
            "description":description,
            "logtypekey":logtypekey ,
            "intakeserviceid": intakeserviceid,
            "referenceid": referenceid,
			"servicerequestnumber":Servicerequestnumber,
			"ipadress":_ipaddress,
			"metadata":logJson,
            "isnew":isnew,
            "isedit":isedit,
            "isdelete":isdelete
        }
        // Auditlog Recording Added here 
        app.models.Auditlog.createlogdetails(newadd);
        next();

	})
	    // for audit log ipaddress 
	Intakeservicerequestreferral.beforeRemote('Add', function(ctx, data, next) {
		if (ctx.req) {
			 ipaddress = ctx.req.connection.remoteAddress; 
		}
		LOGGER.info(ipaddress);
		next();
	});
	Intakeservicerequestreferral.getreferalassessmentlist=(request)=>{
		const sql = "select * from getreferalassessmentlist($1);";
		return util.executeDBQuery(sql, [request.where.intakeserviceid])
		.catch(err => util.logError(err));
	}

	Intakeservicerequestreferral.remoteMethod('getreferalassessmentlist', {
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


	Intakeservicerequestreferral.getsupervisorsbycounty=(request)=>{
		const sql = "select * from getsupervisorsbycounty($1,$2);";
		return util.executeDBQuery(sql, [request.where.countyid, null])
		.catch(err1 => util.logError(err1));
	}
	Intakeservicerequestreferral.remoteMethod('getsupervisorsbycounty', {
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

	Intakeservicerequestreferral.remoteMethod('countybasednewcase', {
		http: {
						path: '/countybasednewcase',
						verb: 'post'
		},
		accepts : [ {arg : 'data',type : 'object',
				http : {source : 'body'}}, {
					arg: 'reqctx',
					type: 'object',
					http: {source: 'context'}
				  } ],   
		returns: {
				type : 'object',
				root : true
		}
});

Intakeservicerequestreferral.countybasednewcase = (data, reqctx)=>{
	const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid; 
	const prs = [];																	//SonarQube fix - removed this unused assignent
	var newcaseno;
	var newintakeno;
	var respintakeservicereqid;
	var asignsecurityuserid=data.intake.asignsecurityuserid ;


data.intake.securityuserid = _securityusersid;
prs.push(new Promise((resolve, reject) => {
	var requestData='IntakeNumber'
	app.models.Nextnumber.getNextNumber(requestData, (err1, result1)=>{
		err1 ? reject(err1) : resolve(result1);
	}); 
	
}));

prs.push(new Promise((resolve, reject) => {
	var requestData='servicerequestauthorizationnumber'
	app.models.Nextnumber.getNextNumber(requestData, (err2, result2)=>{
		err2 ? reject(err2) : resolve(result2);
	}); 
	
}));
return Promise.all(prs)
.then(respdata => {
	newintakeno= respdata[0]
	newcaseno= respdata[1]

	data.intake.General.IntakeNumber = newintakeno;
	data.intake.createdCases.caseID = newcaseno;
	data.intake.intakeDATypeDetails[0].ServiceRequestNumber = newcaseno;
	data.intake.disposition[0].ServiceRequestNumber = newcaseno;
	data.intake.DAType.DATypeDetail[0].ServiceRequestNumber = newcaseno;

	var tempReqStructure = JSON.stringify(data.intake);
	var finalReqStructure = tempReqStructure.replace(/'/g, "''");
	
	var sql = 'SELECT * FROM approveintake($1,$2)'; 
	return util.executeDBQuery(sql, [finalReqStructure, JSON.stringify(data.review)])
    .then(res => {
        LOGGER.info(res);
		return res;
    })
    .catch(err => {
        LOGGER.error(err)
    })		   
} ) .then(resp =>{
	respintakeservicereqid=resp[0].responseintakeserviceid;
	return  app.models.Intakeservicerequestcrossreference.create(
		{
			withintakeservicerequestid:resp[0].responseintakeserviceid, 
			fromintakeservicerequestid:data.intake.intakeserviceid,  
			intakeservicerequestcrossreferencereasontypekey:"CountyNewCase"

		}
	)

}).then(resp =>{

	return  app.models.Intakeservicerequestcrossreference.create(
		{
			fromintakeservicerequestid:respintakeservicereqid, 
			withintakeservicerequestid:data.intake.intakeserviceid,  
			intakeservicerequestcrossreferencereasontypekey:"CountyNewCase"

		}
	)
}).then(resp =>{

	var attachements=data.intake.attachement;
	if(Array.isArray(attachement)){
		attachements.forEach(attachement =>{
			attachement.objectid=respintakeservicereqid; 				//Sonarqube fix - changed comma to ';'
			attachement.servicerequestid=respintakeservicereqid;
		});
	}

	if (data.intake.attachement != null && data.intake.attachement !== undefined && data.intake.attachement !== "")
	 {

			return app.models.Documentproperties.addcaseworkerattachment(attachement, null, reqctx);
	}

})
.then(respdata => {

	var sql = 'SELECT * FROM addcountybasedassessment($1,$2,$3)';
	return util.executeDBQuery(sql, [ JSON.stringify(data.intake),respintakeservicereqid,asignsecurityuserid])
    .then(res => {
        LOGGER.info(res);
		return res;
    })
    .catch(err => {
        LOGGER.error(err)
    }) 		   
} )
.then( resp =>{
		return newcaseno;
	})	
	.catch(err => util.logError(err));

}



	Intakeservicerequestreferral.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeservicerequestreferral.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeservicerequestreferral.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
