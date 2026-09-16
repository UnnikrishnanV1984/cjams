'use strict';
const util = require('../utils/utils');

module.exports = function(Userworkstatustype) {

    Userworkstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userworkstatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Userworkstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
