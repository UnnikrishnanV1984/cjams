'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Conditiontype) {    
    Conditiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Conditiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Conditiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
