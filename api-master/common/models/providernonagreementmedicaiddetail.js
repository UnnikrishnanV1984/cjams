'use strict';
const util = require('../utils/utils');

module.exports = function(Providernonagreementmedicaiddetail) {

    Providernonagreementmedicaiddetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providernonagreementmedicaiddetail.observe('access', (ctx, next) => util.access(ctx, next));
    Providernonagreementmedicaiddetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
