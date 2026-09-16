'use strict';
const util = require('../utils/utils');

module.exports = function(Tb_foster_care_rate_stg) {    
    Tb_foster_care_rate_stg.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_foster_care_rate_stg.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_foster_care_rate_stg.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}