'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestweavertype) {
    
    Intakeservicerequestweavertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestweavertype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestweavertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
