'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function (Adoptioncaseactor) {
    Adoptioncaseactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptioncaseactor.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptioncaseactor.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}    