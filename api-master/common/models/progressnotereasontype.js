'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Progressnotereasontype) {
    Progressnotereasontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Progressnotereasontype.observe('access', (ctx, next) => util.access(ctx, next));
    Progressnotereasontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
