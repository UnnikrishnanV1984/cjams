'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestcourtordertypeconfig) {
    Intakeservicerequestcourtordertypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestcourtordertypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestcourtordertypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};