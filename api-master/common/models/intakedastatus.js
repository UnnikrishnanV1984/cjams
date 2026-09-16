'use strict';
const util = require('../utils/utils');

module.exports = function(Intakedastatus) {
    
    Intakedastatus.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakedastatus.observe('access', (ctx, next) => util.access(ctx, next));
    Intakedastatus.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
