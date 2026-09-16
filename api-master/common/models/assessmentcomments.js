'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Assessmentcomments) {
  Assessmentcomments.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Assessmentcomments.observe('access', (ctx, next) => util.access(ctx, next));
  Assessmentcomments.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
