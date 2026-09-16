'use strict';
const util = require('../utils/utils');

module.exports = function(notificationtype) {

  notificationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  notificationtype.observe('access', (ctx, next) => util.access(ctx, next));
  notificationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
