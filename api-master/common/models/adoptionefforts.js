'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Adoptionefforts) {
    Adoptionefforts.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adoptionefforts.observe('access', (ctx, next) => util.access(ctx, next));
    Adoptionefforts.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    