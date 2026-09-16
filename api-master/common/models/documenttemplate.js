'use strict';
const LOGGER = require("log4js").getLogger("documenttemplate");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
module.exports = function (Documenttemplate) {

    Documenttemplate.list = function (data) {
        var sql = 'SELECT * FROM documenttemplaterolewiselist($1,$2,$3)';
        return util.executeSecondaryNodeDBQuery(sql, [data.where.roletypekey, data.where.intakenumber, data.where.intakeserviceid]).then((_data) => {
                return _data;
            }).catch((err) => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };


    //list remote method
    Documenttemplate.remoteMethod('list', {
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
            type: 'Object',
            root: true
        }
    });




    Documenttemplate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Documenttemplate.observe('access', (ctx, next) => util.access(ctx, next));
    Documenttemplate.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
