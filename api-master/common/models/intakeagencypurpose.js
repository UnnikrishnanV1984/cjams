var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Intakeagencypurpose) {
    Intakeagencypurpose.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeagencypurpose.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeagencypurpose.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}