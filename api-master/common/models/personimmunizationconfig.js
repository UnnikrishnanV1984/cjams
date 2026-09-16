'use strict';
const util = require('../utils/utils');
const logger = require('log4js').getLogger('personimmunizationconfig');
var server = require('../../server/server');
var app = require('../../server/server');
const moment = require('moment');
module.exports = function(Personimmunizationconfig) {

    Personimmunizationconfig.remoteMethod('list', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personimmunizationconfig.list=(request)=>{
      
        var totalcount = 0;
        var sql= 'select * from getimmunizationconfig($1)';
        return util.executeSecondaryNodeDBQuery(sql,[request.where.agetype])
    .then(data => {
                    if (data!==null && data.length>0) {totalcount= data[0].totalcount;}
                    var result;
                    result = {
                        'data' : data,
                        'count' : totalcount
                    };
                    return result;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });        
                
    };

    Personimmunizationconfig.remoteMethod('immunizationlist',
        {
            http: {
                path: '/immunizationlist',
                verb: 'post'
            },
            accepts: [{
                arg: 'data', type: 'object',
                http: { source: 'body' }
            }],
            returns: {
                type: 'object',
                root: true
            }
    });

    Personimmunizationconfig.immunizationupdate=(request, reqctx)=>{
        const userid = util.getSecurityDetails(request, reqctx).securityuserid;
        
        let sql= 'UPDATE personimmunization SET updatedon = now(), updatedby= $1, recordstatus= $2 WHERE personimmunizationid=$3';
        return util.executeDBQuery(sql,[userid,request.recordstatus,request.id])
        .then(data => {
            if (data) {
                return util.generateAuditData('personimmunization', `${request.id}`)
                .then(_data => {
                    if (_data) {
                        return _data;
                    }
                });
            }
        })
        .catch(err => {
            util.logError(err);
        });
    };

    Personimmunizationconfig.remoteMethod('immunizationupdate', {
        http: {
            path: '/immunizationupdate',
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

    Personimmunizationconfig.remoteMethod('immunizationlist', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personimmunizationconfig.immunizationlist=(req)=>{

        var totalcount = 0;
        const pageno = req.page;
        const pagesize = req.limit;
        var sql= 'select * from getpersonimmunizationlist($1,$2,$3)';
        return util.executeDBQuery(sql,[req.where.personid, pageno, pagesize])
        .then(getpersonimmunizationlistdata => {
                    if (getpersonimmunizationlistdata!==null && getpersonimmunizationlistdata.length>0) {totalcount= getpersonimmunizationlistdata[0].totalcount;}
                    var result;
                    result = {
                        'data' : getpersonimmunizationlistdata,
                        'count' : totalcount
                    };
                    return result;
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });

    };


    Personimmunizationconfig.immunizationlist=function(data) {
        const pageno = data.page;
        const pagesize = data.limit;

        var filters = data.where;
        filters["updatedonstartdt"] = !data.where.updatedonStartDt ? null : data.where.updatedonStartDt;
        filters["updatedonenddt"] = !data.where.updatedonEndDt ? null : data.where.updatedonEndDt;
        filters["immunizationstartdt"] = !data.where.immunizationStartDt ? null : data.where.immunizationStartDt;
        filters["immunizationenddt"] = !data.where.immunizationEndDt ? null : data.where.immunizationEndDt;
        var sql= 'select * from getpersonimmunizationlistfilter($1,$2,$3,$4)';
        return util.executeDBQuery(sql, [data.where, pageno, pagesize, filters])
        .then(_data => {
            var result;
            result = {'data': _data};
            return result;
        })
        .catch(err => {
            logger.error(err);
            throw err;
        });
    };

    Personimmunizationconfig.remoteMethod('getpersonimmunizationlist', {
        accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query',
      },
      required: true,
    },
      http: {
            verb: 'get',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    Personimmunizationconfig.getpersonimmunizationlist=(request)=>{

        var totalcount = 0;
        const pageno = request.page;
        const pagesize = request.limit;
        var sql= 'select * from getpersonimmunizationlist($1,$2,$3)';
        return util.executeDBQuery(sql,[request.where.personid, pageno, pagesize])
        .then(getpersonimmunizationlistdata1 => {
                    if (getpersonimmunizationlistdata1!==null && getpersonimmunizationlistdata1.length>0) {totalcount= getpersonimmunizationlistdata1[0].totalcount;}
                    var result;
                    result = {
                        'data' : getpersonimmunizationlistdata1,
                        'count' : totalcount
                    };
                    return result;
        })
        .catch(err => LOGGER.error(err));

    };
  

    Personimmunizationconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personimmunizationconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Personimmunizationconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};