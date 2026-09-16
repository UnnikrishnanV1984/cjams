'use strict';
const LOGGER = require("log4js").getLogger("pubprovapphouseholdbgchecks");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');
var email = require('../models/email');

module.exports = function (Pubprovapphouseholdbgchecks) {

    Pubprovapphouseholdbgchecks.remoteMethod('getlist', {
        http: {
            path: '/getlist',
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

    Pubprovapphouseholdbgchecks.getlist =(request)=> {
       

        var sql = 'select count(1) over() as totalcount,* from pubprovapphouseholdbgchecks where personid=$1 and objectid=$2';

        return util.executeDBQuery(sql, [request.where.personid,request.where.objectid])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };

    Pubprovapphouseholdbgchecks.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Pubprovapphouseholdbgchecks.observe('access', (ctx, next) => util.access(ctx, next));
    Pubprovapphouseholdbgchecks.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};