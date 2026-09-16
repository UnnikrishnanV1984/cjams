'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Caseclosureservice) {
    Caseclosureservice.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Caseclosureservice.observe('access', (ctx, next) => util.access(ctx, next));
    Caseclosureservice.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}