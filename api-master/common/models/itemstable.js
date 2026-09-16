'use strict';
const util = require('../utils/utils');

module.exports = function(Itemstable) {

    Itemstable.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Itemstable.observe('access', (ctx, next) => util.access(ctx, next));
    Itemstable.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
