'use strict';
const util = require('../utils/utils');

module.exports = function(Userprofileaddress) {

    Userprofileaddress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userprofileaddress.observe('access', (ctx, next) => util.access(ctx, next));
    Userprofileaddress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
