'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Suspensionreasontype) {
    
    Suspensionreasontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Suspensionreasontype.observe('access', (ctx, next) => util.access(ctx, next));
    Suspensionreasontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}