'use strict';
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("environmentconfig");
var app = require('../../server/server');

module.exports = function(Environmentconfig) {


  Environmentconfig.getconfigvalues = (request) => {
    var sql = 'select * from getenvironmentconfigvalue($1, $2)';
    return util.executeDBQuery(sql, [request.where.env_variable, request.where.env_variable_module])
      .then(data => data)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  }

  Environmentconfig.remoteMethod('getconfigvalues', {
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


  Environmentconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Environmentconfig.observe('access', (ctx, next) => util.access(ctx, next));
  Environmentconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}