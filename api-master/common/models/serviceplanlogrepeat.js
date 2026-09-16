'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanlogrepeat) {
    Serviceplanlogrepeat.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanlogrepeat.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanlogrepeat.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
