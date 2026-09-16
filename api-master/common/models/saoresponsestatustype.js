'use strict';
const util = require('../utils/utils');

module.exports = function(Saoresponsestatustype) {
  
    Saoresponsestatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Saoresponsestatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Saoresponsestatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}