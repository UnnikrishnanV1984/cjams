var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Meetingfimdetails) {
    Meetingfimdetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Meetingfimdetails.observe('access', (ctx, next) => util.access(ctx, next));
    Meetingfimdetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}