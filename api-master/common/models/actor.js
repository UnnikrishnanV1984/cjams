'use strict';
const util = require('../utils/utils');
module.exports = function(Actor) {

    Actor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Actor.observe('access', (ctx, next) => util.access(ctx, next));
    Actor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
