

'use strict';
const util = require('../utils/utils');

module.exports = function(personmaritalstatus) {
  
  personmaritalstatus.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  personmaritalstatus.observe('access', (ctx, next) => util.access(ctx, next));
  personmaritalstatus.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}