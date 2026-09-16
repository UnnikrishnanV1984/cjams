'use strict';
const LOGGER = require("log4js").getLogger("school");
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(school) {


        school.listschool = function( schoolname,request) {

          var searchval="";

          if (schoolname!=undefined&& schoolname!=null && schoolname!=""){
            searchval =schoolname;
          }else  if (request!=undefined&& request!=null && request!=""){
            searchval =request.where.schoolname;
          }
          var sql = 'select * from listschool($1)';

          return util.executeDBQuery(sql, [searchval])
            .then(data => {
              return data;
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });

      };

      school.remoteMethod('listschool', {
        accepts: [
          {  
            arg: 'school_name',
            type: 'string',
            required: false,
            http: {source: 'query'},
        
          },
          {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: false,
        
        } 
      ], 
        http: {"verb": "get"},
        returns: {
          type: 'Object',
          root: true
        }
      });

      school.remoteMethod('searchschoollist', {
        accepts : {
          arg : 'filter',
          type : 'Object',
          http : {
            source : 'query'
          },
          required : true
        },
        http : {
          path: '/searchschoollist',
          verb : 'get'
        },
        returns : {
          type : 'string',
          root : true
        }
      });

      school.searchschoollist = request => {
        let searchkey = ''
        if(request.where) {
          searchkey = request.where.searchkey;
        }
        const sql = 'Select * from searchschoollist($1)';
        return util.executeDBQuery(sql, [searchkey])
        .then(data => data)
        .catch(err => util.logError(err));
      };

     school.observe('before save', (ctx, next) => util.beforesave(ctx, next));
     school.observe('access', (ctx, next) => util.access(ctx, next));
     school.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
