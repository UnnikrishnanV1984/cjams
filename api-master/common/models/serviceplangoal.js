'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Serviceplangoal) {    
    Serviceplangoal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplangoal.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplangoal.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    Serviceplangoal.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Serviceplangoal.list =(request)=> {

       var objectid=request.where.objectid;
        var sql = 'select * from getserviceplangoal($1)';

        return util.executeDBQuery(sql,[objectid])
        .then(data => data)
        .catch(err => util.logError(err));

    };
}    