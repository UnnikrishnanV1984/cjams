'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestcrossreferencereasontype) {

    Intakeservicerequestcrossreferencereasontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestcrossreferencereasontype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestcrossreferencereasontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
    
};
