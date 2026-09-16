'use strict';
const util = require('../utils/utils');

module.exports = function(Teammemberrolecategory) {

    Teammemberrolecategory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Teammemberrolecategory.observe('access', (ctx, next) => util.access(ctx, next));
    Teammemberrolecategory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
