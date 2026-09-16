'use strict';
const LOGGER = require("log4js").getLogger("providerapproval");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');
var email = require('./email');

module.exports = function (Providerapproval) {
      
      Providerapproval.remoteMethod('getapprovaltype', {
        http: {
            path: '/getapprovaltype',
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

    Providerapproval.getapprovaltype =(request)=> {
        var providerid= request.where.providerid;
        LOGGER.debug(providerid+"My idddd");
        var totalcount=0;
        var sql = 'select * from getapprovalprovider($1,$2,$3)';

        return util.executeDBQuery(sql, [providerid,request.page,request.limit])
        .then(data => {
                    if (data!==null && data.length>0) {
                        totalcount= data[0].totalcount;
                    }
                    let result;
                    result = {
                        totalcount: totalcount,
                        data: data
                    };
                    return result;
        })
        .catch(err => util.logError(err));
    };


  Providerapproval.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Providerapproval.observe('access', (ctx, next) => util.access(ctx, next));
  Providerapproval.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};
