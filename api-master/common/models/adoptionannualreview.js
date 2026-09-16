'use strict';
const LOGGER = require("log4js").getLogger("adoptionannualreview");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Adoptionannualreview) {

  Adoptionannualreview.remoteMethod('addupdate', {
    http: {
      path: '/addupdate',
      verb: 'post'
    },
    accepts: [{
      arg: 'data',
      type: 'object',
      http: {
        source: 'body'
      }
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
  Adoptionannualreview.addupdate = (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    if (request.adoptionannualreviewid !== undefined && request.adoptionannualreviewid !== null) {
      return Adoptionannualreview.updateadoptionannualreview(request, _securityusersid);
    } else {
      return Adoptionannualreview.addadoptionannualreview(request, _securityusersid);
    }
  }

  Adoptionannualreview.updateadoptionannualreview = (request, _securityusersid) => {
    return Adoptionannualreview.updateAll(
      { adoptionannualreviewid: request.adoptionannualreviewid },
      {
        adoptioncaseid: request.adoptioncaseid,
        reviewdate: request.reviewdate,
        ischilddisability: request.ischilddisability,
        ischildspecialneed: request.ischildspecialneed,
        isparentlegalresponsible: request.isparentlegalresponsible,
        isrenewalsigned: request.isrenewalsigned,
        isfinancialsupport: request.isfinancialsupport,
        ischildenrolledschool: request.ischildenrolledschool,
        isdoumentationimmurization: request.isdoumentationimmurization,
        ischildschoolemployeedisabled: request.ischildschoolemployeedisabled,
        iscompletesecondaryeducation: request.iscompletesecondaryeducation,
        isenrolledinstitution: request.isenrolledinstitution,
        isparticipatingemployement: request.isparticipatingemployement,
        isemployeehrspermonth: request.isemployeehrspermonth,
        isincapableactivities: request.isincapableactivities,
        adoptiveparentonedate: request.adoptiveparentonedate,
        adoptiveparenttwodate: request.adoptiveparenttwodate,
        ldssdirectorsigndate: request.ldssdirectorsigndate,
        disabilitynotes: request.disabilitynotes,
        notes: request.notes,
        updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)
      }).then(resp => {
        var status = 15;
        var nofitymsg = 'Adoption Annual Review Submitted for review';
        if (request.intakeserviceid == null && request.intakeserviceid === undefined) {
          request.intakeserviceid = '';
        }
        var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        return util.executeDBQuery(sql, [request.adoptionannualreviewid, (request && request.securityuserid?request.securityuserid: _securityusersid), 'ADYR', status, nofitymsg, '', false, false, false,nofitymsg, '', request.adoptioncaseid,'',1])
          .then(data => data[0].routingintake);
      }).then(data => {
        return data;
      }).catch(err => util.logError(err));
  }

  Adoptionannualreview.addadoptionannualreview = function (request, _securityusersid) {
    return Adoptionannualreview.create({
        adoptioncaseid: request.adoptioncaseid,
        reviewdate: request.reviewdate,
        ischilddisability: request.ischilddisability,
        ischildspecialneed: request.ischildspecialneed,
        isparentlegalresponsible: request.isparentlegalresponsible,
        isrenewalsigned: request.isrenewalsigned,
        isfinancialsupport: request.isfinancialsupport,
        ischildenrolledschool: request.ischildenrolledschool,
        isdoumentationimmurization: request.isdoumentationimmurization,
        ischildschoolemployeedisabled: request.ischildschoolemployeedisabled,
        iscompletesecondaryeducation: request.iscompletesecondaryeducation,
        isenrolledinstitution: request.isenrolledinstitution,
        isparticipatingemployement: request.isparticipatingemployement,
        isemployeehrspermonth: request.isemployeehrspermonth,
        isincapableactivities: request.isincapableactivities,
        adoptiveparentonedate: request.adoptiveparentonedate,
        adoptiveparenttwodate: request.adoptiveparenttwodate,
        ldssdirectorsigndate: request.ldssdirectorsigndate,
        disabilitynotes: request.disabilitynotes,
        notes: request.notes,
        insertedby: request && request.securityuserid ? request.securityuserid : _securityusersid,
				updatedby: request && request.securityuserid ? request.securityuserid : _securityusersid
    }).then(resp => {
      var status = 15;
      var nofitymsg = 'Adoption Annual Review Submitted for review';
      var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
      return util.executeDBQuery(sql, [resp.adoptionannualreviewid, (request && request.securityuserid?request.securityuserid: _securityusersid), 'ADYR', status, nofitymsg, '', false, false, false, nofitymsg, '', request.adoptioncaseid,'',1])
        .then(data => data[0].routingintake);
    }).then(data => {
      return data;
    }).catch(err => util.logError(err));
  };

  Adoptionannualreview.remoteMethod('list', {
    http: {
      path: '/list',
      verb: 'get'
    },
    accepts: [
      {
        arg: 'filter',
        type: 'object',
        http: { source: 'query' }
      }],
    returns: {
      type: 'object',
      root: true
    }
  });

  Adoptionannualreview.list = (request) => {
    
    var adoptioncaseid = request.where.adoptioncaseid?request.where.adoptioncaseid:null;
    var sql = 'select * from getadoptionannualreview($1)';
    return util.executeDBQuery(sql, [adoptioncaseid])
      .then(datas => datas)
      .catch(err => util.logError(err));
  };

  Adoptionannualreview.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Adoptionannualreview.observe('access', (ctx, next) => util.access(ctx, next));
  Adoptionannualreview.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};