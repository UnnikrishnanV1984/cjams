'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Healthassessmenttype) {

    Healthassessmenttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Healthassessmenttype.observe('access', (ctx, next) => util.access(ctx, next));
    Healthassessmenttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}    