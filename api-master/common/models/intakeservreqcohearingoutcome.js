'use strict';
const util = require('../utils/utils');

module.exports = function (Intakeservreqcohearingoutcome) {
    Intakeservreqcohearingoutcome.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqcohearingoutcome.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqcohearingoutcome.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};
