'use strict';
const util = require('../utils/utils');

module.exports = function(Progressnoteclassificationtype) {

    Progressnoteclassificationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Progressnoteclassificationtype.observe('access', (ctx, next) => util.access(ctx, next));
    Progressnoteclassificationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
