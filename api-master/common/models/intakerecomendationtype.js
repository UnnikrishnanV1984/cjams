'use strict';
const util = require('../utils/utils');

module.exports = function(Intakerecomendationtype) {
    Intakerecomendationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakerecomendationtype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakerecomendationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}