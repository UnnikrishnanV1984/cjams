

'use strict';
const util = require('../utils/utils');

module.exports = function(Personrole) {
  
  Personrole.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Personrole.observe('access', (ctx, next) => util.access(ctx, next));
  Personrole.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}