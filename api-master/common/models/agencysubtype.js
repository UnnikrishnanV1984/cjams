'use strict';
const util = require('../utils/utils');

module.exports = function(Activity) {

    Activity.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activity.observe('access', (ctx, next) => util.access(ctx, next));
    Activity.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
