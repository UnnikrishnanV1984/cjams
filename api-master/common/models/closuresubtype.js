'use strict';
const util = require('../utils/utils');

module.exports = function(Closuresubtype) {

    Closuresubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Closuresubtype.observe('access', (ctx, next) => util.access(ctx, next));
    Closuresubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};