'use strict';
const util = require('../utils/utils');


module.exports = function(Attachmenttype) {

    Attachmenttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Attachmenttype.observe('access', (ctx, next) => util.access(ctx, next));
    Attachmenttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next)); 

};
