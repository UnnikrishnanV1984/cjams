'use strict';
const util = require('../utils/utils');

module.exports = function(PlacementPrimaryAdmissionReasonType) {
    PlacementPrimaryAdmissionReasonType.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    PlacementPrimaryAdmissionReasonType.observe('access', (ctx, next) => util.access(ctx, next));
    PlacementPrimaryAdmissionReasonType.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
