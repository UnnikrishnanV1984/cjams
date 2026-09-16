'use strict';
const util = require('../utils/utils');

module.exports = function(Teammemberrolecategoryteammemberroletypemap) {

    Teammemberrolecategoryteammemberroletypemap.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Teammemberrolecategoryteammemberroletypemap.observe('access', (ctx, next) => util.access(ctx, next));
    Teammemberrolecategoryteammemberroletypemap.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
