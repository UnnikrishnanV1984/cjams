'use strict';
const util = require('../utils/utils');

module.exports = function(PlacementPrimaryApprovedAltType) {
    PlacementPrimaryApprovedAltType.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    PlacementPrimaryApprovedAltType.observe('access', (ctx, next) => util.access(ctx, next));
    PlacementPrimaryApprovedAltType.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
