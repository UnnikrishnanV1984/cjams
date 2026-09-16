'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(provideraddresstype) {
  provideraddresstype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  provideraddresstype.observe('access', (ctx, next) => util.access(ctx, next));
  provideraddresstype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
