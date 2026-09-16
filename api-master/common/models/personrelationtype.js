var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Personrelationtype) {
    Personrelationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personrelationtype.observe('access', (ctx, next) => util.access(ctx, next));
    Personrelationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}