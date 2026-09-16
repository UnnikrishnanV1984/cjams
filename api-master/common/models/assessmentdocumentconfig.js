'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Assessmentdocumentconfig) {
    Assessmentdocumentconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Assessmentdocumentconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Assessmentdocumentconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


   
}