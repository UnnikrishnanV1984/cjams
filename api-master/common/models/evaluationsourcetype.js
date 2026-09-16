'use strict';
const util = require('../utils/utils');

module.exports = function(Evaluationsourcetype) {
    Evaluationsourcetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Evaluationsourcetype.observe('access', (ctx, next) => util.access(ctx, next));
    Evaluationsourcetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
