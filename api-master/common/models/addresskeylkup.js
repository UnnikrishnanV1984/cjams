'use strict';
const util = require('../utils/utils');

module.exports = function(Addresskeylkup) {
    Addresskeylkup.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Addresskeylkup.observe('access', (ctx, next) => util.access(ctx, next));
    Addresskeylkup.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
