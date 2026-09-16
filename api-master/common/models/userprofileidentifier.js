'use strict';
const util = require('../utils/utils');

module.exports = function(Userprofileidentifier) {

    Userprofileidentifier.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userprofileidentifier.observe('access', (ctx, next) => util.access(ctx, next));
    Userprofileidentifier.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};