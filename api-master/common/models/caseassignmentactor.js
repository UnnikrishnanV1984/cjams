'use strict';
const util = require('../utils/utils');
module.exports = function(Caseassignmentactor) {
    Caseassignmentactor.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Caseassignmentactor.observe('access', (ctx, next) => util.access(ctx, next));
    Caseassignmentactor.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};
