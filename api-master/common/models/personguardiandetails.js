'use strict';
const util = require('../utils/utils');

module.exports = function(Personguardiandetails) {

    Personguardiandetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personguardiandetails.observe('access', (ctx, next) => util.access(ctx, next));
    Personguardiandetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
