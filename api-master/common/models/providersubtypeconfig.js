'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Providersubtypeconfig) {    
    Providersubtypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providersubtypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Providersubtypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    