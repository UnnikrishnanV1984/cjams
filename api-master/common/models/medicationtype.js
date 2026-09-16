'use strict';
const util = require('../utils/utils');

module.exports = function(Medicationtype) {
    
    Medicationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Medicationtype.observe('access', (ctx, next) => util.access(ctx, next));
    Medicationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
