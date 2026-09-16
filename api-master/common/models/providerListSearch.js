'use strict';
const LOGGER = require("log4js").getLogger("providerListSearch");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Providerlist) {
    Providerlist.findByProvider = (providerId, providerName, taxId, zipCd, serviceId, filtertype, page) =>{
    LOGGER.debug('hello');
    const limit = 10;
    const dataQuery = 'SELECT * from get_provider_search($1, $2, $3, $4, $5, $6, $7, $8)';
            return util.executeDBQuery(dataQuery, [providerId, providerName, taxId, zipCd, serviceId, page ,limit, filtertype])
                .then(result => {
                    LOGGER.debug('success');
                    LOGGER.debug(result,'result');
                    return result;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        };
        Providerlist.remoteMethod ('findByProvider', {
        http: {
            path: '/values',
            verb: 'get'
        },
        accepts: [{
            arg: 'providerId',
            type: 'number',
            http: {
              source: 'query'
            }
        }, {
            arg: 'providerName',
            type: 'string',
            http: {
                source: 'query'
            }
        }, {
            arg: 'taxId',
            type: 'number',
            http: {
                source: 'query'
            }
        }, {
            arg: 'zipCd',
            type: 'number',
            http: {
                source: 'query'
            }
        }, {
            arg: 'serviceId',
            type: 'number',
            http: {
                source: 'query'
            }    

        },
        {
            arg: 'limit',
            type: 'number',
            http: {
                source: 'query'
            }    

        },
        {
            arg: 'page',
            type: 'number',
            http: {
                source: 'query'
            }    

        }
    ],
        returns: {
            arg: 'UserToken', 
            type: 'Object'
        }
        
    });

    Providerlist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Providerlist.observe('access', (ctx, next) => util.access(ctx, next));
    Providerlist.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};