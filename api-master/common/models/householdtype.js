'use strict';
const util = require('../utils/utils');

module.exports = function(householdtype) {

  householdtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  householdtype.observe('access', (ctx, next) => util.access(ctx, next));
  householdtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
