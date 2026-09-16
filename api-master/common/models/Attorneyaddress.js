'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Attorneyaddress) {

    Attorneyaddress.getaddress = (request) => {

        return Attorneyaddress.find({
            where:{activeflag:1},
            nolimit:true,
            fields:['attorneyname','addressline1','addressline2','attorneyphonenumber','attorneyfax','attorneyemail','county','statekey','zipcode','division']
            ,order: request.order
        }

        )
    }

    Attorneyaddress.remoteMethod('getaddress', {
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
            type : 'string',
            root : true
        }
    });
    
    Attorneyaddress.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Attorneyaddress.observe('access', (ctx, next) => util.access(ctx, next));
    Attorneyaddress.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}