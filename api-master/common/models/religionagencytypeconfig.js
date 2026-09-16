'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Religionagencytypeconfig) {
    Religionagencytypeconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Religionagencytypeconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Religionagencytypeconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
