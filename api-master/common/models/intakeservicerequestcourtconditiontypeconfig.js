'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestcourtconditiontypeconfig) {
    Intakeservicerequestcourtconditiontypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestcourtconditiontypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestcourtconditiontypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};