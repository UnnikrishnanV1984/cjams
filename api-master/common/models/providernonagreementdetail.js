'use strict';
const util = require('../utils/utils');

module.exports = function(providernonagreementdetail) {

    providernonagreementdetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	providernonagreementdetail.observe('access', (ctx, next) => util.access(ctx, next));
	providernonagreementdetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 
};
