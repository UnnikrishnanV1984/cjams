'use strict';
const LOGGER = require("log4js").getLogger("Intakeservicerequestsdm");
const util = require('../utils/utils');
let app = require('../../server/server');
var config = require('../../server/config.json');

const pathwaymsg = 'Pathway Submitted for review';

module.exports = function(Intakeservicerequestsdm) {

  // getintakeservicerequestsdm(v_intakeserviceid uuid, v_intakenumber character
  // varying DEFAULT '', isExpungementSuperUser integer DEFAULT 0, isexpunged
  // integer DEFAULT 0) takes a uuid first. Every web caller builds that value
  // from a route param or a data-store case id, so an unresolved id is bound as
  // text and Postgres rejects the statement with 22P02 invalid input syntax for
  // type uuid -- which error-logger rewrites to statusCode 400, landing in APM as
  // a bare "HttpError 400, No stack trace". Reject it here with a message that
  // names the argument instead.
  const UUID_PATTERN = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

  function notAUuid(id) {
    return typeof id !== 'string' || !UUID_PATTERN.test(id.trim());
  }

  function badRequest(message) {
    const err = new Error(message);
    err.statusCode = 400;
    err.code = 'INVALID_ID';
    return Promise.reject(err);
  }

  // Both expungement arguments are integer parameters and the web sends
  // isExpungementSuperUser as parseInt(storage.getItem('IS_EXPUNGED_USER')), which
  // is NaN whenever that session key is absent. JSON.stringify writes NaN as null,
  // so the flag arrives as null; bind the procedure's own default of 0 instead.
  function expungementFlag(value) {
    const flag = parseInt(value, 10);
    return Number.isInteger(flag) ? flag : 0;
  }

  Intakeservicerequestsdm.getintakeservicerequestsdm = function(request, reqctx) {
		let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
    // util.beforeremote only fills in where/limit/page when ctx.args.filter is
    // already set, so a caller that passes something other than an object still
    // reaches here with where undefined and the reads below threw a TypeError that
    // error-logger flattened into the same undiagnosable 400.
    if (!request) { request = {}; }
    if (!request.where) { request.where = {}; }
    if(request.where.servicerequestid == undefined) {request.where.servicerequestid = null;}
    // A null id is legitimate -- intake-sdm looks a draft up by intakenumber alone
    // -- so only a value the caller actually supplied is validated.
    if (request.where.servicerequestid !== null && notAUuid(request.where.servicerequestid)) {
      return badRequest('servicerequestid must be a uuid');
    }
    const iscaseexpunged = expungementFlag(request.where.iscaseexpunged);

    let sql = 'select * from getintakeservicerequestsdm($1,$2,$3, $4)';

    return util.executeSecondaryNodeDBQuery(sql, [request.where.servicerequestid,request.where.intakenumber,expungementFlag(request.where.isExpungementSuperUser), iscaseexpunged])
      .then(data => {
          return data;
      })
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          return util.logError(err).then(() => {
              throw err;
          });
      });
};

Intakeservicerequestsdm.remoteMethod('getintakeservicerequestsdm', {
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
    verb: 'get'
  },
  returns: {
    type: 'Object',
    root: true
  }
});

