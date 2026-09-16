'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestcourthearingconfig) {
    Intakeservicerequestcourthearingconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestcourthearingconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestcourthearingconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};