'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestcrossreference");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Intakeservicerequestcrossreference) {
	/*GetAllCrossReferencebySerReqid*/
	var crossda,datype,dasubtype,instatus;//Added for audit log

Intakeservicerequestcrossreference.getAllCrossReferencebySerReqid = arg => {
	const prs  = [];
	const emptyUUID = '00000000-0000-0000-0000-000000000000';
	const intakeserviceid = arg.where? arg.where.intakerequestid: emptyUUID;

	LOGGER.debug("arg:"+JSON.stringify(arg));
	prs.push(Intakeservicerequestcrossreference.find({
		fields: ['intakeservicerequestcrossrefernceid', 'withintakeservicerequestid', 'fromintakeservicerequestid', 'intakeservicerequestcrossreferencereasontypekey'],
		where : {
			withintakeservicerequestid : intakeserviceid
		},
		skip : (arg.page-1) * arg.limit,
		limit : arg.limit,
		order : arg.order,
		include: [{
			where: {activeflag: 1},
			relation: 'intakeservicerequest',
			scope: {
				fields: ['intakeserviceid', 'servicerequestnumber', 'intakeservreqtypeid','intakeservicerequestclassid', 'intakeserreqstatustypeid'],
				include: [{
					relation:'intakeservicerequesttype',
					scope: {
						fields:['description']
					}
				},
				{
					relation:'servicerequestsubtype',
					scope: {
						fields:['classkey']
					}
				},
				{
					relation:'intakeserreqstatustype',
					scope: {
						fields:['description']
					}
				},
				{
					relation: 'areateammemberservicerequest',
					where: {activeflag: true},
					scope: {
						fields: ['teammemberid'],
						include: {
							relation: 'teammember',
							where: {activeflag: true},
							scope: {
								fields: ['teammemberid'],
								include: {
									relation: 'teammemberassignment',
									where: {activeflag: true},
									scope: {
										fields: ['teammemberid','securityusersid'],
										include:
										{
											relation: 'securityusers',
											scope: {
												fields: ['securityusersid'],
												where: {activeflag: true},
												include:{ relation:'userprofile',
													scope: {	 
														fields: ['displayname','fullname']
													}
												}
											}
										}
									}
								}
							}
							
						}
					}
				 }]
			}
		},
		{
			relation:'intakeservicerequestcrossreferencereasontype',
			scope: {
				fields:['typedescription']
			}
		}]
	}));

	prs.push(Intakeservicerequestcrossreference.count({
			fromintakeservicerequestid : intakeserviceid
	}));

	return Promise.all(prs)
	.then(data => {
		return {data: data[0], count: data[1]};
	})
	.catch(err => err);
};



Intakeservicerequestcrossreference.remoteMethod('getAllCrossReferencebySerReqid', {
	http: {
		path: '/getAllCrossReferencebySerReqid',
		verb: 'get'
	},
		accepts : [ {
			arg : 'filter',
			type : 'object',
			required: true,
			http : {
				source : 'query'
			}
		} ],
		returns : {
			type : 'object',
			root : true
		}
	});

Intakeservicerequestcrossreference.remoteMethod('referrallist', {
    accepts : [
        {
            arg: 'filter',
            type: 'Object',
            required: true,
            http: {source: 'query'}
        },
        
],
http:{"verb": "get", },
	returns : {
		type : 'Object',
		root : true
	}
});


