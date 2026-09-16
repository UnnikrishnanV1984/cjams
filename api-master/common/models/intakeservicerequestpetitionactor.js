'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Intakeservicerequestpetitionactor) {
    Intakeservicerequestpetitionactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestpetitionactor.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestpetitionactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    