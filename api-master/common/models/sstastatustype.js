'use strict';
const util = require('../utils/utils');

module.exports = function(Sstastatustype) {

    Sstastatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Sstastatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Sstastatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
