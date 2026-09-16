'use strict';
const LOGGER = require("log4js").getLogger("personalerttype");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personalerttype) {

    Personalerttype.remoteMethod('getvalues', {
        http: {
            path: '/getvalues',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Personalerttype.getvalues = function(request){
        var sql = "select personalerttypekey,typedescription from personalerttype order by typedescription asc"

        return util.executeDBQuery(sql, [])
            .then(res => {
                return res
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        }

   
        
    Personalerttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personalerttype.observe('access', (ctx, next) => util.access(ctx, next));
    Personalerttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
