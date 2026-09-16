'use strict';
const util = require('../utils/utils');

module.exports = function(notificationconfig) {

  notificationconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  notificationconfig.observe('access', (ctx, next) => util.access(ctx, next));
  notificationconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
