'use strict';
const util = require('../utils/utils');

module.exports = function(familyinvolvementmeeting) {

    familyinvolvementmeeting.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    familyinvolvementmeeting.observe('access', (ctx, next) => util.access(ctx, next));
    familyinvolvementmeeting.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
