'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestsafetyplan");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');
module.exports = function(Intakeservicerequestsafetyplan) {

  Intakeservicerequestsafetyplan.add = function (request) {
    return app.models.Assessmenttemplate.find({
      where: {
        external_templateid: request.external_templateid
      }
    }).then(res => {

        if (res.length > 0)
        {
            const result = JSON.parse(JSON.stringify(res));
            var sql1 = 'UPDATE intakeservicerequestsafetyplan SET activeflag=0 WHERE external_templateid =$1 and intakeserviceid =$2' ;
            return util.executeDBQuery(sql1, [request.external_templateid,request.intakeserviceid])
            .then(() => {
              return Intakeservicerequestsafetyplan.find({
              fields: ['safetyplanid'],
              where: {
                  and: [{ external_templateid: request.external_templateid }, { intakeserviceid: request.intakeserviceid },{activeflag:1}]
              }
              });
            })
            .then(data => {
                const res1 = JSON.parse(JSON.stringify(data));
                return Promise.all(res1.map(action => {
                    var sql2 = 'UPDATE intakeservicerequestsafetyplanaction SET activeflag=0 WHERE safetyplanid = $1';
                    return util.executeDBQuery(sql2, [action.safetyplanid]);
                 }));
            })
            .then(() => {

        request.assessmenttemplateid = result[0].assessmenttemplateid;

       var versionid = uuid();
       const reqdangerinfnc = JSON.parse(JSON.stringify( request.dangerinfluence));
       reqdangerinfnc.forEach(dangerinfluence1=>

			 {
          var  dangerinfulence = dangerinfluence1;
          dangerinfulence.versionid = versionid;
          dangerinfulence.intakeserviceid = request.intakeserviceid;
          dangerinfulence.external_templateid = request.external_templateid;
          dangerinfulence.plandate = request.plandate;
          dangerinfulence.assessmenttemplateid = request.assessmenttemplateid;
          dangerinfulence.submissionid  = request.submissionid;
          Intakeservicerequestsafetyplan.create(dangerinfulence)
          .then(data => {
            var reqaction = dangerinfulence.action
            var prs = reqaction.map(at => app.models.Intakeservicerequestsafetyplanaction.create({
              safetyplanid: data.safetyplanid,
              actiondescription: at.actiondescription
            }));
            return Promise.all(prs);
          })
         });
         return "Success"
            });
      }
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });
  }

Intakeservicerequestsafetyplan.remoteMethod('add', {
  http: {
          path: '/add',
          verb: 'post'
  },
  accepts : [ {arg : '',type : 'object',
      http : {source : 'body'}} ],
  returns: {
      type : 'object',
      root : true
  }
});


Intakeservicerequestsafetyplan.remoteMethod('list', {
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
        type : 'Object',
        root : true
    }
});

Intakeservicerequestsafetyplan.list = function(request) {
    var sql = 'select * from getsafetyplan($1,$2,$3,$4)';
    LOGGER.debug(sql);
    return util.executeDBQuery(sql, [request.where.intakeserviceid, request.where.externalid,
        request.page,request.limit])
      .then(data => {
          return data;
      })
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
      });
}



    Intakeservicerequestsafetyplan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestsafetyplan.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestsafetyplan.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
