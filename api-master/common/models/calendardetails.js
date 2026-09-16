'use strict';

var app = require('../../server/server');
const util = require('../utils/utils');
const LOGGER = require("log4js").getLogger("calendardetails");

module.exports = function (Calendardetails) {

    Calendardetails.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
            _securityusersid = reqctx.req.headers.securityusersid;
        }
        var securityusersid = (request && request.data && request.data.securityusersid ? request.data.securityusersid : _securityusersid);
        var sql = ` UPDATE calendardetails 
        SET activeflag=0, updatedby = $3, updatedon = now() 
        WHERE (calendardetailsid=$1 OR (objectid=$2 and starttime=$4 and endtime=$5) and securityusersid=$3 and activeflag=1 ) `;

        return util.executeDBQuery(sql, [request.data.calendardetailsid, request.data.objectid, securityusersid, request.data.starttime, request.data.endtime])
            .then((data) => {
                if (request.data.isDelete === true) {
                    return "Success";
                } else {
                    var nowDate = new Date().toLocaleString();
                    return Calendardetails.create({
                        securityusersid: securityusersid,
                        casenumber: request.data.casenumber,
                        personid: request.data.personid,
                        objectid: request.data.objectid,
                        objecttype: request.data.objecttype,
                        eventtimstamp: request.data.eventtimstamp,
                        title: request.data.title,
                        appointmenttype: request.data.appointmenttype,
                        appointmentdate: request.data.appointmentdate,
                        starttime: request.data.starttime,
                        endtime: request.data.endtime,
                        address: request.data.address,
                        attendees: request.data.attendees,
                        appointmentdetails: request.data.appointmentdetails,
                        locationtype: request.data.locationtype,
                        other: request.data.other,
                        isinperson:request.data.isinperson,
                        insertedby: securityusersid,
                        updatedby: securityusersid,
                        updatedon: nowDate,
                        insertedon: nowDate,
                    })
                    .then((_data) => {
                        return "Success";
                    });
                }
            })
            .catch((err) => {
                LOGGER.error('>>>>ERROR:', err);
               return err;
            });
    };

    Calendardetails.healthpassportcollateral = function(data, reqctx){
        var sql = 'SELECT * FROM healthpassportcollateral($1,$2)';
        return util.executeSecondaryNodeDBQuery(sql, [data.where.objectid, data.where.objecttypekey])
            .then((response) => {
                LOGGER.debug(response);
                return response;
            })
            .catch((err) => {
                LOGGER.error('>>>>ERROR:', err);
               return err;
            });
    };

    Calendardetails.getcalendareventList = request => {
        const personid = request?.where?.personid || null;
        const securityusersid = request?.where?.securityusersid || null;
        const servicecaseid = request?.where?.servicecaseid || null;
        const intakeserviceid = request?.where?.intakeserviceid || null;
        const datatype = request?.where?.datatype || null;
        const eventdate = request?.where?.eventdate || null;
        const eventtitle = request?.where?.eventtitle || null;
        const attendees = request?.where?.attendees || null;
    
        var sql = 'select * from gethealthpassportcalendardata($1,$2,$3,$4,$5,$6,$7,$8)';
    
        return util.executeSecondaryNodeDBQuery(
                sql,
                [personid, securityusersid, servicecaseid, intakeserviceid, datatype, eventdate, eventtitle, attendees]
            )
            .then((data) => {
                return data;
            })
            .catch((err) => {
                LOGGER.error('>>>>ERROR:', err);
                return err;
            });
        };

    Calendardetails.remoteMethod('addupdate', {
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
            http: { source: 'context' }
        }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Calendardetails.remoteMethod('getcalendareventList', {
        http: {
            'verb': 'get',
            'path': '/getcalendareventList'
        },
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
        }],
        returns : {
            type : 'Object',
            root : true
        }
    });
    Calendardetails.remoteMethod('healthpassportcollateral', {
        http: {
            'verb': 'get',
            'path': '/healthpassportcollateral'
        },
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
        }],
        returns : {
            type : 'Object',
            root : true
        }
    });

    Calendardetails.getcasenumberhealthpassport = function (request) {
        let sql = "SELECT * FROM cjams.getcasenumberhealthpassport($1)";
        let caseworkerid = request.where.securityusersid ? request.where.securityusersid : null;

        return util.executeSecondaryNodeDBQuery(sql, [caseworkerid])
            .then((data) => {
                return data;
            })
            .catch((err) => {
                LOGGER.error('>>>>ERROR:', err);
               return err;
            });
    };

    Calendardetails.remoteMethod('getcasenumberhealthpassport', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/getcasenumberhealthpassport',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Calendardetails.remoteMethod('list', {
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
            type: 'string',
            root: true
        }
    });

    Calendardetails.list = request => {
        const personid = request?.where?.personid || null;
        const securityusersid = request?.where?.securityusersid || null;
        const servicecaseid = request?.where?.servicecaseid || null;
        const intakeserviceid = request?.where?.intakeserviceid || null;
        const datatype = request?.where?.datatype || null;
        const eventdate = request?.where?.eventdate || null;
        const eventtitle = request?.where?.eventtitle || null;
        const attendees = request?.where?.attendees || null;
        var sql = 'select * from gethealthappointmentdates($1,$2,$3,$4,$5,$6,$7,$8)';

        return util.executeSecondaryNodeDBQuery(sql, [personid, securityusersid, servicecaseid, intakeserviceid, datatype, eventdate, eventtitle, attendees])
            .then((data) => {
                return data;
            })
            .catch((err) => {
                LOGGER.error('>>>>ERROR:', err);
               return err;
            });
    }

    Calendardetails.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Calendardetails.observe('access', (ctx, next) => util.access(ctx, next));
    Calendardetails.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};