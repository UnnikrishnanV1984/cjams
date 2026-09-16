'use strict';
const LOGGER = require("log4js").getLogger("gapannualreview");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Gapannualreview) {

  Gapannualreview.remoteMethod('addupdate', {
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
  Gapannualreview.addupdate = (request, reqctx) => {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    if (request.gapannualreviewid !== undefined && request.gapannualreviewid !== null) {
      return Gapannualreview.updategapannualreview(request, _securityusersid);
    } else {
      return Gapannualreview.addgapannualreview(request, _securityusersid);
    }
  }

  Gapannualreview.updategapannualreview = (request, _securityusersid) => {
    const securityuserid = request.securityuserid ? request.securityuserid : _securityusersid;
    return Gapannualreview.updateAll(
      { gapannualreviewid: request.gapannualreviewid },
      {
        gapid: request.gapid,
        gapagreementid: request.gapagreementid,
        reviewdate: request.reviewdate,
        isguardianresponsible: request.isguardianresponsible,
        isguardiansupportfinance: request.isguardiansupportfinance,
        ischildwithguardian: request.ischildwithguardian,
        ischildattendingschool: request.ischildattendingschool,
        isdocumentprovided: request.isdocumentprovided,
        ischildreacheighteen: request.ischildreacheighteen,
        ischilddisability: request.ischilddisability,
        istrainingenrolled: request.istrainingenrolled,
        isunemployment: request.isunemployment,
        isformcomplete: request.isformcomplete,
        cgprimarydate: request.cgprimarydate,
        cgsecondarydate: request.cgsecondarydate,
        directorsigndate: request.directorsigndate,
        ismanualentry: request.ismanualentry,
        updatedby: securityuserid
      }).then(resp => {
        var status = 15;
        var nofitymsg = 'Annual Review Submitted for review';
        if (request.intakeserviceid == null && request.intakeserviceid === undefined) {
          request.intakeserviceid = '';
        }
        var deleteSQL = 'update routing set activeflag=0 where objectid = $1'
        util.executeDBQuery(deleteSQL, [request.gapannualreviewid]);
        var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        return util.executeDBQuery(sql, [request.gapannualreviewid, securityuserid, 'GAYR', status, nofitymsg, '', false, false, false,
                                      nofitymsg, '', request.servicecaseid,'',1])
          .then(data => data[0].routingintake);
      }).then(data => {
        return data;
      })
      .catch(err => util.logError(err));
  }

  Gapannualreview.addgapannualreview = function (request, _securityusersid) {
    const securityuserid = request.securityuserid ? request.securityuserid : _securityusersid;
    return app.models.Gapagreement.find({
      where: {
        and: [{ activeflag: 1 }, { gapid: request.gapid }]
      }
    }).then(data => {
      if (data != null && data.length > 0) {
        return Gapannualreview.create({
          gapid: request.gapid,
          gapagreementid: request.gapagreementid,
          reviewdate: request.reviewdate,
          isguardianresponsible: request.isguardianresponsible,
          isguardiansupportfinance: request.isguardiansupportfinance,
          ischildwithguardian: request.ischildwithguardian,
          ischildattendingschool: request.ischildattendingschool,
          isdocumentprovided: request.isdocumentprovided,
          ischildreacheighteen: request.ischildreacheighteen,
          ischilddisability: request.ischilddisability,
          istrainingenrolled: request.istrainingenrolled,
          isunemployment: request.isunemployment,
          isformcomplete: request.isformcomplete,
          cgprimarydate: request.cgprimarydate,
          cgsecondarydate: request.cgsecondarydate,
          directorsigndate: request.directorsigndate,
          ismanualentry: request.ismanualentry,
          insertedby: securityuserid,
          updatedby: securityuserid  
        }).then(resp => {
          var status = 15;
          var nofitymsg = 'Annual Review Submitted for review';
          var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
          return util.executeDBQuery(sql, [resp.gapannualreviewid, securityuserid, 'GAYR', status, nofitymsg, '', false, false, false,
                                        nofitymsg, '', request.servicecaseid,'',1])
            .then(_data => _data[0].routingintake);
        }).then(_data => {
          return _data;
        })
          .catch(err => util.logError(err));
      } else {
        return Promise.resolve('Agreement Not Available');
      }
    })
  };

  Gapannualreview.remoteMethod('list', {
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

  Gapannualreview.list = (request) => {
    
    var gapid = request.where.gapid?request.where.gapid:null;
    var objectid = request.where.objectid?request.where.objectid:null;
    var objecttype = request.where.objecttype?request.where.objecttype:'';
    var sql = 'select * from getannualreview($1,$2,$3)';
    return util.executeSecondaryNodeDBQuery(sql, [gapid,objectid,objecttype])
      .then(datas => datas)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  };

  Gapannualreview.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Gapannualreview.observe('access', (ctx, next) => util.access(ctx, next));
  Gapannualreview.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};