'use strict';
const util = require('../utils/utils');

module.exports = function(Intakeservreqcourtorderdetails) {
    Intakeservreqcourtorderdetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqcourtorderdetails.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqcourtorderdetails.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
