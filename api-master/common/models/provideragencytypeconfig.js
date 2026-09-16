'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Provideragencytypeconfig) {
    Provideragencytypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Provideragencytypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Provideragencytypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
