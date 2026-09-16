var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Intakeagencyrequesttype) {
    Intakeagencyrequesttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeagencyrequesttype.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeagencyrequesttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}