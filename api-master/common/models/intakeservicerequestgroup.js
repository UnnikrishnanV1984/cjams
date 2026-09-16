'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestgroup");
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestgroup) {


Intakeservicerequestgroup.grouplist = function(data) {
    LOGGER.debug('function grouplist  .....groupid .....', data.groupid);
     

  
 
     return Intakeservicerequestgroup.find({
            where: {groupid: data.groupid},
            fields: ["groupid", "groupnumber", "groupsummary", "description"],
			//include : ['Intakeservicerequestgroupdetails','Intakeservicerequest']
			include:{  
			         	relation : "Intakeservicerequestgroupdetails",
			         	scope: {
			        		"fields": ["groupdetlid", "groupid", "intakeserviceid"],
                             include: { 
						       		 relation:"Intakeservicerequest", 
						        		scope: {
						         		 "fields": ["intakeserviceid", "servicerequestnumber", "servicerequestincidenttypekey","intakeservreqtypeid"],
							       			 include: { 
							       		 		relation:"Intakeservicerequesttype", 
							        				scope: {
							         				 "fields": ["intakeservreqtypeid"],

							         				 include: { 
							       		 				relation:"Servicerequestsubtype", 
							        						scope: {
							         							 "fields": ["intakeservreqtypeid"],
							       							}
	                                        			}  

							       					}
	                                        }  

	                                        


						       			}
                                    } 
					  	} 
	                }


        })
        .catch(err => LOGGER.error(err));   
     

  };
 

	Intakeservicerequestgroup.remoteMethod('grouplist', {
	   /* accepts : [ {arg : 'data',type : 'Object'} ],
	    description:'List the Intakeservicerequestgroup details',
	    returns : {type : 'Object',root : true},
	    http: {"verb": "get", "path": "/grouplist"}*/

	accepts : [ {arg : 'data',type : 'object',http : {source : 'body'}} ],
    description:'List the Configurablelinks',
    returns : {type : 'object',root : true}

	  });

	  Intakeservicerequestgroup.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	  Intakeservicerequestgroup.observe('access', (ctx, next) => util.access(ctx, next));
	  Intakeservicerequestgroup.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}; 
