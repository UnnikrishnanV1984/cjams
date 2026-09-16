'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeappeal) {
    
    Intakeappeal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeappeal.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeappeal.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
