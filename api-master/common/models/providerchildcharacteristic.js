'use strict';
const util = require('../utils/utils');

module.exports = function(Providerchildcharacteristic) {
    Providerchildcharacteristic.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providerchildcharacteristic.observe('access', (ctx, next) => util.access(ctx, next));
    Providerchildcharacteristic.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
