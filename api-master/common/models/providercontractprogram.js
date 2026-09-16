'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Providercontractprogram) {
    Providercontractprogram.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providercontractprogram.observe('access', (ctx, next) => util.access(ctx, next));
    Providercontractprogram.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
