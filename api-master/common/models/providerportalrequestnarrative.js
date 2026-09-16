'use strict';
const util = require('../utils/utils');

module.exports = function(Providerportalrequestnarrative) {

    Providerportalrequestnarrative.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Providerportalrequestnarrative.observe('access', (ctx, next) => util.access(ctx, next));
	Providerportalrequestnarrative.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
 
};
