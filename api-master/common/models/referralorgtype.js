'use strict';
const util = require('../utils/utils');

module.exports = function(Refferalorgtype) {
    Refferalorgtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Refferalorgtype.observe('access', (ctx, next) => util.access(ctx, next));
    Refferalorgtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
