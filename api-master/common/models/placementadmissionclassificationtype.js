'use strict';
const util = require('../utils/utils');

module.exports = function(placementadmissionclassificationtype) {
    placementadmissionclassificationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    placementadmissionclassificationtype.observe('access', (ctx, next) => util.access(ctx, next));
    placementadmissionclassificationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
