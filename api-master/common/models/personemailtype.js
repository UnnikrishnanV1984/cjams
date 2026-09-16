'use strict';
const util = require('../utils/utils');

module.exports = function(Personemailtype) {

  Personemailtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Personemailtype.observe('access', (ctx, next) => util.access(ctx, next));
  Personemailtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
