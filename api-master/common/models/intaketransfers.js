'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function (Intaketransfers) {


    Intaketransfers.remoteMethod('getbyintakenumber', {
        http: {
            path: '/getbyintakenumber',
            verb: 'post'
        },
        accepts: [{
            arg: '', type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Intaketransfers.getbyintakenumber = request => {

        var pageno = request.page;
        var pagesize = request.limit;
        const sql = 'select * from getintaketransferlistbyintakeid($1 ,$2, $3)';

        return util.executeSecondaryNodeDBQuery(sql, [request.intakenumber, pageno, pagesize])
            .then(data => {
                return data[0].getintaketransferlistbyintakeid;
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }
    Intaketransfers.remoteMethod('getsupervisorbycountyid', {
        http: {
            path: '/getsupervisorbycountyid',
            verb: 'post'
        },
        accepts: [{
            arg: '', type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Intaketransfers.getsupervisorbycountyid = request => {

        const sql = 'select * from getsupervisorsbycounty($1,$2)';
        
        return util.executeSecondaryNodeDBQuery(sql, [request.v_countyid, request.v_roletypekey])
            .then(data => util.encryptresponse(data))
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Intaketransfers.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'post'
        },
        accepts: [{
            arg: '', type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Intaketransfers.list = request => {

        var pageno = request.page;
        var pagesize = request.limit;
        const sql = 'select * from getintaketransferlistbyuser($1 ,$2, $3,$4)';

        return util.executeSecondaryNodeDBQuery(sql, [request.where.securityusersid, request.where.screentype, pageno, pagesize])
            .then(data => {
                    return {
                        count : data[0].getintaketransferlistbyuser.length,
                        data: data[0].getintaketransferlistbyuser
                    };
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Intaketransfers.remoteMethod('addUpdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: '', type: 'object',
            http: { source: 'body' }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });
    

    Intaketransfers.addUpdate = request => {
        if (parseInt(request.approvalstatus) === 15) {
            request.requestedby = request.securityusersid;
        } else if (parseInt(request.approvalstatus) === 16) {
            request.approvedby = request.securityusersid;
        }  else if (parseInt(request.approvalstatus) === 17) {
            request.approvedby = request.securityusersid;
        }
        const sql = 'Select * from addupdatetintaketransfer($1::json)';
        return util.executeDBQuery(sql, [request])
            .then(data => data)
            .catch(err => {
                util.logError(err)
            });
    };
 

    Intaketransfers.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intaketransfers.observe('access', (ctx, next) => util.access(ctx, next));
    Intaketransfers.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}