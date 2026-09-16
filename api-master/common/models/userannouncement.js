'use strict';
const util = require('../utils/utils');
module.exports = function(Userannouncement) {

    Userannouncement.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userannouncement.observe('access', (ctx, next) => util.access(ctx, next));
    Userannouncement.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}