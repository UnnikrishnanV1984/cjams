'use strict';
const util = require('../utils/utils');

module.exports = function(removalreasontype) {

  removalreasontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  removalreasontype.observe('access', (ctx, next) => util.access(ctx, next));
  removalreasontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
