var app = require('../../server/server');
const util = require('../utils/utils');
module.exports = function(Actortypeagency) {
    Actortypeagency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Actortypeagency.observe('access', (ctx, next) => util.access(ctx, next));
    Actortypeagency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}