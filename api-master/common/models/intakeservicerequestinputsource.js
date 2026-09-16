var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Intakeservicerequestinputsource) {
    Intakeservicerequestinputsource.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestinputsource.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestinputsource.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}