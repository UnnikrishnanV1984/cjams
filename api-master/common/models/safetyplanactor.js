'use strict';
const util = require('../utils/utils');

module.exports = function(Safetyplanactor) {

  Safetyplanactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Safetyplanactor.observe('access', (ctx, next) => util.access(ctx, next));
  Safetyplanactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
