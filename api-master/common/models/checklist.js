'use strict';
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Checklist) {

    Checklist.remoteMethod('checklistdisplayorder', {
        http: {
            path: '/checklistdisplayorder',
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

    Checklist.checklistdisplayorder = function(request){
     
        var sql = "select * from checklist where checklisttypekey=$1 and activeflag=1 order by displayorder asc"
            
        return util.executeSecondaryNodeDBQuery(sql,[request.where.checklisttypekey]).then((data) => {
              return data;
           }).catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
        } 


Checklist.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Checklist.observe('access', (ctx, next) => util.access(ctx, next));
Checklist.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}