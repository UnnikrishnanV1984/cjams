'use strict';
const LOGGER = require("log4js").getLogger("intakedastaging");
const app = require('../../server/server');
const util = require('../utils/utils');
const config = require('../../server/config.json');
const email = require('../models/email');
const loopback = require('loopback');
const dsloop = loopback.createDataSource('memory');

const withTotalCount = rows => ({
  'data': rows,
  'count': (rows != null && rows.length > 0) ? rows[0].totalcount : 0
});

const logAndRethrow = err => {
  LOGGER.error('>>>>ERROR:', err);
  throw err;
};

// getintakejsondata(v_intakeserviceid uuid, isExpungementSuperUser integer
// DEFAULT 0, isexpunged integer DEFAULT 0) takes a uuid first. The web builds
// that value from CASE_UID, so an unresolved id ('', '0', 'null', 'undefined')
// is bound as text and Postgres rejects the whole statement with 22P02 invalid
// input syntax for type uuid -- which error-logger rewrites to an anonymous
// statusCode 400, landing in APM as a bare "HttpError 400, No stack trace".
// Reject it here with a message that names the argument instead.
const UUID_PATTERN = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

const notAUuid = id => typeof id !== 'string' || !UUID_PATTERN.test(id.trim());

const badRequest = message => {
  const err = new Error(message);
  err.statusCode = 400;
  err.code = 'INVALID_ID';
  return Promise.reject(err);
};

// The expungement arguments are integer parameters and the web sends
// isExpungementSuperUser as parseInt(storage.getItem('IS_EXPUNGED_USER')), which
// is NaN whenever that session key is absent. JSON.stringify writes NaN as null,
// so the flag arrives as null; bind the procedure's own default of 0 instead.
const expungementFlag = value => {
  const flag = parseInt(value, 10);
  return Number.isInteger(flag) ? flag : 0;
};

