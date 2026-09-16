'use strict';
const util = require('../utils/utils');

module.exports = function(Contactroletype) {

    Contactroletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Contactroletype.observe('access', (ctx, next) => util.access(ctx, next));
    Contactroletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
