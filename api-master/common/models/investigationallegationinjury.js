'use strict';
const util = require('../utils/utils');

module.exports = function(investigationallegationinjury) {

  investigationallegationinjury.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  investigationallegationinjury.observe('access', (ctx, next) => util.access(ctx, next));
  investigationallegationinjury.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
