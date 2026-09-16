'use strict';
const util = require('../utils/utils');

module.exports = function(datypedetailmodel) {
    datypedetailmodel.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    datypedetailmodel.observe('access', (ctx, next) => util.access(ctx, next));
    datypedetailmodel.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
