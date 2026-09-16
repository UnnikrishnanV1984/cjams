'use strict';
const LOGGER = require("log4js").getLogger("amgoalstatus");
const util = require('../utils/utils');

module.exports = function(Amgoalstatus) {

    Amgoalstatus.investigationgoaldisposition = function(request) {
      return Amgoalstatus.find({
          fields: ['amgoalstatusid','activitygoaltypekey','activitygoalstatustypekey','activeflag'],
         where: {
             and: [{activeflag:1},{activitygoaltypekey:request.where.activitygoaltypekey},{activitygoalstatustypekey:request.where.activitygoalstatustypekey}]
           },
           include : {
              relation:'amgoaldisposition',
              scope:{
                where :{
                    and: [{activeflag:1}]
                  },
               fields:['amgoaldispositionid','amgoalstatusid','activeflag','activitygoaldispositiontypekey','availabletouser'],
               include :{
                relation:'activitygoaldispositiontype',
                scope:{
                    where :{
                        and: [{activeflag:1}]
                      },
                      fields:['activitygoaldispositiontypekey','activitytypekey','activeflag','typedescription']
                }
            }
        }
    }
}
 )
 .then (data=> {
    const amgoalstatuses = JSON.parse(JSON.stringify(data));
     return amgoalstatuses.map(amgoalstatus => amgoalstatus.amgoaldisposition.map(agdisposition=> agdisposition.activitygoaldispositiontype))
     .reduce((a,b) => a.concat(b), []);
     
 })
 .catch(err => LOGGER.error(err));  
}

 Amgoalstatus.remoteMethod('investigationgoaldisposition', {
  accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
          source : 'query'
      },
      required : true
  },
  http: {"verb": "get", "path": "/investigationgoaldisposition/list"},
  returns : {
      type : 'object',
      root : true
  }
});

Amgoalstatus.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Amgoalstatus.observe('access', (ctx, next) => util.access(ctx, next));
Amgoalstatus.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
