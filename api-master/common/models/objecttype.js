'use strict';
const util = require('../utils/utils');

module.exports = function(Objecttype) {

    Objecttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Objecttype.observe('access', (ctx, next) => util.access(ctx, next));
    Objecttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
