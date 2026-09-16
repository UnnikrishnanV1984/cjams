'use strict';
const LOGGER = require("log4js").getLogger("personnickname");
const util = require('../utils/utils');
var app = require('../../server/server');
var server = require('../../server/server');

module.exports = function(Personnickname) {

    Personnickname.list = request => {
        const personid = request.where.personid;
        return Personnickname.find({
            where: {personid: personid},
            order: 'nickname asc',
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

    Personnickname.remoteMethod(
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

    Personnickname.add = request => {
        return Personnickname.create(request)
        .catch(err => util.logError(err));
    };

    Personnickname.remoteMethod('add', {
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

    Personnickname.updateNickname = request => {
        return Personnickname.updateAll(
            {personnicknameid: request.personnicknameid}, 
            {nickname: request.nickname}
        )
        .catch(err => util.logError(err));
    };

    Personnickname.remoteMethod('updateNickname', {
        http: {
                path: '/updateNickname',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Personnickname.deleteNickname = request => {
      const sqlCmd = "update personnickname set activeflag = 0 where personnicknameid = $1";

      return util.executeDBQuery(sqlCmd, [request.personnicknameid])
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personnickname.remoteMethod('deleteNickname', {
        http: {
                path: '/deleteNickname',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Personnickname.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personnickname.observe('access', (ctx, next) => util.access(ctx, next));
    Personnickname.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    
};
