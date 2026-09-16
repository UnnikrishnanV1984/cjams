'use strict';
const util = require('../utils/utils');

module.exports = function(PlacementAdmissionType) {
    PlacementAdmissionType.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    PlacementAdmissionType.observe('access', (ctx, next) => util.access(ctx, next));
    PlacementAdmissionType.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
