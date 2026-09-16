'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanlogoccurence) {
  Serviceplanlogoccurence.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Serviceplanlogoccurence.observe('access', (ctx, next) => util.access(ctx, next));
  Serviceplanlogoccurence.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
