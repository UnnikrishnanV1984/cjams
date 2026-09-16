'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(provideraddress) {
  provideraddress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  provideraddress.observe('access', (ctx, next) => util.access(ctx, next));
  provideraddress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
