'use strict';
const util = require('../utils/utils');

module.exports = function(Addresskeydetaillkup) {
    Addresskeydetaillkup.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Addresskeydetaillkup.observe('access', (ctx, next) => util.access(ctx, next));
    Addresskeydetaillkup.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
