'use strict';
const LOGGER = require("log4js").getLogger("folderreasontype");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Folderreasontype) {

    Folderreasontype.remoteMethod('getfolderreasontypelist', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http: {"verb": "get", "path": "/getfolderreasontypelist"},
        returns : {
            type : 'object',
            root : true
        }
      });

      Folderreasontype.getfolderreasontypelist = function(data) {
        var foldertypekey = data.where.foldertypekey;
        var sql = 'SELECT * FROM getfolderreasontypelist($1)';
        return util.executeDBQuery(sql, [foldertypekey])
          .then(_data => _data)
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      };
  
    Folderreasontype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Folderreasontype.observe('access', (ctx, next) => util.access(ctx, next));
    Folderreasontype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
