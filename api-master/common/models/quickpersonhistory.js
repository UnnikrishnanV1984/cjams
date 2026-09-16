'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Quickpersonhistory) {

    Quickpersonhistory.list = request => {

        const sql = `select qh.objecttype,qh.activeflag, q2.personid ,qh.firstname , qh.lastname , ui.fullname as insertedby, qh.insertedon ,
          qh.updatedon, qh.deletestatus, q2.deletestatus as activity
         from quickperson_history qh
         left join quickperson q2 on q2.quickpersonid  = qh.quickpersonid
         left join userprofile ui on ui.securityusersid = qh.insertedby
         where qh.intakenumber = $1 and qh.objecttype = $2 order by qh.updatedon desc`;
        return util.executeDBQuery(sql, [request.where.objectid,request.where.objecttype])
          .then(data => {
           const res = data;
            
           return Promise.all(res);
        }) 
        .catch(err => util.logError(err));
    };

    Quickpersonhistory.remoteMethod('list', {
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

    Quickpersonhistory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Quickpersonhistory.observe('access', (ctx, next) => util.access(ctx, next));
    Quickpersonhistory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}