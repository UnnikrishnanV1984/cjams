'use strict';
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("schoollistreference");
module.exports = function(Schoollistreference) {

    Schoollistreference.list = data => {
    return Schoollistreference.find({
      fields:['schoolname', 'address1', 'address2', 'city', 'state', 'zipcode', 'county', 'phoneno'],
      nolimit:true,
      where: {activeflag: 1},
      order: 'schoolname ASC'
    })
    .then(_data => {
			return _data;
		})
		.catch(err => {
            LOGGER.error(err);
          });  
};

Schoollistreference.remoteMethod('list', {
      http: {
        path: '/list',
        verb: 'get'
      },
      accepts : [ {
        arg: 'filter',
        type: 'Object',
        required: true,
        http: {source: 'query'}
      } ],
      returns: {
        type : 'Object',
        root : true
      }
    });
    Schoollistreference.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Schoollistreference.observe('access', (ctx, next) => util.access(ctx, next));
    Schoollistreference.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};