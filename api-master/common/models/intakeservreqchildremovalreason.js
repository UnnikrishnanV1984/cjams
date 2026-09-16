var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Intakeservreqchildremovalreason) {
    Intakeservreqchildremovalreason.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqchildremovalreason.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqchildremovalreason.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}