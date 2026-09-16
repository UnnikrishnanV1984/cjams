'use strict';
const LOGGER = require("log4js").getLogger("statestatutes");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Statestatutes) {

	var totalCount;
	Statestatutes.remoteMethod('list', {
        accepts : {arg: 'filter',type: 'Object',http: {source: 'query'},
        required : true},
        description: "Statestatutes List",
        notes: "Statestatutes list",
        http: {"verb": "get", "path": "/list"},
        returns : {type : 'Object',root : true}
    });

	Statestatutes.beforeRemote('list', function(ctx, request, next) {

  if (JSON.parse(ctx.req.query.filter).page !== 'undefined' && JSON.parse(ctx.req.query.filter).page === 1) {
    const whereObj = JSON.parse(ctx.req.query.filter).where;
       Statestatutes.count(whereObj, function(err, count) {

        if (err){ throw err;    }
        totalCount = count;
       });
  }

  next();
 });

 Statestatutes.afterRemote('list',
   function(ctx, resultset, next) {
    if (ctx.result) {
     ctx.result = {
      'data' : resultset,
      'count' : totalCount
     };
    }
    next();
   });
    

    Statestatutes.list = (arg) => {      
        arg.skip = (arg.page-1) * arg.limit;   
        return Statestatutes.find(arg)
        .then(statestatutes => statestatutes)
        .catch(err => LOGGER.debug(err,' ERROR LIST Statestatutes'));
    };


  Statestatutes.getRegulationLibrary = function (data) {

    var Totalcount = 0;
    var showCount = false;
    if (data.page == 1) {
      showCount = true
    }
    var newJsonStructure = data.where;
    newJsonStructure["page"] = data.page;
    newJsonStructure["limit"] = data.limit;

    if (showCount) {
      var countQuery = 'select * from getregulationlibrary_cnt(\'' + JSON.stringify(newJsonStructure) + '\')';
      return util.executeDBQuery(countQuery, [])
        .then(data1 => {
          Totalcount = data1[0].getregulationlibrary_cnt;
          if (Totalcount > 0) {
            var sql = 'select * from getregulationlibrary(\'' + JSON.stringify(newJsonStructure) + '\')';
            return util.executeDBQuery(sql,[])
              .then(data2 => {
                var result;
                result = {
                  'data': data2,
                  'count': Totalcount
                };
                return result;
              });
          } else {
            var result1;
            result1 = {
              'data': [],
              'count': Totalcount
            };
            return result1;
          }
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    } else {
      var sql1 = 'select * from getregulationlibrary(\'' + JSON.stringify(newJsonStructure) + '\')';
      return util.executeDBQuery(sql1,[])
        .then(data3 => {
          var result2;
          result2 = {
            'data': data3
          };
          return result2;
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        })
    }
  }

   Statestatutes.remoteMethod(
        'getRegulationLibrary', 
              {
                http: {
                    path: '/getRegulationLibrary',
                    verb: 'post'
                },
               accepts : [ {arg : 'data',type : 'object',
                  http : {source : 'body'}} ],   
                returns: {
                  type : 'object',
                root : true
                }
               }
      );


};
