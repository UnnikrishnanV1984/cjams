'use strict';
const LOGGER = require("log4js").getLogger("personbehavioralhealth");
const util = require('../utils/utils');

module.exports = function (Personbehavioralhealth) {

    Personbehavioralhealth.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts: [{
            arg: 'data', type: 'object',
            http: { source: 'body' }
        },  {
            arg: 'reqctx',
            type: 'object',
            http: {
              source: 'context'
            }
          } ],
        returns: {
            type: 'string',
            root: true
        }
    });

    Personbehavioralhealth.remoteMethod('personbehavioralhealthdelete', {
        http: {
            path: '/personbehavioralhealthdelete/:id',
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

    Personbehavioralhealth.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: { source: 'query' }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Personbehavioralhealth.addupdate = function (request, reqctx) {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		} 
        request.updatedby = request && request.securityuserid?request.securityuserid: _securityusersid;
             
        if (request.personbehavioralhealthid == null || request.personbehavioralhealthid == undefined) {
            return Personbehavioralhealth.create(request).then(res => {
                return res;
            });
        }
        else {
            return Personbehavioralhealth.updateAll({ personbehavioralhealthid: request.personbehavioralhealthid }, request);
        }
    };

    Personbehavioralhealth.personbehavioralhealthdelete = (id) => {
        var sql = 'update personbehavioralhealth set activeflag = 0 WHERE personbehavioralhealthid = $1';
        return util.executeDBQuery(sql, [id])
            .then(data => data)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Personbehavioralhealth.list = request => {
        const personid = request.where.personid;
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var sql = 'select ( ';
        sql += 'select json_agg(x)  from (';
        sql += 'select pbh.personbehavioralhealthid, pbh.personservicetypekey as typeofservice, ';
        sql += 'pbh.isbehavioralhealth as isbehaviouraldiagnosis, pbh.clinicianname as clinicianname, pbh.address1 as addressline1, ';
        sql += 'pbh.address2 as addressline2, pbh.city, pbh.state, pbh.county, pbh.zip as zipcode, pbh.phone as phonenumber,pbh.phobiakey,pbh.phobiakey, ';
        sql += 'pbh.currentdiagnoses as currentdiagnosis, pbh.reportname,pbh.uploadpath from personbehavioralhealth pbh where pbh.activeflag=1 ';
        sql += 'and pbh.personid=$1';

        sql += ') as x ) as personalbehaviour ,  (';
        sql += 'select json_agg(x)  from (';
        sql += 'select * from personabusesubstance pbh where pbh.activeflag=1 ';
        sql += 'and pbh.personid=$1';

        sql += ') as x ) as personabusesubstance';


        return util.executeDBQuery(sql, [personid])
            .then(data => data)
            .catch(err => util.logError(err));
    };

    Personbehavioralhealth.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personbehavioralhealth.observe('access', (ctx, next) => util.access(ctx, next));
    Personbehavioralhealth.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PBHVHLTH',
    ctx.isNewInstance?ctx.instance.personid:ctx.data.personid));
    Personbehavioralhealth.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
