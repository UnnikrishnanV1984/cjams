'use strict';
const util = require('../utils/utils');

module.exports = function(allegationsmodel) {
    allegationsmodel.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    allegationsmodel.observe('access', (ctx, next) => util.access(ctx, next));
    allegationsmodel.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
