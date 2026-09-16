'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Stateoffice) {
    Stateoffice.list = request =>{
        var sql='select * from getcountydetails()';

        return util.executeDBQuery(sql, [])
        .then(data => data)
        .catch(err =>util.logError(err));
    }

    
    Stateoffice.remoteMethod('list', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http : {
			path: '/list',
			verb : 'get'
		},
        returns: {
            type: 'string',
            root: true
        }
    });
	Stateoffice.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Stateoffice.observe('access', (ctx, next) => util.access(ctx, next));
    Stateoffice.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    

};
