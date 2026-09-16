'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestcourtactiontype) {
    Intakeservicerequestcourtactiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestcourtactiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestcourtactiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};