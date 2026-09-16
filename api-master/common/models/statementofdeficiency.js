'use strict';
const util = require('../utils/utils');

module.exports = function(Statementofdeficiency) {
    Statementofdeficiency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Statementofdeficiency.observe('access', (ctx, next) => util.access(ctx, next));
    Statementofdeficiency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
