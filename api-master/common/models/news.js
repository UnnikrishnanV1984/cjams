'use strict';
const LOGGER = require("log4js").getLogger("news");
const util = require('../utils/utils');

module.exports = function(News) { 
 
	var totalCount;
News.remoteMethod('list', {
        accepts : {arg: 'filter',type: 'Object',http: {source: 'query'},
        required : true},
        description: "News List",
        notes: "News list",
        http: {"verb": "get", "path": "/list"},
        returns : {type : 'Object',root : true}
    });




News.beforeRemote('list', function(ctx, request, next) {

  if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
    const whereObj = JSON.parse(ctx.req.query.filter).where;
       News.count(whereObj, function(err, count) {

        if (err){ throw err;    }
        totalCount = count;
       });
  }

  next();
 });

 News.afterRemote('list',
   function(ctx, resultset, next) {
    if (ctx.result) {
     ctx.result = {
      'data' : resultset,
      'count' : totalCount
     };
    }
    next();
   });

 
News.list = (arg) => {         
    arg.skip = (arg.page-1) * arg.limit;
        return News.find(arg)
        .then(news => news)
        .catch(err => LOGGER.debug(err,' ERROR LIST NEWS'));
    };

    News.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    News.observe('access', (ctx, next) => util.access(ctx, next));
    News.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
