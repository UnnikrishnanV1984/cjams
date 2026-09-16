'use strict';
const util = require('../utils/utils');

module.exports = function(Medicalconditiontype) {
    
    Medicalconditiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Medicalconditiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Medicalconditiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
