

'use strict';
const LOGGER = require("log4js").getLogger("approle");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(approle) {


  approle.getagencyrole = (request) => {
    var sql = 'select * from getagencyrole($1)';
    return util.executeDBQuery(sql, [request.where.teamtypekey])
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  }

  approle.remoteMethod('getagencyrole', {
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
      type: 'string',
      root: true
    }
  });


  approle.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  approle.observe('access', (ctx, next) => util.access(ctx, next));
  approle.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}