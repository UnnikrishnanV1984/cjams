'use strict';
const util = require('../utils/utils');

module.exports = function(Maltreatmentjurisdictionuser) {

    Maltreatmentjurisdictionuser.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Maltreatmentjurisdictionuser.observe('access', (ctx, next) => util.access(ctx, next));
    Maltreatmentjurisdictionuser.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}