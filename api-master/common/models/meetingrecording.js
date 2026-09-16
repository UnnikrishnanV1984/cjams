'use strict';
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("Meetingrecording");
var app = require('../../server/server');
const { now } = require('moment-timezone');
var config = require('../../server/config.json');
module.exports = function (Meetingrecording) {


  Meetingrecording.addupdate = function (request, reqctx) {
		const _securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;  
    let prs = [];

    if (request.meetingrecordingid == null || request.meetingrecordingid == undefined) {
      return Meetingrecording.create({
        servicecaseid: request.servicecaseid,
        intakeserviceid: request.intakeserviceid,
        adoptioncaseid: request.adoptioncaseid,
        meetingdate: request.meetingdate,
        meetingtypekey: request.meetingtypekey,
        persontype: request.persontype,
        personname: request.personname,
        meetingdescription: request.meetingdescription,
        meetingcomments: request.meetingcomments,
        isfollowupmeeting: request.isfollowupmeeting,
        parentmeetingid: request.parentmeetingid,
        iscompleted: request.iscompleted,
        ismeetingdecision: request.ismeetingdecision,
        followupdate: request.followupdate,
        meetingdecision: request.meetingdecision,
        placementid: request.placementid,
        insertedby: _securityusersid,
        updatedon:now(),
        updatedby: _securityusersid  
      }).then(data =>
        util.executeDBQuery("SELECT * FROM cjams.updatedocumentproperties($1,$2::json,$3,$4,$5,$6)", [null, JSON.stringify(request.uploadedfile),data.meetingrecordingid,'meetingrecording', null,_securityusersid])
          .then(() => data)
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          })
      ).then(data => {
        prs = createMeetingPromises(request, data.meetingrecordingid, _securityusersid, prs);
        return Promise.all(prs);
      })
    }
    else {

      return Meetingrecording.updateAll({ meetingrecordingid: request.meetingrecordingid },
        {
          servicecaseid: request.servicecaseid,
          intakeserviceid: request.intakeserviceid,
          adoptioncaseid: request.adoptioncaseid,
          meetingdate: request.meetingdate,
          meetingtypekey: request.meetingtypekey,
          persontype: request.persontype,
          personname: request.personname,
          meetingdescription: request.meetingdescription,
          meetingcomments: request.meetingcomments,
          isfollowupmeeting: request.isfollowupmeeting,
          parentmeetingid: request.parentmeetingid,
          iscompleted: request.iscompleted,
          uploadedfile: null,
          ismeetingdecision: request.ismeetingdecision,
          followupdate: request.followupdate,
          meetingdecision: request.meetingdecision,
          placementid: request.placementid,
          updatedby: _securityusersid,
        }).then(data => {
          return util.executeDBQuery("SELECT * FROM updatemeetingrecord($1,$2)",[request.meetingrecordingid,_securityusersid])
          .then(_data => {
              return _data;
          })
          .catch(err => {
              LOGGER.error(err);
              return err;
          })
        }).then(data => {
          return util.executeDBQuery("SELECT * FROM cjams.updatedocumentproperties($1,$2::json,$3,$4,$5,$6)", [null, JSON.stringify(request.uploadedfile),request.meetingrecordingid,'meetingrecording', null, _securityusersid])
          .then(_data => {
            return _data;
          })
          .catch(err => {
              LOGGER.error(err)
              return err;
          })
        }).then(data => {
            prs = createMeetingPromises(request, request.meetingrecordingid, _securityusersid, prs);
            return Promise.all(prs);
          })
    }
  }

  function createMeetingPromises(request, meetingrecordingid, _securityusersid, prs){
    if (Array.isArray(request.meetingrecordingactor)) {
      request.meetingrecordingactor.map(actor => {
        prs.push(app.models.Meetingrecordingactor.create({
          meetingrecordingid: meetingrecordingid,
          intakeservicerequestactorid: actor.intakeservicerequestactorid,
          adoptioncaseactorid: actor.adoptioncaseactorid,
          personid: actor.personid,
          insertedby: _securityusersid,
          updatedby: _securityusersid,
          updatedon:now()
        })
        )
      });
    }

    if (Array.isArray(request.meetingparticipants)) {
      request.meetingparticipants.map(participant => {
        prs.push(app.models.Meetingparticipants.create({
          meetingrecordingid: meetingrecordingid,
          participanttype: participant.participanttype,
          participantkey: participant.participantkey,
          participantroledesc: participant.participantroledesc,
          firstname: participant.firstname,
          lastname: participant.lastname,
          emailid: participant.emailid,
          personid: participant.personid,
          isinvited: participant.isinvited,
          isattended: participant.isattended,
          electronicsignature: participant.electronicsignature,
          isaccpted: participant.isaccpted,
          insertedby: _securityusersid,
          updatedby: _securityusersid  
        })
        )
      });
    }
    if(Array.isArray(request.hearingdetails)){
      request.hearingdetails.map(hearingdetails => {
        prs.push(app.models.meetingrecordinghearingdetail.create({
          meetingrecordingid: meetingrecordingid,
          clientid: hearingdetails.clientid,
          intakeservicerequestcourthearingid: ( hearingdetails && hearingdetails.hearingdetails ? hearingdetails.hearingdetails:null),
          insertedby: _securityusersid,
          updatedon:now(),
          updatedby: _securityusersid  
        })
        )
      });

    }
    if (Array.isArray(request.fimtype)) {
      request.fimtype.map(fim => {
        prs.push(app.models.Meetingfimdetails.create({
          meetingrecordingid: meetingrecordingid,
          familymeetingtypekey: fim.familymeetingtypekey,
          familymeetingsubtypekey: fim.familymeetingsubtypekey,
          insertedby: _securityusersid,
          updatedby: _securityusersid  
        })
        )
      });
    }
    return prs;
  }

  Meetingrecording.remoteMethod(
    'addupdate',
    {
      http: {
        path: '/addupdate',
        verb: 'post'
      },
      accepts: [{
        arg: 'data', type: 'object',
        http: { source: 'body' }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    });


  Meetingrecording.getfimdetails = function (request) { // NOSONAR
    var page = request.page;
    var limit = request.limit;
    var sql;
    const iscaseexpunged  = request.where.iscaseexpunged ?? 0;
      sql = 'select * from getfimdetails($1,$2,$3,$4,$5)';
    if (request.where.objecttype === 'servicecase') {
      request.where.intakeserviceid = request.where.objectid;
      sql = 'select * from getservicecasefimdetails($1,$2,$3)';
    }
    if (request.where.objecttype === 'adoptioncase') {
      request.where.adoptioncaseid = request.where.objectid;
      sql = 'select * from getadoptioncasefimdetails($1,$2,$3)';
    }
      return util.executeSecondaryNodeDBQuery(sql, request.where.objecttype==='servicecase'||request.where.objecttype==='adoptioncase'?[request.where.intakeserviceid,page,limit]:[request.where.intakeserviceid,page,limit,request.where.isExpungementSuperUser,iscaseexpunged])
      .then(data => {
          let getservicecasefimdetails = null;
          let getadoptioncasefimdetails = null;
          let getfimdetails = null;
          if(data){
            getservicecasefimdetails = data[0].getservicecasefimdetails;
            getadoptioncasefimdetails =  data[0].getadoptioncasefimdetails;
            getfimdetails = data[0].getfimdetails;
          }
          if (request.where.objecttype === 'servicecase') {
           return {
              'data': getservicecasefimdetails,
              'totalCount': getCount(getservicecasefimdetails)
            };
          }
          else if (request.where.objecttype === 'adoptioncase') {
            return {
              'data': getadoptioncasefimdetails,
              'totalCount': getCount(getadoptioncasefimdetails)
            };
          }
          else {
            return {
              'data': getfimdetails,
              'totalCount': getCount(getfimdetails)
            };
          }
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };
  

  function getCount(value) {
    return value?.length > 0 ? value[0].totalCount : 0;
  }

  Meetingrecording.remoteMethod('getfimdetails', {
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
  Meetingrecording.remoteMethod('gethearingdetails', {
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
  Meetingrecording.gethearingdetails = function (request) {
    var sql;
      request.where.intakeserviceid = request.where.objectid;
      sql = 'select * from cjams.getlisthearingdetails($1,$2,$3,$4)';
    var params = [request.where.objecttypekey,request.where.meetingidforload, request.where.servicecaseid,request.where.meetingdate];

    return util.executeDBQuery(sql, params)
      .then(data => {
          return data;
      })
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
      });

  };

  Meetingrecording.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Meetingrecording.observe('access', (ctx, next) => util.access(ctx, next));
  Meetingrecording.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
