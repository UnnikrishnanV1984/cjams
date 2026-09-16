'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Intakeservreqadultscreentool) {


Intakeservreqadultscreentool.list = request => {

    const sql = 'select * from getadultscreentool($1)';
    return util.executeDBQuery(sql, [request.where.servicerequestid])
    .then(data => data)
    .catch(err => util.logError(err));
  };


Intakeservreqadultscreentool.remoteMethod('list', {
    accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
            source : 'query'
        },
        required : true
    },
    http : {
        verb : 'get'
    },
    returns : {
        type : 'Object',
        root : true
    }
});


    Intakeservreqadultscreentool.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqadultscreentool.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqadultscreentool.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
