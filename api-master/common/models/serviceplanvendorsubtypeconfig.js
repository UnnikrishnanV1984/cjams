'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanvendorsubtypeconfig) {    
    Serviceplanvendorsubtypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanvendorsubtypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanvendorsubtypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}  