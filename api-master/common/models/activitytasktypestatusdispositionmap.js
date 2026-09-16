'use strict';
const LOGGER = require("log4js").getLogger("activitytasktypestatusdispositionmap");
const util = require('../utils/utils');

module.exports = function(Activitytasktypestatusdispositionmap) {

    Activitytasktypestatusdispositionmap.investigationdisposition = function(request) {
		return Activitytasktypestatusdispositionmap.find( {
            fields: ['activitytasktypestatusdispositionmapid','activitytasktypekey','activitytaskstatustypekey','activitytaskdispositiontypekey','activeflag'],
		   where: {
			   and: [{activeflag:1},{activitytasktypekey:request.where.activitytasktypekey},{activitytaskstatustypekey:request.where.activitytaskstatustypekey}]
             },
             include : [{
                relation:'activitytasktype',
                where :{
                 and: [{activeflag:1},{activitytypekey:request.where.activitytypekey}]
               },
                scope:{
                 fields:['activitytasktypekey','activitytypekey','activeflag','typedescription']
                }
            },
            {
                relation:'activitytaskstatustype',
                where :{
                    and: [{activeflag:1},{activitytypekey:request.where.activitytypekey}]
                  },
                  scope:{
                   fields:['activitytaskstatustypekey','activitytypekey','activeflag','typedescription']
                  }
            },
            {
                relation:'activitytaskdispositiontype',
                where :{
                    and: [{activeflag:1},{activitytypekey:request.where.activitytypekey}]
                  },
                  scope:{
                   fields:['activitytaskdispositiontypekey','activitytypekey','activeflag','typedescription']
                  }
            }]
        
		 })
       .then (data=> {
        const activitytasktypestatusdispositionmaps = JSON.parse(JSON.stringify(data));
         return activitytasktypestatusdispositionmaps.map(activitytaskdispositiontypes => activitytaskdispositiontypes.activitytaskdispositiontype)
         .reduce((a,b) => a.concat(b), []);
         
     })
       .catch(err => LOGGER.error(err));  
   }

   Activitytasktypestatusdispositionmap.remoteMethod('investigationdisposition', {
	accepts : {
		arg : 'filter',
		type : 'Object',
		http : {
			source : 'query'
		},
		required : true
	},
    http: {"verb": "get", "path": "/investigationdisposition/list"},
	returns : {
		type : 'object',
		root : true
	}
});

Activitytasktypestatusdispositionmap.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Activitytasktypestatusdispositionmap.observe('access', (ctx, next) => util.access(ctx, next));
Activitytasktypestatusdispositionmap.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
