'use strict';
const util = require('../utils/utils');

module.exports = function(Responsibilitytype) {

    Responsibilitytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Responsibilitytype.observe('access', (ctx, next) => util.access(ctx, next));
    Responsibilitytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
