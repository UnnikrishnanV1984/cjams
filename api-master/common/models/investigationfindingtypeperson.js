var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Investigationfindingtypeperson) {
    Investigationfindingtypeperson.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Investigationfindingtypeperson.observe('access', (ctx, next) => util.access(ctx, next));
    Investigationfindingtypeperson.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}