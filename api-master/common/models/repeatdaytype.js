'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Repeatdaytype) {    
    Repeatdaytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Repeatdaytype.observe('access', (ctx, next) => util.access(ctx, next));
    Repeatdaytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    