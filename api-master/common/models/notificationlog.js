'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function (Notificationlog) {
    Notificationlog.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Notificationlog.observe('access', (ctx, next) => util.access(ctx, next));
    Notificationlog.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));


    Notificationlog.add = (removalnotification, _securityusersid) => {
        return app.models.Notificationlog.create({
            objectid:removalnotification.objectid,
            objecttypekey:removalnotification.objecttypekey,
            personid:removalnotification.personid,
            ldssuserid:removalnotification.ldssuserid,
            intakeserviceid:removalnotification.intakeserviceid,
            emailid:removalnotification.emailid,
            message:removalnotification.message,
            ismailsent:1,
            insertedby:(removalnotification && removalnotification.securityuserid?removalnotification.securityuserid: _securityusersid),
            updatedby:(removalnotification && removalnotification.securityuserid?removalnotification.securityuserid: _securityusersid)
        })
    }

    Notificationlog.remoteMethod('list', {
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

    Notificationlog.list = (request) => {
        return app.models.Notificationlog.find({
            where: { objectid: request.where.objectid }
        }).then(data => {
            return data
        })
    }
}
