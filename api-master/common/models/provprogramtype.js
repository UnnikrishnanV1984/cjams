'use strict';
const util = require('../utils/utils');

module.exports = function(provprogramtype) {
    provprogramtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    provprogramtype.observe('access', (ctx, next) => util.access(ctx, next));
    provprogramtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
