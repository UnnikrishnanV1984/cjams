'use strict';
const LOGGER = require("log4js").getLogger("equipmenttype");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Equipmenttype) {
	
	
		Equipmenttype.getequipmentlist = function(data){
			var sql;

			var newJsonStructure = data.where;
			newJsonStructure["page"] = data.page;
			newJsonStructure["size"] = data.limit;

			sql = 'select * from getequipmentlist($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13)';

			return util.executeDBQuery(sql, [newJsonStructure.typekey,newJsonStructure.manufactur,newJsonStructure.model,newJsonStructure.serialno,newJsonStructure.whitetagnumber,newJsonStructure.yellowtagno,newJsonStructure.loadno,newJsonStructure.organisationno,newJsonStructure.found,newJsonStructure.disposed,newJsonStructure.upforrep,newJsonStructure.size,newJsonStructure.page])
				.then(_data => {
					LOGGER.debug( _data[0].getequipmentlist[0]);
					return _data[0].getequipmentlist[0];
				})
				.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};

		Equipmenttype.remoteMethod(
					'getequipmentlist', 
						    {
						      http: {
						      		path: '/getequipmentlist',
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

			Equipmenttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
			Equipmenttype.observe('access', (ctx, next) => util.access(ctx, next));
			Equipmenttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

	};

