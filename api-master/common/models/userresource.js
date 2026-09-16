'use strict';
const util = require('../utils/utils');
module.exports = function(Userresource) {
    Userresource.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userresource.observe('access', (ctx, next) => util.access(ctx, next));
    Userresource.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
