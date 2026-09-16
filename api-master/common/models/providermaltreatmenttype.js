'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Providermaltreatmenttype) {
    Providermaltreatmenttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providermaltreatmenttype.observe('access', (ctx, next) => util.access(ctx, next));
    Providermaltreatmenttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}