'use strict';
const LOGGER = require("log4js").getLogger("teammemberassignment");
const util = require('../utils/utils');
module.exports = function(Teammemberassignment) {

    Teammemberassignment.investigationplanassignto = function(request) {
    
        const nolimit = request.nolimit
      return Teammemberassignment.find( {
          fields: ['teammemberassignmentid','activeflag','teammemberid','securityusersid'],
         where: {activeflag:true},nolimit:nolimit,
           include : [{
              relation:'teammember',
              scope:{
               fields:['teammemberid','activeflag','teamid','loadnumber','positioncode'],
               nolimit:nolimit
              }
           },
           {
            relation:'userprofile',
            where :{
                and: [{activeflag:1}]
              },
              scope:{
               fields:['securityusersid','firstname','lastname','displayname','fullname','activeflag'],
               nolimit:nolimit
              }
        } 
        ]
       })

       .then (data=> {
        const teammemberassignments = JSON.parse(JSON.stringify(data));
        teammemberassignments.forEach(x => {
            Object.assign(x, x.teammember);
            Object.assign(x, x.userprofile);
            delete x.teammember;
            delete x.userprofile;
        })
        return  teammemberassignments;
     })

     .catch(err => LOGGER.error(err));  
 }

 Teammemberassignment.remoteMethod('investigationplanassignto', {
  accepts : {
      arg : 'filter',
      type : 'Object',
      http : {
          source : 'query'
      },
      required : false
  },
  http: {"verb": "get", "path": "/investigationplanassignto/list"},
  returns : {
      type : 'object',
      root : true
  }
});
Teammemberassignment.add = function(request){
    return Teammemberassignment.findOne(
        {where:{teammemberid:request.teammemberid}}
    ).then(data => {
       return Teammemberassignment.updateAll({teammemberid:request.teammemberid},{activeflag:0})
    }).then(list => Teammemberassignment.create(request)
    ).then(res => res)
      .catch(err => err)
}

Teammemberassignment.remoteMethod('add', {
    accepts : {
        arg : 'data',
        type : 'object',
        http : {
            source : 'body'
        },
        required : true
    },
    http: {"verb": "post", "path": "/add"},
    returns : {
        type : 'object',
        root : true
    }
  });   

Teammemberassignment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Teammemberassignment.observe('access', (ctx, next) => util.access(ctx, next));
Teammemberassignment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
