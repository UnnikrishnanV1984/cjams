'use strict';
const util = require('../utils/utils');

module.exports = function(Offencelocationtype) {
    Offencelocationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Offencelocationtype.observe('access', (ctx, next) => util.access(ctx, next));
    Offencelocationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
