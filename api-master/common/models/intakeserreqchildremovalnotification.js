'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Intakeserreqchildremovalnotification) {
    Intakeserreqchildremovalnotification.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeserreqchildremovalnotification.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeserreqchildremovalnotification.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
