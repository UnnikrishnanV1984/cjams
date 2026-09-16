'use strict';
const util = require('../utils/utils');

module.exports = function(Professiontype) {

  Professiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Professiontype.observe('access', (ctx, next) => util.access(ctx, next));
  Professiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
