'use strict';
const util = require('../utils/utils');

module.exports = function(Userprofilephonenumber) {

    Userprofilephonenumber.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userprofilephonenumber.observe('access', (ctx, next) => util.access(ctx, next));
    Userprofilephonenumber.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
