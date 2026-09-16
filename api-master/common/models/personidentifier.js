'use strict';
const util = require('../utils/utils');
const app = require('../../server/server');

module.exports = function (Personidentifier) {

    Personidentifier.list = async function (request) { 
        const where = (request && request.where) ? request.where : {};
        const Person1 = app.models.Person;

        if (where.cjamspid) {
            const searchPerson = await Person1.findOne({ where: { cjamspid: where.cjamspid } });
            if (!searchPerson) return [];
            return [{ personid: searchPerson.personid }];
        }


        const personId = where.personid ?? null;
        if (!personId) return [];

        const findPerson = await Person1.findOne({ where: { personid: personId } });
        if (!findPerson) return [];

        return [findPerson];
    };

    Personidentifier.remoteMethod('list', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/list',
            verb: 'get'
        },
        returns: {
            type: 'string',
            root: true
        }
    });

    Personidentifier.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personidentifier.observe('access', (ctx, next) => util.access(ctx, next));
    Personidentifier.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));


};
