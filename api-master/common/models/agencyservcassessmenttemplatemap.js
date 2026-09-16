'use strict';
const util = require('../utils/utils');

module.exports = function(Agencyservcassessmenttemplatemap) {
    Agencyservcassessmenttemplatemap.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Agencyservcassessmenttemplatemap.observe('access', (ctx, next) => util.access(ctx, next));
    Agencyservcassessmenttemplatemap.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
