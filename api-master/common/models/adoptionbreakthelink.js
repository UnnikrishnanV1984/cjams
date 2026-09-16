'use strict';
const LOGGER = require("log4js").getLogger("adoptionbreakthelink");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function (Adoptionbreakthelink) {

  Adoptionbreakthelink.addupdate = (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    if (request.adoptionbreakthelinkid !== undefined && request.adoptionbreakthelinkid !== null) {
      return Adoptionbreakthelink.breakthelinkupdate(request, _securityusersid);
    } else {
      return Adoptionbreakthelink.breakthelinkadd(request, _securityusersid);
    }
  }

  Adoptionbreakthelink.breakthelinkadd = function (request, _securityusersid) {
    var securityusersid = (request?.securityuserid ? request.securityuserid : _securityusersid);
    return Adoptionbreakthelink.create({
      adoptionplanningid: request.adoptionplanningid,
      legallyfree: request.legallyfree,
      adoptiveplacement: request.adoptiveplacement,
      placementagreement: request.placementagreement,
      agreementsigneddate: request.agreementsigneddate,
      adoptionfinalization: request.adoptionfinalization,
      associatedcourtorderdate: request.associatedcourtorderdate,
      finalizationdate: request.finalizationdate,
      insertedby: securityusersid,
      updatedby: securityusersid
    }).then(resp => {
      var status = 15;
      var comments = '';
      if (request.comments !== undefined && request.comments !== null)
        {comments = request.comments;}
      /* else
        {comments = '';} */
      var nofitymsg = 'Adoption Break the Link Submitted for review';
      var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
      return util.executeDBQuery(sql, [resp.adoptionbreakthelinkid, securityusersid, 'ABLR', status, comments, '', false, false, false, nofitymsg, '', request.servicecaseid, '', 1])
        .then(data => data[0].routingintake);
    }).then(data => {
      return data;
    })
    .catch(err => util.logError(err));
  }

  Adoptionbreakthelink.breakthelinkupdate = (request, _securityusersid) => {
    return Adoptionbreakthelink.updateAll(
      { adoptionbreakthelinkid: request.adoptionbreakthelinkid },
      {
        adoptionplanningid: request.adoptionplanningid,
        legallyfree: request.legallyfree,
        adoptiveplacement: request.adoptiveplacement,
        placementagreement: request.placementagreement,
        agreementsigneddate: request.agreementsigneddate,
        adoptionfinalization: request.adoptionfinalization,
        associatedcourtorderdate: request.associatedcourtorderdate,
        finalizationdate: request.finalizationdate,
        updatedby: (request && request.securityuserid?request.securityuserid: _securityusersid)
      }).then(resp => {
        var status = 15;
        var comments;
        if (request.comments !== undefined && request.comments !== null)
          {comments = request.comments;}
        else
          {comments = '';}
        var nofitymsg = 'Adoption Break the Link Submitted for review';
        var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
        return util.executeDBQuery(sql, [request.adoptionbreakthelinkid, (request && request.securityuserid?request.securityuserid: _securityusersid), 'ABLR', status, comments, '', false, false, false, nofitymsg, nofitymsg, request.servicecaseid, '', 1])
          .then(data => data[0].routingintake);
      }).then(data => {
        return data;
      })
      .catch(err => util.logError(err));
  }

  Adoptionbreakthelink.remoteMethod('addupdate', {
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
      type: 'string',
      root: true
    }
  });

  Adoptionbreakthelink.getadoptionbreakthelink = function (request) {
    var sql = 'select * from getadoptionbreakthelink($1)';
    return util.executeSecondaryNodeDBQuery(sql, [request.where.adoptionplanningid])
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  Adoptionbreakthelink.remoteMethod('getadoptionbreakthelink', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      path: '/getadoptionbreakthelink',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Adoptionbreakthelink.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Adoptionbreakthelink.observe('access', (ctx, next) => util.access(ctx, next));
  Adoptionbreakthelink.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}    
