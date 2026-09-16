'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Assessmentactor) {
    Assessmentactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Assessmentactor.observe('access', (ctx, next) => util.access(ctx, next));
    Assessmentactor.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
