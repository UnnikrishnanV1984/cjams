'use strict';
const util = require('../utils/utils');

module.exports = function(Restitutionpaymentflatfilecontent) {
    Restitutionpaymentflatfilecontent.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Restitutionpaymentflatfilecontent.observe('access', (ctx, next) => util.access(ctx, next));
    Restitutionpaymentflatfilecontent.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}