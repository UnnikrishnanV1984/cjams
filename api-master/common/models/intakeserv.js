'use strict';
const LOGGER = require("log4js").getLogger("intakeserv");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Intakeserv) {

    Intakeserv.list = function(request) {

      const IntakeagencyservSearchObj = {
            fields: ['intakeagencyservid', 'intakeservid','activeflag'],
            include:  [{
                relation: 'intakeserv',
            //    where: { activeflag: true },
                scope: {
                    fields: ['description','intakeservtypekey','intakeservid','activeflag'],
                    where: { activeflag: true },
                    nolimit:true,
                    include: [{
                        relation:'intakeservsub',
                     //  where: { activeflag: true },
                        scope: {
                            fields: ['activeflag','intakeservsubtypeid','intakeservid','typedescription','intakeservsubtypekey'],
                            nolimit:true,
                            where: { activeflag: true }
                         }
                    }]
                },
                
              }
              ,{
                  relation: 'agencyservcassessmenttemplatemap',
               //  where: { activeflag: true },
                  scope: {
                      fields: ['activeflag','servcassessmenttemplatemapid','assessmenttemplateid','external_templateid'],
                      nolimit:true
                  }
              } 
          
            ],
            nolimit:true
        }

        if(request.where && request.where.teamtypekey && request.where.teamtypekey !== 'all'){
            var teamtypekey  = request.where.teamtypekey;

        if(request.where.intakeservreqtypeid && request.where.intakeservreqtypeid !== undefined)

           {var intakeservreqtypeid  = request.where.intakeservreqtypeid;}

           IntakeagencyservSearchObj.where ={and:[ { activeflag: true },{teamtypekey:teamtypekey},{intakeservreqtypeid:intakeservreqtypeid}]};
        }

        return app.models.Intakeagencyserv.find(IntakeagencyservSearchObj)
        .then(data => {
            const result = JSON.parse(JSON.stringify(data));
            var respjson =[];
           
            respjson = getResults(result);
          return respjson;
        })
        .catch(err => util.logError(err));
    };

  function getResults(result) {
    const respjson =[];
    result.map(x => {

      var retjson = {};
      if (x.agencyservcassessmenttemplatemap != undefined && x.agencyservcassessmenttemplatemap != null) {
        if (x.agencyservcassessmenttemplatemap.length > 0) {
          retjson.assessmenttemplateid = x.agencyservcassessmenttemplatemap[0].assessmenttemplateid;
          retjson.external_templateid = x.agencyservcassessmenttemplatemap[0].external_templateid;
        }
      }

      let retArr = [];
      if (x.intakeserv && x.intakeserv.intakeservsub.length > 0) {
        retArr = x.intakeserv.intakeservsub.map(v => {
          return v;
        });
      }

      if (x.intakeserv != null) {

        retjson.intakeservsubtype = retArr;
        retjson.intakeservid = x.intakeservid;
        retjson.description = x.intakeserv.description;
        retjson.intakeservtypekey = x.intakeserv.intakeservtypekey;

        //  return retjson;
      }
      LOGGER.debug(retjson);
      if (retjson != null) {
        respjson.push(retjson);
      }
    })
    return respjson;
  }
    Intakeserv.remoteMethod('list', {
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

  
    Intakeserv.remoteMethod('getservicedetails', {
          http: {
            path: '/getservicedetails',
            verb: 'get'
          },
          accepts: {
            arg: 'filter',
            type: 'object',
            http: {
              source: 'query'
            }
          },
          returns: {
            type: 'object',
            root: true
          }
        });

   
    
    Intakeserv.remoteMethod('getservicerequestsubtype', {
        http: {
            path: '/getservicerequestsubtype',
            verb: 'get'
          },
          accepts: {
            arg: 'filter',
            type: 'object',
            http: {
              source: 'query'
            }
          },
          returns: {
            type: 'object',
            root: true
          }
        });

    Intakeserv.getservicedetails  = request => {

        var servicetypeid = request.where.intakeservreqtypeid;

        var sql = 'SELECT * FROM getservicesdetails($1)';

        return util.executeDBQuery(sql, [servicetypeid])
        .then(data => data)
        .catch(err => util.logError(err));
      };


      Intakeserv.getservicerequestsubtype  = request => {

        var sql = 'SELECT * FROM getservicerequestsubtype($1,$2)';

        var servicetypeid = request.where.intakeservreqtypeid;
        var intakeservids = request.where.intakeservid;
        return util.executeDBQuery(sql, [servicetypeid, intakeservids])
          .then(data2 => data2)
          .catch(err2 => util.logError(err2));
        };
      
     

        Intakeserv.getvpadetails = function (request) {
              var personid = request.where.personid;
              var county=request.where.county
          var sql = 'select * from checkvpa ($1,$2)';
          return util.executeDBQuery(sql, [personid,county])
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
        };


        
        Intakeserv.remoteMethod ('getvpadetails',{
      accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
          source : 'query'
        }
      },
      http : {
        verb : 'get'
      },
      returns : {
        type : 'string',
        root : true
      }
    });
  

    Intakeserv.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeserv.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeserv.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};


