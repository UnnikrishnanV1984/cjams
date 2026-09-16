'use strict';
const util = require('../utils/utils');

module.exports = function(Permanencyplandetail) {

  Permanencyplandetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Permanencyplandetail.observe('access', (ctx, next) => util.access(ctx, next));
  Permanencyplandetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
