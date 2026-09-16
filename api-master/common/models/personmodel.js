'use strict';
const util = require('../utils/utils');

module.exports = function(personmodel) {
    personmodel.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    personmodel.observe('access', (ctx, next) => util.access(ctx, next));
    personmodel.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
