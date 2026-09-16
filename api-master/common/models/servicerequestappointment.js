'use strict';
const LOGGER = require("log4js").getLogger("servicerequestappointment");
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Servicerequestappointment) {    
    Servicerequestappointment.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Servicerequestappointment.observe('access', (ctx, next) => util.access(ctx, next));
    Servicerequestappointment.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    Servicerequestappointment.remoteMethod('addupdate', {
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

    Servicerequestappointment.remoteMethod('appointmentdelete', {
        http: { 
                path: '/appointmentdelete/:id',
                verb: 'delete'
              },
		accepts:
			  {
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });
    
    Servicerequestappointment.remoteMethod('appointmentlisthistory', {
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
    
    Servicerequestappointment.remoteMethod('personappointmentlist', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    var sql;
    Servicerequestappointment.addupdate = function(request,reqctx) {
      const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        if(request.servreqaptmtid == null || request.servreqaptmtid == undefined)
        {
            request.appointmentworkerid = suserid;
            request.appointmentworkertype = server.currentUser.roletypekey;
            return Servicerequestappointment.create(request).then(res => {
                request.actors.map(actorsres=>{
                    app.models.Servicerequestappointmentactor.create({
                    servreqaptmtid:res.servreqaptmtid,
                    actorid: actorsres.actorid,
                    isoptional: actorsres.isoptional});
                });
                return res;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        }
        else
        {

            sql ="update servicerequestappointment set activeflag = 0 WHERE servreqaptmtid =$1";
            return util.executeDBQuery(sql,[request.servreqaptmtid])
            .then(() => {
                sql ="update servicerequestappointmentactor set activeflag = 0 WHERE servreqaptmtid =$1";
                return util.executeDBQuery(sql,[request.servreqaptmtid]);
            })
            .then(() => {
                request.appointmentworkerid = suserid;
                request.appointmentworkertype = server.currentUser.roletypekey;
                delete request.servreqaptmtid;
                return Servicerequestappointment.create(request).then(res => {
                    request.actors.map(actorsres1 => {
                        app.models.Servicerequestappointmentactor.create({
                        servreqaptmtid:res.servreqaptmtid,
                        actorid: actorsres1.actorid,
                        isoptional: actorsres1.isoptional});
                    });
                    return res;
                });
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        }
    };

    Servicerequestappointment.appointmentdelete = (id) => {
		let sql1 = 'update servicerequestappointment set activeflag = 0 WHERE servreqaptmtid =\''+id+'\'';
        return util.executeDBQuery(sql1,[])
        .then(data => {
			 return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };
    
    Servicerequestappointment.appointmentlisthistory = function(data){
         let sql2 = 'SELECT * FROM appointmentlist($1,$2)';
         let params = [data.where.intakeserviceid,data.where.appointmentid];

         return util.executeDBQuery(sql2, params)
             .then(data1 => {
                 return data1;
             })
             .catch(err => {
                 LOGGER.error('>>>>ERROR:', err);
                 throw err;
             });
      };

      Servicerequestappointment.personappointmentlist = request => {
        const personid = request.where.personid;
        const appointmentid = request.where.appointmentid;
        const sql3 = 'select * from personappointmentlist($1, $2)';
        return util.executeDBQuery(sql3, [personid, appointmentid])
        .then(data => data)
        .catch(err => util.logError(err));
      };

      Servicerequestappointment.remoteMethod(
        'reasonintakeinterviewisrequired',
        {
          http: {
            path: '/reasonintakeinterviewisrequired',
            verb: 'post'
          },
          accepts: [{
            arg: 'data',
            type: 'Object',
            http: {
              source: 'body'
            }
          }
    
          ],
          returns: {
            arg: 'data',
            type: 'Object'
          }
        });

        Servicerequestappointment.reasonintakeinterviewisrequired = function (data) {
            let sql4 = 'SELECT * FROM reasonintakeinterviewisrequired($1)';
            let params = [JSON.stringify(data)];

            return util.executeDBQuery(sql4, params)
                .then(data2 => {
                    return data2;
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });

          };

     
}    
