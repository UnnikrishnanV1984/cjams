var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(AccessToken) {
    AccessToken.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    AccessToken.observe('access', (ctx, next) => util.access(ctx, next));
    AccessToken.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}