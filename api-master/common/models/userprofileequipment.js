'use strict';
const util = require('../utils/utils');

module.exports = function(Userprofileequipment) {

    Userprofileequipment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Userprofileequipment.observe('access', (ctx, next) => util.access(ctx, next));
    Userprofileequipment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
