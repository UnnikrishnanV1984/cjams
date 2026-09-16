'use strict';
const util = require('../utils/utils');

module.exports = function(Investigationtask) {
    
    Investigationtask.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationtask.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationtask.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
