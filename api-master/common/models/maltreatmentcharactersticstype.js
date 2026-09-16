'use strict';
const util = require('../utils/utils');

module.exports = function(Maltreatmentcharactersticstype) {

    Maltreatmentcharactersticstype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Maltreatmentcharactersticstype.observe('access', (ctx, next) => util.access(ctx, next));
    Maltreatmentcharactersticstype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};