'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Providercontracttype) {
    Providercontracttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providercontracttype.observe('access', (ctx, next) => util.access(ctx, next));
    Providercontracttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
