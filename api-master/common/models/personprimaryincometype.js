'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Personprimaryincometype) {

    Personprimaryincometype.remoteMethod('getvalues', {
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

    Personprimaryincometype.getvalues = function(request){
     
        var sql = "select personprimaryincometypekey,typedescription from personprimaryincometype order by typedescription asc"
        return util.executeDBQuery(sql, []).then(res =>{
            return res
          });
        }

   
        
    Personprimaryincometype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personprimaryincometype.observe('access', (ctx, next) => util.access(ctx, next));
    Personprimaryincometype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
