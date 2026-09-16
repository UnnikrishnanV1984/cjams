'use strict';
const util = require('../utils/utils');

module.exports = function(Contactparticipant) {

    Contactparticipant.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Contactparticipant.observe('access', (ctx, next) => util.access(ctx, next));
    Contactparticipant.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
