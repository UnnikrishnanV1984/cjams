'use strict';
const LOGGER = require("log4js").getLogger("agency");

var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Agency) {
	
	Agency.getprovidersearchlist = function(data){
		var newJsonStructure = data.where;
		newJsonStructure["page"] = data.page;
		newJsonStructure["size"] = data.limit;

		Array.prototype.groupBy = function(keyFunction) {
			    var groups = {};
		   this.forEach(function(el) {
			        var key = keyFunction(el);
			        if (key in groups === false) {
			            groups[key] = [];
			        }
			        groups[key].push(el);

			    });
			    return Object.keys(groups).map(function(key) {
			    	LOGGER.debug(key,groups[key]);
			    	return {
			            key: key,
			            values: groups[key]

			        };
			    });
			};
		var sql = 'select * from getprovidersearchlist($1,$2.$3,$4,$5,$6)';
         LOGGER.debug(sql);
		return util.executeDBQuery(sql, [newJsonStructure.agency_name, newJsonStructure.ssbg_, newJsonStructure.type_key, newJsonStructure.fiscal_year, newJsonStructure.size, newJsonStructure.page])
			.then(data1 => data1.groupBy(x => x.agencygroupid))
			.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};
	


		
	Agency.remoteMethod(
		'list', 
				{
				  http: {
						  path: '/list/:id',
						  verb: 'get'
				  },
				  accepts : [ {	
					arg : 'id',
					type : 'string',
					required: true,
					http : {source : 'path'}
				   }, 
					{
					arg : 'filter',
					type : 'object',
					http : {source : 'query'}
					} ],  
					returns: {
						type : 'object',
						  root : true
					} 
				 }
				 
	);


	/* NOSONAR
	Agency.list = function(id,arg,cb){
		LOGGER.debug("Agncylist"+id);
		var ds = server.dataSources.hcuewelfare;		
		 
	 
	 var sql = 'select * from getagencylist(\''+id+'\','+arg.limit+
	 ','+arg.page+')';  
		
		LOGGER.debug("SQL : "+sql);
		ds.connector.execute(sql, 
			  function(err, data){
				   if(err) {return cb(err);}
			     LOGGER.debug(data+ "data");
				 cb(null, data);
		   });
		 
 }*/
	Agency.list = (id ,arg)=>{
		const skip = (arg.page - 1) * arg.limit;
		const limit = arg.limit;
		 return server.models.Agency.find({where:{agencyid:id },
			fields:['agencyid'],
			skip: skip,
			limit: limit,
			include:{
				relation:'intakeservicerequestagency',
				where:{activeflag:true},
				scope:{
					fields:['agencyid','intakeserviceid'],
				  include:{
					  relation:'intakeservicerequest',
					  where:{activeflag:true},
					  scope:{	
						  fields:['intakeserviceid'],
						  include:{
						relation:'intakeservicerequestactor',
					  scope:{
							fields:['intakeserviceid','actorid'],
							include:{
								relation:'actor',
								where:{and:[{activeflag:true},{actortype:{inq:["RA","RC"]}}]},
								scope:{
									fields:['personid','actorid','actortype'],
									include:{
											relation:'Person',
											scope:{
												fields:['personid','firstname','lastname']
											}
									}
								}
							}
						}
					}
				}	
				  }
					
				}
			}
		}).catch(err => err);
	}
		
		Agency.remoteMethod(
				'getprovidersearchlist', 
					    {
					      http: {
					      		path: '/getprovidersearchlist',
					      		verb: 'post'
					      },
					     accepts : [ {arg : 'data',type : 'object',
					     		http : {source : 'body'}} ],   
					      returns: {
					    	  type : 'object',
								root : true
					      }
					     }
			);


			
		Agency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Agency.observe('access', (ctx, next) => util.access(ctx, next));
		Agency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
