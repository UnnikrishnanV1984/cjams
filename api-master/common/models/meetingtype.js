'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Meetingtype) {
    Meetingtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Meetingtype.observe('access', (ctx, next) => util.access(ctx, next));
    Meetingtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
