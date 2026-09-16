'use strict';
const util = require('../utils/utils');

module.exports = function(Personguardianfuneral) {

    Personguardianfuneral.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personguardianfuneral.observe('access', (ctx, next) => util.access(ctx, next));
    Personguardianfuneral.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
