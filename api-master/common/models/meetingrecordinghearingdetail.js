'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(meetingrecordinghearingdetail) {
    meetingrecordinghearingdetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    meetingrecordinghearingdetail.observe('access', (ctx, next) => util.access(ctx, next));
    meetingrecordinghearingdetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}