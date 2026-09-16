'use strict';
const util = require('../utils/utils');

module.exports = function(personspouseaddress) {
  
  personspouseaddress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  personspouseaddress.observe('access', (ctx, next) => util.access(ctx, next));
  personspouseaddress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}