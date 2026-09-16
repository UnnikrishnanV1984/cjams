'use strict';
const LOGGER = require("log4js").getLogger("nytddataelements");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(NytdDataElements) {
    NytdDataElements.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    NytdDataElements.observe('access', (ctx, next) => util.access(ctx, next));
    NytdDataElements.observe('after save', (ctx, next) => util.aftersave(ctx, next,'NYTDE', ctx.instance.elementid));
    NytdDataElements.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    NytdDataElements.list = function (request) {
        return NytdDataElements.find({
            }).then(resp => {
                const data = JSON.parse(JSON.stringify(resp));
                LOGGER.debug("data" + JSON.stringify(resp));
                return data;
            })
            .catch(err => err);
    };

    NytdDataElements.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts : [{
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        }],  
        returns: {
            type : 'object',
            root : true
        } 
    });

}
