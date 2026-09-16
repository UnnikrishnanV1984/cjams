'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Contacttrialvisit) {
  Contacttrialvisit.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Contacttrialvisit.observe('access', (ctx, next) => util.access(ctx, next));
  Contacttrialvisit.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
