'use strict';
const util = require('../utils/utils');

module.exports = function(investigationallegationindicator) {

  investigationallegationindicator.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  investigationallegationindicator.observe('access', (ctx, next) => util.access(ctx, next));
  investigationallegationindicator.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