Intakeservicerequestsdm.createsdm = function (data, reqctx) {
  const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
    let securityuserid = _securityusersid;
    let servicerequestid = data.servicerequestid;
    let intakenumber = data.intakenumber;
    data.sdmdata.changepathway ='changepathway'
    let sdmdata = data.sdmdata;
    let status = 15;
    const notifymsg = pathwaymsg;
    let routeddescription = pathwaymsg;
    let comments = pathwaymsg;
    let selecttraffic = sdmdata.selecttrafficking;
    if (Array.isArray(sdmdata.selecttrafficking)) {
      sdmdata.selecttrafficking.forEach((selectval, index) => {
        if(index === 0){
          selecttraffic =	selectval;
        }else{
          selecttraffic = selecttraffic + ','+selectval;
        }
      });
    }
    sdmdata.selecttrafficking =selecttraffic;
    let sql = 'SELECT * FROM intakesdm($1,$2,$3,$4,$5)';
    return util.executeDBQuery(sql, [sdmdata,'',servicerequestid,securityuserid,intakenumber])
      .then(_data => {
        if(servicerequestid!=null) {
          let qry = 'SELECT * FROM routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)';
          return util.executeDBQuery(qry, [servicerequestid,securityuserid,'PWCR',status,comments,'',false,false,false,notifymsg,routeddescription,servicerequestid])
          .then(result => {
            if(result){
              const respType = getResponseType(sdmdata);
              const initialresponsetypekey = respType.initialresponsetypekey;
              const responsetypekey = respType.responsetypekey;
              sdmdata.subreasonforchange = respType.subreasonforchange;
              let sql1 = 'select * from addresponsereassignhistory($1,$2,$3,$4,$5,$6,$7)';
              return util.executeDBQuery(sql1,[servicerequestid, initialresponsetypekey, responsetypekey, sdmdata.reasonforchange, sdmdata.comments, securityuserid, sdmdata.subreasonforchange])
                .then(resultrrh => {
                  LOGGER.info(resultrrh);
                  return _data;
                })
              .catch(err1 => {
                  LOGGER.error(err1)
                  throw err1;
              })
            }
          })
          .catch(err2 => {
              LOGGER.error(err2)
              throw err2;
            })
        }
        return _data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  function getResponseType(sdmdata){
    const initialresponsetypekey = sdmdata.isar? '101': '102';
    const responsetypekey = sdmdata.isir? '101': '102';
    if(!sdmdata?.subreasonforchange){
      sdmdata.subreasonforchange = [];
    }
    return {
      initialresponsetypekey: initialresponsetypekey,
      responsetypekey: responsetypekey,
      subreasonforchange: sdmdata.subreasonforchange
    }
  }

  Intakeservicerequestsdm.remoteMethod(
    'createsdm',
    {
      http: {
        path: '/createsdm',
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

    Intakeservicerequestsdm.updatechildfatality = function (data, reqctx) {
      let _securityusersid = undefined;
      if (
        reqctx &&
        reqctx.req &&
        reqctx.req.headers &&
        reqctx.req.headers.securityusersid
      ) {
        _securityusersid = reqctx.req.headers.securityusersid;
      }
      let securityuserid =
        data && data.securityuserid ? data.securityuserid : _securityusersid;
      let casenumber = data.casenumber;
      let sdmid = data.intakeservicerequestsdmid;
      let intakeserviceid = data.intakeserviceid;
      let childfatalityvalue = data.childfatalityvalue;
      let isservicecase = data.isservicecase;
      let persons = [];
      if(childfatalityvalue === 'yes') {
       for(let item of data.involvedPersions){
          if(item.dateofdeath) {
            persons.push({
              dateofdeath: item.dateofdeath,
              cjamspid: item.cjamspid,
            });
          }
        }
      }
      let sql = "SELECT * FROM updatechildfatality($1,$2,$3,$4,$5,$6,$7)";
      var params = [
          intakeserviceid,
          childfatalityvalue,
          sdmid,
          securityuserid,
          casenumber,
          JSON.stringify(persons),
          isservicecase
        ];

      return util.executeDBQuery(sql, params)
        .then(updatechildfatalitydata => {
            return updatechildfatalitydata;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };
    Intakeservicerequestsdm.remoteMethod("updatechildfatality", {
      http: {
        path: "/updatechildfatality",
        verb: "post",
      },
      accepts: [
        {
          arg: "data",
          type: "Object",
          http: {
            source: "body",
          },
        },
        {
          arg: "reqctx",
          type: "object",
          http: { source: "context" },
        },
      ],
      returns: {
        arg: "data",
        type: "Object",
      },
    });

    Intakeservicerequestsdm.updatetrafficking = function (data, reqctx){
      let _securityusersid = undefined;
  if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
    _securityusersid = reqctx.req.headers.securityusersid;
  }
    let securityuserid = data && data.securityuserid?data.securityuserid: _securityusersid;
    let casenumber =data.casenumber;
    let sdmid = data.intakeservicerequestsdmid;
    let concerntraffic =data.concerntrafficking;
    let selecttraffic = data.selecttrafficking;
    let isservicecase = data.isservicecase;
	if (Array.isArray(data.selecttrafficking)) {
		data.selecttrafficking.forEach((selectval, index) => {
			if(index == 0){
				selecttraffic =	selectval;
			}else{
				selecttraffic = selecttraffic + ','+selectval;
			}
		});
	}
  let sql = 'SELECT * FROM updatesdmtrafficking($1,$2,$3,$4,$5,$6,$7,$8)';
  var params = [casenumber,sdmid,securityuserid,concerntraffic,selecttraffic,isservicecase,data.intakeserviceid,data.intakenumber];

  return util.executeDBQuery(sql, params)
    .then(updatesdmtraffickingdata => {
        return updatesdmtraffickingdata;
    })
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });

  }
    Intakeservicerequestsdm.remoteMethod(
      'updatetrafficking',
      {
        http: {
          path: '/updatetrafficking',
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
      Intakeservicerequestsdm.getsdmtrafficking= function(request, reqctx) {
       
        let intakenumber = request.where.intakenumber;
        let servicerequestnumber =request.where.servicerequestnumber;
        let servicecasenumber = request.where.servicecasenumber;

        let sql = 'select * from getsdmtraffickingaudittrail($1,$2,$3)';
        var params = [intakenumber,servicerequestnumber,servicecasenumber ];

        return util.executeDBQuery(sql, params)
          .then(data => {
              return data;
          })
          .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
          });

    };

    Intakeservicerequestsdm.remoteMethod('getsdmtrafficking', {
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
        verb: 'get'
      },
      returns: {
        type: 'Object',
        root: true
      }
    });

    Intakeservicerequestsdm.getsdmtraffickingvalid= function(request, reqctx) {

      let id = request.where.objectid;
      let sql = ` SELECT 
      CASE WHEN confirmtrafficking IS NOT NULL 
      AND BTRIM(confirmtrafficking) <> '' THEN TRUE ELSE FALSE END AS isvalid 
    FROM 
      intakeservicerequestsdm 
    WHERE intakeserviceid = $1 AND activeflag = '1' 
    ORDER BY COALESCE(updatedon, insertedon) DESC LIMIT 1; `
      if(request.where.sdmid) {
        id=request.where.sdmid;
        sql = ` SELECT 
      CASE WHEN confirmtrafficking IS NOT NULL 
      AND BTRIM(confirmtrafficking) <> '' THEN TRUE ELSE FALSE END AS isvalid 
    FROM 
      intakeservicerequestsdm 
    WHERE intakeservicerequestsdmid = $1 AND activeflag = '1' 
    ORDER BY COALESCE(updatedon, insertedon) DESC LIMIT 1; `
      }
      return util.executeDBQuery(sql, [id])
        .then(data => {
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });

  };

  Intakeservicerequestsdm.remoteMethod(
    'getsdmtraffickingvalid',
    {
      http: {
        path: '/getsdmtraffickingvalid',
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

Intakeservicerequestsdm.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Intakeservicerequestsdm.observe('access', (ctx, next) => util.access(ctx, next));
Intakeservicerequestsdm.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};