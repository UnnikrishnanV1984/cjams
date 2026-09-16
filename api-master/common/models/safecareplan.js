'use strict';
const LOGGER = require("log4js").getLogger("safecareplan");
const util = require('../utils/utils');
var app = require('../../server/server');

const trylatermsg = 'Please try again later';

module.exports = function(Safecareplan) {

    Safecareplan.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Safecareplan.addupdate = request => {
        const sql = 'select * from addupdatesafecareplan($1::json)';
        return util.executeDBQuery(sql, [request])
        .then(result => {
            return result[0];
        })
        .catch(err =>{
            LOGGER.debug(err);
            return {
                message: err,
                success: false
            };
        });
    };

    Safecareplan.remoteMethod('list', {
        http: {
                path: '/list',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Safecareplan.list = request => {
        const sql = "select * from cjams.getsafecareplandetails($1,$2,$3)"
        return util.executeDBQuery(sql, [request.objectid, request.objecttypekey, request.personids])
        .then(result => {
            return {
                success: true,
                data: result.length > 0 ? result : {}
            };
        })
        .catch(err1 =>{
            LOGGER.debug(err1);
            return {
                message: err1,
                success: false
            };
        });
    };

    Safecareplan.remoteMethod('history', {
        http: {
                path: '/history',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Safecareplan.history = request => {
        const sql = `   select sh.justification
                                , to_char(sh.updatedon, 'MM/DD/YYYY HH:MI AM') as modifiedon 
                                , (select fullname from v_userprofile vu where vu.securityusersid = sh.updatedby::character varying limit 1) as modifiedby
                        from safecareplan_history sh 
                        where sh.safecareplanid = $1
                        order by sh.updatedon desc; `;
        return util.executeDBQuery(sql, [request.safecareplanid])
        .then(result => {
            return {
                success: true,
                data: result
            };
        })
        .catch(err2 =>{
            LOGGER.debug(err2);
            return {
                message: err2,
                success: false
            };
        });
    };

    Safecareplan.remoteMethod('getprimarycaredoctor', {
        http: {
                path: '/getprimarycaredoctor',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Safecareplan.getprimarycaredoctor = request => {
        const sql = ` select p.email, p.phone, p."name", p.personid, p2.description as physiciantype, concat(pr.firstname, ' ', pr.lastname) as personname
                        from personphycisianinfo p 
                        inner join person pr on pr.personid = p.personid
                        inner join physicianspecialtytype p2 on p2.physicianspecialtytypekey = p.physician_speciality 
                        where p.isprimaryphycisian = true and p.personid = any ($1) and p.activeflag = 1;`;
        return util.executeDBQuery(sql, [request.personids])
        .then(result1 => {
            return {
                success: true,
                data: result1
            };
        })
        .catch(err6 =>{
            LOGGER.debug(err6);
            return {
                message: err6,
                success: false
            };
        });
    };
    
}