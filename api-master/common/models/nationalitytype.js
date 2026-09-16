var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Nationalitytype) {
    Nationalitytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Nationalitytype.observe('access', (ctx, next) => util.access(ctx, next));
    Nationalitytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}