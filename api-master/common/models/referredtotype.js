'use strict';
const util = require('../utils/utils');

module.exports = function(Refferedtotype) {
    
    Refferedtotype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Refferedtotype.observe('access', (ctx, next) => util.access(ctx, next));
    Refferedtotype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};