'use strict';
const LOGGER = require("log4js").getLogger("assessmenttemplate");
var app = require('../../server/server');
var uuid = require('node-uuid');
const util = require('../utils/utils');
const dummyid = '00000000-0000-0000-0000-000000000000';

module.exports = function(Assessmenttemplate) {
	
	Assessmenttemplate.listdata = function(data) {
		var pageno =(data.page - 1) * data.limit
	 LOGGER.debug(data)
	var sql = 'select * from listassessmenttemplate($1,$2,$3,$4,$5,$6)';  
	LOGGER.debug(sql);
		return util.executeSecondaryNodeDBQuery(sql,[data.where.categoryid,data.where.subcategoryid,data.where.targetid,data.where.isactive,pageno,data.limit]).then((_data) => {
			return _data;
		}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
	}; 


	Assessmenttemplate.afterRemote('listdata', function(ctx, data, next) {
		if (ctx.result) {
			ctx.result = {
				'data' : data,
				'count' : totalCount
			};
		}	
		next();
	});
	 
	Assessmenttemplate.list = function(request) {

		 return Assessmenttemplate.find( {
			//  fields: ["assessmenttextpositiontypekey"] ,
			 where:{activeflag: 1},
			 include:{
				 relation:"assessmenttextpositiontype",
				 scope: {
					fields: ["assessmenttextpositiontypekey","sequencenumber", "datavalue","editable",
					"typedescription"] 
				 }
			 }
		  }
		//   , 
		
		// 	function(err, res) {
		// 	cb(err, res);
		) .catch(err => LOGGER.error(err));  

	};

	Assessmenttemplate.gettemplate = function(request) {

		 LOGGER.debug(request)
				 return Assessmenttemplate.find( {
					//  fields: ["assessmenttextpositiontypekey"] ,
					 where:{assessmenttemplateid: request.where.assessmenttemplateid},
					 include:[{
						 where:{activeflag:1},
						 relation:"assessmenttemplatecategoryfiltermap",
						 scope: {
							fields: ["assessmenttemplateid","assessmenttemplatecategoryfilterid","assessmenttemplatecategoryfiltermapid" 
							 ] ,
							
						 include:{
							relation:"assessmenttemplatecategoryfilter",
							scope: {
							   fields: ["assessmenttemplatecategoryfilterid","assessmenttemplatecategoryid"
							   ,"assessmenttemplatesubcategoryid"
							   ,"assessmenttemplatetargetid"
								] ,
								
							
							include:[{
								relation:"assessmenttemplatecategory",
								scope: {
								   fields: ["assessmenttemplatecategoryid","category" 
									] 
								}
							},
							 {
								relation:"assessmenttemplatesubcategory",
								scope: {
								   fields: ["assessmenttemplatesubcategoryid","subcategory" 
									] 
								}
							},
							 {
								relation:"assessmenttemplatetarget",
								scope: {
								   fields: ["assessmenttemplatetargetid","target" 
									] 
								}
							}]
						}
						}
						}
					 }]
				  }
				//   , 
				
				// 	function(err, res) {
				// 	cb(err, res);
				) .catch(err => LOGGER.error(err));  
		
			};

			Assessmenttemplate.createtemplate = function(request) {
				if (request.assesment!=null && request.assesment!=undefined &&
					request.assesment.external_templateid  !=null && request.assesment.external_templateid!=undefined)
				{

					return app.models.Assessmenttemplate.find({
						where : {
							external_templateid :request.assesment.external_templateid

						}
					}).then(result => {
						if (result.length>0) {

							LOGGER.debug("update");
							request.assesment.assessmenttemplateid  =result[0].assessmenttemplateid;

							LOGGER.debug(request);
							return app.models.Assessmenttemplate.updatetemplate(request);
						} else {
							LOGGER.debug("create");
							return app.models.Assessmenttemplate.createtemplate1(request);
						}
					}).catch(err => {
						LOGGER.error('>>>>ERROR:', err);
						throw err;
					});
				} else {
					return Promise.resolve({data:{message:"Invalid Request"}});
				}
			}

		Assessmenttemplate.createtemplate1 = function(request) {

		if (request.assesment!==null && request.assesment!==undefined)
		{
			request.assesment.assessmenttemplateid=uuid();
			request.assesment.activeflag=true;
			return Assessmenttemplate.create(request.assesment)
				.then(res => {
					if (request.assesment.datamappingenabled =="true" &&
						request.datamap!=null && request.datamap!=undefined &&
						res.assessmenttemplateid!=null && res.assessmenttemplateid!=undefined) {
							checkAssessmenttemplatecategoryfiltermap(request, res);
					}
					return {data:{assessmenttemplateid:res.assessmenttemplateid,
						status:200,message:"Successfully Added"}};
				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
		}
	};

	function checkAssessmenttemplatecategoryfiltermap(request, res) {
		for (const element of request.datamap)
					{
						var ret1={};
						ret1 =element;
						if (ret1.intakeservicerequesttypeid==null || ret1.intakeservicerequesttypeid ==undefined)
						{
							ret1.intakeservicerequesttypeid=dummyid;
						}
						/*else{
							teamtypekey =   new Promise((resolve, reject) => { app.models.Intakeagencypurpose.find(
								{
									fields:['teamtypekey'],
									where: {intakeservreqtypeid: ret1.intakeservicerequesttypeid}})
							.then(data => {	
								var tt =data[0];
								resolve(tt.teamtypekey);
								return data[0].teamtypekey;
							})});
						}*/
						if (ret1.intakeservicerequestsubtypeid==null || ret1.intakeservicerequestsubtypeid ==undefined)
						{
							ret1.intakeservicerequestsubtypeid=dummyid;
						}					
						createAssessmenttemplatecategoryfiltermap(res.assessmenttemplateid, ret1, res)
					}
	}

	function updateAssessmenttemplatecategoryfiltermap(refid, data) {
		app.models.Assessmenttemplatecategoryfiltermap.updateAll(
			refid, data,
			function(err, res1) {

			if (err) {
					LOGGER.error(err);
					throw err;
			}
			
		});
	}

	function createAssessmenttemplatecategoryfiltermap(templateid, ret1, assres) {
		var responseJson = {};
		responseJson.assessmenttemplateid=templateid;
		responseJson.assessmenttemplatecategoryfiltermapid= uuid();
		responseJson.activeflag=true;
		responseJson.intakeservicerequesttypeid=ret1.intakeservicerequesttypeid;
		responseJson.intakeservicerequestsubtypeid=ret1.intakeservicerequestsubtypeid;
		responseJson.assessmenttemplatetargetid=ret1.assessmenttemplatetargetid;
		responseJson.insertedby = assres.updatedby;
		responseJson.updatedby = assres.updatedby;
		responseJson.effectivedate =assres.effectivedate;
		responseJson.expirationdate = assres.expirationdate;
		responseJson.timestamp = assres.timestamp;
		responseJson.repeatable = ret1.repeatable;
		responseJson.old_id=" ";
		responseJson.teamtypekey=null;
		
		app.models.Assessmenttemplatecategoryfiltermap.create(responseJson,
			function(_err, res1) {
				if (_err) {
					LOGGER.error(_err);
					throw _err;
				}
			});
	}

	function findUpdateAssessmenttemplatecategoryfiltermap(request, templateid) {
		var assres = request.assesment;
		for (const element of request.datamap) {
			var ret1 = {};
			ret1 = element;
			if (ret1.intakeservicerequesttypeid == null || ret1.intakeservicerequesttypeid == undefined) {
				ret1.intakeservicerequesttypeid = dummyid;
			}

			if (ret1.intakeservicerequestsubtypeid == null || ret1.intakeservicerequestsubtypeid == undefined) {
				ret1.intakeservicerequestsubtypeid = dummyid;
			}

			if (element.assessmenttemplatecategoryfiltermapid != null &&
				element.assessmenttemplatecategoryfiltermapid != undefined) {
				updateAssessmenttemplatecategoryfiltermap({ assessmenttemplatecategoryfiltermapid: ret1.assessmenttemplatecategoryfiltermapid }, { activeflag: ret1.activeflag });
			} else {
				callAssessmenttemplatecategoryfiltermap(ret1, templateid, assres);
			}

		}
	}

	function callAssessmenttemplatecategoryfiltermap(ret1, templateid, assres){
		app.models.Assessmenttemplatecategoryfiltermap.find({
			where: {
				intakeservicerequesttypeid: ret1.intakeservicerequesttypeid,
				intakeservicerequestsubtypeid: ret1.intakeservicerequestsubtypeid,
				assessmenttemplatetargetid: ret1.assessmenttemplatetargetid,
				assessmenttemplateid: templateid
			}
		}, function (err, result) {
			if (err) {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			}
			if (result.length > 0) {
				updateAssessmenttemplatecategoryfiltermap({ assessmenttemplatecategoryfiltermapid: result.assessmenttemplatecategoryfiltermapid }, { activeflag: ret1.activeflag });

			} else {
				createAssessmenttemplatecategoryfiltermap(templateid, ret1, assres)
			}
		});
	}
	 		
Assessmenttemplate.updatetemplate = function(request) {
	if (request.assesment!==null && request.assesment!==undefined &&
	  request.assesment.assessmenttemplateid !=null && request.assesment.assessmenttemplateid!=undefined)
  	{
	 var templateid =request.assesment.assessmenttemplateid;
	  return Assessmenttemplate.updateAll(
		  		{assessmenttemplateid:request.assesment.assessmenttemplateid},
				{name:request.assesment.name ,
				titleheadertext:request.assesment.titleheadertext,
				description:request.assesment.description,
				version:request.assesment.version,
				assessmenttextpositiontypekey:request.assesment.assessmenttextpositiontypekey,
				timestamp:request.assesment.timestamp,
				instructions:request.assesment.instructions,
				updatedby:request.assesment.updatedby,
				effectivedate:request.assesment.ffectivedate,
				expirationdate:request.assesment.expirationdate,
				helptext:request.assesment.helptext,
				datamappingenabled:request.assesment.datamappingenabled,
				enableassessmentscore:request.assesment.enableassessmentscore,
				scoringname:request.assesment.scoringname,
				calculationmethod:request.assesment.calculationmethod,
				duedays:request.assesment.duedays,
				ismandatory:request.assesment.ismandatory})
			  	.then(res => {
					if ( request.assesment.datamappingenabled =="false")
					{
						updateAssessmenttemplatecategoryfiltermap({assessmenttemplateid:templateid},{activeflag:0});
					} else  if (request.assesment.datamappingenabled =="true" && request.datamap!=null && request.datamap!=undefined
					&&  templateid!=null &&templateid!=undefined)
					{
						findUpdateAssessmenttemplatecategoryfiltermap(request, templateid);
					}
					return {data:{assessmenttemplateid:templateid, status:200,message:"Successfully updated"}};
  				})
				.catch(err => {
					LOGGER.error('>>>>ERROR:', err);
					throw err;
				});
	  	}
		return Promise.resolve({ data: { message: 'Invalid Request' } });
	};

	 		
Assessmenttemplate.deletetemplate = function(request, reqctx) {
	LOGGER.debug(request);
	let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
 if (request !=null && request !=undefined)
  {
	 var templateid =request;

	  return Assessmenttemplate.updateAll({assessmenttemplateid:templateid},
		  {activeflag:0,updatedby: request.updatedby ? request.updatedby: _securityusersid})
			  .then(res => {
				app.models.Assessmenttemplatecategoryfiltermap.updateAll(
					{assessmenttemplateid:templateid},{activeflag:0})
					.catch(_err1 => {
						LOGGER.error('>>>>ERROR:', _err1);
						throw _err1;
					});

			  return {data:{assessmenttemplateid:templateid, status:200,message:"Assessment template deleted successfully"}};
		  })
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

  }

    return Promise.resolve({ data: { message: 'Invalid Request' } });
};
	Assessmenttemplate.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'body'
			},
			required : true
		},
		http : {
			verb : 'post'
		},
		returns : {
			type : 'object',
			root : true
		}
	});

	Assessmenttemplate.remoteMethod('listdata', {
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

	Assessmenttemplate.remoteMethod('gettemplate', {
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

	Assessmenttemplate.remoteMethod('createtemplate', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'body'
			},
			required : true
		},
		http : {
			verb : 'post'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	Assessmenttemplate.remoteMethod('updatetemplate', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'body'
			},
			required : true
		},
		http : {
			verb : 'put'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

	Assessmenttemplate.remoteMethod('deletetemplate', {
        accepts : [ {arg : 'data',type : 'object',
		    http : {source : 'body'}}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
        http: {"verb": "delete", "path": "/deletetemplate/:id"},
        returns : {
        type : 'Object',
        root : true
        }
	});

	Assessmenttemplate.getitemold = (request,id,intakenumber) =>{
		return app.models.Assessmenttemplatecategoryfiltermap.find({
			where :{intakeservicerequesttypeid:request.intakeservicerequesttypeid,
				intakeservicerequestsubtypeid:request.intakeservicerequestsubtypeid,
				assessmenttemplatetargetid:id}
		})
   		.then(records =>{  

		const value = JSON.parse(JSON.stringify(records)) 

		const templateIds = value.map(res => res.assessmenttemplateid);

		return app.models.Assessmenttemplate.find({
			where :{assessmenttemplateid :{inq : templateIds}},
			include : 
				{
					relation:'assessment',
						
					scope:{
					where :{intakenumber:intakenumber},
					fields:['assessmentid','assessmenttemplateid','submissionid','updatedon','assessmentstatustypekey']
					}
				}
		});
	})
	.then(rec =>{
			const data = JSON.parse(JSON.stringify(rec));
			data.map(d => d.target = 'Intake');
			return data;
   })
   .catch(err => LOGGER.error(err));
}

Assessmenttemplate.getitem = (request,id,intakenumber) =>{
	var agencycode = null;
	if (request.agencycode !=null && request.agencycode!=undefined)
	{
		agencycode = request.agencycode;
	}
	var servreqtypeid =dummyid;
	var servreqsubtypeid =dummyid;
	if (request.intakeservicerequesttypeid!=null && request.intakeservicerequesttypeid!=undefined)
		{
			servreqtypeid = request.intakeservicerequesttypeid;

		}
		if (request.intakeservicerequestsubtypeid!=null && request.intakeservicerequestsubtypeid!=undefined)
		{
			servreqsubtypeid = request.intakeservicerequestsubtypeid;
			
		}
	//assessmenttemplatetargetid:id,
	return app.models.Assessmenttemplatecategoryfiltermap.find({
		where :{ intakeservicerequesttypeid:servreqtypeid,assessmenttemplatetargetid:id,teamtypekey:agencycode
				 ,intakeservicerequestsubtypeid:servreqsubtypeid},
	  
	})
	// where : 
	// 	{
	// 		or: [
	// 		  { and: [{intakeservicerequesttypeid:servreqtypeid }, 	{intakeservicerequestsubtypeid:servreqsubtypeid}] },
	// 		  { teamtypekey:agencycode }
	// 		]
	// 	  }
	   .then(records =>{  

	const value = JSON.parse(JSON.stringify(records)) 

	const templateIds = value.map(res => res.assessmenttemplateid);

	return app.models.Assessmenttemplate.find({
		where :{assessmenttemplateid :{inq : templateIds}},
		include : 
			{
				relation:'assessment',
			
				scope:{
			   where :{intakenumber:intakenumber},
				fields:['assessmentid','intakenumber','assessmenttemplateid','submissionid','updatedon','assessmentstatustypekey']
				}
			}
	});
})
.then(rec =>{
		LOGGER.info(rec);
		const data = JSON.parse(JSON.stringify(rec));
		data.map(d => d.target = 'Intake');
		return data;
})
.catch(err => LOGGER.error(err));
}


	Assessmenttemplate.getlist = function(arg) {
		var requestarray = arg.where.assessmenttemplate
		var response ={} 

		if (Array.isArray(requestarray)) {
			
				return app.models.Assessmenttemplatetarget.find({
					where :{target:arg.where.target}
				})
				.then(value=>{
					const prs= [];
					 prs.push(requestarray.map(request => Assessmenttemplate.getitem(request,value[0].assessmenttemplatetargetid,arg.where.intakenumber))
					.reduce(function(a,b){ return a.concat(b) }, []));
					 var flatPrs = prs.reduce(function(a,b){ return a.concat(b) }, []);
					return Promise.all(flatPrs);
				})
				.then(output => {	
					var flatPrs = output.reduce(function(a,b){ return a.concat(b) }, []);
					 response.data =flatPrs;
					 return response
				})

							
		}
		return Promise.resolve([]);
	}
	//Assessment list based on Agency and Intakenumber
		Assessmenttemplate.getintakeassessment = function(arg) {

		var requestparam = arg.where;
		var datypeid =requestparam.intakeservicerequesttypeid;
		var dasubtypeid  =requestparam.intakeservicerequestsubtypeid;
	 
		if (datypeid==null || datypeid==undefined) {datypeid="";}
		if (dasubtypeid==null || dasubtypeid==undefined) {dasubtypeid="";}

		var sql = 'select * from getassessmentlist($1,$2,$3,$4,$5,$6,$7)';

		LOGGER.debug(sql);
		var totalCount = 0;
		return util.executeSecondaryNodeDBQuery(sql, [requestparam.intakenumber, requestparam.target, 
				requestparam.agencycode, datypeid,dasubtypeid,requestparam.page,requestparam.limit]).then((data) => {
				if (data.length>0) { 
					if(data[0].getassessmentlist!=null && data[0].getassessmentlist.length>0) 
					{totalCount= data[0].getassessmentlist[0].totalcount;}
				}
				var result;
				  result = {
				  'data' : data[0].getassessmentlist,
				  'count' : totalCount
				  };
				return result;
			}).catch((err) => { LOGGER.error('>>>>ERROR:', err); throw err; });
	}
    Assessmenttemplate.remoteMethod(
        'getintakeassessment', {
            http: {
                path: '/getintakeassessment',
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
        }
    );
	Assessmenttemplate.remoteMethod(
        'getlist', {
            http: {
                path: '/getlist',
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
        }
    );
 
	//client centric summary

	//Assessment list based on Agency and person id
	Assessmenttemplate.getintakeassessmentsummarybypersonid = function(arg) {
		var requestparam = arg.where;
		var datypeid =requestparam.intakeservicerequesttypeid;
		var dasubtypeid  =requestparam.intakeservicerequestsubtypeid;
	 
		if (datypeid==null || datypeid==undefined) {datypeid="";}
		if (dasubtypeid==null || dasubtypeid==undefined) {dasubtypeid="";}

		var sql = 'select * from getassessmentsummarybyperson($1,$2,$3,$4,$5,$6,$7,$8)';

		LOGGER.debug(sql);
		var totalCount = 0;
		return util.executeSecondaryNodeDBQuery(sql, [requestparam.personid, requestparam.personstatus,requestparam.target, 
				requestparam.agencycode, datypeid,dasubtypeid,requestparam.page,requestparam.limit]).then((data) => {
				if (data.length>0) { 
					if(data[0].getassessmentsummarybyperson!=null && data[0].getassessmentsummarybyperson.length>0) 
					{totalCount= data[0].getassessmentsummarybyperson[0].totalcount;}
				}
				var result;
				  result = {
				  'data' : data[0].getassessmentsummarybyperson,
				  'count' : totalCount
				  }
				return result;
			}).catch((err) => { LOGGER.error('>>>>ERROR:', err); throw err; });
	}

	
    Assessmenttemplate.remoteMethod(
        'getintakeassessmentsummarybypersonid', {
            http: {
                path: '/getintakeassessmentsummarybypersonid',
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
        }
	);


	//Assessment list based on Type and subtype and target
	Assessmenttemplate.listassessmenttemplate = function(arg) {
		var requestparam = arg.where;
		var datypeid =requestparam.intakeservicerequesttypeid;
		var dasubtypeid  =requestparam.intakeservicerequestsubtypeid;
	 
		if (datypeid==null || datypeid==undefined) {datypeid="";}
		if (dasubtypeid==null || dasubtypeid==undefined) {dasubtypeid="";}

		var sql = 'select * from getlistassessmenttemplate($1,$2,$3,$4)';

		LOGGER.debug(sql);
		return util.executeSecondaryNodeDBQuery(sql, [datypeid,dasubtypeid,requestparam.agencycode,requestparam.target]).then((data) => {
				return data;
			}).catch((err) => { LOGGER.error('>>>>ERROR:', err); util.logError(err); throw err; });
	}

	
    Assessmenttemplate.remoteMethod(
        'listassessmenttemplate', {
            http: {
                path: '/listassessmenttemplate',
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
        }
    );
	
	Assessmenttemplate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Assessmenttemplate.observe('access', (ctx, next) => util.access(ctx, next));
	Assessmenttemplate.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};