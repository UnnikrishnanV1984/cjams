'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Adjudicateddecisiontype) {    
    Adjudicateddecisiontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Adjudicateddecisiontype.observe('access', (ctx, next) => util.access(ctx, next));
    Adjudicateddecisiontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}