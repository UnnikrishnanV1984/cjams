'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Progressnotepurposetype) {    
    Progressnotepurposetype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Progressnotepurposetype.observe('access', (ctx, next) => util.access(ctx, next));
    Progressnotepurposetype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}