'use strict';
const LOGGER = require("log4js").getLogger("cpsresponsetimeractions");
const util = require('../utils/utils');
var app = require('../../server/server');
const trylatermsg = 'Please try again later';
var config = require('../../server/config.json');

const dbFailure = err => {
    LOGGER.debug(err);
    return {
        message: trylatermsg,
        success: false
    };
};

module.exports = function(Cpsresponsetimeractions) {

    Cpsresponsetimeractions.remoteMethod('addupdate', {
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

    Cpsresponsetimeractions.addupdate = request => {
        const sql = 'select * from addupdatecpsresponsetimeractions($1::json)';
        return util.executeDBQuery(sql, [request])
        .then(result => result[0])
        .catch(dbFailure);
    };

    Cpsresponsetimeractions.remoteMethod('list', {
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

    Cpsresponsetimeractions.list = request => {
        const sql = ` with list as (select c.*, vu.fullname as updatedbyname, vu2.fullname as approvedby, r.insertedon as approveddate, r.routingstatustypeid,
            r.tosecurityusersid, vu3.fullname as submittedto
        from cpsresponsetimeractions c
            inner join userprofile vu on vu.securityusersid = c.updatedby
            left join routing r on r.objectid = c.intakeserviceid::character varying  
                and r.routingstatustypeid = 16
                and r.activeflag = 1
                and r.eventcode ='CPSRTS'
            left join userprofile vu2 on vu2.securityusersid = r.fromsecurityusersid  
            left join userprofile vu3 on vu3.securityusersid = r.tosecurityusersid
        where c.intakeserviceid  = $1
          and c.cpsresponsetimeractiontype = 'Skip 2'
          and c.activeflag = 1
        union all
        select c.*, vu.fullname as updatedbyname, vu2.fullname as approvedby, 
        r.insertedon as approveddate, r.routingstatustypeid, r.tosecurityusersid, vu3.fullname as submittedto
        from cpsresponsetimeractions c
            inner join userprofile vu on vu.securityusersid = c.insertedby
            left join routing r on r.objectid = c.cpsresponsetimeractionsid::character varying
                and r.routingstatustypeid in (15, 16, 17)
                and r.activeflag = 1
            left join userprofile vu2 on vu2.securityusersid = r.fromsecurityusersid and r.routingstatustypeid in (16, 17)
            left join userprofile vu3 on vu3.securityusersid = r.tosecurityusersid
        where c.intakeserviceid  = $1 
        and c.cpsresponsetimeractiontype = 'Save'
         and c.activeflag = 1
         union all 
        select c.*, vu.fullname as updatedbyname, '' as approvedby, null as approveddate, null as routingstatustypeid, null as tosecurityusersid, null as submittedto
from cpsresponsetimeractions c 
    inner join userprofile vu on vu.securityusersid = c.updatedby
where c.intakeserviceid  = $1
  and c.cpsresponsetimeractiontype in ( 'Skip 1', 'Skip 3' )
  and c.activeflag = 1) select * from list order by insertedon desc; `;

        return util.executeDBQuery(sql, [request.intakeserviceid])
        .then(result => ({
            success: true,
            data: result
        }))
        .catch(dbFailure);
    };

    Cpsresponsetimeractions.remoteMethod('duedate', {
        http: {
                path: '/duedate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Cpsresponsetimeractions.duedate = request => {
        const isExpungementSuperUser = request.isExpungementSuperUser ? request.isExpungementSuperUser : 0;
        const iscaseexpunged = request.iscaseexpunged ?? 0;
        const sql = `select * from cjams.getresponsetimerdetails($1::uuid,
                                            ''::character varying,$2,$3);`;

        return util.executeDBQuery(sql, [request.intakeserviceid,isExpungementSuperUser,iscaseexpunged])
        .then(result => ({
            success: true,
            data: result.length > 0 ?  result[0] : {}
        }))
        .catch(dbFailure);
    };

    Cpsresponsetimeractions.remoteMethod('skip2routing', {
        http: {
                path: '/skip2routing',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Cpsresponsetimeractions.skip2routing = request => {
        const sql = 'select * from cpsresponsetimerskipapproval($1::json)';
        return util.executeDBQuery(sql, [request])
        .then(result => result[0])
        .catch(err =>{
            util.logError(err)
        });
    };
    
    Cpsresponsetimeractions.remoteMethod('saverouting', {
        http: {
                path: '/saverouting',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Cpsresponsetimeractions.saverouting = request => {
        const sql = 'select * from cpsresponsetimersaveapproval($1::uuid, $2::json)';
        request.data.securityuserid = request.securityuserid;
        return util.executeDBQuery(sql, [request.cpsresponsetimeractionsid, request.data])
        .then(result => result[0])
        .catch(err =>{
            util.logError(err)
        });
    };
    
}