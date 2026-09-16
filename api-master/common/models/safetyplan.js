'use strict';
const LOGGER = require("log4js").getLogger("safetyplan");
const util = require('../utils/utils');
var app = require('../../server/server');
var uuid = require('node-uuid');
module.exports = function (Safetyplan) {

  Safetyplan.add = function (request,reqctx) {
    const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
    const prs = [];
    var securityusersid = suserid;
    return app.models.Assessmenttemplate.find({
      where: {
        external_templateid: request.external_templateid
      }
    }).then(res => {

      if (res.length > 0) {
      if (request.safetyplanid != null && request.safetyplanid !== undefined && request.safetyplanid.length !== 0) {
        var safetyplanid = request.safetyplanid;

        /*Update existing  Plan */
        return Safetyplan.updatesafetyplan(safetyplanid,request);

    } else {
      const result = JSON.parse(JSON.stringify(res));
      Safetyplan.find({
        fields: ['safetyplanid'],
        where: {
          and: [{ external_templateid: request.external_templateid }, { intakeserviceid: request.intakeserviceid }, { activeflag: 1 }]
        }
      })
        .then(data => {
          const res1 = JSON.parse(JSON.stringify(data));
          res1.map(action => {

            var sql = "SELECT * FROM updatesafetyplan($1,$2,$3)";
            util.executeDBQuery(sql, [action.safetyplanid,request.external_templateid,request.intakeserviceid])
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
          });
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        })

      request.assessmenttemplateid = result[0].assessmenttemplateid;

      var versionid = uuid();


      var dangerinfulence= {};
      dangerinfulence.versionid = versionid;
      dangerinfulence.intakeserviceid = request.intakeserviceid;
      dangerinfulence.external_templateid = request.external_templateid;
      dangerinfulence.plandate = request.plandate;
      dangerinfulence.assessmenttemplateid = request.assessmenttemplateid;
      dangerinfulence.submissionid = request.submissionid;
      dangerinfulence.status = request.status;
      dangerinfulence.savemode = request.savemode;
      dangerinfulence.insertedby = securityusersid;
      dangerinfulence.insertedon = new Date().toLocaleString();
      dangerinfulence.updatedon = new Date().toLocaleString();
     return Safetyplan.create(dangerinfulence)
        .then(data => {
         request.dangerinfluence.map(at =>
          prs.push(
            app.models.Safetyplanaction.create({
            safetyplanid: data.safetyplanid,
            actiondescription: at.actiondescription,
            dangerinfluencenumber: at.dangerinfluencenumber,
            dangerinfluencedesc: at.dangerinfluencedesc,
            completiondate: at.completiondate,
            partiesname: at.partiesname,
            reevaluationdate: at.reevaluationdate,
            insertedby: securityusersid,
            updatedby: securityusersid,
            insertedon: new Date().toLocaleString(),
            updatedon: new Date().toLocaleString()
          }).catch(err => LOGGER.error(err)))
        )
       request.safetyplanactor.map(actor =>
        prs.push(
          app.models.Safetyplanactor.create({
            safetyplanid: data.safetyplanid,
            intakeservicerequestactorid: actor.intakeservicerequestactorid,
            issignrefuse: actor.issignrefuse,
            signimage: actor.signimage,
            insertedby: securityusersid,
            updatedby: securityusersid,
            insertedon: new Date().toLocaleString(),
            updatedon: new Date().toLocaleString()
          }).catch(err => LOGGER.error(err)))
        )
          return Promise.all(prs);
        }).catch(error => { return error; });
    }
    }
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });

  }

  Safetyplan.remoteMethod('add', {
    http: {
      path: '/add',
      verb: 'post'
    },
    accepts: [{
      arg: '', type: 'object',
      http: { source: 'body' }
    },{
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
    }],
    returns: {
      type: 'object',
      root: true
    }
  });

  Safetyplan.updatesafetyplan = (id, data,reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 

    var prs = [];
    var securityusersid = (data && data.securityuserid?data.securityuserid: suserid);
    var safetyplanid =id;
    /* 0 - draft save
       1 - Actual save */
    return Safetyplan.updateAll({ safetyplanid: safetyplanid },
        {
          versionid : data.versionid,
          intakeserviceid : data.intakeserviceid,
          external_templateid : data.external_templateid,
          plandate : data.plandate,
          assessmenttemplateid : data.assessmenttemplateid,
          submissionid : data.submissionid,
          status : data.status,
          savemode : data.savemode,
          updatedby : securityusersid,
            updatedon: new Date().toLocaleString()
        }).then(plan => {
          var sql = "SELECT * FROM updatesafetyplan($1)";

          util.executeDBQuery(sql, [safetyplanid])
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });

          if (Array.isArray(data.dangerinfluence)) {
              data.dangerinfluence.map(at =>
              prs.push(
              app.models.Safetyplanaction.create({
              safetyplanid: safetyplanid,
              actiondescription: at.actiondescription,
              dangerinfluencenumber: at.dangerinfluencenumber,
              dangerinfluencedesc: at.dangerinfluencedesc,
              completiondate: at.completiondate,
              partiesname: at.partiesname,
              reevaluationdate: at.reevaluationdate,
              insertedby: securityusersid,
              updatedby:securityusersid,
              insertedon: new Date().toLocaleString(),
            updatedon: new Date().toLocaleString()
            }).catch(error => { return error; }))
          ) }

          if (Array.isArray(data.safetyplanactor)) {
            data.safetyplanactor.map(actor =>
              prs.push(
              app.models.Safetyplanactor.create({
              safetyplanid: safetyplanid,
              intakeservicerequestactorid: actor.intakeservicerequestactorid,
              signimage: actor.signimage,
              issignrefuse:actor.issignrefuse,
              insertedby: securityusersid,
              updatedby: securityusersid,
              insertedon: new Date().toLocaleString(),
            updatedon: new Date().toLocaleString()
            }).catch(error => { return error; })
          ));
          }
          
          return Promise.all(prs);
        }).catch(error => { return error; });


  }
  Safetyplan.remoteMethod('updatesafetyplan', {
    http: {
      path: '/updatesafetyplan/:id',
      verb: 'patch'
    },
    accepts: [
      {
        arg: 'id',
        type: 'data',
        required: true,
        http: { source: 'path' }
      },
      {
        arg: 'data',
        type: 'object',
        http: { source: 'body' }
      },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
    returns: {
      type: 'object',
      root: true
    }
  });

  Safetyplan.remoteMethod('list', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Safetyplan.list = function (request) {
    var sql = 'select * from getsafetyplan($1,$2,$3,$4)';
    LOGGER.debug(sql);
    var params = [request.where.intakeserviceid, request.where.externalid,
    request.page, request.limit];

    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  }




  Safetyplan.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Safetyplan.observe('access', (ctx, next) => util.access(ctx, next));
  Safetyplan.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}
