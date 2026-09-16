'use strict';
const util = require('../utils/utils');

module.exports = function(Agencystatustype) {

    Agencystatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Agencystatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Agencystatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
