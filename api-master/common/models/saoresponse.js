'use strict';
const util = require('../utils/utils');

module.exports = function(Saoresponse) {
  
    Saoresponse.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Saoresponse.observe('access', (ctx, next) => util.access(ctx, next));
    Saoresponse.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}