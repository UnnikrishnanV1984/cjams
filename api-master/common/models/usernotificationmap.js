'use strict';
const util = require('../utils/utils');

module.exports = function(Usernotificationmap) {

    Usernotificationmap.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Usernotificationmap.observe('access', (ctx, next) => util.access(ctx, next));
    Usernotificationmap.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
