'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
var server = require('../../server/server');

module.exports = function(Alias) {

    Alias.list = request => {
        const personid = request.where.personid;
        return Alias.find({
            where: {personid: personid},
            order: 'updatedon desc',
            include: [{
                relation: 'inserteduser',
                scope: {
                    fields: ['firstname', 'lastname', 'displayname', 'cjamspid']
                }
            },{
                relation: 'updateduser',
                scope: {
                    fields: ['firstname', 'lastname', 'displayname', 'cjamspid']
                }
            }]
        })
        .catch(err => util.logError(err));
    };

    Alias.remoteMethod(
        'list', {
            http: {
                path: '/list',
                verb: 'get'
            },
            accepts: [{
                arg: 'filter',
                type: 'object',
                http: {
                    source: 'query'
                }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );

    Alias.add = request => {
        return Alias.create(request)
        .catch(err => util.logError(err));
    };

    Alias.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Alias.updatealias = request => {
        return Alias.updateAll(
            {aliasid: request.aliasid},
            {
                firstname: request.firstname,
                lastname: request.lastname,
                middlename: request.middlename
            }
        )
        .catch(err => util.logError(err));
    };

    Alias.remoteMethod('updatealias', {
        http: {
                path: '/updatealias',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Alias.deletealias = request => {
      const sqlCmd = "update alias set activeflag = 0 where aliasid = $1";

      return util.executeDBQuery(sqlCmd, [request.aliasid])
      .catch(err => util.logError(err));
    };

    Alias.remoteMethod('deletealias', {
        http: {
                path: '/deletealias',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Alias.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Alias.observe('access', (ctx, next) => util.access(ctx, next));
    Alias.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
