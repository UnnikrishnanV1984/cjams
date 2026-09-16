'use strict';
const LOGGER = require("log4js").getLogger("teammemberequipment");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Teammemberequipment) {
	
	Teammemberequipment.remoteMethod('list', {
	        accepts : [{
	                arg: 'id',
	                type: 'string',
	                required: true,
	                http: {source: 'path'}
	            }
	            
	   ],
	        http: {"verb": "get", "path": "/list/:id"},
			returns : {
				type : 'Object',
				root : true
			}
	    });
	
	
	Teammemberequipment.list = (id) => (Teammemberequipment.findById(id, {
         
		 where: {activeflag: true},
		fields: [ 'equipmentid','teammemberid','teammemberequipmentid'],
		
        include:[
        	
        	{
        	 relation: 'teammember',
             scope: {
            	 fields: ['loadnumber','positioncode','effectivedate','teammemberid','teamid','roletypekey'],
                 where: {activeflag: true},
                 include:[{
                     relation: 'team',
                     where: {activeflag: true},
                     scope: {
                    	 fields: [ 'name', 'teamnumber','region','teamid'],
                    	 
                     }
                 },
                   {
                       relation: 'teammemberroletype',
                       where: {activeflag: true},
                       scope: {
                      	 fields: [ 'roletypekey'],
                      	 
                       }
                   },
                   {
                 		 relation: 'teammemberassignment',
                        
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
                                     		 fields: ['securityuserid','firstname','lastname','displayname','fullname','orgname','orgnumber'],	
                                     	 }
                                      }
                             	    }
                             	 }
                         	  }
                 	 }
                   ]}
        	},
                   {
                       relation: 'equipment',
                       where: {activeflag: true},
                       scope: {
                         	   fields: ['equipmentid','activeflag','equipmenttypekey','description','manufacturer','locationcode','model','serialnumber','whitetagnumber','yellowtagnumber','sutnumber','roomnumber','comments','primarymachine' ,'found','transfer','upforreplacement','disposed','dh60date','unit'],
                      	 
                       }
                   },
                   ]
             })
        );
	
	Teammemberequipment.remoteMethod(
			'add', 
			{
				accepts : {
					arg : 'data',
					type : 'object',
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

          Teammemberequipment.add = function(req){
				return app.models.Teammember.findOne({
			  	          	where : {
			  			      positioncode : req.positioncode
			  	                 	}})
						.then(result => {
							return Teammemberequipment.updateAll ({equipmentid:req.equipmentid}, {activeflag:0})
							.then(res => {
								return Teammemberequipment.create ({equipmentid:req.equipmentid,teammemberid:result.teammemberid,activeflag:req.activeflag,insertedby:req.insertedby,updatedby:req.updatedby,effectivedate:req.effectivedate})
								.then(object => {
									LOGGER.debug("inside teammemberequipment create");
									return object;
								});
							});
						})
						.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

                           };
                           
                         Teammemberequipment.remoteMethod('assignlist', {
                   	        accepts : [
                   	        	{
                   	        	   arg: 'id',
                  	                type: 'string',
                  	                required: true,
                  	                http: {source: 'path'}
                   	        	},
                   	         {
                   	                arg: 'filter',
                   	                type: 'Object',
                   	                required: true,
                   	                http: {source: 'query'}
                   	            },
                   	   ],
                   	        http: {"verb": "get", "path": "/assignlist/:id"},
                   	     returns: {
					    	  type : 'object',
								root : true
					      }
                   	    });

                        Teammemberequipment.assignlist = function(id,req){

                        	var sql = 'SELECT * from getassignmentlist($1,$2,$3)';
                        	LOGGER.debug(sql);
                        	return util.executeDBQuery(sql, [id,req.limit,req.page])
                        	.then(data => {
                        		LOGGER.debug(data);
                        		return data;
                        	})
                        	.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
						};
                        		        
		Teammemberequipment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Teammemberequipment.observe('access', (ctx, next) => util.access(ctx, next));
		Teammemberequipment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
													   
}
