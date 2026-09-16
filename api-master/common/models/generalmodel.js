'use strict';
const util = require('../utils/utils');

module.exports = function(generalmodel) {
    generalmodel.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    generalmodel.observe('access', (ctx, next) => util.access(ctx, next));
    generalmodel.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
