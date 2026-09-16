'use strict';
const util = require('../utils/utils');

module.exports = function(Actionletterheaderconfig) {
  
    Actionletterheaderconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Actionletterheaderconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Actionletterheaderconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}