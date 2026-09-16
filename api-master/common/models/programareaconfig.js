'use strict';
const util = require('../utils/utils');
module.exports = function(Programareaconfig) {
    Programareaconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Programareaconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Programareaconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};