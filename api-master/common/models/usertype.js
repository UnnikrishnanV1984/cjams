'use strict';
const util = require('../utils/utils');

module.exports = function(Usertype) {

    Usertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Usertype.observe('access', (ctx, next) => util.access(ctx, next));
    Usertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
