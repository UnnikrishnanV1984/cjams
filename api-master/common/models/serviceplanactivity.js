'use strict';
const LOGGER = require("log4js").getLogger("serviceplanactivity");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Serviceplanactivity) {    
    Serviceplanactivity.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanactivity.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanactivity.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
           
    Serviceplanactivity.remoteMethod('list', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    }); 

    Serviceplanactivity.list = function(request){
       var newJsonStructure = request.where;
       newJsonStructure["pagenumber"] = request.page;
       newJsonStructure["pagesize"] = request.limit;

        var sql = 'select * from serviceplanactivitylist($1)';
        return util.executeDBQuery(sql,[JSON.stringify(newJsonStructure)])
            .then(data => {
                let totalCount = 0;
                if (data.length > 0 ) {totalCount = data[0].totalcount;}
                data.forEach(x => {
                delete x.totalcount;
                })
                
                return {count: totalCount, data: data};
            })
            .catch(err => err);
    };	   


    Serviceplanactivity.serviceplanunmetlist= (request) =>{
        var objectid=request.where.objectid;
       
        var page = request.page;
        var limit = request.limit;
        
        var totalcount = 0;

        const sql = 'Select * from serviceplanunmetlist($1,$2,$3)';

        return util.executeDBQuery(sql, [objectid, page, limit])
            .then(data => {
                if (data!==null && data.length>0) {totalcount= data[0].totalcount;}

                var result;
                result = {
                    'data' : data,
                    'count' : totalcount
                };
                LOGGER.debug(result)
                return result;
            })
            .catch(err => util.logError(err));
      }
      Serviceplanactivity.remoteMethod('serviceplanunmetlist', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
            path:'/serviceplanunmetlist',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });
}    