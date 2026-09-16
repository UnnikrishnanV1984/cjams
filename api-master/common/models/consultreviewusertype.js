'use strict';
const util = require('../utils/utils');

module.exports = function(Consultreviewusertype) {
    Consultreviewusertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Consultreviewusertype.observe('access', (ctx, next) => util.access(ctx, next));
    Consultreviewusertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
