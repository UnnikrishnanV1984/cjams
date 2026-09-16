'use strict';
const util = require('../utils/utils');

module.exports = function(Childcharacteristictype) {
    Childcharacteristictype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Childcharacteristictype.observe('access', (ctx, next) => util.access(ctx, next));
    Childcharacteristictype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
