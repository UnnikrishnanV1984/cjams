'use strict';
const util = require('../utils/utils');

module.exports = function(Closuretype) {

    Closuretype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Closuretype.observe('access', (ctx, next) => util.access(ctx, next));
    Closuretype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};