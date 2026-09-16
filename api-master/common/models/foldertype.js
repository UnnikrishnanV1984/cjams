'use strict';
const util = require('../utils/utils');

module.exports = function(Foldertype) {
  
    Foldertype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Foldertype.observe('access', (ctx, next) => util.access(ctx, next));
    Foldertype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}