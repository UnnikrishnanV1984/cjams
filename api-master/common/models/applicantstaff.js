'use strict';
const util = require('../utils/utils');

module.exports = function(Applicantstaff) {
    Applicantstaff.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Applicantstaff.observe('access', (ctx, next) => util.access(ctx, next));
    Applicantstaff.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
