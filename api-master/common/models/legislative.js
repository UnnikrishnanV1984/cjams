'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
const LOGGER = require("log4js").getLogger("legislative");
var app = require('../../server/server');
module.exports = function (Legislative) {
    Legislative.remoteMethod('addupdate', {
    http: {
      path: '/addupdate',
      verb: 'post'
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    }],
    returns: {
      type: 'string',
      root: true
    }
  });
  Legislative.addupdate = function (request) {   
    if (request.legislative.legislativeid == null || request.legislative.legislativeid== undefined) {	
      return Legislative.create(request.legislative)
        .then(res => res)
        .catch(err => util.logError(err));
    }
    else {
      return Legislative.updateAll({ legislativeid: request.legislative.legislativeid }, request.legislative)
        .catch(err => util.logError(err));
    }
  };
  Legislative.remoteMethod('list', {
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
      type: 'object',
      root: true
    }
  });
  Legislative.list = function (request) {
    return Legislative.find({
      fields: ['legislativeid', 'intakeserviceid', 'isapprovedsafec', 'activeflag', 'updatedby', 'updatedon', 'insertedby','insertedon','isinitialfacetoface','isapprovedmfira','isapprovecansf','isvictimperpetrator','isallpersons','isallegedvicitm','islegislativereporting','isdataentrynotes','isemergency','isreasonnotprovided', 'islateinitialcontact'],
      where: {
        and: [
          { activeflag: 1 },
          { intakeserviceid: request.where.intakeserviceid }
        ]
      }
    }
    ).catch(err => LOGGER.error(err));  
    
  }
  
  Legislative.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Legislative.observe('access', (ctx, next) => util.access(ctx, next));
  Legislative.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}