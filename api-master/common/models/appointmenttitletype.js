'use strict';
const util = require('../utils/utils');

module.exports = function(Appointmenttitletype) {
  
    Appointmenttitletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Appointmenttitletype.observe('access', (ctx, next) => util.access(ctx, next));
    Appointmenttitletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}