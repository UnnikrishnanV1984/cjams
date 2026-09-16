'use strict';
const util = require('../utils/utils');

module.exports = function(Petitionstatustype) {
    Petitionstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Petitionstatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Petitionstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
