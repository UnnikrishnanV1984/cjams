'use strict';
const util = require('../utils/utils');

module.exports = function(recordingmodel) {
    recordingmodel.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    recordingmodel.observe('access', (ctx, next) => util.access(ctx, next));
    recordingmodel.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
