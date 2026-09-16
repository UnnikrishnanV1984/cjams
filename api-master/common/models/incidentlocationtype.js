'use strict';
const util = require('../utils/utils');

module.exports = function(Incidentlocationtype) {

  Incidentlocationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Incidentlocationtype.observe('access', (ctx, next) => util.access(ctx, next));
  Incidentlocationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
