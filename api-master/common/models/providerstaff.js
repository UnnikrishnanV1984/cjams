'use strict';
const LOGGER = require("log4js").getLogger("providerstaff");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
var config = require('../../server/config.json');
var email = require('../models/email');

module.exports = function (Providerstaff) {

	Providerstaff.assignstaff = function(request,reqctx){
            let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
		var appid = request.applicant_id;
		var userid = (request && request.securityuserid?request.securityuserid: suserid);
		const response = [];
		var result = [];
		const currentDate = new Date().toLocaleString();
		const activitytask = request.staff;
		LOGGER.debug(activitytask, "activitytask");
		if   (activitytask[0]!== null && activitytask[0]!== undefined ){
			LOGGER.debug('yes')
			if(Array.isArray(activitytask)){
				activitytask.forEach(element=>{
					LOGGER.debug(element);
					response.push(
						app.models.Providerstaffconfig.create({
                                          object_id: appid,
                                          provider_staff_id: element.provider_staff_id,
							updatedby: userid,
							updatedon:currentDate,
							insertedby: userid,
							insertedon:currentDate,
							delete_sw: 'N'
				      })
			      )
			}) 
			return Promise.all(response).then(function(values) { 
				values.map(x=>{                         
					result.push(x);                           
				}); 
                        LOGGER.info(result);
				return "Success";
                  });
		}
		}
		return Promise.resolve('Invalid request');
	};


	Providerstaff.remoteMethod(
            'assignstaff', 
                  {
                  http: {
                              path: '/assignstaff',
                              verb: 'post'
                  },
                  accepts : [{
                        arg : 'data',
                        type : 'object',
                        http : {
                              source : 'body'
                        }
                  },{
                        arg: 'reqctx',
                        type: 'object',
                        http: {source: 'context'}
                      }] ,   
                  returns: {
                        type : 'object',
                        root : true
                  }
            }
      );
                  

      Providerstaff.getassignedstaff = function (request) {
            var appid = request.where.provider_applicant_id;
            var getappstaff = 'select * from providerstaffconfig tpas join providerstaff tps on tps.provider_staff_id = tpas.provider_staff_id  where tpas.object_id =$1';
            return util.executeDBQuery(getappstaff, [appid])
                  .catch(err => {
                        LOGGER.error('>>>>ERROR:', err);
                        throw err;
                  });
      };
		
      Providerstaff.remoteMethod(
            'getassignedstaff', {
                  http: {
                        path: '/getassignedstaff',
                        verb: 'post'
                  },
                  accepts: {
                        arg: 'data',
                        type: 'object',
                        http: {
                              source: 'body'
                        }
                  },
                  returns: {
                        type: 'object',
                        root: true
                  }
            }
      );

      Providerstaff.remoteMethod(
            'getassignedstaff', {
                  http: {
                        path: '/getassignedstaff',
                        verb: 'post'
                  },
                  accepts: {
                        arg: 'data',
                        type: 'object',
                        http: {
                              source: 'body'
                        }
                  },
                  returns: {
                        type: 'object',
                        root: true
                  }
            }
      );

      Providerstaff.remoteMethod('updateproviderstaff', {
            http: {
                path: '/updateproviderstaff',
                verb: 'post'
            },
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body'
                }
            }],
            returns: {
                type: 'object',
                root: true
            }
        });

         
        Providerstaff.updateproviderstaff = function (request) {
      LOGGER.debug(request.provider_staff_id);
       return Providerstaff.updateAll({provider_staff_id:request.provider_staff_id 
       },{delete_sw:'Y'}).then(data =>{
             delete request.provider_staff_id;
       return Providerstaff.create({request
        })
       }
       )
         }
  
      
      Providerstaff.observe('before save', (ctx, next) => util.beforesave(ctx, next));
      Providerstaff.observe('access', (ctx, next) => util.access(ctx, next));
      Providerstaff.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
