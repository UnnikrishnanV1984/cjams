'use strict';
const util = require('../utils/utils');

module.exports = function(Personroletype) {
  
  Personroletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Personroletype.observe('access', (ctx, next) => util.access(ctx, next));
  Personroletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}