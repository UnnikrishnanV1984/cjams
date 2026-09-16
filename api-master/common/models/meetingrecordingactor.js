'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Meetingrecordingactor) {
    Meetingrecordingactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Meetingrecordingactor.observe('access', (ctx, next) => util.access(ctx, next));
    Meetingrecordingactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
