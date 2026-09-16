'use strict';
const util = require('../utils/utils');

module.exports = function(Resourcetype) {

    Resourcetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Resourcetype.observe('access', (ctx, next) => util.access(ctx, next));
    Resourcetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