Intakeservicerequestcrossreference.referrallist = function(arg) {
	
	
	  const intakeserviceid = arg.where.intakeserviceid;
	  const  intakeservreqtypekey = "ANE";
	  LOGGER.debug(intakeserviceid);
	  return  Intakeservicerequestcrossreference.find({
		 where:{and:[ {activeflag: true},{withintakeservicerequestid:intakeserviceid}]}, 
		 fields:['withintakeservicerequestid'],
		 include:{  relation: 'intakeservicerequest',
		 		 scope:{
		 fields: [ 'intakeserviceid','servicerequestnumber','reporteddate','intakeservreqtypeid','intakeserreqstatustypeid','intakeserreqinputtypeid','intakeservicerequestclassid','agencyname'],
		 include:[{ relation: 'intakeservicerequesttype',
			    scope: {
			    	 fields: ['intakeservreqtypeid'],
			    	where:{intakeservreqtypekey:{neq:intakeservreqtypekey}},
			         include:{
			             relation: 'servicerequestsubtype', 
			             scope: {
			             fields: ['intakeservreqtypeid',
			            		 'servicerequestsubtypeid',
			            		 'description']
			             }
			   }
			   }
		 },
		/* {
           relation: 'intakeservicerequestreferraldetail',
           scope: {
        	   where: {activeflag: true},
               fields: [ 'referralorgtypekey','intakeserviceid'],
             include:{
          		relation :'referralorgtype',
                 scope: {
                	 where: {activeflag: true},
                	 fields: ['referalorgtypekey',
                		 'typedescription'],
                 }
     		 }
          	 
           }
       }, */
       {
   		 relation: 'intakeserreqstatustype',
           scope: {
         	  where: {activeflag: true},
         	  fields: ['intakeserreqstatustypeid','description'],
          	  }
  	 },{
       	 relation: 'intakeservicerequestdispositioncode',
       	scope: {
  	    fields: ['intakeserviceid','servicerequesttypeconfigiddispostionid'],
  	     where: {activeflag: true,
          include:{
          		 relation:'servicerequesttypeconfigdispositioncode',
          		 scope:{
          fields:['servicerequesttypeconfigiddispostionid','description'],
          where: {activeflag: true}}	 
          	 }
          	  }
  	 }
  		 
  	 },{
       	 relation: 'areateammemberservicerequest',
   	     
   	     scope: {
   	    	 fields: ['teammemberid','intakeserviceid'], 
   	    	 where: {activeflag: true},
   	    	 include: {
   	    		 relation: 'teammember',
   	    		 scope: {
   	    			 fields: ['teammemberid','intakeserviceid'], 
   	     	    	 where: {activeflag: true},
   	     	    	include:
              		 {
   	     	    	 relation: 'teammemberassignment',
                scope: {
               	 fields: ['teammemberid','securityusersid'],
               	 where: {activeflag: true},
               	 include:
               		 {
                   		 relation: 'securityusers',
                            scope: {
                                fields: ['securityusersid'],
                                where: {activeflag: true},
                           	 include:{ relation:'userprofile',
                           		 scope: {	 
                           		 fields: ['displayname'],
                           		
                           	 }
                            }
                   	    }
                   	 }
               	  }
   	    		 }
   	      }
       	 }
	 }
   		 
   	 }]
		 }
	  }
		
	 });
};
 // Added for audit log

Intakeservicerequestcrossreference.restype =(sintakeservicerequestid) =>{
	return  app.models.Intakeservicerequest.findOne(
		{
		where:{intakeservicerequestid:sintakeservicerequestid},
		 fields: ['intakeserviceid', 'servicerequestnumber', 'intakeservreqtypeid','intakeservicerequestclassid', 'intakeserreqstatustypeid'],
		 include: [{
			 relation:'intakeservicerequesttype',
			 scope: {
				 fields:['description']
			 }
		 },
		 {
			 relation:'servicerequestsubtype',
			 scope: {
				 fields:['classkey']
			 }
		 },
		 {
			 relation:'intakeserreqstatustype',
			 scope: {
				 fields:['description']
			 }
		 }]
	}).then(data => {
		return data;
	}).catch(err => err)

}

