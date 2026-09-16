'use strict';
const util = require('../utils/utils');

module.exports = function(Attachmentclassificationtype) {

    Attachmentclassificationtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Attachmentclassificationtype.observe('access', (ctx, next) => util.access(ctx, next));
    Attachmentclassificationtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next)); 

};
