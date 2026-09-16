'use strict';
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("hospitaldetail");
module.exports = function(Hospitaldetail) {

    Hospitaldetail.list = data => {
      let wherecondition = {activeflag: 1, objecttype: null};
      if(data.objecttype == 'SEN') {
        wherecondition = {
          activeflag: 1,
          objecttype: 'SEN'
        }
      }
    return Hospitaldetail.find({
      fields:['name', 'addresss1', 'addresss2', 'city', 'state', 'zipcode', 'county', 'phoneno'],
      nolimit:true,
      where: wherecondition
    })
    .then(_data => {
			return _data;
		})
		.catch(err => LOGGER.error(err));  
};

Hospitaldetail.remoteMethod('list', {
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
    Hospitaldetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Hospitaldetail.observe('access', (ctx, next) => util.access(ctx, next));
    Hospitaldetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};