'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestillegalactivitytype) {

    Intakeservicerequestillegalactivitytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestillegalactivitytype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestillegalactivitytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
