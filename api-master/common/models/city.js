'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(City) {


    City.remoteMethod('getstatedetails', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    City.getstatedetails=(request)=>{
        var zipcode = request.where.zipcode;
        var sql= 'select * from getstatedetails($1)';
        return util.executeDBQuery(sql,[zipcode])
        .catch(err => util.logError(err));
    };
    City.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    City.observe('access', (ctx, next) => util.access(ctx, next));
    City.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}