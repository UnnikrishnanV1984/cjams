'use strict';
const util = require('../utils/utils');

module.exports = function(Personresultfield) {
    Personresultfield.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personresultfield.observe('access', (ctx, next) => util.access(ctx, next));
    Personresultfield.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
