'use strict';
const LOGGER = require("log4js").getLogger("foldertypeproviderconfig");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Foldertypeproviderconfig) {

     //sprint 5 changes for add placement  and provider list
     Foldertypeproviderconfig.remoteMethod('listProviderByFoldertype', {
        accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
        source : 'query'
        },
        required : true
        },
        http : {
        path: '/listProviderByFoldertype',
        verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
        });
        
        Foldertypeproviderconfig.listProviderByFoldertype = function(request){
        var sql = "select * from getproviderbyfoldertype($1)"
        return util.executeDBQuery(sql, [request.where.foldertype])
        .then(res =>{
        return res
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
        }

    Foldertypeproviderconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Foldertypeproviderconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Foldertypeproviderconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}