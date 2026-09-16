  'use strict';
  const LOGGER = require("log4js").getLogger("adoptioncaseagreementrate");
  const util = require('../utils/utils');
  const app = require('../../server/server');
  module.exports = function(Adoptioncaseagreementrate) {

  Adoptioncaseagreementrate.remoteMethod('add', {
    http: {
            path: '/add',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
        } ],
    returns: {
        type : 'string',
        root : true
    }
  });

  const routeAdoptionCaseRate = (request, reqctx) => {
    const securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
    const sql = 'select * from adoptioncaserouting($1,$2,$3,$4,$5)';

    return util.executeDBQuery(sql, [
      request.servicecaseid,
      request.adoptionagreementrateid,
      securityusersid,
      'AARR',
      request.statustypeid
    ])
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Adoptioncaseagreementrate.add = (request, reqctx) => routeAdoptionCaseRate(request, reqctx);

  Adoptioncaseagreementrate.remoteMethod('routerate', {
    http: {
            path: '/routerate',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
        } ],
    returns: {
        type : 'string',
        root : true
    }
  });

  Adoptioncaseagreementrate.routerate = (request, reqctx) => routeAdoptionCaseRate(request, reqctx);

  Adoptioncaseagreementrate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Adoptioncaseagreementrate.observe('access', (ctx, next) => util.access(ctx, next));
  Adoptioncaseagreementrate.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    
