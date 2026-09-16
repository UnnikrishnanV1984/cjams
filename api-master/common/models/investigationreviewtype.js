'use strict';
const util = require('../utils/utils');

module.exports = function(Investigationreviewtype) {

    Investigationreviewtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationreviewtype.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationreviewtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
