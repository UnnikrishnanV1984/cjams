'use strict';
const util = require('../utils/utils');

module.exports = function(Safetyplanaction) {

  Safetyplanaction.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Safetyplanaction.observe('access', (ctx, next) => util.access(ctx, next));
  Safetyplanaction.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
