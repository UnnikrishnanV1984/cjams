'use strict';
const LOGGER = require("log4js").getLogger("servicerequestincidenttype");
const util = require('../utils/utils');

module.exports = function(Servicerequestincidenttype) {

	var totalCount;
	Servicerequestincidenttype.remoteMethod('list', {
        accepts : {arg: 'filter',type: 'Object',http: {source: 'query'},
        required : true},
        description: "Servicerequestincidenttype List",
        notes: "Servicerequestincidenttype list",
        http: {"verb": "get", "path": "/list"},
        returns : {type : 'Object',root : true}
    });


    Servicerequestincidenttype.list = (arg) => {         
        arg.skip = (arg.page-1) * arg.limit;
        return Servicerequestincidenttype.find(arg)
        .then(servicerequestincidenttype => servicerequestincidenttype)
        .catch(err => LOGGER.debug(err,' ERROR LIST Servicerequestincidenttype'));
    };


    Servicerequestincidenttype.beforeRemote('list', function(ctx, request, next) {

      if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
        const whereObj = JSON.parse(ctx.req.query.filter).where;
           Servicerequestincidenttype.count(whereObj, function(err, count) {

            if (err){ throw err;    }
            totalCount = count;
           });
      }
      next();
    });

    Servicerequestincidenttype.afterRemote('list',
       function(ctx, resultset, next) {
        if (ctx.result) {
         ctx.result = {
          'data' : resultset,
          'count' : totalCount
         };
        }
        next();
    });

    Servicerequestincidenttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicerequestincidenttype.observe('access', (ctx, next) => util.access(ctx, next));
    Servicerequestincidenttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
