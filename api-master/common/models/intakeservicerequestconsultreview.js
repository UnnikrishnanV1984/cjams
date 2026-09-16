'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestconsultreview");
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
const { now } = require("moment-timezone");
module.exports = function(Intakeservicerequestconsultreview) {   

    Intakeservicerequestconsultreview.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Intakeservicerequestconsultreview.remoteMethod('consultreviewdelete', {
        http: { 
                path: '/consultreviewdelete/:id',
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

    Intakeservicerequestconsultreview.remoteMethod('consultreviewconfigdelete', {
        http: { 
                path: '/consultreviewconfigdelete/:id',
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

    Intakeservicerequestconsultreview.remoteMethod('listconsultreview', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            path: '/listconsultreview',
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });
    Intakeservicerequestconsultreview.addupdate = function(request)
    { 
        if(request.intakeservicerequestconsultreviewid== null || request.intakeservicerequestconsultreviewid == undefined)
        {      
            return Intakeservicerequestconsultreview.create(request).then(res => {
                
                request.resourceConsultUser.forEach(resourceConsultUsers => {
                    resourceConsultUsers.intakeservicerequestconsultreviewid=res.intakeservicerequestconsultreviewid;
                    resourceConsultUsers.insertedon= new Date().toLocaleString();
                return app.models.Intakeservicerequestconsultreviewconfig.create(resourceConsultUsers)
            });
            return res;
        });
        }
        else
        {
            
          return Intakeservicerequestconsultreview.updateAll({intakeservicerequestconsultreviewid:request.intakeservicerequestconsultreviewid},request).then(res => {
            request.resourceConsultUser.forEach(resourceConsultUsers => {
            if(resourceConsultUsers.intakeservicerequestconsultreviewconfigid != null)
            {
                resourceConsultUsers.updatedon= new Date().toLocaleString();
                return app.models.Intakeservicerequestconsultreviewconfig.updateAll({intakeservicerequestconsultreviewid:resourceConsultUsers.intakeservicerequestconsultreviewconfigid},resourceConsultUsers);   
            }
            else
            {
            resourceConsultUsers.intakeservicerequestconsultreviewid=request.intakeservicerequestconsultreviewid;
            resourceConsultUsers.insertedon= new Date().toLocaleString();
            return app.models.Intakeservicerequestconsultreviewconfig.create(resourceConsultUsers);
            }
        });
            return res;
          });
    }
    };

    Intakeservicerequestconsultreview.consultreviewdelete = (id) => {
		var sql = 'update intakeservicerequestconsultreview set activeflag = 0,updatedon=now() WHERE intakeservicerequestconsultreviewid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Intakeservicerequestconsultreview.consultreviewconfigdelete = (id) => {
		var sql = 'update intakeservicerequestconsultreviewconfig set activeflag = 0,updatedon=now() WHERE intakeservicerequestconsultreviewconfigid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .then(_data => {
                return _data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };
        
        Intakeservicerequestconsultreview.listconsultreview = function(request){
            const sql = 'Select * from listconsultreview($1, $2, $3, $4)';
            return util.executeDBQuery(sql, [request.where.objectid, request.where.objecttypekey, request.page, request.limit])
            .then(data => data)
            .catch(err => util.logError(err));
        };
    
    Intakeservicerequestconsultreview.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestconsultreview.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestconsultreview.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
