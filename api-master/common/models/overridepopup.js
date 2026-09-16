'use strict';
const LOGGER = require("log4js").getLogger("overridepopup");
const errorUtils = require('../../server/utils/error-utils');
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
var email = require('../models/email');
const pdf = require('../models/pdf');

module.exports = function(overridepopup) {    

    overridepopup.remoteMethod('listla', {
        http: {
                path: '/listla',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    overridepopup.listla = request => {
        const sql = ` with list as (  select * from overduepopup c where objectid = $1) select * from list order by insertedon desc; `;
        return util.executeDBQuery(sql, [request.placementid])
            .then(result => ({
                success: true,
                data: result
            }))
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                return {
                    message: err,
                    success: false
                };
            });
    };


    overridepopup.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    overridepopup.addupdate = request => {
        const sql = 'select * from addupdateoverrideup($1::json)';
        return util.executeDBQuery(sql, [request])
            .then(result => result[0])
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                return {
                    success: false,
                    message: err
                };
            });
    };

   
   
    overridepopup.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    overridepopup.observe('access', (ctx, next) => util.access(ctx, next));
    overridepopup.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));    
}    
