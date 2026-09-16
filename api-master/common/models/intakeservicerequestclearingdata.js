'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestclearingdata) {

    Intakeservicerequestclearingdata.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestclearingdata.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestclearingdata.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
