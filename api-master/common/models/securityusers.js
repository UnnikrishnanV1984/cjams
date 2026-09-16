'use strict';
const util = require('../utils/utils');

module.exports = function(Securityusers) {

    Securityusers.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Securityusers.observe('access', (ctx, next) => util.access(ctx, next));
    Securityusers.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
