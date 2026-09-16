'use strict';
const LOGGER = require("log4js").getLogger("adoptionagreementrate");
const util = require('../utils/utils');
const app = require('../../server/server');
module.exports = function(Adoptionagreementrate) {

  Adoptionagreementrate.remoteMethod('add', {
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

  const routeAdoptionRate = (request, reqctx) => {
    const securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
    const sql = 'select * from adoptionrouting($1,$2,$3,$4,$5)';

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

  Adoptionagreementrate.add = (request, reqctx) => routeAdoptionRate(request, reqctx);

  Adoptionagreementrate.remoteMethod('routerate', {
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

  Adoptionagreementrate.routerate = (request, reqctx) => routeAdoptionRate(request, reqctx);

  Adoptionagreementrate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Adoptionagreementrate.observe('access', (ctx, next) => util.access(ctx, next));
  Adoptionagreementrate.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}    
