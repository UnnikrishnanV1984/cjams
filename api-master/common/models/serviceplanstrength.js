'use strict';
const LOGGER = require("log4js").getLogger("serviceplanstrength");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

// The remote method passes the LoopBack context here, but the internal callers
// in serviceplanfocus.js / splanobjective.js pass a bare securityusersid
// instead. Accept either so the id is not silently lost.
function resolvesuserid(reqctx) {
    if (reqctx?.req?.headers?.securityusersid) {
        return reqctx.req.headers.securityusersid;
    }
    if (reqctx && typeof reqctx !== 'object') {
        return reqctx;
    }
    return undefined;
}

module.exports = function(Serviceplanstrength) {

    Serviceplanstrength.addupdate = function(request,reqctx){
        const suserid = resolvesuserid(reqctx);
        const insertedon = new Date().toLocaleString();

        // Deactivate the existing rows before inserting the new set. This must be
        // awaited: when the UPDATE ran fire-and-forget it could land after the
        // inserts and clear activeflag on the rows just created.
        let deactivated = Promise.resolve();
        if(request.serviceplanfocusid!=null && request.serviceplanfocusid !=undefined){
            const sql = 'UPDATE serviceplanstrength SET activeflag=0 WHERE serviceplanfocusid = $1';
            deactivated = util.executeDBQuery(sql, [request.serviceplanfocusid]);
        }

        return deactivated.then(() => {
            const response = [];
            var arr = request.serviceplanstrength;
            if(arr!=null && Array.isArray(arr)){
                arr.forEach(element => {
                    request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
                    request.insertedon = insertedon;
                    request.activeflag = true;
                    request.serviceplanstrengthname = element;
                    response.push(
                        app.models.Serviceplanstrength.create(request))
                })
            }
            return Promise.all(response);
        }).then(values => {
            LOGGER.info(values);
            return values;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Serviceplanstrength.updateserviceplanstrength = function(request,suserid){
        // addupdate() already deactivates the rows for this focus by
        // serviceplanfocusid, so the redundant UPDATE that used to run here was
        // dropped. It matched serviceplanstrengthid against a focus id, so it
        // never affected the intended rows anyway.
        request.serviceplanstrengthid = null;
        return Serviceplanstrength.addupdate(request, suserid);
    };



   Serviceplanstrength.list = function(request) {
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var intakeserviceid = request.where.intakeserviceid;
        var servicecaseid = request.where.servicecaseid;
        var totalcount = 0;
        let sql4;
        let paramsdata = []
        if (request.servicecaseid == undefined || request.servicecaseid == null) {
             sql4 = 'select DISTINCT serviceplanstrengthname from serviceplanstrength where activeflag=1 and intakeserviceid = $1';
             paramsdata = [intakeserviceid];
        } else {
             sql4 = 'select DISTINCT serviceplanstrengthname from serviceplanstrength where activeflag=1 and servicecaseid = $1 and intakeserviceid = $2';
             paramsdata = [servicecaseid,intakeserviceid];
        }

        return util.executeSecondaryNodeDBQuery(sql4, paramsdata)
            .then(data => {
                    if ( data?.length > 0) {totalcount = data.length;}
                    var result;
                    result = {
                        'data': data,
                        'count': totalcount
                    };
                    return result;
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    /**
     * Add multiple strengths
     */
    Serviceplanstrength.addstrengths = (request,suserid) => {
        LOGGER.debug("SIMAR -> ", request);
        const insertedon = new Date().toLocaleString();
        const response = [];
        var arr = request.serviceplanstrengths;

        if (Array.isArray(arr)) {
            arr.forEach(element => {
                request.insertedby = (request && request.securityuserid?request.securityuserid: suserid);
                request.insertedon = insertedon;
                request.activeflag = true;
                request.serviceplanstrengthname = element.strengthname;
                request.serviceplanstrengthsection = element.strengthsection;

                response.push(
                    app.models.Serviceplanstrength.create(request))
            })
            return Promise.all(response);
        }
    };


    /**
     * Remote methods
     */
    Serviceplanstrength.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplanstrength.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });


    Serviceplanstrength.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Serviceplanstrength.observe('access', (ctx, next) => util.access(ctx, next));
    Serviceplanstrength.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

}
