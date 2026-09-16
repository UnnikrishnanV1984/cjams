'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Adoptioniverenewal) {

  Adoptioniverenewal.remoteMethod('addupdate', {
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
  Adoptioniverenewal.addupdate = (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    if (request.adoptioniverenewalid !== undefined && request.adoptioniverenewalid !== null) {
      return Adoptioniverenewal.updateAdoptioniverenewal(request, _securityusersid);
    } else {
      return Adoptioniverenewal.addAdoptioniverenewal(request, _securityusersid);
    }
  }

  Adoptioniverenewal.updateAdoptioniverenewal = (request, _securityusersid) => {
    var securityuserid = (request.securityuserid?request.securityuserid: _securityusersid);
    var securityusersid = request.securityuserid ? request.securityuserid : securityuserid;
    return Adoptioniverenewal.updateAll(
      { adoptioniverenewalid: request.adoptioniverenewalid },
      {
        adoptionid: request.adoptionid,
        assessmentdate: request.assessmentdate,
        fatheragreementdate: request.fatheragreementdate,
        motheragreementdate: request.motheragreementdate,
        designeeagreementdate: request.designeeagreementdate,
        paytill22medchk: request.disabilitynotes,
        comments: request.comments,
        parentsupportflag: request.parentsupportflag,
        schoolenrollflag: request.schoolenrollflag,
        immunizationflag: request.immunizationflag,
        mededuvoccertflag: request.mededuvoccertflag,
        paytill22educhkflag: request.paytill22educhkflag,
        paytill22enrollchkflag: request.paytill22enrollchkflag,
        paytill22emppgmchkflag: request.paytill22emppgmchkflag,
        paytill22emp80hrchkflag: request.paytill22emp80hrchkflag,
        paytill22medchkflag: request.paytill22medchkflag, 
        ischilddisability: request.ischilddisability,   
        ischildspecialneed: request.ischildspecialneed,   
        isparentlegalresponsible: request.isparentlegalresponsible,   
        isrenewalsigned: request.isrenewalsigned, 
        updatedby: securityuserid
      }).then(resp => {
        var status = request.status;
        var sql = 'select * from adoptioncaserouting($1,$2,$3,$4,$5)';
        return util.executeDBQuery(sql, [request.adoptionid, request.adoptioniverenewalid, securityusersid, 'ADYR', status]);
      }).then(data => {
        return data;
      }).catch(err => {
        util.logError(err);
        throw err;
      });
  }

  Adoptioniverenewal.addAdoptioniverenewal = function (request, _securityusersid) {
    var securityuserid = (request.securityuserid?request.securityuserid: _securityusersid);
    var securityusersid = request.securityuserid ? request.securityuserid : securityuserid;
    return Adoptioniverenewal.create({
        adoptionid: request.adoptionid,
        assessmentdate: request.assessmentdate,        
        fatheragreementdate: request.fatheragreementdate,
        motheragreementdate: request.motheragreementdate,
        designeeagreementdate: request.designeeagreementdate,
        paytill22medchk: request.disabilitynotes,
        comments: request.comments,
        parentsupportflag: request.parentsupportflag,
        schoolenrollflag: request.schoolenrollflag,
        immunizationflag: request.immunizationflag,
        mededuvoccertflag: request.mededuvoccertflag,
        paytill22educhkflag: request.paytill22educhkflag,
        paytill22enrollchkflag: request.paytill22enrollchkflag,
        paytill22emppgmchkflag: request.paytill22emppgmchkflag,
        paytill22emp80hrchkflag: request.paytill22emp80hrchkflag,
        paytill22medchkflag: request.paytill22medchkflag,
        ischilddisability: request.ischilddisability,
        ischildspecialneed: request.ischildspecialneed,
        isparentlegalresponsible: request.isparentlegalresponsible,
        isrenewalsigned: request.isrenewalsigned,
        insertedby: securityuserid,
        updatedby: securityuserid
    }).then(resp => {

      var status = request.status;
      var sql = 'select * from adoptioncaserouting($1,$2,$3,$4,$5)';
      return util.executeDBQuery(sql, [request.adoptionid, resp.adoptioniverenewalid, securityusersid, 'ADYR', status])
        .catch(err => { util.logError(err); throw err; });
    }).then(data => {
      return data;
    }).catch(err => {
      util.logError(err);
      throw err;
    });
  };

  Adoptioniverenewal.remoteMethod('list', {
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

  Adoptioniverenewal.list = (request) => {
    
    var adoptioncaseid = request.where.adoptioncaseid?request.where.adoptioncaseid:null;
    var sql = 'select * from getadoptioncaseannualreview($1)';
    return util.executeDBQuery(sql, [adoptioncaseid])
      .then(datas => datas)
      .catch(err => util.logError(err));
  };

  Adoptioniverenewal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Adoptioniverenewal.observe('access', (ctx, next) => util.access(ctx, next));
  Adoptioniverenewal.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};