'use strict';
const LOGGER = require("log4js").getLogger("amactivity");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Amactivity) {

	var totalCount;
	Amactivity.list = function(request) {
		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;

		}

		return Amactivity.find(request);

	};
	Amactivity.remoteMethod('add', {
		http : {
			path : '/add',
			verb : 'post'
		},
		accepts : [ {
			arg : 'data',
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

	Amactivity.add= function(data){
	 return	Amactivity.find({
			where:{and:[{name:data.where.name},
				{activitytypekey: data.where.activitytypekey}]}
		}).then(res => {
			if(res.length  === 0){
				return Amactivity.create(data.where);
			}else if(res.length > 0){
				return "Already Exist";
			}
		}).catch(err => err);
		}



	Amactivity.mappinglist = function(request) {
	
	 const limit = request.limit;
	 const skip = (request.page-1) * limit;
	 const order = request.order
	 const nolimit = request.nolimit
     var  datares =[]; 
	    return app.models.Ammapping.find({
			//where:{and:[{activitytypekey:request.activitytypekey,ammappingid:request.ammappingid}]},
			where: request.where,
			limit:limit,nolimit:nolimit, skip:skip,order:order,
			fields:['ammappingid','amactivityid','name','description','ondemand','workload','helptext','isreviewactivity','iseditable'],
			include:[
				{
			   relation:"amactivity",
				scope:{
					fields: ['amactivityid','activitytypekey','name','description','iscontinue']
				}		
			},
				{
				relation:"ammappinggoal",
				scope: {
					nolimit:true,
					   fields: ['ammappingid','amgoalid','required','helptext','duedateoffset','activitygoaltypekey','activityprioritytypekey','activeflag'],
				include: {
					   relation: "amgoal",
					   scope:{
						   nolimit:true,
						   fields:['amgoalid','name','description']
					   }
				   }
				}
			},
		   {
			   relation:"activitytype"
		   }, 
		   {
			relation:"investigationmapping",
			scope:{
				fields:['objectid', 'ammappingid','activitytypekey'],
				}
		
		   },
		   {
			   relation: "ammappingtask",
			   scope: {
				   nolimit:true,
				   fields: ['ammappingid','amtaskid','required','helptext','duedateoffset','activitytasktypekey','activityprioritytypekey','activeflag'],
				   include: {
					   relation: "amtask",
					   scope:{
						   nolimit:true,
						   fields:['amtaskid','name','description']
					   }
				   }
			   }
		   }]	
		})
		
		.then( result => {
			LOGGER.debug(result)
			var obj = JSON.parse(JSON.stringify(result));
			LOGGER.debug(obj + "obj")
			datares = obj;
			LOGGER.debug(datares + "datares")
           var objectid;
			if( datares.length>0){
			 if( datares[0].investigationmapping !== undefined ){
				  objectid  = datares[0].investigationmapping.objectid;
			 }
			     return  app.models.Servicerequesttypeconfig.find({
			     where:{servicerequesttypeconfigid:objectid},
			     fields : ['intakeservreqtypeid','servicerequestsubtypeid']	
		       	})
			.then( ammapping =>{
				datares.forEach(x=>x.daobj = ammapping)
				return [{ammapping:datares}]
			})
		
		}	
		})
   }

	Amactivity.beforeRemote('list', function(ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== undefined && JSON.parse(ctx.req.query.filter).page === 1) {
			LOGGER.debug(":: Inside :: ");
			Amactivity.count( JSON.parse(ctx.req.query.filter).where, function(err, count) {
				if (err) {
					throw err;
				}
				totalCount = count;
				LOGGER.debug(count);
			});
		}

		next();
	});
	const aftRemotefn = (ctx, resultset, next) => {

		if (ctx.result) {
				 ctx.result = {
						 'data' : resultset,
						'count' : totalCount
				 };
		}
		next();
	}

	Amactivity.afterRemote('list', aftRemotefn);

	Amactivity.remoteMethod('list', {
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
	
	Amactivity.remoteMethod('mappinglist', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				path :'/mappinglist',
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
    Amactivity.beforeRemote('mappinglist', function(ctx, request, next) {

		if (JSON.parse(ctx.req.query.filter).page !== undefined && JSON.parse(ctx.req.query.filter).page === 1) {
				LOGGER.debug(":: Inside :: ");
				app.models.Ammapping.count( JSON.parse(ctx.req.query.filter).where, function(err, count) {
						if (err) {
								throw err;
						}
						totalCount = count;
				});
	   }

		next();
});

Amactivity.afterRemote('mappinglist', aftRemotefn);

	Amactivity.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Amactivity.observe('access', (ctx, next) => util.access(ctx, next));
	Amactivity.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
