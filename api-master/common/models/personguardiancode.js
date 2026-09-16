'use strict';
const util = require('../utils/utils');

module.exports = function(Personguardiancode) {

    Personguardiancode.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personguardiancode.observe('access', (ctx, next) => util.access(ctx, next));
    Personguardiancode.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
