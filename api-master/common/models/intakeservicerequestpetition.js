'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestpetition");
const util = require('../utils/utils');
var app = require('../../server/server');
const checkstatusqry = "select * from checkstatusandclose($1,$2)";
const usermsg = 'This method is only allowed for DJS user';
var config = require('../../server/config.json');

module.exports = function (Intakeservicerequestpetition) {
  Intakeservicerequestpetition.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Intakeservicerequestpetition.observe('access', (ctx, next) => util.access(ctx, next));
  Intakeservicerequestpetition.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

  Intakeservicerequestpetition.remoteMethod('add', {
    http: {
      path: '/add',
      verb: 'post',
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: { source: 'context' }
    }],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestpetition.remoteMethod('list', {
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

  Intakeservicerequestpetition.remoteMethod('createPetition', {
    http: {
      path: '/createPetition',
      verb: 'post',
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: { source: 'context' }
    }],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestpetition.remoteMethod('updatePetition', {
    http: {
      path: '/updatePetition',
      verb: 'patch',
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    },
    {
      arg: 'reqctx', type: 'object',
      http: { source: 'context' }
    }],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestpetition.remoteMethod('deletePetition', {
    http: {
      path: '/deletePetition/:id',
      verb: 'delete',
    },
    accepts: [{
      arg: 'id',
      type: 'string',
      required: true,
      http: { source: 'path' }
    },
    {
      arg: 'reqctx', type: 'object',
      http: { source: 'context' }
    }],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestpetition.associatePetition = (request, reqctx) => {
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
    var associatetype = "associate";
    if (request.associatetype) {
      if (request.associatetype !== "" && request.associatetype != null) { associatetype = request.associatetype; }
    }
    if (associatetype == "associate") {
      let prs = [];
      prs = request.associate.map(associates => {
        request.associatedpetitionid = associates.intakeservicerequestpetitionid;
        return app.models.Associatedpetitionsconfig.create(request)
          .then(res => {
            const sql = "update intakeservicerequestpetition set petitionstatustypekey='CLS' where intakeservicerequestpetitionid = $1";
            return util.executeDBQuery(sql, [associates.intakeservicerequestpetitionid])
              .then(data => {
                return data;
              })
              .catch(err => {
                LOGGER.error(err)
              })
          })
          .then(res => {
            const sql = "Update intakeservicerequestevaluation set complaintstatustypekey = 'CHC' where intakeservicerequestevaluationid in (select intakeservicerequestevaluationid from intakeservreqevalpetitionconfig where intakeservicerequestpetitionid= $1 )";
            return util.executeDBQuery(sql, [associates.intakeservicerequestpetitionid])
              .then(data => {
                return data;
              })
              .catch(err => {
                LOGGER.error(err)
              })
          })
          .then(res => {
            const sql = checkstatusqry;
            return util.executeDBQuery(sql, [associates.intakenumber, _securityusersid])
              .then(data => {
                return data;
              })
              .catch(err => {
                LOGGER.error(err)
              })
          })

      })

      return Promise.all(prs);
    }
    else {

      let prs = [];
      prs = request.associate.map(associates => {
        request.associatedpetitionid = associates.intakeservicerequestpetitionid;
        return app.models.Associatedpetitionsconfig.create(request)
          .then(res1 => {
            const sql1 = "update intakeservicerequestpetition set petitionstatustypekey='CLS' where intakeservicerequestpetitionid = $1";
            return util.executeDBQuery(sql1, [associates.intakeservicerequestpetitionid])
              .then(data => {
                return data;
              })
              .catch(err => {
                LOGGER.error(err)
                return err;
              })
          }).then(res2 => {
            return util.executeDBQuery(checkstatusqry, [associates.intakenumber, _securityusersid])
              .then(data => {
                return data;
              })
              .catch(err => {
                LOGGER.error(err);
                return err;
              })
          })

      })
      return Promise.all(prs)

    }
  };

  Intakeservicerequestpetition.associateComplaint = (request, reqctx) => {
    let _securityusersid = undefined;
    if (reqctx?.req?.headers?.securityusersid) {
      _securityusersid = reqctx.req.headers.securityusersid;
    }
    const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);

    let prs = [];
    prs = request.associate.map(associates => {
      request.associatedevalfieldid = associates.intakeservicerequestevaluationid;
      return app.models.Associatedpetitionsconfig.create(request)
        .then(res => {
          const sql = "Update intakeservicerequestevaluation set complaintstatustypekey = 'CHC' where intakeservicerequestevaluationid = $1 ";
          return util.executeDBQuery(sql, [associates.intakeservicerequestevaluationid]);
        }).then(res => {
          const sql = checkstatusqry;
          return util.executeDBQuery(sql, [associates.intakenumber, securityuserid]);
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });

    })
    return Promise.all(prs);
  };

  Intakeservicerequestpetition.list = request => {
    let intakenumber = '';
    if (request.where) { intakenumber = request.where.intakenumber; }
    const pageno = request.page;
    const pagesize = request.limit;
    const sortcolumn = request.sortcolumn;
    const sortorder = request.sortorder;
    const sql = 'select * from listpetitions($1, $2, $3, $4, $5)';
    return util.executeDBQuery(sql, [intakenumber, pageno, pagesize, sortcolumn, sortorder])
      .then(data => data)
      .catch(err => util.logError(err));
  };

  Intakeservicerequestpetition.add = async (request, reqctx) => {
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
    var _email = util.getSecurityDetails(request, reqctx).email;
    
    var requestuserinfo = { 'token': '', 'email': _email };
    var teamtypekey;
    var teamtypeDesc;
    await util.getuserinfo(requestuserinfo).then(data => {
      teamtypekey = data.teamtypekey;
      teamtypeDesc = data.teamtypedesc;
    });
    var respond;
    var intakeservicerequestpetitionactors = request.petitionactors;
    var intakeservicerequestclientactors = request.clientactors;
    var intakeservicerequestparentactors = request.parentactors;
    request.insertedby = request.insertedby ? request.insertedby : _securityusersid;
    request.updatedby = request.updatedby ? request.updatedby : _securityusersid;
    var prs = [];
    var v_intakeservicerequestpetitionid;
    // CDM-34531 Unable to create petition
    if (teamtypekey === 'CW' || teamtypeDesc == 'Child Welfare') {
      if ((request.intakeservicerequestid !== null && request.intakeservicerequestid !== undefined) || (request.servicecaseid !== null && request.servicecaseid !== undefined)) {
        if (request.intakeservicerequestpetitionid == null && request.intakeservicerequestpetitionid == undefined) {
          return Intakeservicerequestpetition.create(request)
            .then(res => {
              respond = res;
              v_intakeservicerequestpetitionid = res.intakeservicerequestpetitionid;
              const resIntakepetitionactor = createIntakeservicerequestpetitionactor(intakeservicerequestpetitionactors, v_intakeservicerequestpetitionid, _securityusersid)
              prs = prs.concat(resIntakepetitionactor);
              const resIntakepetitionclient = createIntakeservicerequestpetitionactor(intakeservicerequestclientactors, v_intakeservicerequestpetitionid, _securityusersid)
              prs = prs.concat(resIntakepetitionclient);
              const resIntakepetitionparent = createIntakeservicerequestpetitionactor(intakeservicerequestparentactors, v_intakeservicerequestpetitionid, _securityusersid)
              prs = prs.concat(resIntakepetitionparent);
              return Promise.all(prs);
            })
            .then(resp => {
              var responseJson = {};
              responseJson.Intakeservicerequestpetitionactor = resp;
              responseJson.Intakeservicerequestpetition = respond;
              return responseJson;
            })
            .catch(err => util.logError(err));
        } else {
          v_intakeservicerequestpetitionid = request.intakeservicerequestpetitionid;
          return Intakeservicerequestpetition.updateAll(
            { intakeservicerequestpetitionid: v_intakeservicerequestpetitionid },
            {
              petitionactortype: request.petitionactortype,
              intakenumber: request.intakenumber,
              petitiontypekey: request.petitiontypekey,
              petitionfocusname: request.petitionfocusname,
              petitionid: request.petitionid,
              associatedattorneys: request.associatedattorneys,
              complaintid: request.complaintid,
              transferpetitionid: request.transferpetitionid,
              petitionfiled: request.petitionfiled,
              courtcasenumber: request.courtcasenumber,
              petitiondate: request.petitiondate,
              intakeservicerequestid: request.intakeservicerequestid,
              witness1: request.witness1,
              clientactorsid: request.clientactorsid
            }
          )
            .then(resp => {
              var sql = 'select * from updatepetition($1)';
              return util.executeDBQuery(sql, [v_intakeservicerequestpetitionid])
                .then(data => {
                  return data;
                })
                .catch(err => {
                  LOGGER.error(err)
                })
            }).then(res => {
              const resIntakepetitionactor = createIntakeservicerequestpetitionactor(intakeservicerequestpetitionactors, v_intakeservicerequestpetitionid, _securityusersid)
              prs = prs.concat(resIntakepetitionactor);
              const resIntakepetitionclient = createIntakeservicerequestpetitionactor(intakeservicerequestclientactors, v_intakeservicerequestpetitionid, _securityusersid)
              prs = prs.concat(resIntakepetitionclient);
              const resIntakepetitionparent = createIntakeservicerequestpetitionactor(intakeservicerequestparentactors, v_intakeservicerequestpetitionid, _securityusersid)
              prs = prs.concat(resIntakepetitionparent);
              return Promise.all(prs);
            })
            .then(resp => {
              var sql = 'select * from intakeservicerequestpetition where intakeservicerequestpetitionid = $1';
              return util.executeDBQuery(sql, [resp[0].intakeservicerequestpetitionid])
                .then(data => {
                  return data;
                })
                .catch(err => {
                  LOGGER.error(err)
                })
            })
            .then(data => {
              LOGGER.info(data);
              LOGGER.info('UPDATED SUCCESSFULLY');
              return data;
            })
            .catch(err => {
              LOGGER.error(err);
              util.logError(err);
            });
        }
      }
    }
  };

  function createIntakeservicerequestpetitionactor(data, v_intakeservicerequestpetitionid, _securityusersid) {
    var prs = [];
    if (Array.isArray(data)) {
      data.forEach(element => {
        prs.push(
          app.models.Intakeservicerequestpetitionactor.create({
            intakeservicerequestpetitionid: v_intakeservicerequestpetitionid,
            intakeservicerequestactorid: element.intakeservicerequestactorid,
            petitionactortype: element.petitionactortype,
            insertedby: _securityusersid,
            updatedby: _securityusersid
          })
        )
      })
      return prs;
    }


  }

  Intakeservicerequestpetition.createPetition = async (petition, reqctx) => {
    let petitionObj;
    petition.intakeservicerequestid = util.emptyUUID;
    petition.petitionstatustypekey = 'OP';
    var teamtypekey;
    var teamcounty;
    var _email;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application) {
      _email = reqctx.req.headers.user_email_captureby_application;
    }
    var requestuserinfo = { 'token': '', 'email': _email };
    await util.getuserinfo(requestuserinfo).then(data => {
      teamtypekey = data.teamtypekey;
      teamcounty = data.countyid;
    });
    if (teamtypekey === 'DJS') {
      return Intakeservicerequestpetition.create(petition)
        .then(res => {
          petitionObj = JSON.parse(JSON.stringify(res));
          const prs = petition.evaluationfields.map(evalField => {
            evalField.intakenumber = petition.intakenumber;
            evalField.intakeservicerequestpetitionid = petitionObj.intakeservicerequestpetitionid;

            return app.models.Intakeservreqevalpetitionconfig.create(evalField);

          });
          return Promise.all(prs);
        })
        .then(res => {
          const prsev = petition.evaluationfields.map(evalField => {
            const sql = "Update intakeservicerequestevaluation set complaintstatustypekey = 'PS' where intakeservicerequestevaluationid = $1";
            return util.executeDBQuery(sql, [evalField.intakeservicerequestevaluationid]);
          });
          return Promise.all(prsev);
        })
        .then(res => {
          var sql = "select countyid,countyname from county where countyid=$1"
          return util.executeDBQuery(sql, [teamcounty]);
        })
        .then(res => {
          var sql = "  select count(1)>0 as isfirstpetition,INPC.updatedby from intakeservicerequestpetition INP "
            + " join intakeservreqevalpetitionconfig  INPC on INPC.intakeservicerequestpetitionid=INP.intakeservicerequestpetitionid and INPC.activeflag=1 "
            + " where INP.intakenumber=$1 and INP.petitionstatustypekey='PEFW'  "
            + "  and (select count(1) from intakeservicerequestpetition where intakenumber=$1 and petitionstatustypekey!='PEFW')=1 "
            + " group by INPC.updatedby,INPC.updatedon  order by INPC.updatedon desc limit 1";
          const details = getDetails(res);
          var countyval = details.countyval;
          var youth = details.youth;

          return util.executeDBQuery(sql, [petition.intakenumber])
            .then(data => {
              if (data.length > 0) {

                if (data[0].isfirstpetition) {
                  var nofiticationJson = {};
                  nofiticationJson.securityusersid = data[0].updatedby;
                  nofiticationJson.usernotificationtypekey = "System";
                  nofiticationJson.objectid = petition.intakenumber;
                  nofiticationJson.subject = ' Transfer intake# "' + petition.intakenumber + '"' + ' – Accepted  - "' + countyval + '"';
                  nofiticationJson.priorityleveltypekey = "High";
                  nofiticationJson.body = 'Transferred intake# "' + petition.intakenumber + '" of "' + youth + '" has been accepted by "' + countyval + '" . New Petition "' + petition.petitionid + '" is assigned.';
                }
              }
              return data;
            })
            .catch(err => {
              LOGGER.error(err)
              throw err;
            });
        })

        .then(res => {
          return {
            intakeservicerequestpetition: petitionObj,
            intakeservreqevalpetitionconfig: JSON.parse(JSON.stringify(res)),
          };
        })
        .catch(err => util.logError(err));
    } else {
      return usermsg;
    }
  };

  function getDetails(res) {
    var countyval = "";
    var youth = "";
    if (res) {
      var courtObj = JSON.parse(JSON.stringify(res));
      if (courtObj.length > 0) {
        countyval = courtObj[0].countyname;
      }
      if (petition.youth != null) {
        youth = petition.youth.fullName
      }
    }
    return {
      countyval: countyval,
      youth: youth
    }
  }

  Intakeservicerequestpetition.deletePetition = async (id, reqctx) => {
    var _email;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application) {
      _email = reqctx.req.headers.user_email_captureby_application;
    }
    var requestuserinfo = { 'token': '', 'email': _email };
    const prs = [];
    var teamtypekey;
    await util.getuserinfo(requestuserinfo).then(data => {
      teamtypekey = data.teamtypekey;
    });
    if (teamtypekey === 'DJS') {
      prs.push(util.executeDBQuery('Update intakeservicerequestpetition set activeflag = 0 where intakeservicerequestpetitionid = $1', [id]));
      prs.push(util.executeDBQuery('Update intakeservreqevalpetitionconfig set activeflag = 0 where intakeservicerequestpetitionid = $1', [id]));
      return Promise.all(prs)
        .then(data => data)
        .catch(err => util.logError(err));
    } else {
      return usermsg;
    }
  };

  Intakeservicerequestpetition.updatePetition = async (request, reqctx) => {
    var _email;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application) {
      _email = reqctx.req.headers.user_email_captureby_application;
    }
    var requestuserinfo = { 'token': '', 'email': _email };
    let prs = [];
    const petitionid = request.intakeservicerequestpetitionid;
    var teamtypekey;
    await util.getuserinfo(requestuserinfo).then(data => {
      teamtypekey = data.teamtypekey;
    });
    if (teamtypekey === 'DJS') {
      return Intakeservicerequestpetition.updateAll(
        { intakeservicerequestpetitionid: petitionid },
        request
      )
        .then(res => {
          const sql = 'Update intakeservreqevalpetitionconfig set activeflag = 0 where intakeservicerequestpetitionid = $1';
          return util.executeDBQuery(sql, [petitionid]);
        })
        .then(res => {
          prs = request.evaluationFields
            .filter(x => x.intakeservreqevalpetitionconfigid)
            .map(evalField => {
              return app.models.Intakeservreqevalpetitionconfig.updateAll(
                { intakeservreqevalpetitionconfigid: evalField.intakeservreqevalpetitionconfigid },
                { activeflag: 1 }
              );
            })
            .then(res1 => {
              const prs1 = request.evaluationFields
                .filter(x => !x.intakeservreqevalpetitionconfigid)
                .forEach(x => x.intakeservicerequestpetitionid = petitionid)
                .map(evalField => {
                  return app.models.Intakeservreqevalpetitionconfig.create(evalField);
                });
              return Promise.all(prs1);
            })
            .catch(err => util.logError(err));
          return Promise.all(prs);
        })
        .catch(err => util.logError(err));
    } else {
      return usermsg;
    }
  };

  Intakeservicerequestpetition.remoteMethod('legalactionhistory', {
    http: {
      path: '/legalactionhistory',
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


  Intakeservicerequestpetition.legalactionhistory = request => {
    let intakenumber = '';
    if (request.where) { intakenumber = request.where.intakenumber; }
    const pageno = request.page;
    const pagesize = request.limit;
    const sortcolumn = request.sortcolumn;
    const sortorder = request.sortorder;

    const sql = 'select * from getintakehearingdetailsjson($1, $2, $3, $4, $5, $6)';
    let _searchjson = request.filter;
    return util.executeDBQuery(sql, [intakenumber, pageno, pagesize, sortcolumn, sortorder, _searchjson])
      .then(data => data)
      .catch(err => util.logError(err));
  };


  Intakeservicerequestpetition.remoteMethod('legalactionhistory', {
    http: {
      path: '/legalactionhistory',
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


  Intakeservicerequestpetition.legalactionhistory = request => {
    let intakenumber = '';
    let sptype = '';
    if (request.where) {
      intakenumber = request.where.intakenumber;
      sptype = request.where.type;
    }
    const pageno = request.page;
    const pagesize = request.limit;
    const sortcolumn = request.sortcolumn;
    const sortorder = request.sortorder;


    const sql = 'select * from getintakehearingdetailsjson($1, $2, $3, $4, $5, $6, $7)';
    var searchjson = request.filter;
    return util.executeDBQuery(sql, [intakenumber, pageno, pagesize, sortcolumn, sortorder, searchjson, sptype])
      .then(data => data)
      .catch(err => util.logError(err));
  };

  Intakeservicerequestpetition.getpetitiondetailsbycomplaint = request1 => {
    var intakedevalid = '';
    if (request1.where) {
      intakedevalid = request1.where.intakeservicerequestevaluationid;
    }
    const sql = "select * from getpetitiondetailsbycomplaint($1)";

    return util.executeDBQuery(sql, [intakedevalid])
      .then(data => data)
      .catch(err => util.logError(err));
  };

  Intakeservicerequestpetition.remoteMethod(
    'getpetitiondetailsbycomplaint',
    {
      http: {
        path: '/getpetitiondetailsbycomplaint',
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

  Intakeservicerequestpetition.getassociatepetitionslist = request => {
    var intakedevalid = '';
    if (request.where) {
      intakedevalid = request.where.intakenumber;
    }
    const skip = request.page;
    const limit = request.limit;
    const sql = "select * from getassociatepetitionslist($1,$2,$3)";

    return util.executeDBQuery(sql, [intakedevalid, skip, limit])
      .then(data => data)
      .catch(err => util.logError(err));
  };

  Intakeservicerequestpetition.remoteMethod(
    'getassociatepetitionslist',
    {
      http: {
        path: '/getassociatepetitionslist',
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

  Intakeservicerequestpetition.remoteMethod(
    'associatePetition',
    {
      http: {
        path: '/addassociatePetition',
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
        http: { source: 'context' }
      }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });

  Intakeservicerequestpetition.remoteMethod(
    'associateComplaint',
    {
      http: {
        path: '/addassociateComplaint',
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
        http: { source: 'context' }
      }

      ],
      returns: {
        arg: 'data',
        type: 'Object'
      }
    });
  //changes by venkatesh

  Intakeservicerequestpetition.getpetitiondetailsbycomplaint = request => {
    var intakedevalid = '';
    if (request.where) {
      intakedevalid = request.where.intakeservicerequestevaluationid;
    }
    const sql = "select * from getpetitiondetailsbycomplaint($1)";

    return util.executeDBQuery(sql, [intakedevalid])
      .then(data => data)
      .catch(err => util.logError(err));
  };

  Intakeservicerequestpetition.remoteMethod(
    'getpetitiondetailsbycomplaint',
    {
      http: {
        path: '/getpetitiondetailsbycomplaint',
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

  //client centric legal action history

  Intakeservicerequestpetition.remoteMethod('clientcentriclegalactionhistory', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        path: '/clientcentriclegalactionhistory',
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


  Intakeservicerequestpetition.clientcentriclegalactionhistory = request => {
    let personid = '';
    let searchtext = '';
    if (request.where) {
      personid = request.where.personid;
      searchtext = request.where.personstatus;

    }
    const skip = (request.page - 1) * request.limit;
    const limit = request.limit;


    const sql = 'select * from legalactionhistory($1, $2, $3,$4)';
    return util.executeDBQuery(sql, [personid, skip, limit, searchtext])
      .then(data => data)
      .catch(err => util.logError(err));
  };


  Intakeservicerequestpetition.remoteMethod('clientcentriclegalactionbycomplaint', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        path: '/clientcentriclegalactionbycomplaint',
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


  Intakeservicerequestpetition.clientcentriclegalactionbycomplaint = request => {
    let evalutionid = '';
    if (request.where) {
      evalutionid = request.where.intakeservicerequestevaluationid;

    }

    const sql = 'select * from legalactionbycomplaint($1)';
    return util.executeDBQuery(sql, [evalutionid])
      .then(data => data)
      .catch(err => util.logError(err));
  };

   Intakeservicerequestpetition.getpetitiondetails = (request) => {    
    const isExpungementSuperUser = request.where.isExpungementSuperUser ? request.where.isExpungementSuperUser : 0;
    let objectid = request.where.intakeservicerequestid;
    let objecttype = 'servicerequest';
    if (request.where.objecttype === 'servicecase') {
       objectid = request.where.objectid;
       objecttype = request.where.objecttype
    }
    const iscaseexpunged = request.where.iscaseexpunged ?? 0;
    let responseJson;
    let sql = 'select * from getpetitiondetails($1,$2,$3,$4)';
    return util.executeSecondaryNodeDBQuery(sql, [objectid,objecttype,isExpungementSuperUser, iscaseexpunged])  
    .then(data => {
        responseJson = getResponseJson(data);
        request.where.eventcode = 'CORR';
        request.where.intakeserviceid = request.where.intakeservicerequestid;
        return app.models.Routing.getroutinginfo(request);   
    }).then(resp => {
      var status = null;
      if (resp.length > 0) {
        status = resp[0].status
      }
      if (responseJson.length > 0) {
        responseJson.map(res => {
          res.status = status;
        })
      }
      return responseJson;
    })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
  }

  function getResponseJson(data) {
    const responseJson = JSON.parse(JSON.stringify(data));
    var clientactors = [];
    var petitionactors = [];
    if (responseJson) {
      responseJson.forEach(res => {
        if (res.intakeservicerequestpetitionactor.length !== 0) {
          res.intakeservicerequestpetitionactor.forEach(da => {
            // CA - Client Actor
            // PA - Petirion Actor
            if (da.petitionactortype === 'CA') {
              clientactors.push(da);
              res.clientactors = clientactors;
            }
            if (da.petitionactortype === 'PA') {
              petitionactors.push(da);
              res.petitionactors = petitionactors;

            }
          })
          clientactors = [];
          petitionactors = [];
        }
      })
    }
    return responseJson;
  }

  Intakeservicerequestpetition.remoteMethod('getpetitiondetails', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      }
    },
    http: {
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  })

  Intakeservicerequestpetition.getforwardedassociatepetitionslist = request => {
    var intakedevalid = '';
    if (request.where) {
      intakedevalid = request.where.intakenumber;
    }
    const skip = request.page;
    const limit = request.limit;
    const sql = "select * from getforwardedassociatepetitionslist($1,$2,$3)";

    return util.executeDBQuery(sql, [intakedevalid, skip, limit])
      .then(data => data)
      .catch(err => util.logError(err));
  };


  Intakeservicerequestpetition.remoteMethod('getforwardedassociatepetitionslist', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      path: '/getforwardedassociatepetitionslist',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Intakeservicerequestpetition.getforwardpetitioncounty = async (request, reqctx) => {
    var _email;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application) {
      _email = reqctx.req.headers.user_email_captureby_application;
    }
    var requestuserinfo = { 'token': '', 'email': _email };
    var intakedevalid = '';
    if (request.where) {
      intakedevalid = request.where.intakenumber;
    }
    var teamcounty;
    await util.getuserinfo(requestuserinfo).then(data => {
      teamcounty = data.countyid;
    });
    var sql = "select countyid,countyname from county where countyid=$1"
    return util.executeDBQuery(sql, [teamcounty])
      .then(res => {
        const sql1 = "select distinct ins.saocountyid,ins.saotransfernotes,c.countyname as fromcounty from intakedastatus ins join intakeservicerequestpetition inp on inp.intakenumber=ins.intakenumber and inp.activeflag=1 "
          + " join muser mu on mu.securityusersid=inp.updatedby join teammemberassignment tma on tma.securityusersid=mu.securityusersid and tma.activeflag=1 join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag=1 "
          + " join team t on t.teamid=tm.teamid and t.activeflag=1 join county c on c.countyid=t.countyid::uuid  where ins.intakenumber=$1 and ins.saocountyid!=null";
        return util.executeDBQuery(sql1, [intakedevalid]);
      })
      .then(data => data)
      .catch(err => util.logError(err));
  };


  Intakeservicerequestpetition.remoteMethod('getforwardpetitioncounty', {
    accepts: [{
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    {
      arg: 'reqctx', type: 'object',
      http: { source: 'context' }
    }],
    http: {
      path: '/getforwardpetitioncounty',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  //sprint 4 changes for complaint summary
  Intakeservicerequestpetition.remoteMethod('listprobationpetition', {
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
      http: { source: 'context' }
    }],
    http: {
      path: '/listprobationpetition',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Intakeservicerequestpetition.listprobationpetition = function (request, reqctx) {
    let _securityusersid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      _securityusersid = reqctx.req.headers.securityusersid;
    }
    var sql = "select * from probationpetitionlist($1,$2,$3,$4)"
    const skip = (request.page - 1) * request.limit;
    const limit = request.limit;
    return util.executeDBQuery(sql, [request.where.personid, skip, limit, (request && request.securityuserid ? request.securityuserid : _securityusersid)])
      .then(res => {
        return res
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }
  Intakeservicerequestpetition.remoteMethod('listvopconditionsbasedontype', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      path: '/listvopconditionsbasedontype',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Intakeservicerequestpetition.listvopconditionsbasedontype = function (request) {

    var sql = "select * from getvopconditionsbasedontype($1,$2)"
    return util.executeDBQuery(sql, [request.where.vopviolationoffencetype, request.where.intakeservicerequestpetitionid])
      .then(res => {
        return res
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Intakeservicerequestpetition.remoteMethod('createvoppetition', {
    http: {
      path: '/createvoppetition',
      verb: 'post',
    },
    accepts: [{
      arg: 'data', type: 'object',
      http: { source: 'body' }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: { source: 'context' }
    }],
    returns: {
      type: 'string',
      root: true,
    },
  });

  Intakeservicerequestpetition.createvoppetition = function (request, reqctx) {
    let _securityusersid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      _securityusersid = reqctx.req.headers.securityusersid;
    }
    var intakeservicerequestpetitionid = request.intakeservicerequestpetitionid;
    var currentuserid = (request && request.securityuserid ? request.securityuserid : _securityusersid);
    var voilationdate = request.vopviolationdate;
    var voilationoffence = request.vopviolationoffencetype;
    var vopnotes = request.vopnotes;
    var courtconditions = JSON.stringify(request.conditiontype);
    var initiatedby = request.initiatedby;
    var sql = "select * from createvop($1,$2,$3,$4,$5,$6,$7)"

    return util.executeDBQuery(sql, [intakeservicerequestpetitionid, currentuserid, voilationdate, voilationoffence, vopnotes, courtconditions, initiatedby])
      .then(res => {
        return res
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Intakeservicerequestpetition.remoteMethod('listadjdispdetails', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      path: '/listadjdispdetails',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Intakeservicerequestpetition.listadjdispdetails = function (request) {

    var sql = "select * from getadjdispdetails($1,$2,$3)"
    const skip = (request.page - 1) * request.limit;
    const limit = request.limit;
    return util.executeDBQuery(sql, [request.where.intakenumber, skip, limit])
      .then(res => {
        return res
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }


  Intakeservicerequestpetition.remoteMethod('getvoppetitiondetails', {
    accepts: {
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'query'
      },
      required: true
    },
    http: {
      path: '/getvoppetitiondetails',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Intakeservicerequestpetition.getvoppetitiondetails = function (request) {

    var sql = "select * from getvoppetitiondetails($1)"
    return util.executeDBQuery(sql, [request.where.intakeservicerequestpetitionid])
      .then(res => {
        return res
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

};