'use strict';
const util = require('../utils/utils');

module.exports = function(Oasactionletterprogramactionconfig) {
  
    Oasactionletterprogramactionconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Oasactionletterprogramactionconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Oasactionletterprogramactionconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}