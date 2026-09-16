'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Meetingparticipants) {
    Meetingparticipants.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Meetingparticipants.observe('access', (ctx, next) => util.access(ctx, next));
    Meetingparticipants.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
