'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Serviceplanscheduleexemption) {    
    Serviceplanscheduleexemption.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanscheduleexemption.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanscheduleexemption.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}    