'use strict';
const LOGGER = require("log4js").getLogger("servicecase");
const util = require('../utils/utils');
const server = require('../../server/server');
const app = require('../../server/server');
module.exports = function (Servicecase) {
  Servicecase.createservicecase = function (request, reqctx) {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    const sql = 'select * from createservicecase($1,$2,$3,$4,$5,$6,$7,$8)';
    const userid = (request && request.securityuserid?request.securityuserid: _securityusersid);
    return util.executeDBQuery(sql, [request.intakeserviceid, request.servicecaseid, request.isnewcase, userid,(request?.personprogramids || null), request.subtypekey,request.source,request.isoverriderequest])
      .then(data => {
        return data;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  };

  Servicecase.remoteMethod('createservicecase', {
    accepts: [{
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'body'
      },
      required: true
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    http: {
      path: '/createservicecase',
      verb: 'post'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Servicecase.servicecaselist = (request) => {
    const sql = 'select * from servicecaselist($1,$2,$3)';
    return util.executeDBQuery(sql, [request.where.intakeserviceid, request.page, request.limit])
      .then(data => {
        return data[0].servicecaselist;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
  }

  Servicecase.remoteMethod('servicecaselist', {
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

  Servicecase.remoteMethod('servicecasepaymentlist', {
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

  Servicecase.servicecasepaymentlist = (request) => {
    const sql = 'select * from servicecasepaymentlist($1)';
    return util.executeDBQuery(sql, [request.where.objectid])
      .then(data => {
        return data;
      })
     .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  }

  Servicecase.remoteMethod(
    'assigncase',
    {
      http: {
        path: '/assigncase',
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
    }
  );

  Servicecase.assigncase = (data,reqctx) => {
    const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
    const userid = suserid;
    const appeventcode = data.appeventcode;
    const assignedusers = JSON.stringify(data.assignedusers);
    const servicecaseid = data.servicecaseid;
    const programkey = data.programkey?data.programkey:'';
    const subprogramkey = data.subprogramkey?data.subprogramkey:'';
    const assignlater = data.assignlater ? data.assignlater : false;

    const params = [appeventcode, servicecaseid, userid, assignedusers, programkey, subprogramkey, assignlater];

    const sql = "SELECT * FROM assigncase($1,$2,$3,$4,$5,$6,$7)"
    return util.executeDBQuery(sql, params)
      .then(data1 => {
        app.models.Auditlog.create({
            logtypekey:'WL001',
            intakeserviceid:null,
            servicerequestnumber:null,
            referenceid:null,
            description:'A program assigment is made',
            isnew :false,
            isedit:true,
            isdelete:true,
            insertedby: suserid,
            updatedby: suserid,
            insertedon:new Date(),
            updatedon:new Date(),
            metadata:null,
            ipaddress:null,
            old_id:null,
            modifieddata:null,
            objectid:servicecaseid,
            objecttype: 'servicecase'
        }).catch(err1 => LOGGER.error(err1));
        app.models.Intakedastaging.sendintakenotification(servicecaseid);
        return data1;
      }).catch(err => util.logError(err));

  }

  Servicecase.remoteMethod(
    'reassigncase',
    {
      http: {
        path: '/reassigncase',
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
    }
  );

  Servicecase.reassigncase = (data,reqctx) => {
    const userid = util.getSecurityDetails(data, reqctx).securityuserid;
    const appeventcode = data.appeventcode;
    const assigneduser = data.assigneduser;
    const servicecaseid = data.servicecaseid;
    const responsibilitytypekey = data.responsibilitytypekey;
    const caseassignmentid = data.caseassignmentid?data.caseassignmentid:null;
    const enddate = data.enddate?data.enddate:null;
    const remarks = data.remarks?data.remarks:'';
    const isanotherunit = data.isanotherunit?data.isanotherunit:0;
    const toteamid = data.toteamid?data.toteamid:null;
    const children = data.child?JSON.stringify(data.child):null;
    const assignmenttype = data.assignmenttype? data.assignmenttype:null;
    const startdate = data.startdate?data.startdate:null;
    const assessmenttype = data.assessmenttype ? data.assessmenttype : null;


    const params = [appeventcode, servicecaseid, userid, assigneduser, responsibilitytypekey, caseassignmentid,enddate,remarks,isanotherunit,toteamid,children,assignmenttype,startdate, assessmenttype];

    const sql = "SELECT * FROM reassigncase($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)"
    return util.executeDBQuery(sql, params)
      .then(data2 => {
        return data2;
      }).catch(err => util.logError(err));

  }

  Servicecase.getpersonrelation = (request) => {
    const servicecaseid = request.where.servicecaseid;

    const sql = "SELECT * FROM getpersonrelation($1)"
    return util.executeDBQuery(sql, [servicecaseid])
      .then(data => {
        LOGGER.debug(data);
        return data;
      }).catch(err => util.logError(err));

  }

  Servicecase.remoteMethod('getpersonrelation', {
    http: {
      path: '/getpersonrelation',
      verb: 'get'
    },
    accepts:
      {
        arg: 'filter',
        type: 'object',
        http: { source: 'query' }
      },
    returns: {
      type: 'object',
      root: true
    }
  });


  Servicecase.getintakeserviceid = (request) => { 
    const serviceCaseId = request.where.serviceCaseId;
    const sql = ' SELECT DISTINCT isa.servicecaseid,isa.intakeserviceid,ir.intakenumber FROM intakeservicerequest ir '+
      ' INNER JOIN intakeservicerequestactor isa ON ' +
      ' ir.intakeserviceid=isa.intakeserviceid '+
      ' WHERE ir.servicecaseid=$1';
    LOGGER.debug('sql ===',sql);
    return util.executeDBQuery(sql, [serviceCaseId])
      .then(data => {
        LOGGER.debug(data);
        return data;
      }).catch(err => util.logError(err));
  }
  
  Servicecase.remoteMethod('getintakeserviceid', {
    http: {
      path: '/getintakeserviceid',
      verb: 'get'
    },
    accepts:
      {
        arg: 'filter',
        type: 'object',
        http: { source: 'query' }
      },
    returns: {
      type: 'object',
      root: true
    }
  });
  

  Servicecase.getpersonrelationbyintakeservice = (request) => {
    const intakeserviceid = request.where.intakeserviceid;
    const idType = request.where.idType;
    let sql = "SELECT * FROM getpersonrelationbyintakeservice($1)";
    if(idType === 'intakenumber'){
      sql = "SELECT * FROM getpersonrelationbyintakeserviceByNumber($1)";
    }
    LOGGER.debug('sql ===',sql);
    return util.executeDBQuery(sql, [intakeserviceid])
      .then(data => {
        LOGGER.debug(data);
        return data;
      }).catch(err => util.logError(err));

  }

  Servicecase.remoteMethod('getpersonrelationbyintakeservice', {
    http: {
      path: '/getpersonrelationbyintakeservice',
      verb: 'get'
    },
    accepts:
      {
        arg: 'filter',
        type: 'object',
        http: { source: 'query' }
      },
    returns: {
      type: 'object',
      root: true
    }
  });

  Servicecase.getservicecasesdm = (request) => {
    const servicecaseid = request.where.servicecaseid;
    const sql = "SELECT * FROM getservicecasesdm($1)";
    return util.executeSecondaryNodeDBQuery(sql, [servicecaseid]).then((data4) => {
      return data4;
   }).catch((err) => { LOGGER.error('>>>>ERROR:', err); return util.logError(err).then(() => { throw err; }); });
  }

  Servicecase.remoteMethod('getservicecasesdm', {
    http: {
      path: '/getservicecasesdm',
      verb: 'get'
    },
    accepts:
      {
        arg: 'filter',
        type: 'object',
        http: { source: 'query' }
      },
    returns: {
      type: 'object',
      root: true
    }
  });

  Servicecase.remoteMethod('getauditlog', {
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

  Servicecase.getauditlog = (request) => {
      const sql = 'select * from get_auditlog($1,$2,$3,$4,$5)';
      return util.executeDBQuery(sql, [request.where.columnid, request.where.tableid, request.where.objectid, request.page, request.limit])
      .then(data => {
        return {code: 200, message: 'success', data: data[0].get_auditlog};
      })
      .catch(err=> util.logError(err))
  }
  Servicecase.remoteMethod('getauditlogbyimmunizationid', {
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

  Servicecase.getauditlogbyimmunizationid = (request) => {
      const sql = 'select * from get_auditlogbyimmunizationid($1,$2,$3,$4,$5,$6)';
      return util.executeDBQuery(sql, [request.where.columnid, request.where.tableid, request.where.objectid, request.where.personimmunizationid, request.page, request.limit])
      .then(data => {
        LOGGER.debug(data);
        return {code: 200, message: 'success', data: data[0].get_auditlogbyimmunizationid};
      })
      .catch(err=> util.logError(err))
  }
  Servicecase.remoteMethod('getapprovalhistory', {
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

	  Servicecase.getapprovalhistory = (request) => {
    const sql = 'select * from getapprovalhistory($1)';
		return util.executeDBQuery(sql, [request.where.assessmentid])
		.then(data => {
			return {code: 200, message: 'success', data: data};
		})
		.catch(err=> LOGGER.error(err))
	}

  Servicecase.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Servicecase.observe('access', (ctx, next) => util.access(ctx, next));
  Servicecase.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}