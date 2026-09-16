'use strict';
const util = require('../utils/utils');

module.exports = function(Prescriptionreasontype) {

    Prescriptionreasontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Prescriptionreasontype.observe('access', (ctx, next) => util.access(ctx, next));
    Prescriptionreasontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
