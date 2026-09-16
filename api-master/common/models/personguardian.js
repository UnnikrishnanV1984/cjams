'use strict';
const util = require('../utils/utils');

module.exports = function(Personguardian) {

    Personguardian.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personguardian.observe('access', (ctx, next) => util.access(ctx, next));
    Personguardian.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
