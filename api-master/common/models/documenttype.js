'use strict';
const util = require('../utils/utils');


module.exports = function(Documenttype) {

    Documenttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Documenttype.observe('access', (ctx, next) => util.access(ctx, next));
    Documenttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
