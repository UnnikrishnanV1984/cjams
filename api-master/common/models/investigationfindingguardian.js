'use strict';
const util = require('../utils/utils');

module.exports = function(Investigationfindingguardian) {
    Investigationfindingguardian.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationfindingguardian.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationfindingguardian.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
