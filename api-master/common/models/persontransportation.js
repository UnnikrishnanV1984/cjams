'use strict';
const LOGGER = require("log4js").getLogger("persontransportation");
const util = require('../utils/utils');
var app = require('../../server/server');

const transportationsubmittedmsg = 'Transportation Submitted for review';

module.exports = function(Persontransportation) {
    

    Persontransportation.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });
    Persontransportation.remoteMethod('updatetransport', 
        {
            http: {
                path: '/updatetransport/:id',
                verb: 'post'
            },
           accepts : [
            {
              arg: 'id',
             type: 'string',
              required: true,
              http: {source: 'path'}
          },
            {arg : 'data',type : 'object',
               http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
                }
                ],
            returns: {
              type : 'object',
            root : true
            }
    });
    Persontransportation.remoteMethod('deletetransport', {
        http: { 
                path: '/deletetransport/:id',
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
    Persontransportation.remoteMethod('list', {
        accepts: [{
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }],
        http: {
            path:'/list',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });
      Persontransportation.remoteMethod('getpersontransportationbyId', {
        accepts: [{
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }],
        http: {
            path:'/getpersontransportationbyId',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });
    
    Persontransportation.add = (request, reqctx) => {
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  

        var securityuserid =(request && request.securityuserid?request.securityuserid: _securityusersid);
        var intakeserviceid = request.intakeserviceid;
                return app.models.Persontransportation.create({
                    intakeserviceid: intakeserviceid,
                    dateoftransport :request.pickuptime,
                    pickuptime:request.pickuptime,
                    droptime:request.droptime,
                    youthname:request.youthname,
                    dob:request.dob,
                    locationfromtypekey:request.locationfromtypekey,
                    locationtotypekey:request.locationtotypekey,
                    otherlocationfrom:request.otherlocationfrom,
                    otherlocationto:request.otherlocationto,
                    chargereason:request.chargereason,
                    notes:request.notes,
                    personid:request.personid,
                    allegationid:request.allegationid,
                    courtlocation:request.courtlocation,
                    courttime:request.courttime,
                    insertedby: securityuserid,
                    updatedby: securityuserid, 
                })
                .then(res =>{
                    var data =res;
                    var persontransportationid =res.persontransportationid;
                    var notifymsg = transportationsubmittedmsg;
                    var routeddescription = transportationsubmittedmsg;
                    var comments = transportationsubmittedmsg;
                    var status = 78;

                    if(intakeserviceid!=null) {
                        var qry = 'SELECT * FROM routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
                        util.executeDBQuery(qry, [persontransportationid,securityuserid,'PNTR',status,comments,'',false,false,false,notifymsg,routeddescription,intakeserviceid])
                          .catch(err => {
                            LOGGER.error('>>>>ERROR:', err);
                            throw err;
                          });
                        }
                        return data;
                })
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                })
    }
    Persontransportation.updatetransport = (id,request, reqctx) =>{
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
       return Persontransportation.updateAll(
           {
            persontransportationid:id
           },
           {
            dateoftransport:request.pickuptime,
            personid: request.personid,
            pickuptime:request.pickuptime,
            droptime:request.droptime,
            youthname:request.youthname,
            appointmentdate:request.appointmentdate,
            dob:request.dob,
            courttime:request.courttime,
            courtlocation:request.courtlocation,
            chargereason:request.chargereason,
            locationfromtypekey:request.locationfromtypekey,
            locationtotypekey:request.locationtotypekey,
            otherlocationfrom:request.otherlocationfrom,
            otherlocationto:request.otherlocationto,
            notes:request.notes,
            updatedby:(request && request.securityuserid?request.securityuserid: _securityusersid),
            allegationid:request.allegationid
           }
       ).then(data=>{
           return data;

       })
       .catch(err => {
           LOGGER.error('>>>>ERROR:', err);
           throw err;
       });
    }

    Persontransportation.deletetransport = (id) => {
		var sql = 'update Persontransportation set activeflag = 0 WHERE Persontransportationid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Persontransportation.list= (request, reqctx) =>{
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
        var intakeserviceid=request.where.intakeserviceid;
        var personid = request.where.personid;
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var page = request.page;
        var limit = request.limit;
        
        var totalcount = 0;

        const sql = 'Select * from getpersontransportation($1,$2,$3,$4,$5)';

        return util.executeDBQuery(sql, [intakeserviceid,personid,securityusersid, page, limit])
            .then(data => {
                  if (data!==null && data.length>0) {
                    totalcount= data[0].totalcount;
                  }

                  var result;
                  result = {
                      'data' : data,
                      'count' : totalcount
                  };
                  LOGGER.debug(result)
                  return result;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
      }
      Persontransportation.getpersontransportationbyId= (request, reqctx) =>{
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        var persontransportationid=request.where.persontransportationid;
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        const sql = 'select * from getpersontransportationbyId($1, $2)';
        return util.executeDBQuery(sql, [persontransportationid, securityusersid])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
      }

      Persontransportation.remoteMethod('gettransportrosterwithalerts', {
        accepts: {
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        },
        http: {
            path:'/gettransportrosterwithalerts',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });

      Persontransportation.gettransportrosterwithalerts= (request) =>{

        var pickupstarttime='';
        
        if(util.isNullorEmpty(request.where.pickupstarttime)){
          pickupstarttime=request.where.pickupstarttime;
        }

        var pickupendtime = '';

        if(util.isNullorEmpty(request.where.pickupendtime)){
          pickupendtime = request.where.pickupendtime;
        }

        var dropstarttime='';

        if(util.isNullorEmpty(request.where.dropstarttime)){
          dropstarttime=request.where.dropstarttime;
        }


        var dropendtime ='';

        if(util.isNullorEmpty(request.where.dropendtime)){
          dropendtime = request.where.dropendtime;
        }

        var dateoftransport = request.where.dateoftransport;
        var page = request.page;
        var limit = request.limit;
        
        var totalcount = 0;

        const sql = 'Select * from gettransportrosterlistwithalerts($1,$2,$3,$4,$5,$6,$7)';

        return util.executeDBQuery(sql, [pickupstarttime,pickupendtime,dropstarttime,dropendtime,dateoftransport, page, limit])
            .then(gettransportrosterlistwithalertsdata => {
                  if (gettransportrosterlistwithalertsdata!==null && gettransportrosterlistwithalertsdata.length>0) {totalcount= gettransportrosterlistwithalertsdata[0].totalcount;}

                  var result;
                  result = {
                      'data' : gettransportrosterlistwithalertsdata,
                      'count' : totalcount
                  };
                  LOGGER.debug(result)
                  return result;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
      }




      Persontransportation.remoteMethod('gettransportationdashboardlist', {
        accepts: [{
          arg: 'filter',
          type: 'Object',
          http: {
            source: 'query'
          },
          required: true
        }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }],
        http: {
            path:'/gettransportationdashboardlist',
          verb: 'get'
        },
        returns: {
          type: 'Object',
          root: true
        }
      });


      Persontransportation.gettransportationdashboardlist= (request, reqctx) =>{
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
        var status = request.where.status;
        var sortcolumn = request.where.sortcolumn;
        var sortorder = request.where.sortorder;
        var searchval = request.where.searchval;
        var searchcol = request.where.searchcol;
        var page = request.page;
        var limit = request.limit;
        
        var totalcount = 0;

        const sql = 'Select * from gettransportationdashboardlist($1,$2,$3,$4,$5,$6,$7,$8)';

        return util.executeDBQuery(sql, [securityusersid,status,sortcolumn,sortorder,searchval,searchcol, page, limit])
            .then(data => {
                  if (data!==null && data.length>0) {totalcount= data[0].totalcount;}

                  var result;
                  result = {
                    'count' : totalcount,
                      'data' : data
                  };
                  LOGGER.debug(result)
                  return result;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
      }



    Persontransportation.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Persontransportation.observe('access', (ctx, next) => util.access(ctx, next));
    Persontransportation.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
