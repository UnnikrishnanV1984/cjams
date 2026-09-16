'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const LOGGER = require("log4js").getLogger("cinapetition");

module.exports = function (Cinapetition) {

	Cinapetition.remoteMethod('addcinapetition', {
		http: {
			path: '/addcinapetition',
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
			type: 'string',
			root: true
		}
	});

	Cinapetition.addcinapetition = function (request, reqctx) {
		const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
		const securityusersid = _securityusersid;
		const insertedon = new Date().toLocaleString();
		request.insertedby = securityusersid;
		request.insertedon = insertedon;
		if (request.cinapetitionid === null || request.cinapetitionid === undefined) {
			request.activeflag = 1;
            request.supervisorname = securityusersid;
            return Cinapetition.create(request).then(data => {
				const petitionwitness = request.petitionwitness;
				const cinasibling = request.cinasibling;
				const cinasubpoenad = request.cinasubpoenad;

				createPetitionwitness(petitionwitness, insertedon);
				createCinasibling(cinasibling, insertedon, data.cinapetitionid, data.intakeservicerequestpetitionid);
				createCinasubpoenad(cinasubpoenad, insertedon, securityusersid, data.cinapetitionid, data.intakeservicerequestpetitionid)
			return data;

			}).catch(err => util.logError(err));

		} else {

			return Cinapetition.updateAll({
				cinapetitionid: request.cinapetitionid
			}, {
				intakeservicerequestpetitionid: request.intakeservicerequestpetitionid,

				updatedon: request.updatedon,
				activeflag: request.activeflag,
				isnew: request.isnew,
				isemergency: request.isemergency,
				policecomplaintnumber: request.policecomplaintnumber,
				color: request.color,
				legalservicefilenumber: request.legalservicefilenumber,
				childname: request.childname,
				isfosterhome: request.isfosterhome,
				isgrouphome: request.isgrouphome,
				fosterhomename: request.fosterhomename,
				grouphomename: request.grouphomename,
				kinhomename: request.kinhomename,
				kinaddress: request.kinaddress,
				kinrelation: request.kinrelation,
				personwithlegalcustody: request.personwithlegalcustody,
				personphysicalcustody: request.personphysicalcustody,
				legalcustodianrelationship: request.legalcustodianrelationship,
				parent1name: request.parent1name,
				parent1address: request.parent1address,
				isparent1notifiedbyacdss: request.isparent1notifiedbyacdss,
				isparent1notified: request.isparent1notified,
				reasonforparent1notnotified: request.reasonforparent1notnotified,
				parent2name: request.parent2name,
				parent2address: request.parent2address,
				isparent2notifiedbyacdss: request.isparent2notifiedbyacdss,
				isparent2notified: request.isparent2notified,
				reasonforparent2notnotified: request.reasonforparent2notnotified,
				caseworker: request.caseworker,
				supervisorname: request.supervisorname,
				updatedby: request.updatedby ? request.updatedby: _securityusersid,
				daterequestcompleted: request.daterequestcompleted,
				childinsheltercareon: request.childinsheltercareon,
				dateofemergencysheltercare: request.dateofemergencysheltercare,
				ispreviousjuvenilecourt: request.ispreviousjuvenilecourt,
				ischildorsibling: request.ischildorsibling,
				physicalabusenature: request.physicalabusenature,
				physicalabusemedicalexam: request.physicalabusemedicalexam,
				physicalabusedocumentation: request.physicalabusedocumentation,
				physicalabusefailedtoprotect: request.physicalabusefailedtoprotect,
				physicalabusedisclosedto: request.physicalabusedisclosedto,
				sexualabusenature: request.sexualabusenature,
				sexualabusemedicalexam: request.sexualabusemedicalexam,
				sexualabusedocumentation: request.sexualabusedocumentation,
				sexualabusefailedtoprotect: request.sexualabusefailedtoprotect,
				sexualabusedisclosedto: request.sexualabusedisclosedto,
				neglectabusenature: request.neglectabusenature,
				neglectabusemedicalexam: request.neglectabusemedicalexam,
				neglectabusedocumentation: request.neglectabusedocumentation,
				neglectabusefailedtoprotect: request.neglectabusefailedtoprotect,
				neglectabusedisclosedto: request.neglectabusedisclosedto,
				within12months: request.within12months,
				severechronicdisability: request.severechronicdisability,
				mentalhealthdisorder: request.mentalhealthdisorder,
				physicalissues: request.physicalissues,
				bornsubstanceexposed: request.bornsubstanceexposed,
				currentlocation: request.currentlocation,
				cinachildmedical: request.cinachildmedical,
				psychological: request.psychological,
				disability: request.disability,
				childrelationshipwithparents: request.childrelationshipwithparents,
				legalstatus: request.legalstatus,
				homeconditiondescription: request.homeconditiondescription,
				inadequatehousing: request.inadequatehousing,
				isparentcannotidentified: request.isparentcannotidentified,
				parentcannotidentified: request.parentcannotidentified,
				isparentlocationunknown: request.isparentlocationunknown,
				parentlocationunknown: request.parentlocationunknown,
				isdepartmentattempttolocateparents: request.isdepartmentattempttolocateparents,
				departmentattempttolocateparents: request.departmentattempttolocateparents,
				isparentphysicalmentalissues: request.isparentphysicalmentalissues,
				parentphysicalmentalissues: request.parentphysicalmentalissues,
				isparentincarcerated: request.isparentincarcerated,
				parentincarcerated: request.parentincarcerated,
				isparenteconomicstatus: request.isparenteconomicstatus,
				parenteconomicstatus: request.parenteconomicstatus,
				isparentnotcareforchild: request.isparentnotcareforchild,
				parentnotcareforchild: request.parentnotcareforchild,
				isparentsubstance: request.isparentsubstance,
				parentsubstance: request.parentsubstance,
				isparentadmitted: request.isparentadmitted,
				parentadmitted: request.parentadmitted,
				isparentrefused: request.isparentrefused,
				parentrefused: request.parentrefused,
				isparentnotcompletetreatment: request.isparentnotcompletetreatment,
				parentnotcompletetreatment: request.parentnotcompletetreatment,
				isparentuncooperative: request.isparentuncooperative,
				parentuncooperative: request.parentuncooperative,
				isparentsafetyplan: request.isparentsafetyplan,
				parentsafetyplan: request.parentsafetyplan,
				parentcps: request.parentcps,
				parentchildwelfareservices: request.parentchildwelfareservices,
				parentcriminal: request.parentcriminal,
				parentcina: request.parentcina,
				activechildwelfare: request.activechildwelfare,
				effortsforpreventremoval: request.effortsforpreventremoval,
				ismonitoredchildsafety: request.ismonitoredchildsafety,
				monitoredchildsafety: request.monitoredchildsafety,
				isofferedchildwelfareservices: request.isofferedchildwelfareservices,
				offeredchildwelfareservices: request.offeredchildwelfareservices,
				ismedicalservices: request.ismedicalservices,
				medicalservices: request.medicalservices,
				isparentingclasses: request.isparentingclasses,
				parentingclasses: request.parentingclasses,
				isdisorderscreening: request.isdisorderscreening,
				disorderscreening: request.disorderscreening,
				ismentalhealth: request.ismentalhealth,
				mentalhealth: request.mentalhealth,
				isexploredrelative: request.isexploredrelative,
				exploredrelative: request.exploredrelative,
				isotherreasons: request.isotherreasons,
				otherreasons: request.otherreasons,
				werereasonableeffortsmade: request.werereasonableeffortsmade,
				reasonableeffortsmade: request.reasonableeffortsmade,
				wasfamilymeetingheld: request.wasfamilymeetingheld,
				familymeetingdate: request.familymeetingdate,
				familymeetingparticipants: request.familymeetingparticipants,
				familymeetingoutcome: request.familymeetingoutcome,
				dateofremoval: request.dateofremoval,
				timeofremoval: request.timeofremoval,
				typeofplacement: request.typeofplacement,
				otherinformation: request.otherinformation,
				isphotoinformationexists: request.isphotoinformationexists,
				whohasevidence: request.whohasevidence,
                caseworkerphonenumber: request.caseworkerphonenumber,
				supervisorphonenumber: request.supervisorphonenumber,
				iskinhome : request.iskinhome

			}).then(data => {

				var sql = 'UPDATE Petitionwitness SET activeflag=0, updatedon=now(), updatedby=$1 WHERE petitionid =$2';
				util.executeDBQuery(sql,[securityusersid,request.intakeservicerequestpetitionid])
				.then(_data => {
					LOGGER.info(_data);
				})
				.catch(err => {
					LOGGER.error(err)
					throw err;
				})


					const petitionwitness = request.petitionwitness;
					const cinasibling = request.cinasibling;
					const cinasubpoenad = request.cinasubpoenad;

				createPetitionwitness(petitionwitness);

				var sql2 = 'UPDATE Cinasibling SET activeflag=0, updatedon=now(), updatedby = $1 WHERE cinapetitionid = $2';
				util.executeDBQuery(sql2,[securityusersid,request.cinapetitionid])
				.then(_data => {
					LOGGER.info(_data);
				})
				.catch(err => {
					LOGGER.error(err)
					throw err;
				})

				createCinasibling(cinasibling, insertedon, request.cinapetitionid, request.intakeservicerequestpetitionid);

				var sql3 = 'UPDATE Cinasubpoenad SET activeflag=0, updatedon=now(), updatedby = $1 WHERE cinapetitionid = $2';
				util.executeDBQuery(sql3,[securityusersid,request.cinapetitionid])
				.then(_data => {
					LOGGER.info(_data);
				})
				.catch(err => {
					LOGGER.error(err)
					throw err;
				})

				createCinasubpoenad(cinasubpoenad, insertedon, securityusersid, request.cinapetitionid, request.intakeservicerequestpetitionid)
				return data;
			});


		}
	};

	function createCinasubpoenad(cinasubpoenad, insertedon, securityusersid, cinapetitionid, intakeservicerequestpetitionid){
		const response = [];
		if (Array.isArray(cinasubpoenad)) {
			cinasubpoenad.forEach(element => {
				element.activeflag = 1;
				element.insertedon = insertedon;
				element.insertedby = securityusersid;
				element.updatedby = securityusersid;
				element.cinapetitionid = cinapetitionid;
				element.intakeservicerequestpetitionid = intakeservicerequestpetitionid;

				response.push(
					app.models.Cinasubpoenad.create(element))
			})
			Promise.all(response).then(function (values) {
				LOGGER.info(values);
			});
		}
	}

	function createPetitionwitness(petitionwitness, insertedon){
		const response = [];
		if (Array.isArray(petitionwitness)) {
			petitionwitness.forEach(element => {
				element.activeflag = 1;
				element.insertedon = insertedon;
				response.push(
					app.models.Petitionwitness.create(element))
			})
			Promise.all(response).then(function (values) {
				LOGGER.info(values);
			});
		}
	}

	function createCinasibling(cinasibling, insertedon, cinapetitionid, intakeservicerequestpetitionid){
		const response = [];
		if (Array.isArray(cinasibling)) {
			cinasibling.forEach(element => {
				element.activeflag = 1;
				element.insertedon = insertedon;
				element.cinapetitionid = cinapetitionid;
				element.intakeservicerequestpetitionid = intakeservicerequestpetitionid;

				response.push(
					app.models.Cinasibling.create(element))
			})
			Promise.all(response).then(function (values) {
				LOGGER.info(values);
			});
		}
	}

	Cinapetition.remoteMethod('list', {
		http: {
			path: '/list',
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

	Cinapetition.list = (request) => {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}

		var intakeservicerequestpetitionid = request.where.intakeservicerequestpetitionid;
		var totalcount = 0;
		var sql = 'select count(1) over() as totalcount,*,rv.value_text placementdesc,up.fullname as supervisorfullname from Cinapetition cp left join referencevalues rv on rv.ref_key=cp.typeofplacement and rv.referencetypeid=77 and rv.teamtypekey=\'CW\' left join userprofile up on up.securityusersid = cp.supervisorname and up.activeflag=1 where cp.intakeservicerequestpetitionid=$1 limit $2 offset $3';

		return util.executeSecondaryNodeDBQuery(sql,[intakeservicerequestpetitionid,request.page,request.skip])
			.then(data => {
				if (data && data.length && data.length > 0) {
					totalcount = data[0].totalcount;
					var cinasiblingsql = 'select cs.* from cinasibling cs where cs.activeflag = 1 and cs.cinapetitionid = $1';
					return util.executeSecondaryNodeDBQuery(cinasiblingsql,[data[0].cinapetitionid])
						.then(data1 => {
							const cinasubpoenadsql = 'Select *,rv.value_text as recorddesc from cinasubpoenad cs left join referencevalues rv on rv.ref_key=cs.typeofrecord and rv.referencetypeid=136 and rv.teamtypekey=\'CW\' where cs.activeflag=1 and cs.cinapetitionid=$1';
							return util.executeSecondaryNodeDBQuery(cinasubpoenadsql,[data[0].cinapetitionid])
								.then(data2 => {
									const petitionwitnesssql = 'select p.firstname as firstname,p.lastname as lastname,pw.* from actor as ac inner join person AS p ON p.personid=ac.personid AND p.activeflag =1 inner join intakeservicerequestactor iac on iac.actorid=ac.actorid inner join petitionwitness pw on pw.activeflag=1 and iac.intakeservicerequestactorid = pw.personid and pw.petitionid = $1';
									return util.executeSecondaryNodeDBQuery(petitionwitnesssql,[data[0].intakeservicerequestpetitionid])
										.then(data3 => {
											var parent1 = 'select p.firstname || \',\'  || p.lastname as parent1name,p.* from actor as ac inner join person AS p ON p.personid=ac.personid AND p.activeflag =1 inner join intakeservicerequestactor iac on iac.actorid=ac.actorid inner join cinapetition cp on cp.activeflag=1 and iac.intakeservicerequestactorid::text = cp.parent1name and cp.cinapetitionid=$1';
											return util.executeSecondaryNodeDBQuery(parent1,[data[0].cinapetitionid])
												.then(data4 => {
													var parent2 = 'select p.firstname || \',\'  || p.lastname as parent2name,p.* from actor as ac inner join person AS p ON p.personid=ac.personid AND p.activeflag =1 inner join intakeservicerequestactor iac on iac.actorid=ac.actorid inner join cinapetition cp on cp.activeflag=1 and iac.intakeservicerequestactorid::text = cp.parent2name and cp.cinapetitionid=$1';

													return util.executeSecondaryNodeDBQuery(parent2,[data[0].cinapetitionid])
														.then(data5 => {
															var result;
															result = {
																'data': data,
																'count': totalcount,
																'petitionwitness': data3,
																'cinasibling': data1,
																'cinasubpoenad': data2,
																'parent1details': data4,
																'parent2details': data5
															};
															return result;
														})
														.catch(err5 => {
															LOGGER.error('>>>>ERROR:', err5);
															return err5;
														})
												})
												.catch(err4 => {
													LOGGER.error(err4);
													return err4;
												})
										})
										.catch(err3 => {
											LOGGER.error(err3);
											return err3;
										})
								})
								.catch(err2 => {
									LOGGER.error(err2);
									return err2;
								})
						})
						.catch(err => {
							LOGGER.error(err);
							return err;
						})
				}
				else {
					return data;
				}
			})
			.then(data => {
				return (!request.isNotEncrpt ? util.encryptresponse(data) : data);
			})
			.catch(err => {
				util.logError(err);
				LOGGER.error(err);
				return err;
			});
	};

	Cinapetition.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Cinapetition.observe('access', (ctx, next) => util.access(ctx, next));
	Cinapetition.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}