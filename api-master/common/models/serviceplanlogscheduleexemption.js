'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanlogscheduleexemption) {
    Serviceplanlogscheduleexemption.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanlogscheduleexemption.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanlogscheduleexemption.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
