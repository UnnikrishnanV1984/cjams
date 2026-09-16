'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Participantsubtype) {
    Participantsubtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Participantsubtype.observe('access', (ctx, next) => util.access(ctx, next));
    Participantsubtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
