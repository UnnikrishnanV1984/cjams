'use strict';
const util = require('../utils/utils');

module.exports = function(Complaintstatustype) {
    Complaintstatustype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Complaintstatustype.observe('access', (ctx, next) => util.access(ctx, next));
    Complaintstatustype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
