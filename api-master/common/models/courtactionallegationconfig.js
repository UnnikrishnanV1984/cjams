'use strict';
const util = require('../utils/utils');
module.exports = function(Courtactionallegationconfig) {

    Courtactionallegationconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Courtactionallegationconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Courtactionallegationconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};