'use strict';
const LOGGER = require("log4js").getLogger("assessmenttemplatecategoryfilter");
 
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Assessmenttemplatecategoryfilter) {
	 
	Assessmenttemplatecategoryfilter.assessmentcategory = function(request) {
		return app.models.Assessmenttemplatecategory.find( {
		   fields: ["assessmenttemplatecategoryid","category"] ,
		   order: "category" ,
		   // where:{activeflag: 1},
		   where: {
			   and: [{activeflag:1}]
			 } ,
			 include:[{
				 relation:"assessmenttemplatecategoryfilter" 
				//  scope: {
				// 	fields: ["assessmenttemplatecategoryid","category"] ,
				// 	"order": "category" 
				//  }
			 }],
			 groupby:"assessmenttemplatecategoryid"
		 }
	   ).catch(err => LOGGER.error(err));  
   }
   Assessmenttemplatecategoryfilter.assessmentsubcategory1 = function(request) {
	return Assessmenttemplatecategoryfilter.find( {
	   fields: ["assessmenttemplatesubcategoryid"] ,
	   // where:{activeflag: 1},
	   where: {
		   and: [{activeflag:1,assessmenttemplatecategoryid: request.where.categoryid}]
		 } ,
		 include:[{
			 relation:"assessmenttemplatesubcategory",
			 scope: {
				fields: ["assessmenttemplatesubcategoryid","subcategory"] ,
				"order": "subcategory",
				where:{activeflag:1}
			 }
		 }],
		 groupby:"assessmenttemplatesubcategoryid"
	 }
   ) .catch(err => LOGGER.error(err));  
}
 
	
//    Assessmenttemplatecategoryfilter.assessmentcategory = function(request, cb) {
//	sortJsonArray(jsonCollection, 'category','asc');
// 	   return app.models.Assessmenttemplatecategory.find( {
// 		  fields: ["assessmenttemplatecategoryid","category"] ,
// 		  // where:{activeflag: 1},
// 		  where: {
// 			  and: [{activeflag:1}]
// 			} ,
// 			include:[{
// 				relation:"assessmenttemplatecategoryfilter" 
// 			   //  scope: {
// 			   // 	fields: ["assessmenttemplatecategoryid","category"] ,
// 			   // 	"order": "category" 
// 			   //  }
// 			}],
// 			groupby:"assessmenttemplatecategoryid"
// 		}
// 	  ).then(result => {
// 	   var data = JSON.parse(JSON.stringify(result));
	
// 	   //return data;
	
// 	   return sortJsonArray(data.map(x => x.assessmenttemplatecategory), 'category','asc');
// 	   //return data.intakeservicerequestactor[0].actor.Person;
// 	 }) .catch(err => LOGGER.error(err));  
//   }
Assessmenttemplatecategoryfilter.assessmentsubcategory = function(request) {
	return app.models.Assessmenttemplatesubcategory.find( {
		fields: ["assessmenttemplatesubcategoryid","subcategory"] ,
		order: "subcategory",
	   // where:{activeflag: 1},
	   where:{activeflag:1} ,
		 include:[{
			 relation:"assessmenttemplatecategoryfilter",
			 scope: {
				where: {
					and: [{activeflag:1,assessmenttemplatecategoryid: request.where.categoryid}]
				  }  
				
			 }
		 }],
		 groupby:"assessmenttemplatesubcategoryid"
	 }
   ) .catch(err => LOGGER.error(err));  
}
   Assessmenttemplatecategoryfilter.remoteMethod('assessmentcategory', {
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
Assessmenttemplatecategoryfilter.remoteMethod('assessmentsubcategory', {
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

Assessmenttemplatecategoryfilter.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Assessmenttemplatecategoryfilter.observe('access', (ctx, next) => util.access(ctx, next));
Assessmenttemplatecategoryfilter.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
