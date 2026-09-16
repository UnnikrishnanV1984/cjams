'use strict';

var app = require('../../server/server');
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("reviewrecommendations");

module.exports = function(Reviewrecommendations) {

    // Reviewrecommendations add/update 
    Reviewrecommendations.addupdate = (request,reqctx) => {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        var securityuserid =(request && request.securityuserid?request.securityuserid: suserid);
        
        var sql = "select * from reviewrecommendationsaddupdate($1,$2)"
        return util.executeDBQuery(sql, [request, securityuserid])
          .then(res =>{
            return res
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
    };

    Reviewrecommendations.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
				arg: 'reqctx',
				type: 'object',
				http: {source: 'context'}
			  } ],
        returns: {
            type : 'string',
            root : true
        }
    }); 
    
     // Review type list
     Reviewrecommendations.getReviewtypeList = function (data) {

		var sql = 'select * from getreviewtypelist()'

		return util.executeDBQuery(sql, [])
			.then(data1 => {
				return data1;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};
	
	Reviewrecommendations.remoteMethod('getReviewtypeList', {
		accepts: [{
            arg: 'filter',
            type: 'object',
            required: false

        }],
        http: {
			verb: 'get'
		},
		returns: {
			type: 'Object',
			root: true
		}
    });
    

    // fetch Reviewrecommendations based on casereviewid
	Reviewrecommendations.fetchrecommendationsbycasereviewid = function (data) {

		var sql = 'select * from fetchrecommendationsbycasereviewid($1)'
		var params = [data.where.casereviewid];

		return util.executeDBQuery(sql, params)
			.then(fetchrecommendationsbycasereviewiddata => {
				return fetchrecommendationsbycasereviewiddata;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};
	
	Reviewrecommendations.remoteMethod('fetchrecommendationsbycasereviewid', {
		accepts: {
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true
		},
		http: {
			verb: 'get'
		},
		returns: {
			type: 'Object',
			root: true
		}
	});
	
    Reviewrecommendations.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Reviewrecommendations.observe('access', (ctx, next) => util.access(ctx, next));
    Reviewrecommendations.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