module.exports = function (Intakedastaging) {
  var general = dsloop.define('generalmodel', app.models.generalmodel)
  var datypedetail = dsloop.define('datypedetailmodel', app.models.datypedetailmodel)
  var person = dsloop.define('personmodel', app.models.personmodel)
  var recording = dsloop.define('recordingmodel', app.models.recordingmodel)
  var allegations = dsloop.define('allegationsmodel', app.models.allegationsmodel)
                                                     //SonarQube fix - removed this unused assignent
  const datypeformat = {
    "DATypeDetail": datypedetail
  }
  const recodingsformat = {
    "Recordings": recording
  }

const dataFormat = {
    "General": {
      "type": general,
      "id": true
    },
    "DAType": {
      "type": datypeformat
    },
    "Person": {
      "type": [person]
    },
    "Recording": {
      "type": recodingsformat
    },
    "Allegations": {
      "type": [allegations]
    }
  };

  const listIntakeDARequestStructure = {
    "pagenumber": {
      "type": "String",
      "required": false
    },
    "pagesize": {
      "type": "String",
      "required": false
    },
    "authorid": {
      "type": "String",
      "required": true,
      "id": true
    }
  }
  LOGGER.info(listIntakeDARequestStructure);
  LOGGER.info(dataFormat);
  //SonarQube fix - removed this unused assignent
  Intakedastaging.saveIntake = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
    data.securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);
    const tempReqStructure = JSON.stringify(data);
    const finalReqStructure = tempReqStructure.replace(/'/g, "''");
    const sql = 'SELECT * FROM saveintake($1)';

    return util.executeDBQuery(sql, [finalReqStructure])
      .then(_data => {
        return _data[0];
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };
 Intakedastaging.getsupervisorapprovalinfo = function (data) {

    const intakenumber = data.intakenumber;
    const isExpungementSuperUser = data.isExpungementSuperUser ? data.isExpungementSuperUser: 0;
    const iscaseexpunged = data.iscaseexpunged ?? 0;

    const sql = 'select * from getsupervisorapprovaldetails($1,$2,$3)';

    return util.executeSecondaryNodeDBQuery(sql,[intakenumber,isExpungementSuperUser,iscaseexpunged])
      .then(_data => {
        return _data[0];
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Intakedastaging.completeIntake = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
    data.securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);

    data.Allegations.forEach(allegation => {
      if (allegation.Indicators.length > 0)
        {allegation.Indicators = allegation.Indicators.join();}
    })

    const tempReqStructure = JSON.stringify(data);
    const finalReqStructure = tempReqStructure.replace(/'/g, "''");

    const sql = 'SELECT * FROM createintake($1)';
    return util.executeDBQuery(sql, [finalReqStructure])
      .then(_data => {
        return _data[0];
      })
      .catch(err1 => {
        LOGGER.error('>>>>ERROR:', err1);
        throw err1;
      });
  };

  Intakedastaging.reviewIntake = async function (data, reqctx) {
    const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
    let _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
		}  
    const requestuserinfo = {'token': '', 'email': _email};
    let teamtypekey ;
    await util.getuserinfo(requestuserinfo).then (_data => {
			teamtypekey = _data.teamtypekey;
		});
    if(data?.intake?.sdm?.childfatality === 'yes') {
      data.intake.fatalityPersons = data.intake.persons?.filter(item => {
        let roles = item.personRole.filter(value => ['OTHERCHILD', 'CHILD', 'AV'].indexOf(value.rolekey) > -1)
        if(item.dateofdeath && roles.length) {
          return {
            dateofdeath: item.dateofdeath,
            cjamspid: item.cjamspid,
          };
        }
      });
    }
    data.intake.securityuserid = _securityusersid;
    data.intake.General.teamtypekey = teamtypekey;
    const tempReqStructure = JSON.stringify(data.intake);
    const finalReqStructure =tempReqStructure;
    let preintake = data.review.ispreintake;
    const bmanualrouting = data.review.ismanualrouting;
    if (preintake == null || preintake === undefined) {
      preintake = false;}

      const intakenumber = data.intake.General.IntakeNumber;

    if (bmanualrouting == null || bmanualrouting === undefined)
      {data.review.ismanualrouting = false;}

      const sql = 'SELECT * FROM reviewintake($1,$2)';


      const appeventcode = data.review.appevent;
      const responseJson = { "message": "", "isreceiveddelay": false, "issubmitdelay": false };

    // for auditlog  inside  review intake
    //  metadata.datereceived = new Date(data.intake.general.RecivedDate);
    //  metadata.intakeworker = data.intake.general.Author;
    //  metadata.status = data.review.status;
    //  metadata.disposition = data.intake.disposition.dispositioncode
    //  metadata.intakenumber = data.intake.general.IntakeNumber
    //  metadata.raname = (data.intake.persons[0].Firstname) +',' +(data.intake.persons[0].Lastname);

    const dReason = checkDalayReason(data, responseJson);

    if (dReason.bvalidate === true) {
      return dReason.responseJson;
    }
    return util.executeDBQuery(sql, [finalReqStructure, JSON.stringify(data.review)])
    .then(_data => {
        if (appeventcode === 'INTR' && preintake === false) {
          Intakedastaging.sendintakenotification(intakenumber);

          Intakedastaging.createAuditlog(intakenumber, _securityusersid);
        }
       return _data
    })
    .catch(err => {
        LOGGER.error(err)
        responseJson.message = err;
        return responseJson;
    })
  };

  function checkDalayReason(data, responseJson){
    let bvalidate = false;
    const receiveddelayreason = data.intake.General.receiveddelay;
    const submitteddelayreason = data.intake.General.submissiondelay;

    const recivedDate = new Date(data.intake.General.RecivedDate);
    const submittedDate = new Date(data.intake.General.RecivedDate);
    const currentDate = new Date();
    const status = (data.review.status);
    const appeventcode = data.review.appevent;

    if (status === 'supreview' && appeventcode === 'INTR' ) {
      if (receiveddelayreason == null || receiveddelayreason === undefined) {
        if (recivedDate.getTime() + config.recivedDelayDuration * 24 * 60 * 60 * 1000 <= currentDate) {
          responseJson.isreceiveddelay = true;
          responseJson.message = "Received date greater than 5 days";
          bvalidate = true;
        }
      }
      if (submitteddelayreason == null || submitteddelayreason === undefined) {
        if (submittedDate.getTime() + config.submittedDelayDuration * 24 * 60 * 60 * 1000 <= currentDate) {
          responseJson.issubmitdelay = true;
          responseJson.message = "Submitted date greater than 25 days";
          bvalidate = true;
        }
      }
    }
    return {
      bvalidate: bvalidate,
      responseJson: responseJson
    }
  }

  // Referral Received Audit Log
  Intakedastaging.createAuditlog = function (intakenumber, userid) {
      app.models.Auditlog.create({
        logtypekey:'RF001',
        intakeserviceid:null,
        servicerequestnumber:null,
        referenceid:null,
        description:'Referral Received',
        isnew :false,
        isedit:true,
        isdelete:true,
        insertedby:userid,
        updatedby:userid,
        insertedon:new Date(),
        updatedon:new Date(),
        metadata:null,
        ipaddress:null,
        old_id:null,
        modifieddata:null,
        objectid:intakenumber,
        objecttype: 'servicecase'
     }).catch(err => LOGGER.error(err));
  };

  Intakedastaging.logpersonmdm =(request,requestid) =>{
    let values = [];
    let query ='';
    if (request.hasOwnProperty('mdmId')) {
        query = 'insert into mdmlog (requestid,typeofpayload,payload,mdmid,insertedby,updatedby) values ($1,$2,$3,$4,$5,$6)';
        values = [requestid,'response',request,request.mdmId,'MDM log','MDM log'];
    } else{
        query = 'insert into mdmlog (requestid,typeofpayload,payload,insertedby,updatedby) values ($1,$2,$3,$4,$5)';
        values = [requestid,'request',request,'MDM log','MDM log'];
    }
   return util.executeDBQuery(query, values)
     .then(result => {
       LOGGER.debug(result);
       return result;
     })
    .catch(err => util.logError(err));
}

  Intakedastaging.revertapprovedintake = function (data) {
    const sql = 'SELECT * FROM revertapprovedintake($1)';
    return util.executeDBQuery(sql, [data.intakenumber])
      .then(res => {
        return res
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Intakedastaging.approveIntake = function (data, reqctx) {
    const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
    let approveResponse;
    data.intake.securityuserid = _securityusersid;
    const intakenumber = data.intake.General.IntakeNumber;

    data.intake.Allegations.forEach(allegation => {
      if (allegation.Indicators.length > 0)
        {allegation.Indicators = allegation.Indicators.join();}
    });

    const tempReqStructure = JSON.stringify(data.intake);
    const finalReqStructure = tempReqStructure.replace(/'/g, "''");

    // for auditlog inside  approve intake
    //  metadata.datereceived = new Date(data.intake.General.RecivedDate);
    //  metadata.intakeworker = data.intake.General.Author;
    //  metadata.status = data.review.status;
    //  metadata.disposition = data.intake.DAType.DATypeDetail[0].DADisposition;
    //  metadata.intakenumber = data.intake.General.IntakeNumber;
    //  metadata.raname = (data.intake.persondetails.Person[0].Firstname).trim() +',' +(data.intake.persondetails.Person[0].Lastname).trim();
    //  metadata.servicerequestnumber = data.intake.DAType.DATypeDetail[0].ServiceRequestNumber;

    const sql = 'SELECT * FROM approveIntake20($1,$2)';
    return util.executeDBQuery(sql, [finalReqStructure, JSON.stringify(data.review)])
      .then(_data => {
          /* MDM Integration */
          if (_data.length > 0) {
            const intakeserviceid = _data[0].responseintakeserviceid;
            const request = {"count":-1,"page":1,"limit":20,"method":"get","where":{"intakeserviceid":intakeserviceid}};
            const basicPersondetails = app.models.Person.getpersondetail(request,reqctx);
            basicPersondetails.then(function(value){
              return value;
            }).then(function(value){
              LOGGER.debug('### --->>> ',value);
              return value;
            });
          }
          /*Email Notification for approval*/
          if (_data.length > 0) {
            approveResponse = _data;
            Intakedastaging.sendintakenotification(intakenumber);
            return {data: approveResponse};
          }
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Intakedastaging.completeIntakeInternal = (data, _securityusersid) => {
    data.securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);

    if (data.Allegations) {
      data.Allegations.forEach(allegation => {
        if (allegation.Indicators.length > 0)
          {allegation.Indicators = allegation.Indicators.join();}
      });
    }

    const tempReqStructure = JSON.stringify(data);
    const finalReqStructure = tempReqStructure.replace(/'/g, "''");

    const sql = 'SELECT * FROM createintake($1)';
    return util.executeDBQuery(sql, [finalReqStructure])
      .then(_data => {
        return _data[0];
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Intakedastaging.listda = function (data, reqctx) {
    let userid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.id){
		  userid = reqctx.req.headers.id;
		}
    let Totalcount = 0;
    const pageNumber = data.page;
    const pageLimit = data.limit;
    let showCount = false;
    if (data.page === 1) {
      showCount = true;
    }/*  else {               //SonarQube fix - commented as showCount is already set to false above
      showCount = false
    }; */

    if (showCount) {
      const countQuery = 'select * from getintakeda_cnt($1)';
      return util.executeDBQuery(countQuery,[userid])
      .then(data1 => {
          Totalcount = data1[0].getintakeda_cnt;
          if (Totalcount > 0) {
            const sql = 'select * from getintakeda($1,$2,$3)';
            return util.executeDBQuery(sql,[userid,pageNumber,pageLimit])
            .then(_data => {
                LOGGER.info(_data);
                let result;
                result = {
                  'data': _data,
                  'count': Totalcount
                };
                return result;
              })
            .catch(_err => {
                LOGGER.error(_err)
                throw _err;
            });
          } else {
            let result1;
            result1 = {
              'data': [],
              'count': Totalcount
            };
            return result1;
          }
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    } else {
      const sql1 = 'select * from getintakeda($1,$2,$3)';

      return util.executeDBQuery(sql1,[userid,pageNumber,pageLimit])
      .then(_data => {
          LOGGER.info(_data);
          let result2;
          result2 = {
            'data': _data,
            'count': _data.length
          };
          return result2;
      })
      .catch(err => {
          LOGGER.error(err)
          throw err;
      })
    }
  };

  Intakedastaging.beforeRemote('listdadetails', function(ctx, data, next) {
    let suserid=undefined;
    if(ctx && ctx.req && ctx.req.headers) {
      suserid=ctx.req.headers.securityusersid
    }
    const securityuserid = data && data.securityuserid?data.securityuserid: suserid;
    const logtypekey = 'CV';
    const description = 'Intake was viewed by a worker';
    let status;
    let referenceid;
    if(ctx.args.data && ctx.args.data.where) {
      status =  ctx.args.data.where.status;
      referenceid =  ctx.args.data.where.intakenumber;
    }
    const newadd = {
      "description":description,
      "logtypekey":logtypekey ,
      "referenceid": securityuserid,
      "objectid": referenceid,
      "objecttype": 'intake',
      "insertedby":securityuserid,
      "updatedby":securityuserid,
    }
    if(status && referenceid) {
      app.models.Auditlog.create(newadd);
    }
    next();
  });

  Intakedastaging.listdadetails = (data, reqctx) => {
		const _securityusersid = data.where.securityusersid? data.where.securityusersid : util.getSecurityDetails(data, reqctx).securityuserid;

    const status = data.where.status;
    const intakenumber = data.where.intakenumber;
    const isExpungementSuperUser = data.where.isExpungementSuperUser ? data.where.isExpungementSuperUser: 0;
    const iscaseexpunged  = data.where.iscaseexpunged ?? 0; 
    var actionQuery;
    if(iscaseexpunged == 0) {
       actionQuery = `SELECT intakenumber FROM Intakedastaging WHERE intakenumber = $1 and teamtypekey = 'CW' and activeflag =1;`
    } else {
       actionQuery = `SELECT intakenumber FROM Intakedastaging WHERE intakenumber = $1 and teamtypekey = 'CW' and activeflag =1 
                      union all SELECT intakenumber FROM expunge.Intakedastaging_expunge WHERE intakenumber = $1 and teamtypekey = 'CW' and activeflag =1;`
    }
    if (status === "intake") {     
      return util.executeDBQuery(actionQuery,[intakenumber])
      .then(result => {
        if (result == null || result.length === 0) {

          return getdraftintake(intakenumber,isExpungementSuperUser,iscaseexpunged);
        }
        else {
          return Intakedastaging.listintakedetails(data, _securityusersid);

        }
      })
    }
    else {

      return Intakedastaging.listintakedetails(data, _securityusersid);

    }
  };
  /* */
  function getdraftintake(intakenumber,isExpungementSuperUser, iscaseexpunged) {
    let sql = '';
    let Totalcount = 0;
    sql = 'select * from getdraftintake($1,$2,$3)';

    return util.executeSecondaryNodeDBQuery(sql, [intakenumber, isExpungementSuperUser,iscaseexpunged])
      .then(data => {
        if (data!=null && data.length > 0) {
          Totalcount = data[0].totalcount;}
        let result;
        result = {
          'data': data,
          'count': Totalcount
        };
        return util.encryptresponse(result);
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Intakedastaging.listintakedetails = (data, _securityusersid) => {
    const userid = _securityusersid;
    const pageNumber = data.page;
    const pageLimit = data.limit;
    const status = data.where.status;
    const intakenumber = data.where.intakenumber;
    let { bpreintake, sortcolumn, sortorder, isExpungementSuperUser, iscaseexpunged } = returnParamsFn(data);
    let sql = '';
    let params;


    sql = 'select * from listintakedetails($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)';
    params = [userid, status, pageNumber, pageLimit, intakenumber, bpreintake, sortcolumn, sortorder, isExpungementSuperUser, iscaseexpunged];
    if (bpreintake === true) {
      if (sortcolumn == null || sortcolumn === undefined) {
        sortcolumn = "DateRecieved";}
      if (sortorder == null || sortorder === undefined) {
        sortorder = "desc";
      }
      sql = 'select * from listpreintake($1,$2,$3,$4,$5,$6,$7,$8)';
      params = [userid, status, pageNumber, pageLimit, intakenumber, bpreintake, sortcolumn, sortorder];
    }

    if(status === 'screenin' || status === 'screenout' || status === 'spclosed' || status === 'intakescreenin' || status === 'intakescreenout') {
      sql = checkstatus(status, sortcolumn, sortorder, sql);
      params = [userid, status, pageNumber, pageLimit, intakenumber, bpreintake, sortcolumn, sortorder];
    }

    return executelistIntake(sql, params)
    .then(_data => _data)
    .catch(err => err);

  };

  function checkstatus(status, sortcolumn, sortorder, sql){
    if(status === 'screenin' || status === 'screenout' || status === 'spclosed')
    {
      sql = 'select * from listintakedcompletestatus($1,$2,$3,$4,$5,$6,$7,$8)';
    }

    if(status === 'intakescreenin' || status === 'intakescreenout' )
    {
      // Use parameterized query - let the database function handle ORDER BY with $7 and $8
      sql = 'select * from listintakescreenindashboard($1,$2,$3,$4,$5,$6,$7,$8)';
    }
    return sql
  }

  function executelistIntake(sql, params){
    let Totalcount = 0;
    return util.executeSecondaryNodeDBQuery(sql, params)
      .then(data => {
        if (data!=null && data.length > 0) {
          Totalcount = data[0].totalcount;}
        let result;
        result = {
          'data': data,
          'count': Totalcount
        };
        return result;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }


  /* Get the user list  based on USER */
  Intakedastaging.getroutingusers = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    const userid = (data && data.securityuserid?data.securityuserid: _securityusersid);
    const appevent = data.where.appevent;
    const teamid = data.where.teamid?data.where.teamid:null;
    const authId = data.where.authId ? data.where.authId:null;
    const sql = 'SELECT * FROM getroutingusers($1,$2,$3,$4)';
    var params = [userid, appevent, teamid, authId];
    return util.executeDBQuery(sql, params)
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Intakedastaging.getIntakeUsers = async function(request, reqctx) {
    let _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
		}  
    const requestuserinfo = {'token': '', 'email': _email};
    let roletypekey = '';
    let teamtypekey ;
    	await util.getuserinfo(requestuserinfo).then (data => {
			teamtypekey = data.teamtypekey;
		});
    if(teamtypekey === 'DJS'){
      roletypekey = 'JSIW';
    }

    const skip = (request.page - 1) * request.limit;
    const limit = request.limit;

    const sql = 'select * from getintakeusers($1, $2, $3)';

    return util.executeDBQuery(sql, [roletypekey, skip, limit])
      .then(data => {
        let totalCount = 0;
        if (data.length > 0) {
          totalCount = data[0].totalcount;}
        data.forEach(x => {
          delete x.totalcount;
        })

        return { count: totalCount, data: data };
      })
      .catch(err => util.logError(err));
  }

  /* Get the routed DA based on USER */
  Intakedastaging.getroutedda = function (data, reqctx) {
    const securityuserid = util.getSecurityDetails(data, reqctx).securityuserid;

    const userid = data.where.securityusersid ? data.where.securityusersid : securityuserid;
    const isassigned = data.where.assigned;
    const serreqno = data.where.serreqno;
    const pageNumber = data.page;
    const pageLimit = data.limit;
    let sortcolumn = data.where.sortcolumn;
    let sortorder = data.where.sortorder;
    if (sortcolumn == null || sortcolumn === undefined) {
      sortcolumn = "assigneddate";}
    if (sortorder == null || sortorder === undefined) {
      sortorder = "desc";}

    const sql = 'SELECT * FROM getroutedda($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)';

    return util.executeSecondaryNodeDBQuery(sql, [userid, isassigned, pageNumber, pageLimit, serreqno,sortcolumn,sortorder,null,data.where.status,data.where.filter])
      .then(withTotalCount)
      .catch(logAndRethrow);

  };

  /* Get the Review Pending cases  based on USER */
  Intakedastaging.getpendingreviewda = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    let Totalcount = 0;
    const securityuserid = data.securityuserid?data.securityuserid: _securityusersid;
    const userid = data.where.securityusersid?data.where.securityusersid:securityuserid;
    let serreqno = data.where.serreqno;
    let pageNumber = data.page;
    let pageLimit = data.limit;

    if(serreqno === undefined || serreqno === ''){
      serreqno = null;
    }
    const sql = 'SELECT * FROM getpendingreviewda($1,$2,$3,$4)';

    return util.executeDBQuery(sql, [userid, pageNumber, pageLimit, serreqno])
      .then(_data => {
          if (_data.length > 0) {
            Totalcount = _data[0].totalcount;
          }
          let result;
          result = {
            'count': Totalcount,
            'data': _data
          };
          return result;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  Intakedastaging.getpendingcaseworker = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    const securityuserid = (data.securityuserid ? data.securityuserid : _securityusersid);
    let userid = data.where.securityusersid ? data.where.securityusersid : securityuserid;
    const serreqno = data.where.serreqno;
    const dateFrom = data.where.dateFrom;
    const dateTo = data.where.dateTo;
    const teamid = data.where.teamid;
    const role = data.where.role;
    let sql = 'SELECT * FROM getpendingcaseworker($1,$2,$3,$4,$5,$6,$7)';
    // This logic is for only Admin screen
    if(teamid){
      if(data.where.securityusersid){
        userid = data.where.securityusersid;
      } else {
        userid = null;
      }
      
    }

    if(role === 'CWSP'){
      sql = 'SELECT * FROM getallapprovedrecord($1,$2,$3,$4,$5,$6,$7)';
    }
    
    const pageNumber = data.page;
    // NOSONAR
    // data.limit; //Temporary change, need to modify later
    const pageLimit = 50;


    return util.executeDBQuery(sql, [userid, pageNumber, pageLimit, serreqno,dateFrom,dateTo,teamid])
      .then(withTotalCount)
      .catch(logAndRethrow);

  };

  /* Get the routed DA based on USER */
  Intakedastaging.routeda = function (data, reqctx) {
    const userid = util.getSecurityDetails(data, reqctx).securityuserid;
    const appeventcode = data.where.appeventcode;
    const serreqid = data.where.serreqid;
    const assigneduserid = JSON.stringify(data.where.assignedusers);
    const isgroup = data.where.isgroup;
    let responsibilitytypekey = data.where.responsibilitytypekey;

    const servicerequestid = data.where.serreqid;

    if (responsibilitytypekey == null || responsibilitytypekey === undefined) {
      responsibilitytypekey =null;}
    if (data.where.assignfolder == null || data.where.assignfolder === undefined) {
      data.where.assignfolder = {};}
    const assignfolder = data.where.assignfolder;
    const assignlater = data.where.assignlater ? data.where.assignlater : false;
    const notifyuser = data.where.assignlater ? false : true;

    if (isgroup === true)
    {
      const  sql = 'SELECT * FROM routinggroupda($1,$2,$3,$4,$5)';
      return util.executeDBQuery(sql, [appeventcode, serreqid, userid, assigneduserid,assignfolder])
        .then(_data => {
            Intakedastaging.sendintakenotification(servicerequestid);
            return _data;
        })
        .catch(_err => {
          LOGGER.error('>>>>ERROR:', _err);
          throw _err;
        });
    } else {
      const sql = 'SELECT * FROM routingda($1,$2,$3,$4,$5,$6,$7,$8)';
      return util.executeDBQuery(sql, [appeventcode, serreqid, userid, assigneduserid,responsibilitytypekey,assignfolder,notifyuser,assignlater])
        .then(_data => {
            Intakedastaging.sendintakenotification(servicerequestid);
            return _data;
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
    }
  };


  /*temporary URL for modifying Create Intake*/

  Intakedastaging.tempCompleteIntake = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    data.securityuserid = data && data.securityuserid?data.securityuserid: _securityusersid;

    data.Allegations.forEach(allegation => {
      if (allegation.Indicators.length > 0)
        {allegation.Indicators = allegation.Indicators.join();}
    })

    const tempReqStructure = JSON.stringify(data);
    const finalReqStructure = tempReqStructure.replace(/'/g, "''");

    const sql = 'SELECT * FROM createintake_activity($1)';
    return util.executeDBQuery(sql, [finalReqStructure])
      .then(_data => {
        return _data[0];
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };


  /* Get the Appeal DA based on Routed USER */
  Intakedastaging.getappealda = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    let Totalcount = 0;

    const userid = data && data.securityuserid?data.securityuserid: _securityusersid;
    const serreqno = data.where.serreqno;
    const pageNumber = data.page;
    const pageLimit = data.limit;

    const sql = 'SELECT * FROM getappealda($1,$2,$3,$4)';

    return util.executeDBQuery(sql, [userid, pageNumber, pageLimit, serreqno])
      .then(_data => {
          if (_data.length > 0) {
            Totalcount = _data[0].totalcount;
            let result;
            result = {
              'data': _data,
              'count': Totalcount
            };
            return result;
          }
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };



  Intakedastaging.assignintake = function (data, reqctx) {
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    let _email;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
      _email = reqctx.req.headers.user_email_captureby_application;
		}  
    const requestuserinfo = {'token': '', 'email': _email};
    let teamtypekey ;
    return util.getuserinfo(requestuserinfo).then (_data => {
      teamtypekey = _data.teamtypekey;

      const userid = data && data.securityuserid?data.securityuserid: _securityusersid;
      const appeventcode = data.where.appeventcode;
      let intakenumber = data.where.intakenumber;
      const assigneduserid = data.where.assigneduserid;
      let status = data.where.status;
      if (!status)
        {status = 10;}

      if (!intakenumber)
        {intakenumber = '';}

      const sql = 'SELECT * FROM assignintake($1,$2,$3,$4, $5,$6)';

      return util.executeDBQuery(sql, [appeventcode, intakenumber, userid, assigneduserid, status,teamtypekey]);
    })
    .catch(logAndRethrow);

  };

  

  Intakedastaging.remoteMethod(
    'getsupervisorapprovalinfo',
    {
      http: {
        path: '/getsupervisorapprovalinfo',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakedastaging.remoteMethod(
    'saveIntake',
    {
      http: {
        path: '/saveIntake',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakedastaging.remoteMethod(
    'completeIntake',
    {
      http: {
        path: '/completeIntake',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  /* review and Approve intake */

  Intakedastaging.remoteMethod(
    'reviewIntake',
    {
      http: {
        path: '/reviewIntake',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakedastaging.remoteMethod(
    'approveIntake',
    {
      http: {
        path: '/approveIntake',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakedastaging.remoteMethod(
    'revertapprovedintake',
    {
      http: {
        path: '/revertapprovedintake',
        verb: 'post'
      },
      accepts: {
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      },
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakedastaging.remoteMethod(
    'getroutingusers',
    {
      http: {
        path: '/getroutingusers',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakedastaging.remoteMethod(
    'getIntakeUsers',
    {
      accepts: [{
        arg: 'filter',
        type: 'object',
        required: true},
        {arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}}],
      http: {
        path: '/getIntakeUsers',
        verb: 'get'
      },
      returns: {
        type: 'Object',
        root: true
      }
    });


  Intakedastaging.remoteMethod(
    'getroutedda',
    {
      http: {
        path: '/getroutedda',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );
  Intakedastaging.remoteMethod(
    'getpendingcaseworker',
    {
      http: {
        path: '/getpendingcaseworker',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );
  Intakedastaging.remoteMethod(
    'getpendingreviewda',
    {
      http: {
        path: '/getpendingreviewda',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );
  Intakedastaging.remoteMethod(
    'routeda',
    {
      http: {
        path: '/routeda',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );
  Intakedastaging.remoteMethod(
    'getappealda',
    {
      http: {
        path: '/getappealda',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );
  Intakedastaging.remoteMethod(
    'assignintake',
    {
      http: {
        path: '/assignintake',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );

  Intakedastaging.remoteMethod(
    'tempCompleteIntake',
    {
      http: {
        path: '/tempCompleteIntake',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });



  Intakedastaging.remoteMethod(
    'listda',
    {
      http: {
        path: '/listintakeda',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'listIntakeDARequest',
        http: {
          source: 'body'
        }
      },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );


  Intakedastaging.remoteMethod(
    'listdadetails',
    {
      http: {
        path: '/listdadetails',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        type: 'object',
        root: true
      }
    }
  );


  Intakedastaging.getintakesnapshot = function (request) {

    const sql = 'select * from getintakesnapshot($1)';
    var params = [request.where.servicerequestid];

    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

  };

  Intakedastaging.remoteMethod('getintakesnapshotrecord', {
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


  Intakedastaging.getintakesnapshotrecord = function (request) {

    const sql = 'select * from intakesnapshot where intakenumber = $1 and activeflag = 1 order by insertedon desc limit 1';
    return util.executeSecondaryNodeDBQuery(sql, [request.where.intakenumber])
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error(err);
        return util.logError(err);
      });

  };

  Intakedastaging.remoteMethod('getintakesnapshot', {
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

  Intakedastaging.sendintakenotification = function (objectid, response) {
    const sql = 'select * from getemailnotification($1)';

    return util.executeDBQuery(sql, [objectid])
      .then(result => {
        result.map(x => {
          email.SendEmail(x.email, 'CJAMS Notification', x.body);
          const sql1 = 'update usernotification set ismailsent = true,mailsentdate=$1 where usernotificationid = $2 ';
          return util.executeDBQuery(sql1, [new Date(), x.usernotificationid])
            .catch(_err => {
              LOGGER.error('>>>>ERROR:', _err);
              throw _err;
            });
        });
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Intakedastaging.remoteMethod(
    'clwClosedIntake',
    {
      http: {
        path: '/clwClosedIntake',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakedastaging.clwClosedIntake = function (data, reqctx) {
    const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
    let gData;
    let prs = [];
    data.intake.securityuserid = _securityusersid;
    const tempReqStructure = JSON.stringify(data.intake);
    const finalReqStructure = tempReqStructure.replace(/'/g, "''");
    const intakenumber = JSON.parse(finalReqStructure).General.IntakeNumber;
    prs.push(new Promise((resolve, reject) => {
      app.models.Intakedastaging.reviewIntake(data, reqctx, (err, _data) => {
        if (err)
          {reject(err);}
        else
          {resolve(_data);}
      })
    }));
    if (data.intake.clwstatus === 4) {
      prs.push(
        app.models.Intakeservicerequestpetition.add(data.intake.petitionDetails)
      );
    }
    if (data.intake.clwstatus === 4) {
      prs.push(
        app.models.Intakeservicerequestcourtaction.add(data.intake.courtDetails)
      );
    }
    else {
      if (data.intake.courtDetails.intakeservicerequestids != null || data.intake.courtDetails.intakeservicerequestids !== undefined) {
        if (Array.isArray(data.intake.courtDetails.intakeservicerequestids)) {
          data.intake.courtDetails.intakeservicerequestids.forEach(result => {
            data.intake.courtDetails.intakeservicerequestid = result;
            prs.push(
              app.models.Intakeservicerequestcourtaction.addupdate(data.intake.courtDetails)
            );
          }
          );
        }
      }
    }
    if (data.intake.disposition) {
      prs.push(
        app.models.Intakeservicerequestdispositioncode.Add(data.intake.disposition)
      );
    }

    const flatPrs = prs.reduce((a, b) => a.concat(b), []);
    return Promise.all(flatPrs)
      .then(_data => {
        gData = _data;
        const sql = "update routing set activeflag = 1 where routingstatustypeid=4 and  objectid::uuid in(select intakeserviceid from intakeservicerequest where intakenumber=$1)";
        
        return util.executeDBQuery(sql, [intakenumber])
        .then(data1 => {
            LOGGER.info(data1);
        })
        .catch(err => {
            LOGGER.error(err)
        })
      })
      .then(_data => {
        return gData;
      })
      .catch(err => err);

  };

    Intakedastaging.remoteMethod(
      'pathwayapprove',
      {
        http: {
          path: '/pathwayapprove',
          verb: 'post'
        },
        accepts: [{
          arg: 'data',
          type: 'object',
          http: {
            source: 'body'
          }
        }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }],
        returns: {
          arg: 'data',
          type: 'Object'
        }
      });

  Intakedastaging.pathwayapprove = function (request,reqctx) {
    const _securityusersid = util.getSecurityDetails(request,reqctx).securityuserid;
    const securityusersid = _securityusersid;
    let status = 16;
    let comments = "Pathway has been ";
    comments = (request.comments != null && request.comments !== undefined) ? request.comments : (comments + request.status);
    let notifymsg = '';
    let routeddescription = '';
    if (request.status === "Approved") {
      status = 16;
      notifymsg = 'Pathway has been approved';
      routeddescription = 'Pathway has been approved';
    } else if (request.status === "Rejected") {
      status = 17;
      notifymsg = 'Pathway has been rejected';
      routeddescription = 'Pathway has been rejected';
    }
    const qry = 'SELECT * FROM routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
    return util.executeDBQuery(qry,[request.servicerequestid,securityusersid,'PWCR',status,comments,'',false,false,false,notifymsg,routeddescription,request.servicerequestid])
      .then(result => {
        return result[0].routingintake;
      })
      .then(data => {
        if (status === 16) {
          const qry1 = 'SELECT * FROM pathwayapprove($1,$2,$3)';
          return util.executeDBQuery(qry1,[request.servicerequestid,request.intakeservicerequestsdmid,securityusersid]).then(result => {
            return result;
          }).then(_data => {
            return _data;
          }).catch(err => {
            LOGGER.error(err);
            return err;
          });

        } else if (status === 17) {
          // Pathway Rejected
          const qry2 = 'SELECT * FROM pathwayreject($1, $2, $3)';
          return util.executeDBQuery(qry2,[
            request.servicerequestid,
            request.intakeservicerequestsdmid,
            securityusersid
          ]).then(result => {
            let childfatalityAuditQuery = 'SELECT * FROM updatechildfatality($1,$2,$3,$4,$5,$6)';

            util.executeDBQuery(childfatalityAuditQuery,[
              request.servicerequestid,
              'no',
              request.intakeservicerequestsdmid,
              securityusersid,
              request.casenumber,
              null,
            ]).catch(cfaError => {
              LOGGER.error(cfaError);
            });

            // Return response immediately after pathway rejection
            return result?.[0]?.pathwayreject || 'Pathway has been rejected';
          }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
        }
        else {
          return data;
        }
      }).catch(err => {
        LOGGER.error(err)
      })
  };
    //Payment header and details api ended

    Intakedastaging.remoteMethod('personsearchfolders', {
      accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
          source : 'query'
        },
        required : true
      },
      http : {
        path: '/personsearchfolders',
        verb : 'get'
      },
      returns : {
        type : 'string',
        root : true
      }
    });

    Intakedastaging.personsearchfolders = request => {
      let searchkey = '';
      if(request.where) {
        searchkey = request.where.searchkey;
      }

      const sql = 'Select * from personsearchfolders($1)';

      return util.executeDBQuery(sql, [searchkey])
      .then(data => data)
      .catch(err => util.logError(err));
    };

    Intakedastaging.remoteMethod('servicerequestsearchfolders', {
      accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
          source : 'query'
        },
        required : true
      },
      http : {
        path: '/servicerequestsearchfolders',
        verb : 'get'
      },
      returns : {
        type : 'string',
        root : true
      }
    });

    Intakedastaging.servicerequestsearchfolders = request => {
      let searchkey = '';
      if(request.where) {
        searchkey = request.where.searchkey;
      }
      
      const sql = 'Select * from servicerequestsearchfolders($1)';
      return util.executeDBQuery(sql, [searchkey])
      .then(data => data)
      .catch(err => util.logError(err));
    };


    Intakedastaging.listservicestatus = (data, reqctx) => {
      let _securityusersid = undefined;
      if(reqctx?.req?.headers?.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
      const userid = (data.securityuserid ? data.securityuserid : _securityusersid);
      const pageNumber = data.page;
      const pageLimit = data.limit;
      const Reqforservice = data.where.Reqforservice;
      let sortcolumn = data.where.sortcolumn;
      let sortorder = data.where.sortorder;

      if (sortcolumn == null || sortcolumn === undefined) {
        sortcolumn = "receiveddate";}
      if (sortorder == null || sortorder === undefined) {
        sortorder = "desc";}
      let sql = '';

      sql = 'select * from listintakeservicestatus($1,$2,$3,$4,$5,$6)';

      const params = [userid, Reqforservice, pageNumber, pageLimit, sortcolumn, sortorder];

      return util.executeDBQuery(sql, params)
        .then(withTotalCount)
        .catch(err => err);

    };




    Intakedastaging.remoteMethod(
      'listservicestatus',
      {
        http: {
          path: '/listservicestatus',
          verb: 'post'
        },
        accepts: [{
          arg: 'data',
          type: 'object',
          http: {
            source: 'body'
          }
        }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }],
        returns: {
          type: 'object',
          root: true
        }
      }
    );




     //Reject intake and routing to review  to supervisor

            Intakedastaging.remoteMethod(
            'rejectservicestatus',
            {
              http: {
                path: '/rejectservicestatus',
                verb: 'post'
              },
              accepts: {
                arg: 'data',
                type: 'object',
                http: {
                  source: 'body'
                }
              },
              returns: {
                arg: 'data',
                type: 'Object'
              }
            });


          //Service Status and details in dashboard Reject

     Intakedastaging.rejectservicestatus =request => {
      const sql = 'SELECT * FROM getreviewintakejson($1)';
      const intakenumber=request.intakenumber;
        return util.executeDBQuery(sql, [intakenumber])
      .then(res => {
        const reviewObj = JSON.parse(JSON.stringify(res));
        return new Promise((resolve, reject) => {
          const Objectreview = {
            appevent: "INTR",
            status: "supreview",
            commenttext: request.rejectcomments,
            ispreintake: false,
            assignsecurityuserid: reviewObj[0].intake.reviewstatus.assignsecurityuserid,
            ismanualrouting: true
        };

          reviewObj[0].intake.DAType.DATypeDetail[0].DAStatus='Review';
          reviewObj[0].intake.DAType.DATypeDetail[0].intakeserreqstatustypekey='Review';
          reviewObj[0].intake.DAType.DATypeDetail[0].dispositioncode="ScreenOUT";
          reviewObj[0].intake.DAType.DATypeDetail[0].DADisposition="ScreenOUT";

          reviewObj[0].intake.disposition[0].DAStatus='Review';
          reviewObj[0].intake.disposition[0].intakeserreqstatustypekey='Review';
          reviewObj[0].intake.disposition[0].dispositioncode="ScreenOUT";
          reviewObj[0].intake.disposition[0].DADisposition="ScreenOUT";
          const intakereviewObj={intake:reviewObj[0].intake,review:Objectreview};
          app.models.Intakedastaging.reviewIntake(intakereviewObj, reqctx, (err, data) => {
            err ? reject(err) : resolve(data);
          })
        });
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

    };


    //CaseWorker create duplicate case for Request for service APS

Intakedastaging.CompletecaseAPS = (request) => {
let gIntakeObj = {};

return setupNewCaseWorkerforAPS(request)
.then(newAPSIntakeObj => {
  return app.models.Intakedastaging.completeIntakeInternalAPS(newAPSIntakeObj);
})
.then(data => {
  gIntakeObj = data;
  const userid = (request && request.securityuserid?request.securityuserid:null);
  const requestData = {where:{assigneduserid:userid,appeventcode:'INVT',isgroup:false,serreqid:data.responseintakeserviceid,responsibilitytypekey:null}};

  return new Promise((resolve, reject) => {
    Intakedastaging.routeda(requestData, reqctx, (_ph, result)=>{
      resolve(result);
    });
  });

}).then(_res =>gIntakeObj)
  .catch(err=>err)

};

const setupNewCaseWorkerforAPS = (request) => {
let gIntakeNum = '';
const gIntakeserviceId = request.intakeserviceid;
let gFocusPerson = {};
let gIntakeservreqtypeid = '';
let gServicerequestsubtypeid = '';
let gStatusId = '';
let gDispositionId = '';
const gCurrentUser = app.currentUser;

return app.models.Intakeservicerequest.getIntakeDetails(gIntakeserviceId)
.then(intakeNum => {
  gIntakeNum = intakeNum;
  const prs = [];
  prs.push(app.models.Intakeservicerequestactor.getAPSFocusPerson(gIntakeserviceId));
  prs.push(Intakedastaging.getintakeTypeSubType(gIntakeserviceId));
  prs.push(Intakedastaging.getStatusDispositionDuplicate());
  
  const currentUser = JSON.parse(JSON.stringify(gCurrentUser));

  prs.push(app.models.Userprofile.find({
    where: {securityusersid: currentUser.securityusersid},
    fields: ['securityusersid', 'displayname']
  }));

  prs.push(app.models.Intakeservicerequestinputtype.find({
    where: {intakeservreqinputtypekey: 'Other'},
    fields: ['intakeservreqinputtypeid']
  }));

    prs.push(new Promise((resolve, reject) => {
      const requestData='servicerequestauthorizationnumber'
      app.models.Nextnumber.getNextNumber(requestData, (err, result)=>{
        err ? reject(err) : resolve(result);
      });
  }));
  prs.push(app.models.Intakeservicerequestinputsource.find({
    where: {intakeservreqinputsourcekey: 'Other Services'},
    fields: ['intakeservreqinputsourceid']
  }));

  return Promise.all(prs);

})
.then(resp => {
  const data = JSON.parse(JSON.stringify(resp));
  gFocusPerson = data[0];
 
  
  const getintakeTypeSubType = data[1];
  gIntakeservreqtypeid = getintakeTypeSubType.intakeservreqtypeid;
  gServicerequestsubtypeid = getintakeTypeSubType.intakeservicerequestclassid;

  const statusDisposition = data[2];
  if(statusDisposition) {
    gStatusId = statusDisposition.intakeserreqstatustypeid;
    
    if(statusDisposition.servicerequesttypeconfigdispositioncode && statusDisposition.servicerequesttypeconfigdispositioncode.length > 0)
      {gDispositionId = statusDisposition.servicerequesttypeconfigdispositioncode[0].servicerequesttypeconfigiddispostionid;}
  }
  const details = checkDetails(data);
  const displayName = details.displayName;
  const intakeSource = details.intakeSource;
  const newIntakeNum = details.newIntakeNum;
  const inputSource = details.inputSource;
  

  const newAPSIntakeObj = {};
  newAPSIntakeObj.General = {
    Time: new Date(),
    IntakeNumber: newIntakeNum,
    Source: intakeSource,
    InputSource:inputSource,
    RecivedDate: new Date(),
    CreatedDate: new Date(),
    Author: displayName,
    Narrative: gIntakeNum.narrative
  };

  newAPSIntakeObj.Person = getpersondetail(gFocusPerson);

  newAPSIntakeObj.DAType = {
    DATypeDetail: [{
      DaTypeKey: gIntakeservreqtypeid,
      DasubtypeKey: gServicerequestsubtypeid,
      personid: '',
      DAStatus: gStatusId,
      DADisposition: [gDispositionId],
      CancelReason: [null],
      CancelDescription: [null],
      Summary: [''],
      ServiceRequestNumber: newIntakeNum
  }]};
  newAPSIntakeObj.CrossReferences = [{
    "CrossRefDA": gIntakeNum.servicerequestnumber,
    "ReasonsofCrossref": "APSContinuing",
    "Assighnedto": displayName,
    //"DAType": "CAN",
    //"DASubType": "Class II",
    "CrossRefwith": newIntakeNum,
    "CrossRefDAID": request.intakeserviceid
  }];
  newAPSIntakeObj.Allegations = [];
  
  return newAPSIntakeObj;
})
.catch(err => util.logError(err));
};

function checkDetails(data){
  const userProfile = data[3];
  let displayName = '';

  if(userProfile.length > 0)
    {displayName = userProfile[0].displayname;}
  
  const intakeSourceData = data[4];
  let intakeSource = '';
  if(intakeSourceData.length > 0)
    {intakeSource = intakeSourceData[0].intakeservreqinputtypeid;}
      
  const newIntakeNumObj = data[5];
  let newIntakeNum = '';
  if(newIntakeNumObj.length > 0)
   { newIntakeNum = newIntakeNumObj;}

  const inputSourceData = data[6];
  let inputSource ='';
  if(inputSourceData.length > 0)
  {inputSource = inputSourceData[0].intakeservreqinputsourceid;}

  return {
    displayName: displayName,
    intakeSource: intakeSource,
    newIntakeNum: newIntakeNum,
    inputSource: inputSource
  }
}

function getpersondetail(gFocusPerson){
  return gFocusPerson.map(x=> {
    let personaddressid = '';
    let address = '';
    let address2 = '';
    let city = '';
    let state = '';
    let zipcode = '';
    let county = '';
    let dangeraddress = '';
    let dangerreason = '';
    if(x.personaddress.length > 0){
      let personaddress =  x.personaddress[0];
      personaddressid = personaddress.personaddressid;
      address = personaddress.address;
      address2 = personaddress.address2;
      city = personaddress.city;
      state = personaddress.state;
      zipcode = personaddress.zipcode;
      county = personaddress.county;
      dangeraddress = personaddress.danger ? 'Yes' : 'No';
      dangerreason = personaddress.dangerreason;
    }
    return {
              "Firstname": x.firstname,
              "Pid": x.personid,
              "Role": x.actortype,
              "Lastname": x.lastname,
              "Middlename": x.middlename,
              "Race": [x.racetypekey],
              "PrimaryPhoneNumber": "",
              "AddressId": personaddressid,
              "Address": address,
              "Address2": address2,
              "City": city,
              "State": state,
              "Zip": zipcode,
              "County": county,
              "Dangerous": x.dangerlevel === 1 ? 'Yes': 'No',
              "DangerousWorkerReason": "D _ Person",
              "DangerousAddress": dangeraddress,
              "DangerousAddressReason": dangerreason,
              "RoutingAddress": "1"

    };
    
  });
}


Intakedastaging.getStatusDispositionDuplicate = () => {
 
  return app.models.Intakeserreqstatustype.find({
    where: {intakeserreqstatustypekey: 'Approved'},
    fields: ['intakeserreqstatustypeid'],
    include: {
      relation: 'servicerequesttypeconfigdispositioncode',
      scope: {
        where: {dispositioncode: 'Scrnin'},
        fields: ['intakeserreqstatustypeid', 'servicerequesttypeconfigiddispostionid']
      }
    }
  })
  .then(resp => {
    const data = JSON.parse(JSON.stringify(resp));
    if(data.length > 0)
      {return data[0];}
    return null;
  })
  .catch(err => util.logError(err));
  
};
    
Intakedastaging.getintakeTypeSubType = (intakereqid) => {
  return app.models.Intakeservicerequest.findById(intakereqid, {
    fields: ['intakeservreqtypeid', 'intakeservicerequestclassid'],
    //include: [{}, {}]
  })
  .then(resp => {
    return JSON.parse(JSON.stringify(resp));
  })
  .catch(err => util.logError(err));
};

Intakedastaging.completeIntakeInternalAPS = data => {
  data.securityuserid = (data && data.securityuserid?data.securityuserid: null);

  if (data.Allegations) {
    data.Allegations.forEach(allegation => {
      if (allegation.Indicators.length > 0)
        {allegation.Indicators = allegation.Indicators.join();}
    });
  }

  const tempReqStructure = JSON.stringify(data);
  const finalReqStructure = tempReqStructure.replace(/'/g, "''");
  let rroletypecode=request.roletypecode;
  let rteamtypekey=request.teamtypekey;
  if (rroletypecode == null || rroletypecode === undefined) {
    rroletypecode = "Default";}
  if (rteamtypekey == null || rteamtypekey === undefined) {
    rteamtypekey = "Default";}

    const sql = 'SELECT * FROM createintakeapscontinue($1,$2,$3)';
  return util.executeDBQuery(sql, [finalReqStructure,rroletypecode,rteamtypekey])
    .then(_data => {
      return _data[0];
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });
};
  

Intakedastaging.getpriors = function (request) {

  const sql = 'select * from getintakeprior($1)';

  return util.executeDBQuery(sql, [request.where.intakenumber])
    .then(data => {
      if(data){
        return data[0].getintakeprior;
      }else {
        return data;
      }
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });

};

Intakedastaging.remoteMethod('getpriors', {
  accepts: {
    arg: 'filter',
    type: 'Object',
    http: {
      source: 'query'
    },
    required: true
  },
  http: {
    path: '/getpriors',
    verb: 'get'
  },
  returns: {
    type: 'Object',
    root: true
  }
});



  Intakedastaging.getpriorbyservicecase = function (request) {

    const sql = 'select * from getpriorbyservicecase($1)';

    return util.executeSecondaryNodeDBQuery(sql, [request.where.servicecaseid])
      .then(data => {
        if (data) {
          return data[0].getpriorbyservicecase;
        } else {
          return data;
        }
      })
      .catch(err => {
        LOGGER.error(err);
        return util.logError(err);
      });

  };

  Intakedastaging.remoteMethod('getpriorbyservicecase', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      path: '/getpriorbyservicecase',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

Intakedastaging.getintakejsondata = function (request) {

  // util.beforeremote only fills in where/limit/page when ctx.args.filter is
  // already an object, so a caller that passes anything else still reached the
  // reads below with where undefined -- and only the first read was guarded, so
  // the next two threw a TypeError that error-logger flattened into the same
  // undiagnosable 400.
  const where = (request && request.where) ? request.where : {};

  // The procedure filters solely on isr.intakeserviceid, so there is no valid
  // call without one -- reject anything that is not a uuid rather than let it
  // reach Postgres as text.
  if (notAUuid(where.intakeserviceid)) {
    return badRequest('intakeserviceid must be a uuid');
  }

  const intakeserviceid = where.intakeserviceid.trim();
  const isExpungementSuperUser = expungementFlag(where.isExpungementSuperUser);
  const iscaseexpunged = expungementFlag(where.iscaseexpunged);
  const sql = 'select * from getintakejsondata($1, $2, $3)';

  return util.executeSecondaryNodeDBQuery(sql, [intakeserviceid, isExpungementSuperUser, iscaseexpunged])
    .then((data) => {
      let result = null;
      // Tested- Array.isArray(data) check is also not needed as data[0] will itself be undefined
      // if 'data' is not an array, so the if condition will not proceed to data[0].jsondata
      if (data && data[0] && data[0].jsondata) {
        result = data[0].jsondata.unknownPersons;
      }
      return result;
    })
    .catch((err) => {
      LOGGER.error(err);
      throw err;
    });

};

  Intakedastaging.updateintakejsondata = function (request) {

    let intakeserviceid = '';
    let unknownPersonList = [];
    if (request) {
      intakeserviceid = request.intakeserviceid;
      unknownPersonList = request.unknownpersonlist;
    }
    if (notAUuid(intakeserviceid)) {
      return badRequest('intakeserviceid must be a uuid');
    }
    // getintakejsondata.sql explicitly DROPs the single-argument overload, so the
    // old 'getintakejsondata($1)' call could only ever raise 42883 undefined
    // function -- another anonymous 400. Bind the procedure's own defaults for
    // the two expungement arguments.
    const sql = 'select * from getintakejsondata($1, $2, $3)';

    return util.executeDBQuery(sql, [intakeserviceid.trim(), 0, 0])
      .then(data => {
        // An empty result set is still a truthy array, so the old `if (data)` fell
        // through to data[0].jsondata and threw a TypeError for any intake that has
        // no CW staging row -- yet another anonymous 400.
        if (data && data[0] && data[0].jsondata) {
          data[0].jsondata.unknownPersons = unknownPersonList;
        return Intakedastaging.updateAll(
            {
              intakenumber: data[0].jsondata.General.IntakeNumber,
              activeflag: true
            },
            {
              jsondata: JSON.stringify(data[0].jsondata)
            }
          ).then(
            _data => {
              LOGGER.debug('result>> ', _data);
              return _data;
            }
            , _err => {

              return _err;
             })

        } else {
          return data;
        }
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };
  Intakedastaging.remoteMethod(
    'updateintakejsondata',
    {
      http: {
        path: '/updateintakejsondata',
        verb: 'post'
      },
      accepts: {
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      },
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

Intakedastaging.remoteMethod('getintakejsondata', {
  accepts: {
    arg: 'filter',
    type: 'Object',
    http: {
      source: 'query'
    },
    required: true
  },
  http: {
    path: '/getintakejsondata',
    verb: 'get'
  },
  returns: {
    type: 'Object',
    root: true
  }
});

Intakedastaging.remoteMethod(
  'listplacementuserdetails',
  {
    http: {
      path: '/listplacementuserdetails',
      verb: 'post'
    },
    accepts: [{
      arg: 'data',
      type: 'object',
      http: {
        source: 'body'
      }
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    returns: {
      type: 'object',
      root: true
    }
  }
);


Intakedastaging.listplacementuserdetails = (data, reqctx) => {
  let _securityusersid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    _securityusersid = reqctx.req.headers.securityusersid;
  }
  const userid = (data && data.securityuserid?data.securityuserid: _securityusersid);
  const pageNumber = data.page;
  const pageLimit = data.limit;
  const status = data.where.status;
  const intakenumber = data.where.intakenumber;
  let sortcolumn = data.where.sortcolumn;
  let sortorder = data.where.sortorder;
  const placementworkertype = data.where.placementworkertype;
  if (sortcolumn == null || sortcolumn === undefined) {
    sortcolumn = "receiveddate";}
  if (sortorder == null || sortorder === undefined) {
    sortorder = "desc";}
  let sql = '';
  sql = 'select * from listplacementuserdetails($1,$2,$3,$4,$5,$6,$7,$8)';
  const params = [userid, status, pageNumber, pageLimit, intakenumber, sortcolumn,sortorder,placementworkertype];
  return util.executeDBQuery(sql, params)
    .then(withTotalCount)
    .catch(err => err);
};

Intakedastaging.assigntoplacementworker = (data, reqctx) => {
  let _securityusersid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    _securityusersid = reqctx.req.headers.securityusersid;
  }
  const securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);
  const intakenumber = data.intakenumber;
  let eventcode = '';
  let routingstatustype;

  if (data.placementworkertype === 'DET') {
    eventcode = 'DWAN';
    routingstatustype = 54;
  } else {
    eventcode = 'ADWAN';
    routingstatustype = 59;
  }

    
  const sql = 'select * from routingintake ($1,$2,$3,$4,$5)';
  return util.executeDBQuery(sql, [intakenumber, securityuserid, eventcode, routingstatustype,''])
    .then(_data => {
      return _data;
    })
    .catch(err => util.logError(err));
};

Intakedastaging.remoteMethod(
  'assigntoplacementworker',
  {
    http: {
      path: '/assigntoplacementworker',
	  verb: 'post'
    },
    accepts: [{
      arg: 'data',
	  type: 'object',
	  http: {
        source: 'body'
      }
    }, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
	returns: {
	  type: 'object',
      root: true
    }
  }
);
Intakedastaging.servicecaseassignlist = (request, reqctx) =>{
  let _securityusersid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    _securityusersid = reqctx.req.headers.securityusersid;
  }
  const pageno = request.page;
  const pagesize = request.limit;
  const status = request.where.status;
  const securityuserid = request && request.securityuserid?request.securityuserid: _securityusersid;
  var userid = request.where.securityusersid ? request.where.securityusersid : securityuserid;
  const servicecaseno = request.where.servicecaseno?request.where.servicecaseno:'';

  let sql = '';

   sql = 'select * from servicecaseassignlist($1, $2, $3,$4,$5)';

   if(status === 'CLOSED' )
  {

     sql = 'select * from servicecaseclosedlist($1, $2, $3,$4,$5)';

  }

  return util.executeDBQuery(sql, [userid, status,pageno, pagesize,servicecaseno])
    .then(resp => resp)
    .catch(err => util.logError(err));
}

Intakedastaging.remoteMethod('servicecaseassignlist', {
  accepts: [{
    arg: 'filter',
    type: 'Object',
    http: {
      source: 'query'
    },
    required: true
  }, {
    arg: 'reqctx',
    type: 'object',
    http: {source: 'context'}
    }],
  http: {
    path: '/servicecaseassignlist',
    verb: 'get'
  },
  returns: {
    type: 'Object',
    root: true
  }
});



Intakedastaging.adoptioncaseassignlist = (request, reqctx) =>{
  let _securityusersid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    _securityusersid = reqctx.req.headers.securityusersid;
  }  
  const pageno = request.page;
  const pagesize = request.limit;
  const status = request.where.status;
  const securityuserid = request && request.securityuserid?request.securityuserid: _securityusersid;
  const adoptioncasenumber = request.where.adoptioncasenumber ? request.where.adoptioncasenumber : '';

  let sql = '';

   sql = 'select * from adoptioncaseassignlist($1, $2, $3,$4,$5)';

  return util.executeDBQuery(sql, [securityuserid, status,pageno, pagesize,adoptioncasenumber])
    .then(resp => resp)
    .catch(err => err);
}

Intakedastaging.remoteMethod('adoptioncaseassignlist', {
  accepts: [{
    arg: 'filter',
    type: 'Object',
    http: {
      source: 'query'
    },
    required: true
  }, {
    arg: 'reqctx',
    type: 'object',
    http: {source: 'context'}
    }],
  http: {
    path: '/adoptioncaseassignlist',
    verb: 'get'
  },
  returns: {
    type: 'Object',
    root: true
  }
});





Intakedastaging.getldsscasetransferlist = (request, reqctx) =>{
  const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
  const pageno = request.page;
  const pagesize = request.limit;                       //SonarQube fix - removed this unused assignent
  const securityuserid = _securityusersid;
  const servicecasenumber = request.where.servicecasenumber?request.where.servicecasenumber:null;
  const teamid = request.where.localdepartment?request.where.localdepartment:null;
  const toworkerid = request.where.toworkerid?request.where.toworkerid:null;
  const countycode = request.where.countycode?request.where.countycode:null;
  const startdate = request.where.startdate?request.where.startdate:null;
  const enddate = request.where.enddate?request.where.enddate:null;
  const statuscode = request.where.statuscode?request.where.statuscode:null;
  const localdeptid = request.where.localdeptid?request.where.localdeptid:null;
  const casetype = request.where.casetype?request.where.casetype:null;
  const sortcolumn = request.where.sortcolumn?request.where.sortcolumn:null;
  const sortorder = request.where.sortorder?request.where.sortorder:null;
  let Totalcount = 0;

  let sql = 'select * from getldsscasetransferlist($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
  return util.executeDBQuery(sql, [securityuserid,servicecasenumber,teamid,toworkerid,countycode,startdate,enddate,statuscode,
    localdeptid,pageno,pagesize,casetype,sortcolumn,sortorder])
    .then(data => {
        LOGGER.info(data);
        if (data!=null && data.length > 0) {
          Totalcount = data[0].totalcount;}
          let result;
          result = {
            'data': data,
            'count': Totalcount
          };
          return result;
    })
  .then(resp => resp)
  .catch(err => {
    LOGGER.error(err)
  });
}

Intakedastaging.remoteMethod('getldsscasetransferlist', {
  accepts: [{
    arg: 'filter',
    type: 'Object',
    http: {
      source: 'query'
    },
    required: true
  }, {
    arg: 'reqctx',
    type: 'object',
    http: {source: 'context'}
    }],
  http: {
    path: '/getldsscasetransferlist',
    verb: 'get'
  },
  returns: {
    type: 'Object',
    root: true
  }
});

/*INTAKE SNAPSHOT REPORT */
Intakedastaging.getintakesnapshotreport = request =>{
    const intakenumber = request.where.intakenumber;
    const isExpungementSuperUser = request.where.isExpungementSuperUser ? request.where.isExpungementSuperUser : 0;
    let Totalcount = 0;
    const iscaseexpunged = request.where.iscaseexpunged ?? 0;

    let sql = 'select * from getintakesnapshotreport($1,$2,$3,$4)';

    return util.executeSecondaryNodeDBQuery(sql, [intakenumber,null,isExpungementSuperUser,iscaseexpunged])
      .then(data => {
          let result = {
            'data': data,
            'count': Totalcount
          };
          if (data!=null && data.length > 0) {
            result.count = data[0].totalcount;
          }
          return result;
      })
       .catch(err => util.logError(err));
  }
  
  Intakedastaging.remoteMethod('getintakesnapshotreport', {
     accepts: {
      arg: 'data',
      type: 'Object',
      http: {
        source: 'body'
      },
      required: true
    },
    http: {
      path: '/getintakesnapshotreport',
      verb: 'post'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Intakedastaging.remoteMethod(
    'sendOverride',
    {
      http: {
        path: '/sendoverride',
        verb: 'post'
      },
      accepts: [{
        arg: 'data',
        type: 'Object',
        http: {
          source: 'body'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        arg: 'data',
        type: 'Object'
      }
  });
  
  Intakedastaging.sendOverride = (request, reqctx) =>{ 
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    request.securityusersid = request && request.securityuserid?request.securityuserid: _securityusersid;
    const sql = 'select * from recordintakeadministrativeoverride($1)';
    return util.executeDBQuery(sql, [JSON.stringify(request)])
      .then(resp => resp)
      .catch(err => util.logError(err));
  }

  Intakedastaging.remoteMethod(
    'getOverride',
    {
      http: {
        path: '/getoverride',
        verb: 'get'
      },
      accepts: [{
        arg: 'filter',
        type: 'Object',
        http: {
          source: 'query'
        }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
        arg: 'data',
        type: 'Object'
      }
  });
  
  Intakedastaging.getOverride = (request, reqctx) =>{ 
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
    request.securityusersid = request && request.securityuserid?request.securityuserid: _securityusersid
    const sql = 'select * from getintakeadministrativeoverride($1)';
    return util.executeDBQuery(sql, [request.where.intakenumber])
      .then(data => {
        if(data && data.length && data[0])
        {return data[0].getintakeadministrativeoverride;}
        else
        {return data;}
      })
      .catch(err => util.logError(err));
  }
  Intakedastaging.remoteMethod('getCasebyIntake', {
        http: {
          path: '/getCasebyIntake',
          verb: 'post'
      },
      accepts: [{
          arg: 'data',
          type: 'object',
          http: {
              source: 'body'
          }
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      returns: {
          type: 'object',
          root: true
      }
      }); 

      
      
      Intakedastaging.getCasebyIntake = function (request, reqctx) {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        } 
        const iscaseexpunged  = request.iscaseexpunged ?? 0;                                         //SonarQube fix - removed this unused assignent 
        const sql = 'select * from cjams.getcasebyintake($1,$2,$3,$4)';
        return util.executeSecondaryNodeDBQuery(sql, [request.intakenumber,request.securityuserid,request.isExpungementSuperUser, iscaseexpunged])
        .then(resp => resp)
       .catch(err => util.logError(err));
    }
      


  Intakedastaging.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Intakedastaging.observe('access', (ctx, next) => util.access(ctx, next));
  Intakedastaging.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
function returnParamsFn(data) {
  let bpreintake = data.where.ispreintake;
  let sortcolumn = data.where.sortcolumn;
  let sortorder = data.where.sortorder;
  const iscaseexpunged = data.where.iscaseexpunged ?? 0;
  const isExpungementSuperUser = data.where.isExpungementSuperUser ? data.where.isExpungementSuperUser : 0;


  if (bpreintake == null || bpreintake === undefined) {
    bpreintake = false;
  }
  if (sortcolumn == null || sortcolumn === undefined) {
    sortcolumn = "receiveddate";
  }
  if (sortorder == null || sortorder === undefined) {
    sortorder = "desc";
  }
  return { bpreintake, sortcolumn, sortorder, isExpungementSuperUser, iscaseexpunged };
}
