'use strict';
const util = require('../utils/utils');

module.exports = function(Typesagencymapping) {
    Typesagencymapping.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Typesagencymapping.observe('access', (ctx, next) => util.access(ctx, next));
    Typesagencymapping.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
