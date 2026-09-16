'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Exitreasontype) {
  Exitreasontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Exitreasontype.observe('access', (ctx, next) => util.access(ctx, next));
  Exitreasontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}