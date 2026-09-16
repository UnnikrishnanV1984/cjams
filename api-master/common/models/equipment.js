'use strict';
const LOGGER = require("log4js").getLogger("equipment");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Equipment) {
	
	   Equipment.addupdate= function(request) {
			return Equipment.find(request)
				.then(function(res){
					if(request.equipmentid === 'undefined' && request.equipmentid !== null) {
						LOGGER.debug((request.equipmentid + "(res.length"));
						return Equipment.create(request);
					}else if (request.equipmentid !== 'undefined'){
						LOGGER.debug((request.equipmentid ));
						return Equipment.upsert({equipmentid:request.equipmentid,activeflag:request.activeflag,equipmenttypekey:request.equipmenttypekey,description:request.description,manufacturer:request.manufacturer,locationcode:request.locationcode,model:request.model,serialnumber:request.serialnumber,whitetagnumber:request.whitetagnumber,yellowtagnumber:request.yellowtagnumber,itponumber:request.sutnumber, physicallocation:request.roomnumber, comments:request.comments, primarymachine:request.primarymachine,found:request.found,notfound:request.notfound,transfer:request.transfer,upforreplacement:request.upforreplacement,disposed:request.disposed,dh60date:request.dh60date,unit:request.unit,updatedby:request.updatedby,insertedby:request.insertedby,effectivedate:request.effectivedate });
			        }
				})
				.catch(_err => {
					LOGGER.error('>>>>ERROR:', _err);
					throw _err;
				});

 };
 
 
		
 Equipment.remoteMethod(
			'addupdate', 
				    {
				      http: {
				      		path: '/add',
				      		verb: 'post'
				      },
				     accepts : [ {arg : 'data',type : 'object',
				     		http : {source : 'body'}} ],   
				      returns: {
				    	  type : 'object',
							root : true
				      }
				    
			});
	  Equipment.remoteMethod(
				'addupdate', 
					    {
					      http: {
					      		path: '/update',
					      		verb: 'put'
					      },
					     accepts : [ {arg : 'data',type : 'object',
					     		http : {source : 'body'}} ],   
					      returns: {
					    	  type : 'object',
								root : true
					      }
					    
				});
	  Equipment.list = function(id,arg){
		 	var sql = 'SELECT * FROM equipment WHERE equipmentid IN (SELECT equipmentid   FROM  teammemberequipment  WHERE  teammemberid = \''+id+'\')' ;
			return util.executeDBQuery(sql, [])
				.then(data => {
					LOGGER.debug( data);
					return data;
				})
				.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};

	

	  Equipment.remoteMethod('list', {
	         accepts : [{
	                 arg: 'id',
	                 type: 'string',
	                 required: true,
	                 http: {source: 'path'}
	             },
	             {
	                 arg: 'filter',
	                 type: 'Object',
	                 required: false,
	                 http: {source: 'query'}
	             }
	             
	    ],
	         http: {"verb": "get", "path": "/list/:id"},
	 		returns : {
	 			type : 'Object',
	 			root : true
	 		}
	     }); 
	     
		 Equipment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		 Equipment.observe('access', (ctx, next) => util.access(ctx, next));
		 Equipment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};	
