'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeagency) {
    Intakeagency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeagency.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeagency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
