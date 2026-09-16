'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Personrelation) {
    
    Personrelation.list = function(request) {
        let personid = '';

        if(request.where && request.where.personid){
            personid = request.where.personid;
        }

        return Personrelation.find({
            where: {personid: personid},
            fields: ['personrelativeid', 'personrelationtypeid'],
            include: [
                {
                relation: 'personrelative',
                scope: {
                    fields: ['firstname','lastname', 'middlename']
                }
            },
            {
                relation: 'personrelationtype',
                scope: {
                    fields: ['personrelationtypekey', 'description']
                }
            }
        ]
        })
        .then(data => {
           return JSON.parse(JSON.stringify(data));
        })
        .catch(err => util.logError(err));
    };

    Personrelation.remoteMethod('list', {
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

    Personrelation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personrelation.observe('access', (ctx, next) => util.access(ctx, next));
    Personrelation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
