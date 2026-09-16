'use strict';
const util = require('../utils/utils');

module.exports = function(Userprofileaddresstype) {

    Userprofileaddresstype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userprofileaddresstype.observe('access', (ctx, next) => util.access(ctx, next));
    Userprofileaddresstype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
