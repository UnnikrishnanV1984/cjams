'use strict';
const util = require('../utils/utils');

module.exports = function(Roletype) {
  
    Roletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Roletype.observe('access', (ctx, next) => util.access(ctx, next));
    Roletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}