'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Progressnoteactor) {
    Progressnoteactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Progressnoteactor.observe('access', (ctx, next) => util.access(ctx, next));
    Progressnoteactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
