'use strict';
const util = require('../utils/utils');
module.exports = function(Ldsslocations) {   
    Ldsslocations.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Ldsslocations.observe('access', (ctx, next) => util.access(ctx, next));
    Ldsslocations.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};