'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestactor");
var app = require('../../server/server');
const util = require('../utils/utils');
const actoridstr = '\'and actorid=\'';
var config = require('../../server/config.json'); 

module.exports = function(Intakeservicerequestactor) {
var personname,dangerlevel,actordesc;// Added for auditlog
	// getpersonsbyinvestigation(v_intakeserviceid uuid, _page integer, _limit
	// integer, isExpungementSuperUser integer DEFAULT 0, isexpunged integer
	// DEFAULT 0) and getpersonsbyservicecase(v_servicecaseid uuid, ...) both take
	// a uuid first. The web builds this where clause from a data-store case id, so
	// an unresolved id reaches Postgres as 22P02 invalid input syntax for type
	// uuid, and error-logger rewrites every failure to statusCode 400 -- which is
	// why it lands in APM as a bare "HttpError 400, No stack trace". Reject a
	// missing/malformed id here with a message that names the argument instead.
	const UUID_PATTERN = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

	function notAUuid(id) {
		return typeof id !== 'string' || !UUID_PATTERN.test(id.trim());
	}

	function badRequest(message) {
		const err = new Error(message);
		err.statusCode = 400;
		err.code = 'INVALID_ID';
		return Promise.reject(err);
	}

	// Both expungement arguments are integer columns and the web sends
	// isExpungementSuperUser as parseInt(storage.getItem('IS_EXPUNGED_USER')),
	// which is NaN whenever that session key is absent. JSON.stringify writes NaN
	// as null, so the flag arrives as null; bind the procedure's own default of 0
	// rather than passing that through.
	function expungementFlag(value) {
		const flag = parseInt(value, 10);
		return Number.isInteger(flag) ? flag : 0;
	}

	Intakeservicerequestactor.GetPersonList = function(data){
		var response="";
		// util.beforeremote only fills in where/page/limit when ctx.args.data is
		// already set, so a caller that omits the where clause still arrives here
		// with data.where undefined and the reads below threw a TypeError that
		// error-logger flattened into the same undiagnosable 400.
		if (!data) {
			data = {};
		}
		if (!data.where) {
			data.where = {};
		}
		const iscaseexpunged = expungementFlag(data.where.iscaseexpunged);
		var sql = 'SELECT * FROM getpersonsbyinvestigation($1, $2, $3,$4,$5)';
		var objectid = data.where.intakeservreqid;
		var idfield = 'intakeservreqid';
		var sqlparams = [objectid, data.page, data.limit,expungementFlag(data.where.isExpungementSuperUser),iscaseexpunged];
		if (data.where.objecttypekey == 'servicecase' && (data.where.objectid != null && data.where.objectid != undefined)) {
			sql = 'SELECT * FROM getpersonsbyservicecase($1, $2, $3)';
			objectid = data.where.objectid;
			idfield = 'objectid';
			sqlparams = [objectid, data.page, data.limit];
		}

		// Checked after the servicecase branch so it covers whichever id won.
		if (notAUuid(objectid)) {
			return badRequest(idfield + ' must be a uuid');
		}

		return util.executeSecondaryNodeDBQuery(sql, sqlparams)
			.then(req3 => {
				response = {
					'data': req3
				}
				return util.encryptresponse(response);
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Intakeservicerequestactor.GetActorServiceRequests = function(data){
			return Intakeservicerequestactor.find({
					where : {
						actorid : data.ActorId
					},
					include: 'Intakeservicerequest'
			});
		};
		Intakeservicerequestactor.deletewithintakeserreqnumber = function(id,data){
			var reqparam_intakeserreqid = id;
			var reqparam_actorid = data.actorid;
			var objecttype = data.objecttype;
			// Added for Auditlog
			app.models.Actor.findOne({
					where:{
						actorid:data.actorid
					},fields:['personid','actortype','actorid'],
					include:[{
						relation:'Person',
						scope:{
							fields:['firstname','lastname','dangerlevel']
						}
					},
				    {
						relation:'actortypedesc',
						scope:{
							fields:['typedescription','actortype']
						}
					}]
			}).then(data1=>{
				 var result = JSON.parse(JSON.stringify(data1))
				personname = "'"+result.Person.firstname+","+result.Person.lastname+"'";
				actordesc = result.actortypedesc.typedescription;
				dangerlevel = result.Person.dangerlevel;
			})
			//-ENDS Auditlog actordesc personname dangerlevel


		let  getintseractidQuery = 'SELECT intakeservicerequestactorid from  Intakeservicerequestactor where intakeserviceId =\''+reqparam_intakeserreqid+actoridstr+reqparam_actorid+'\'';
		if (objecttype == 'servicecase'){
			getintseractidQuery = 'SELECT intakeservicerequestactorid from  Intakeservicerequestactor where servicecaseid =\''+reqparam_intakeserreqid+actoridstr+reqparam_actorid+'\'';

		}
		return util.executeDBQuery(getintseractidQuery,[])
			.then(data1 => {
				if(data1.length >0){
					var intakeservicerequestactorid = data1[0].intakeservicerequestactorid;
					var deleteActorRelationQuery = 'update actorrelationship set activeflag =0  where intakeservicerequestactorid =\''+intakeservicerequestactorid+'\'';
					return util.executeDBQuery(deleteActorRelationQuery,[])
						.then(data2 => {
							var deleteInvestigationAllegationActor = 'update investigationallegationactor set activeflag =0 where intakeservicerequestactorid =\''+intakeservicerequestactorid+'\'';
							return util.executeDBQuery(deleteInvestigationAllegationActor,[])
							.then(data3 => {
								var deleteQuery = 'update Intakeservicerequestactor set activeflag = 0 where intakeserviceId =\''+reqparam_intakeserreqid+actoridstr+reqparam_actorid+'\'';
								return util.executeDBQuery(deleteQuery,[])
								.then(data4 => {
									var sql = 'update actor set activeflag= 0 where actorid=\''+reqparam_actorid+'\'';
									return util.executeDBQuery(sql,[])
									.then(data5 => {
										return data5;
									})
								})
							})
						})
				}	else {
					return "No Record Found";
				}
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
		};

		Intakeservicerequestactor.remoteMethod('GetActorServiceRequests', {
		accepts : [ {
			arg : 'intakeservreqid',
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



Intakeservicerequestactor.remoteMethod('GetPersonList', {
        accepts : {
                arg : 'data',
                type : 'object',
                required : true,
                http : { source: 'query' }
            },
        http: {
            'verb': 'get',
            'path': '/GetPersonList'
            },
        returns : {
            type : 'Object',
            root : true
            }
	});
	Intakeservicerequestactor.remoteMethod('deletewithintakeserreqnumber', {
		http: {
			path: '/deletewithintakeserreqnumber/:id',
			verb: 'patch'
		},
		accepts : [{
		arg : 'id',
		type : 'data',
		required: true,
		http : {source : 'path'}
		},
		{arg : 'data',type : 'object',
			http : {source : 'body'}} ],
		returns: {
			type : 'object',
			root : true
		}
		});

	Intakeservicerequestactor.afterRemote('deletewithintakeserreqnumber', function (ctx, next) {
	  var description1,referenceid,Servicerequestnumber,ipaddress,isnew,isdelete,isedit ;
	  var logtypekey = "IPP";
	    ipaddress = ctx.req.connection.remoteAddress;
	  isdelete = true;
	  referenceid = ctx.args.id;
	  description1 = "Person "+ personname +" (Roletype:"+actordesc +")  deleted  from DA#";
	  var logJson = {
		  "data": {
			  "danumber": "",
			  "name":"",
			  "actortype":"",
			  "dangerlevel":""
		  }
	  };
			return Intakeservicerequestactor.findOne({
						where :{actorid:ctx.result.id },
						fields: ['intakeserviceid']
					}).then(ids =>{
						const  intakeserviceid = ids.intakeserviceid;
						logJson.data.name = personname;
						logJson.data.actortype = actordesc;
						logJson.data.dangerlevel = dangerlevel;
						var newadd = {
                            "description":description1,
                            "logtypekey":logtypekey ,
                            "intakeserviceid": intakeserviceid,
                            "referenceid": referenceid,
                            "servicerequestnumber":Servicerequestnumber,
							"metadata":logJson,
							"ipaddress":ipaddress,
                            "isnew":isnew,
                            "isedit":isedit,
                            "isdelete":isdelete
                        }
                        // Auditlog Recording Added here
                        app.models.Auditlog.createlogdetails(newadd);
						next();
					}).catch (err => err)

	});

	Intakeservicerequestactor.getFocusPerson = (intakeserviceid) => {
        return Intakeservicerequestactor.find({
          fields: ['intakeservicerequestactorid', 'actorid', 'intakeservicerequestpersontypekey'],
		  where:{
			and: [
				{intakeserviceid: intakeserviceid},
				{intakeservicerequestpersontypekey: {'inq': ['RA', 'RC']}}
			]
		  },
		  include: {
			relation: 'actor',
			scope: {
				fields: ['actorid', 'personid'],
				include: {
					relation: 'Person',
					scope: {
						fields: ['personid', 'firstname', 'lastname', 'middlename', 'racetypekey', 'dangerlevel', 'dangerreason'],
						include: [{
							relation: 'personphonenumber',
							scope: {
								fields: ['phonenumber', 'personid'],
								//where: {personphonetypekey: 'P'}
							}
						},
						{
							relation: 'personaddress',
							scope: {
								fields: ['personaddressid', 'address', 'address2', 'city', 'state', 'county', 'state', 'zipcode', 'country', 'danger', 'dangerreason', 'personid']
							}
						}]
					}
				}
			}
		  }
        })
		.then(data => {
			const isrActor = JSON.parse(JSON.stringify(data));
			if(isrActor.length > 0 && isrActor[0].actor && isrActor[0].actor.Person)
			{
				const person = isrActor[0].actor.Person;
				person.actortype = isrActor[0].intakeservicerequestpersontypekey;

				return isrActor[0].actor.Person;
			}
			else
				{return;}
		})
        .catch(err => util.logError(err));
	  };
	  

	  Intakeservicerequestactor.getAPSFocusPerson = (intakeserviceid) => {
        return Intakeservicerequestactor.find({
          fields: ['intakeservicerequestactorid', 'actorid', 'intakeservicerequestpersontypekey','isprimary'],
		  where:{
			and: [
				{intakeserviceid: intakeserviceid}
			//	{intakeservicerequestpersontypekey: {'inq': ['RA', 'RC']}}
			]
		  },
		  include: {
			relation: 'actor',
			scope: {
				fields: ['actorid', 'personid'],
				include: {
					relation: 'Person',
					scope: {
						fields: ['personid', 'firstname', 'lastname', 'middlename', 'racetypekey', 'dangerlevel', 'dangerreason'],
						include: [{
							relation: 'personphonenumber',
							scope: {
								fields: ['phonenumber', 'personid'],
								//where: {personphonetypekey: 'P'}
							}
						},
						{
							relation: 'personaddress',
							scope: {
								fields: ['personaddressid', 'address', 'address2', 'city', 'state', 'county', 'state', 'zipcode', 'country', 'danger', 'dangerreason', 'personid']
							}
						}]
					}
				}
			}
		  }
        })
		.then(data => {
			const isrActor = JSON.parse(JSON.stringify(data));
			
			if(Array.isArray(isrActor)) {
               return isrActor.map(element => {
				const person = element.actor.Person;
					person.actortype = element.intakeservicerequestpersontypekey;	
					return element.actor.Person;
                });
			}
			return [];
			
		})
        .catch(err => util.logError(err));
      };

	Intakeservicerequestactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Intakeservicerequestactor.observe('access', (ctx, next) => util.access(ctx, next));
	Intakeservicerequestactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
