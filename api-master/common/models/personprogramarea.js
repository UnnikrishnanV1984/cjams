'use strict';
const LOGGER = require("log4js").getLogger("personprogramarea");
const util = require('../utils/utils');
var app = require('../../server/server');
const moment = require('moment');
const config = require('../../server/config.json');
module.exports = function(Personprogramarea) {

    Personprogramarea.addupdate = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        if(request.personprogramid !== undefined && request.personprogramid !== null) {
            return Personprogramarea.updatepersonprogramarea(request, _securityusersid);
        } else {
            return Personprogramarea.addpersonprogramarea(request, _securityusersid);
        }
    }

    Personprogramarea.updateEndDate = (request) => {
      if(request.personid && request.enddate){
            var personid = request.personid;
            var enddate = request.enddate;
            var sql = 'update personprogramarea set enddate=$1 '+
             ' where personprogramid in ( '+
             ' select personprogramid from personprogramarea '+
            '  where personid=$2 and enddate is null ) ';
            return util.executeDBQuery(sql, [enddate,personid])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      }
        return Promise.resolve('Invalid request');
    }

    Personprogramarea.addpersonprogramarea = function (request, _securityusersid) {
        var sql = 'select * from getcasenumber($1,$2)';
        return util.executeDBQuery(sql, [request.objecttypekey, request.objectid]).then(data => {
            var casenumber = [];
            if (data.length > 0) {
                casenumber = data ? data[0].casenumber : null;
            }
            return Personprogramarea.create({
                personid: request.personid,
                startdate: request.startdate,
                enddate: request.enddate,
                programkey: request.programkey,
                subprogramkey: request.subprogramkey,
                objecttypekey: request.objecttypekey,
                objectid: request.objectid,
                endreasonkey: request.endreasonkey,
                ifpsatriskflag: request.ifpsatriskflag,
                insertedby: _securityusersid,
                updatedby: _securityusersid, 
                entityid: casenumber,
                datatransferflag: 'A',
                sourcetype : 'CW',
            })
        }).then(data => {
            if (data.personprogramid) {
                util.auditLogSingleSave(data.personprogramid, 'PRGMAREA', request);
            }
            return data;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personprogramarea.updatepersonprogramarea = (request, _securityusersid) => {
        var ds = app.dataSources.hcuewelfare;
        var sql = 'select * from getcasenumber($1,$2)';
        return util.executeDBQuery(sql, [request.objecttypekey, request.objectid]).then(data => {
            var casenumber = getCaseNumber(request, data);
            
            return Personprogramarea.updateAll(
                { personprogramid: request.personprogramid },
                {
                    personid: request.personid,
                    startdate: request.startdate,
                    enddate: request.enddate,
                    programkey: request.programkey,
                    subprogramkey: request.subprogramkey,
                    objecttypekey: request.objecttypekey,
                    endreasonkey: request.endreasonkey,
                    ifpsatriskflag: request.ifpsatriskflag,
                    insertedby: request.securityusersid,
                    updatedby: request.securityusersid,
                    entityid: casenumber,
                    datatransferflag: 'U',
                })
        }).then(_data => {
            return updateProgramAssignment(request, ds)
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }


    function getCaseNumber(request, data ) {
        var casenumber = [];
        if ((request.casenumber == null || request.casenumber == undefined || request.casenumber === '') && data.length > 0) {
            casenumber = data ? data[0].casenumber : null;
        } else { 
            casenumber = request.casenumber; 
        }
        return casenumber; // +1 for the binary operator
    }


    function updateProgramAssignment(request, ds) {
        if (request.programkey === 'IHSFP' && request.subprogramkey === 'SFCI' && request.isdefault && request.enddate) {
            const updatePersonsql = `
                    WITH updatedperson AS (
                      update person
                      set senstatusflag = 0,
                          updatedby = '${request.securityusersid}',
                          updatedon = now()
                      where personid = '${request.personid}'
                      RETURNING row_to_json(person.*) AS updated_person
                    )
                    INSERT INTO personauditlog (
                      personauditlogid,
                      personid,
                      personjson,
                      typekey,
                      insertedon,
                      insertedby,
                      updatedby,
                      updatedon,
                      activeflag
                    )
                    SELECT
                      gen_random_uuid(),
                      '${request.personid}' ,
                      updated_person ,
                      'new'::character varying,
                       now(),
                       '${request.securityusersid}',
                       '${request.securityusersid}',
                       now(),
                       1
                    FROM updatedperson`;
            return util.executeDBQuery(updatePersonsql, []).then(data1 => {
              if (request.personprogramid) {
                util.auditLogSingleSave(request.personprogramid, 'PRGMAREA', request);
              }
              return "Program Assignment updated successfully";
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
          } else {
            if (request.personprogramid) {
              util.auditLogSingleSave(request.personprogramid, 'PRGMAREA', request);
            }
            return "Program Assignment updated successfully";
        }
    }
    Personprogramarea.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Personprogramarea.remoteMethod('updateEndDate', {
        http: {
            path: '/updateEndDate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Personprogramarea.remoteMethod('movepersonApproval', {
        http: {
            path: '/movepersonApproval',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Personprogramarea.movepersonApproval = (request) => {
        var sql = 'select * from movepersonapproval($1, $2, $3, $4, $5, $6, $7, $8, $9)';
        const tempReqStructure = JSON.stringify(request.programs);
        const finalReqStructure = tempReqStructure.replace(/'/g, "''");
        request.supervisor = request.supervisor || request.securityuserid;
        return util.executeDBQuery(sql, [request.supervisor, request.securityuserid, finalReqStructure, request.caseType, request.status, request.eventtype, request.personid, request.caseid, request.comments])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personprogramarea.remoteMethod('movepersonHistory', {
        http: {
            path: '/movepersonHistory',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Personprogramarea.movepersonHistory = (request) => {
        var sql = `select
                    mph.actiondescription,
                    (select up.fullname from userprofile up where up.securityusersid= mph.fromuserid:: character varying) as requestedby,
                    mph.insertedon as requestedon, 
                    (select up.fullname  from userprofile up where up.securityusersid= mph.touserid:: character varying) as requestedto,
                    (case when mph.status='Review' then null else (select up.fullname  from userprofile up where up.securityusersid=r.fromsecurityusersid order by r.updatedon desc limit 1) end) as approvedby,
                    (case when mph.status='Review' then null else r.insertedon end) as approvedon,
                    mph.status,
                    mph.endvalue,
                    mph.comments
                    from moveperson_history mph
                    inner join actor a on a.personid = $1 and (a.servicecaseid= $2 or a.intakeserviceid=$2)
                    inner join routing r on r.objectid = a.actorid:: character varying 
                    and (case when mph.status='Approved' then r.routingstatustypeid=16 
                            when mph.status='Rejected' then r.routingstatustypeid=17 
                                 else r.routingstatustypeid=15 and r.activeflag=1 end) and to_char(r.insertedon, 'yyyy-MM-dd HH12:MI:SS AM') = to_char(mph.updatedon, 'yyyy-MM-dd HH12:MI:SS AM')
                     where mph.objectid=a.actorid:: character varying
                     order by mph.insertedon desc;`;
        return util.executeDBQuery(sql, [request.personid, request.caseid])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personprogramarea.getpersonprogramarea = (request) => {
        const isExpungementSuperUser = request.where.isExpungementSuperUser ? request.where.isExpungementSuperUser: 0;
        const iscaseexpunged = request.where.iscaseexpunged ?? 0;
        var sql = 'select * from getpersonprogramarea($1,$2,$3,$4)';
        return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid, request.where.personid,isExpungementSuperUser,iscaseexpunged])
        .then(data => {
            return data;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };


    Personprogramarea.remoteMethod('getpersonprogramarea', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/getpersonprogramarea',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });
  
    Personprogramarea.getmultiplepersonprogramarea = (request) => {
        var sql = 'select * from getmultiplepersonprogramarea($1,$2)';
        return util.executeSecondaryNodeDBQuery(sql, [request.where.objectid, request.where.personid])
            .then(data => {
                return data
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personprogramarea.remoteMethod('getmultiplepersonprogramarea', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/getmultiplepersonprogramarea',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Personprogramarea.programassignmentupdate = (request, _securityusersid) => {
        var sql = 'select * from programassignmentupdate($1,$2,$3,$4)';
        return util.executeDBQuery(sql, [request.eventcode, request.objecttypekey, (request && request.securityuserid?request.securityuserid: _securityusersid), request.transid]).then(data => {
            return data
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personprogramarea.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personprogramarea.observe('access', (ctx, next) => util.access(ctx, next));
    Personprogramarea.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}

