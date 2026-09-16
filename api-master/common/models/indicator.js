'use strict';
const util = require('../utils/utils');

module.exports = function(Indicator) {
    Indicator.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Indicator.observe('access', (ctx, next) => util.access(ctx, next));
    Indicator.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
