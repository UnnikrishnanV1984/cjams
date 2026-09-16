var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Intakeserviceagencyroletype) {
    Intakeserviceagencyroletype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeserviceagencyroletype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeserviceagencyroletype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}