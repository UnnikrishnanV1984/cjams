'use strict';
const LOGGER = require("log4js").getLogger("tb-services");
var server = require('../../server/server');
const util = require('../utils/utils');


module.exports = function (Tbservices) {
    Tbservices.agencyservices = (request) => {
        LOGGER.debug('hello');
        const dataQuery = 'SELECT * from GET_SERVLIST_NAMES()';
        return util.executeDBQuery(dataQuery).then(result => {
            LOGGER.debug('success');
            LOGGER.debug(result, 'result');
            return result;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    Tbservices.remoteMethod('agencyservices', {
        http: {
            path: '/agencyservices',
            verb: 'get'
        },
        accepts: {
            arg: 'User',
            type: 'Object',
            http: {
                source: 'body'
            }
        },
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }
    });

    Tbservices.vendorservices = (request) => {
        LOGGER.debug('hello');
        const dataQuery = 'SELECT * FROM  get_servlist_Vendor(null)';
        return util.executeDBQuery(dataQuery).then(result1 => {
            LOGGER.debug('success');
            LOGGER.debug(result1, 'result');
            return result1;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    Tbservices.remoteMethod('vendorservices', {
        http: {
            path: '/vendorservices',
            verb: 'get'
        },
        accepts: {
            arg: 'User',
            type: 'Object',
            http: {
                source: 'body'
            }
        },
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }
    });

    Tbservices.allvendorservices = (request) => {
        LOGGER.debug('hello');
        const dataQuery = 'SELECT * FROM  get_all_servlist_vendor()';
        return util.executeDBQuery(dataQuery).then(result2 => {
            LOGGER.debug('success');
            LOGGER.debug(result2, 'result');
            return Array.isArray(result2) ? result2 : [];
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); return []; });
    };
    Tbservices.remoteMethod('allvendorservices', {
        http: {
            path: '/allvendorservices',
            verb: 'get'
        },
        accepts: {
            arg: 'User',
            type: 'Object',
            http: {
                source: 'body'
            }
        },
        returns: {
            arg: 'UserToken',
            type: 'Object'
        }
    });

    Tbservices.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tbservices.observe('access', (ctx, next) => util.access(ctx, next));
    Tbservices.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};


