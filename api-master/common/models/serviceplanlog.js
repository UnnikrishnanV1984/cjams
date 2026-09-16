'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(serviceplanlog) {
  serviceplanlog.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  serviceplanlog.observe('access', (ctx, next) => util.access(ctx, next));
  serviceplanlog.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
