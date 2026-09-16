'use strict';
const LOGGER = require("log4js").getLogger("providerassignmentownership");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(providerassignmentownership) {      

      providerassignmentownership.getassignownership = function (request) {
        var eventcode = request.where.eventcode;
        var objectId = request.where.objectid;
       var sql= "SELECT cast(up.firstname || ' ' || up.lastname as character varying) as ownername, * FROM tb_provider_assignment_ownership pao  join userprofile up on up.securityusersid = pao.tosecurityusersid  where pao.eventcode=$1 and pao.objectid =$2 order by pao.insertedon desc";

       return util.executeDBQuery(sql, [eventcode, objectId])
        .then(data => data)
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
}
      providerassignmentownership.remoteMethod(
		'getassignownership', 
				{
					http: {
							path: '/getassignownership',
							verb: 'POST'
					},
					accepts : {
						arg : 'data',
						type : 'object',
						http : {
							source : 'body'
						}
					},   
					returns: {
						type : 'object',
						root : true
					}
					}
	);


	
	
	
	providerassignmentownership.getroutingusers = function (data,reqctx) {
		let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        var userid = data && data.securityuserid?data.securityuserid: suserid;
        var appevent = data.where.appevent;
        var sql = 'SELECT * FROM getroutingusers($1,$2)';
        var params = [userid, appevent];
        return util.executeDBQuery(sql, params)
          .then(getroutingusersdata => {
            return getroutingusersdata;
          })
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
      };

      providerassignmentownership.remoteMethod(
        'getroutingusers',
        {
          http: {
            path: '/getroutingusers',
            verb: 'post'
          },
          accepts: [{
            arg: 'data',
            type: 'Object',
            http: {
              source: 'body'
            }
          },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }
    
          ],
          returns: {
            arg: 'data',
            type: 'Object'
          }
        });
	
	

providerassignmentownership.observe('before save', (ctx, next) => util.beforesave(ctx, next));
providerassignmentownership.observe('access', (ctx, next) => util.access(ctx, next));
providerassignmentownership.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
		
};
