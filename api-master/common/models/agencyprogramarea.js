'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Agencyprogramarea) {

    Agencyprogramarea.list = (request) => {
        var sql = 'select * from getprogramarea($1)';

        var programkey =  request.where.servicerequestsubtypekey
        if(request.where.programkey){
            sql = 'select * from getsubprogramarea($1)';
            programkey =  request.where.programkey;
        
        }
        return util.executeDBQuery(sql, [programkey])
		.then(datas => datas)
		.catch(err => util.logError(err));
    }

    Agencyprogramarea.remoteMethod('list', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            }
        },
        http : {
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    }) 

    Agencyprogramarea.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Agencyprogramarea.observe('access', (ctx, next) => util.access(ctx, next));
    Agencyprogramarea.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};