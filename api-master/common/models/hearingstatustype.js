'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(hearingstatustype) {

  hearingstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  hearingstatustype.observe('access', (ctx, next) => util.access(ctx, next));
  hearingstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
