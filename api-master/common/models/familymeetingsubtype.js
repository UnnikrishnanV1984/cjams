var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Familymeetingsubtype) {
    Familymeetingsubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Familymeetingsubtype.observe('access', (ctx, next) => util.access(ctx, next));
    Familymeetingsubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}