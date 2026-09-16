'use strict';
const LOGGER = require("log4js").getLogger("configurablelinks");
const util = require('../utils/utils');

// for test purpose
// var testfncall = require('./test.js');
// LOGGER.debug('inside Configurablelinks function');
// testfncall.validatefn.isinteger(10);
 



module.exports = function(Configurablelinks) { 


var totalCount;
Configurablelinks.remoteMethod('list', {
        accepts : {arg: 'filter',type: 'Object',http: {source: 'query'},
        required : true},
        description: "Configurablelinks List",
        notes: "Configurablelinks list",
        http: {"verb": "get", "path": "/list"},
        returns : {type : 'Object',root : true}
    });


Configurablelinks.list = (arg) => {
      arg.skip = (arg.page-1) * arg.limit;
        return Configurablelinks.find(arg)
        .then(configurablelinks => configurablelinks)
        .catch(err => LOGGER.debug(err,' ERROR LIST Configurablelinks'));
    };

    Configurablelinks.beforeRemote('list', function(ctx, request, next) {

  if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
      const whereObj = JSON.parse(ctx.req.query.filter).where;
       Configurablelinks.count(whereObj, function(err, count) {

        if (err){ throw err;    }
        totalCount = count;
       });
  }

  next();
 });

 Configurablelinks.afterRemote('list',
   function(ctx, resultset, next) {
    if (ctx.result) {
     ctx.result = {
      'data' : resultset,
      'count' : totalCount
     };
    }
    next();
   });

  Configurablelinks.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Configurablelinks.observe('access', (ctx, next) => util.access(ctx, next));
  Configurablelinks.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));


};
 