Intakeservicerequestcrossreference.observe('after save', function (ctx, next) {
	var description,intakeserviceid,referenceid,Servicerequestnumber,isnew,isdelete,isedit ;
	var logJson = {
		"data": {
			"danumber": "",
			"reasontypekey": "",
			"type": "",
			"subtype": "",
			"crossreferencedanumber": "",
			"status": "",
			"createdby": "",
			"createadon": ""
		}
	};
	var logtypekey = "CR";

	if (ctx.isNewInstance){
		isnew = true;
		intakeserviceid = ctx.instance.fromintakeservicerequestid;
		referenceid = ctx.instance.intakeservicerequestcrossrefernceid;
		description =  "Crossreference added with reason: "+ ctx.instance.intakeservicerequestcrossreferencereasontypekey +" for DA#";
		Intakeservicerequestcrossreference.restype(ctx.instance.withintakeservicerequestid)
		.then(result =>{
				const respon = JSON.parse(JSON.stringify(result));
				crossda = respon.servicerequestnumber;
				datype = respon.intakeservicerequesttype.description;
				dasubtype = respon.servicerequestsubtype.classkey;
				instatus = respon.intakeserreqstatustype.description;
				logJson.data.type = datype;
				logJson.data.subtype = dasubtype;
				logJson.data.status = instatus;
				logJson.data.crossreferencedanumber = crossda;
			   return result;
			});

		logJson.data.reasontypekey = ctx.instance.intakeservicerequestcrossreferencereasontypekey;
     	logJson.data.createdby = app.currentUser.email;
		logJson.data.createadon = ctx.instance.insertedon;
	}
	var newadd = {
		"description":description,
		"logtypekey":logtypekey ,
		"intakeserviceid": intakeserviceid,
		"referenceid": referenceid,
		"servicerequestnumber":Servicerequestnumber,
		"metadata":logJson,
		"isnew":isnew,
		"isedit":isedit,
		"isdelete":isdelete
	}
	// Auditlog Recording Added here 
	app.models.Auditlog.createlogdetails(newadd);
	next();

})

Intakeservicerequestcrossreference.observe('after delete', function (ctx, next) {
	var description,reason,intakeserviceid,referenceid,Servicerequestnumber,isnew,isdelete;
	var logJson =  {
		"data": {
			"danumber": "",
			"type": "",
			"subtype": "",
			"crossreferencedanumber": "",
			"reasontypekey":"",
			"status": "",
			"createdby": ""
		}
	}
	var logtypekey = "CR";
	 isdelete = true;
	 
	Intakeservicerequestcrossreference.findOne({where :{intakeservicerequestcrossrefernceid:ctx.where.id},
fields:['fromintakeservicerequestid','withintakeservicerequestid','intakeservicerequestcrossreferencereasontypekey']
	}).then(data => {
		intakeserviceid = data.fromintakeservicerequestid;
		var withintakeservicerequestid = data.withintakeservicerequestid;
		reason = data.intakeservicerequestcrossreferencereasontypekey;
		referenceid = ctx.where.intakeservicerequestcrossrefernceid;
        description = "'"+reason+"'" + " Crossreference deleted from #DA : ";
		Intakeservicerequestcrossreference.restype(withintakeservicerequestid)
		.then(result =>{
				const respon = JSON.parse(JSON.stringify(result));
				crossda = respon.servicerequestnumber;
				datype = respon.intakeservicerequesttype.description;
				dasubtype = respon.servicerequestsubtype.classkey;
				instatus = respon.intakeserreqstatustype.description;
				logJson.data.type = datype;
				logJson.data.subtype = dasubtype;
				logJson.data.status = instatus;
				logJson.data.crossreferencedanumber = crossda;
				logJson.data.reasontypekey =reason;

			   return result;
			});
		
		
	
     	logJson.data.createdby = app.currentUser.email;
		

		var newadd = {
            "description":description,
            "logtypekey":logtypekey ,
            "intakeserviceid": intakeserviceid,
            "referenceid": referenceid,
			"servicerequestnumber":Servicerequestnumber,	
			"metadata":logJson,
            "isnew":isnew,
			"isedit":logJson,
            "isdelete":isdelete
        }
		  app.models.Auditlog.createlogdetails(newadd);
        next();
	})
})

Intakeservicerequestcrossreference.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Intakeservicerequestcrossreference.observe('access', (ctx, next) => util.access(ctx, next));
Intakeservicerequestcrossreference.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
