'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequest");
const loopback = require('loopback');
var app = require('../../server/server');
const util = require('../utils/utils');
var config = require('../../server/config.json'); 

const ds = loopback.createDataSource('memory');
module.exports = function(Intakeservicerequest) {
var _ipaddress; // for auditlog
  Intakeservicerequest.GetPriors = function (pid) {
    var sql = 'SELECT * FROM getpersonpriorscount($1)';
    return util.executeDBQuery(sql, [pid])
      .then(data => {
        return data[0];
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };


	Intakeservicerequest.routeda = function(data){
      var sql = 'SELECT * FROM routeda_temp($1)';
    	return util.executeDBQuery(sql, [data.where.servicerequestnumber])
        .then(data1 => {
              var finalResponseObj = {}
              if(data1 != undefined && data1.length >= 1 ){
                finalResponseObj = {
                  "caseworker_name" : data1[0].caseworker_name,
                  "loadnumber" : data1[0].loadnumber,
                  "teamname" : data1[0].teamname,
                }
              }
            return finalResponseObj;
        })
        .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
        });
  };

  Intakeservicerequest.routedaInternal = data => {
      var sql = 'SELECT * FROM routeda_temp($1)';
      return util.executeDBQuery(sql, [data.where.servicerequestnumber])
        .then(data1 => {
              var finalResponseObj = {}
              if(data1 != undefined && data1.length >= 1 ){
                finalResponseObj = {
                  "caseworker_name" : data1[0].caseworker_name,
                  "loadnumber" : data1[0].loadnumber,
                  "teamname" : data1[0].teamname
                }
              }
            return finalResponseObj;
        })
        .catch(err1 => err1);
  }

	Intakeservicerequest.remoteMethod (
    'routeda',
    {
      http: {
      		path: '/routeda',
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
     }
     );

  /*For DSDS Action Popup in Person Search Details*/

  Intakeservicerequest.getdsdsactions = function (id,data,reqctx) {
    var intakeserviceid = data.where.intakerequestid;
    const securityuserid = util.getSecurityDetails(data,reqctx,).securityuserid;
    if (intakeserviceid == null) {
      intakeserviceid = "00000000-0000-0000-0000-000000000000";
    }
    var sql = 'select * from listdsdsactioninpersonpopup($1,$2,$3)';
    let record = { };
    return util.executeDBQuery(sql,[id,intakeserviceid,securityuserid])
      .then(response => {
        if (response.length > 0) {
          var data1 = [];
          var temp_map = new Map();

          for (var len = response.length,i = 0; i < len; ++i) {
            const key = response[i].datype

            if (temp_map.get(key) == undefined) {
              var obj1 = {
                "intakeserviceid": response[i].intakeserviceid,
                "danumber": response[i].danumber,
                "adoptionplanid": response[i].daplanningid,
                "description": response[i].description,
                "firstname": response[i].firstname,
                "lastname": response[i].lastname,
                "role": response[i].role,
                "roletypekey": response[i].roletypekey,
                "datereceived": response[i].datereceived,
                "datecreated": response[i].datecreated,
                "datecompleted": response[i].datecompleted,
                "status": response[i].status,
                "county": response[i].county,
                "dasubtype": response[i].dasubtype
              }
              var arr1 = [];
              arr1.push(obj1);
              temp_map.set(key,arr1);
            } else {
              var arr2 = temp_map.get(key);
              var obj2 = {
                "intakeserviceid": response[i].intakeserviceid,
                "danumber": response[i].danumber,
                "adoptionplanid": response[i].daplanningid,
                "description": response[i].description,
                "firstname": response[i].firstname,
                "lastname": response[i].lastname,
                "role": response[i].role,
                "roletypekey": response[i].roletypekey,
                "datereceived": response[i].datereceived,
                "datecreated": response[i].datecreated,
                "datecompleted": response[i].datecompleted,
                "status": response[i].status,
                "county": response[i].county,
                "dasubtype": response[i].dasubtype
              }
              arr2[arr2.length] = obj2;
              temp_map.set(key,arr2);
            }
          }
          for (const [key,value] of temp_map) {
            var finalResponseObj = {
              "daTypeName": key,
              "daDetails": value,
            };
            data1.push(finalResponseObj);
          }
          record["data"] = data1;
        } else {
          var data2 = [];
          record["data"] = data2;
        }
        return util.encryptresponse(record);
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      })
  };

Intakeservicerequest.getcasesummarydtls = function(id,reqctx){
 
  return Intakeservicerequest.getdsdsactionsummarydtls(id,'',reqctx);//reqctx 
};

  
  Intakeservicerequest.getdsdsactionsummarydtls = function (data, casetype, reqctx) {
    var { securityuserid, isExpungementSuperUser, iscaseexpunged, scasetype } = returnCseAndUseridFn(reqctx, casetype);

    var sql = 'select * from getdsdsactionsummarydtls($1,$2,$3,$4)';
    var dsdsactionsummary = [];

    return util.executeSecondaryNodeDBQuery(sql, [data, securityuserid, isExpungementSuperUser, iscaseexpunged])
      .then(datasummary => {
        dsdsactionsummary = datasummary;

        // Safety Check: If no records are found, return empty array immediately
        if (!datasummary || datasummary.length === 0) {
          return Promise.resolve([]);
        }

        const requestData = { where: { investigationid: datasummary[0].da_investigationid } };
        return app.models.Investigation.GetTaskSummaryv1(requestData, reqctx);
      })
      .then(tasksummary => {
        // Check if we actually have data before mutating it
        if (dsdsactionsummary && dsdsactionsummary.length > 0) {
          dsdsactionsummary[0].tasksummary = tasksummary;
          if (scasetype != '') {
            dsdsactionsummary[0].da_type = scasetype;
            dsdsactionsummary[0].da_subtype = '';
          }
        }
        return dsdsactionsummary;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        util.logError(err);

        // Critical: throw the error so Loopback knows the request failed
        throw err;
      });
  };

  Intakeservicerequest.remoteMethod ('getdsdsactions', {
    http: {
        path: '/getdsdsactions',
        verb: 'get'
    },
    accepts: [{
      arg: 'personid',
      type: 'string',
      required : true
  },{
    arg: 'filter',
    type: 'object'
}, {
  arg: 'reqctx',
  type: 'object',
  http: {source: 'context'}
  }],
    returns: {
        type: 'object',
        root : true
    }
  });

  //Remote Method getCrossRefByPersonType

  Intakeservicerequest.remoteMethod('getCrossRefByPersonType', {
    http: {
      path: '/getCrossRefByPersonType/:id',
      verb: 'get'
    },
    accepts : [{
      arg: 'id',
      type: 'string',
      required: true,
      http: {source: 'path'}
   },
   {
      arg : 'filter',
      type : 'object',
      required: true,
      http: {source: 'query'}
    }],
    description: "Search Cross Reference By Person Type",
    notes: "Cross reference search - Search Cross Reference By Person Type",
    returns: {
      root :true,
      type: 'object'
    }
  });


  Intakeservicerequest.remoteMethod('GetPriors', {
        accepts : {
                arg: 'pid',
                type: 'string',
                required: true,
                http: {source: 'query'}
            },
        http: {
            'verb': 'get',
            'path': '/GetPriors'
            },
        returns : {
            type : 'Object',
            root : true
            }
    });
/** locate related cases with through persons */
  Intakeservicerequest.getcaseconnected = function (id,reqctx) {
    var sql = 'select * from getcaseconnected($1)';
    return util.executeDBQuery(sql, [id])
      .then(resp => resp)
      .catch(err1 => util.logError(err1));
  };

  Intakeservicerequest.remoteMethod('getcaseconnected', {
    accepts : [{
            arg: 'id',
          type: 'string',
            required: true,
            http: {source: 'path'}
        },
        {
          arg: 'reqctx',
       type: 'object',
        http: {source: 'context'}
      }
  ],
    http: {"verb": "get", "path": "/getcaseconnected/:id/"},
      returns: {
          type: 'object',
          root : true
      }
  });

/**Service case info */
  Intakeservicerequest.getcasedetails = function (id, casetype,reqctx) {
    let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
    if (casetype == 'adoptioncase') {
      return Intakeservicerequest.getadoptioncasedtls(id,suserid);
    }
    else {
      return Intakeservicerequest.getservicecasedtls(id,suserid);
    }
  }

  Intakeservicerequest.getservicecasedtls = function (id,securityuserid) {
    var sql = 'select * from getservicecasesummarydtls($1, $2)';
    return util.executeDBQuery(sql, [id, securityuserid])
      .then(resp => resp)
      .catch(err1 => util.logError(err1));
  };

      Intakeservicerequest.remoteMethod('getcasedetails', {
        accepts : [{
                arg: 'id',
               type: 'string',
                required: true,
                http: {source: 'path'}
            },
            {
              arg: 'casetype',
              type: 'string',
              required: true,
              http: {source: 'path'}
          },
          {
            arg: 'ctx',
            type: 'object',
             http: {source: 'context'}
        }
      ],
        http: {"verb": "get", "path": "/getdsdsactionsummarydtls/:id/:casetype"},
           returns: {
               type: 'object',
               root : true
           }
      });


      Intakeservicerequest.remoteMethod('getrestrictedcasestatus', {
        accepts : [{
                arg: 'id',
               type: 'string',
                required: true,
                http: {source: 'path'}
            },
            {
              arg: 'reqctx',
              type: 'object',
               http: {source: 'context'}
          }
      ],
        http: {"verb": "get", "path": "/getrestrictedcasestatus/:id"},
           returns: {
               type: 'object',
               root : true
           }
      });
      
      /**Adoption case info */
    Intakeservicerequest.getadoptioncasedtls = function(id,securityuserid){
                var sql = 'select * from getadoptioncasesummarydtls($1, $2)';
                return util.executeDBQuery(sql, [id, securityuserid])
                  .catch(err1 => util.logError(err1));
      };

      // To check whether the case is restricted or not
      Intakeservicerequest.getrestrictedcasestatus = function(id,reqctx){
        let suserid=undefined;
        if(reqctx && reqctx.req &&reqctx.req.headers){
          suserid=reqctx.req.headers.securityusersid
        }
            var sql = 'select * from getRestrictedCaseStatus($1, $2)';
            return util.executeDBQuery(sql, [id, suserid])
              .catch(err1 => util.logError(err1));
        };
     
  Intakeservicerequest.getCrossRefByPersonType = (id, data) => {
  const emptyUUID = '00000000-0000-0000-0000-000000000000';
  const intakeserviceid = id ? id : emptyUUID;
  const personType = data.where? data.where.persontype: '';
  const gPageno = data.page;

  return app.models.Intakeservicerequest.findById(intakeserviceid, {
    fields:["intakeserviceid"],
    where: {activeflag: 1},
    include: {
      relation: "intakeservicerequestactor",
      scope: {
        fields: ["actorid","intakeservicerequestpersontypekey"],
        where: {intakeservicerequestpersontypekey: personType},
        include: {
          relation: "actor",
          scope: {
            fields: ["personid"],
            where: {activeflag: 1},
            include: {
              relation: "Person",
              scope: {
                fields: ["firstname", "lastname"],
                where: {activeflag: 1}
              }
            }
          }
        }
      }
    }
  })
  .then(result => {
    var tempRes = {};
    var Totalcount = 0;
    const data1 = JSON.parse(JSON.stringify(result));
    var actorsid= []
    if(data1.intakeservicerequestactor.length > 0){
       actorsid = data1.intakeservicerequestactor.map(record =>record.actorid)
       .map(x => "'" + x + "'");
    }
    var sql = 'select * from getsameracrossrefda($1::varchar[],$2::varchar,$3::varchar)';

    var countPromise = Promise.resolve();
    if(gPageno == 1){
      var Count = 'select * from getsameracrossrefda_cnt($1::varchar[],$2::varchar,$3::varchar)';
      countPromise = util.executeDBQuery(Count, [actorsid, intakeserviceid, personType])
        .then(data2 => {
          Totalcount = data2[0].getsameracrossrefda_cnt;
        });
     }
    return countPromise
      .then(() => util.executeDBQuery(sql, [actorsid,intakeserviceid,personType]))
      .then(res => {
          tempRes.data = res
          tempRes.count = Totalcount
          return tempRes;
      })
    .catch(err => err);
  })
  .catch(err => err);
};

     Intakeservicerequest.remoteMethod('getCrossRefBySameProvider', {
    http: {
      path: '/getCrossRefBySameProvider',
      verb: 'get'
    },
    accepts : [{
      arg : 'filter',
      type : 'Object',
      required: true,
      http: {source: 'query'}
    }],
    description: "Search Cross Reference By Provider",
    notes: "Cross reference search - Search Cross Reference By Provider",
    returns: {
      root :true,
      type: 'object'
    }
  });

  Intakeservicerequest.getCrossRefBySameProvider = arg => {
    const emptyUUID = '00000000-0000-0000-0000-000000000000';

    const limit = arg.limit;
    const skip = (arg.page-1) * limit;
    const nolimit = arg.nolimit

    const intakeserviceid = arg.where? arg.where.intakerequestid: emptyUUID;

    return app.models.Statementofdeficiency.find({
      fields:["agencyid"],
      where: {and: [{intakeserviceid: intakeserviceid}, {activeflag: 1}]},nolimit:true,
      include: {
        relation: "agency",
        scope: {
          fields: ["agencyid"],
          where: {activeflag: 1},
          include: {
            relation: "intakeservicerequestagency",
            scope: {
              fields: ["intakeserviceid"],
              where: {activeflag: 1}
            }
          }
        }
        }
      })
      .then(data =>{
            var result = JSON.parse(JSON.stringify(data));

            const isrs = result.map(x => x.agency.intakeservicerequestagency).reduce((a,b) => a.concat(b), []);

              const intakeid = isrs.map(record => record.intakeserviceid)
              const prs = [];

             prs.push(app.models.Intakeservicerequest.find({

              fields: ['intakeserviceid', 'servicerequestnumber', 'intakeservreqtypeid','intakeservicerequestclassid', 'intakeserreqstatustypeid', 'reporteddate'],
              where : {intakeserviceid :{inq : intakeid}},limit:limit,skip:skip,nolimit:nolimit,
                  include: [{
                    relation:'intakeservicerequesttype',
                    scope: {
                      fields:['description']
                    }
                  },
                  {
                    relation:'servicerequestsubtype',
                    scope: {
                      fields:['classkey']
                    }
                  },
                  {
                    relation: "intakeservicerequestactor",
                    scope: {
                        fields: ["intakeservicerequestactorid", "intakeserviceid", "actorid"],
                        where: {activeflag: true},
                        include: {
                            relation: "actor",
                            scope: {
                                fields: ["personid", "actortype"],
                                where: {and : [{activeflag: true}, {actortype: "RA"}]},
                                include: {
                                    relation: "Person",
                                    scope: {
                                        fields: ["firstname", "lastname"],
                                        where: {activeflag: 1},
                                        include: {
                                          relation: "personaddress",
                                          scope: {
                                            fields: ["county"],
                                            where: {activeflag: true}
                                          }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                ]
                }
             ));

             if (arg.page !== 'undefined' && arg.page === 1) {
              prs.push(app.models.Intakeservicerequest.count({
                intakeserviceid :{inq : intakeid}
              }))

            }

        return Promise.all(prs);
      }).then(data => {
        var resp = {};
        const isrs = JSON.parse(JSON.stringify(data[0]));
        const modifiedIsr = getModifiedISR(isrs);

resp.data = modifiedIsr;
        if(data.length>0){
            resp.count = data[1];
        }
        return resp;
    })
    .then(data => {
      return data;
    })
    .catch(err => err)
    };

    function getModifiedISR(isrs){
      return isrs.map(isr => {
        if(isr.intakeservicerequesttype.length > 0){
          isr.srtype = isr.intakeservicerequesttype.description;
          isr.srsubtype = isr.servicerequestsubtype.classkey;
        }

        if(isr.intakeservicerequestactor.length > 0)
        {
          const isrPerson = isr.intakeservicerequestactor
            .filter(isractor => isractor.actor)
            .filter(isractor => isractor.actor.actortype=='RA')
            .filter(isractor => isractor.actor.Person)
            .map(isractor => isractor.actor.Person);
          const counties = isrPerson.filter(person => person.personaddress)
            .map(person => person.personaddress)
            .reduce((a,b) => a.concat(b), [])
            .map(paddr => paddr.county);

            isr.raname = isrPerson.map(person => person.firstname + ' ' + person.lastname).join();
            isr.county = counties.length > 0? counties[0]: "";
        }
        else {
          isr.raname = "";
          isr.county = ""
        }
        isr.insertedon = isr.reporteddate;
        const reportedDate = new Date(isr.reporteddate)
        isr.datedue = new Date(reportedDate.setDate((reportedDate.getDate() + 30)));
        isr.pastdue = isr.datedue < Date.now() ? true: false;
        delete isr.reporteddate;
        delete isr.intakeservicerequesttype;
        delete isr.servicerequestsubtype;
        delete isr.intakeservicerequestactor;
        return isr;
      });
    }
  Intakeservicerequest.remoteMethod('getcasesummarydtls', {
   accepts : [{
           arg: 'id',
          type: 'string',
           required: true,
           http: {source: 'path'}
       },
       {
        arg: 'reqctx',
       type: 'object',
        http: {source: 'context'}}
],

   http: {"verb": "get", "path": "/getdsdsactionsummarydtls/:id"},
      returns: {
          type: 'object',
          root : true
      }
});

Intakeservicerequest.remoteMethod('expungedreportsummary', {
  accepts : [{
          arg: 'id',
          type: 'string',
          required: true,
          http: {source: 'path'}
      },
      {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}}
],
http: {"verb": "get", "path": "/expungedreportsummary/list/:id"},
returns : {
 type : 'Object',
 root : true
}
});

// intakeserviceid is a uuid column, so a non-uuid :id reaches Postgres as
// 22P02 invalid input syntax for type uuid. The web builds these URLs by string
// concatenation and several callers do it without a guard, so an unresolved
// case id arrives as the literal text 'null'. error-logger rewrites every
// failure to statusCode 400, which is why this surfaces as a bare
// "HttpError 400, No stack trace" against .../reportsummary/list/null.
const UUID_PATTERN = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i;

function notAUuid(id) {
  return typeof id !== 'string' || !UUID_PATTERN.test(id.trim());
}

Intakeservicerequest.expungedreportsummary = async (id, reqctx) => {
  // Same uuid-typed parameter as reportsummary, reached from the same
  // unguarded web callers.
  if (notAUuid(id)) {
    const err = new Error('id must be a uuid');
    err.statusCode = 400;
    err.code = 'INVALID_ID';
    throw err;
  }

  let sql = 'select * from getreportsummary_expunge($1)';
  return util.executeDBQuery(sql, [id])
  .then(data => {
      if(data && data.length > 0) {
        return data[0];
      }
  })
  .catch(err => {
      LOGGER.error(err);
      // Returning err resolved the promise with an Error instance, so the
      // caller received a 200 whose body serialized to {} and the failure was
      // silently swallowed. Reject so error-logger sees the real cause.
      throw err;
  })

};

Intakeservicerequest.remoteMethod('reportsummary', {
  accepts : [{
          arg: 'id',
          type: 'string',
          required: true,
          http: {source: 'path'}
      },
      {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}}
],
http: {"verb": "get", "path": "/reportsummary/list/:id"},
returns : {
 type : 'Object',
 root : true
}
});


Intakeservicerequest.reportsummary = async (id, reqctx) => {
  if (notAUuid(id)) {
    const err = new Error('id must be a uuid');
    err.statusCode = 400;
    err.code = 'INVALID_ID';
    throw err;
  }
  const prs =[];
  var _email =util.getSecurityDetails(id, reqctx).email;
  var requestuserinfo = {'token': '', 'email': _email};
  var teamtypekey ;
  // getuserinfo resolves undefined whenever its own lookup fails, so reading
  // teamtypekey off the result directly threw a TypeError that error-logger
  // flattened into the same undiagnosable 400.
  await util.getuserinfo(requestuserinfo).then (data => {
    teamtypekey = data ? data.teamtypekey : undefined;
  });

 prs.push(Intakeservicerequest.findById(id, {
  where: {"or": [{"activeflag": 0 },{"activeflag": 1 }]},
  fields: ['intakeserviceid','countyid','servicerequestnumber','narrative','description','reporteddate','reportedtime', 'reporterfirstname', 'reporterlastname', 'requesterphone', 'insertedon','insertedby','suspiciousdeath','missingpersons','intakeservreqtypeid','intakeservicerequestclassid','servicerequestincidenttypekey','intakeservreqinputtypeid','monumber','intakeservreqinputsourceid','isanonymousreporter','isunknownreporter','intakeservreqpurposeid','reportermiddlename','reporterphonenumber','reporterroletypekey','reporterzipcode','reporteremail','reporterincidentlocation','reporterisapproximate','reporterorganization','reportertitle','reporterincidentdate','reporterisAnonymousReporter','reporterisUnknownReporter','reporternarrative','reporterrefuseToShareZip','reporterisacknowledgementletter','reporteraddress1','reporteraddress2','reportercity','reporterstate','offenselocation','reporterphonenumberext','intakenumber'],
  include : [{
    relation:'intakeservicerequesttype',
    scope:{
      fields:['intakeserreqstatustypekey','description']
    }
   },
    {
      relation:'county', 
      scope:{
        fields:['countyid','countyname','statecountycode']
      }   
 },
 {
   relation:'servicerequestsubtype',
   scope:{
     fields:['servicerequestsubtypeid','classkey','description']
   }
},
{
 relation:'servicerequestincidenttype',
 scope:{
   fields:['servicerequestincidenttypekey','typedescription']
 }
},
{
 relation:'intakeservicerequestinputtype',
 scope:{
   fields:['intakeservreqinputtypeid','intakeservreqinputtypekey','description']
 }
},
{
  relation:'intakeservicerequestinputsource',
  scope:{
    fields:['intakeservreqinputsourceid','intakeservreqinputsourcekey','description']
  }
 },
 {
  relation:'intakeservicerequestpurpose',
  scope:{
    fields:['intakeservreqpurposeid','intakeservreqpurposekey','description']
  }
 },
 {
  relation:'intakeservicerequestevaluation',
  scope:{
    fields:['intakeservicerequestevaluationid','objectid','countyid','complaintid','yearsofage','offensedate','begindate','unknownrange','offencelocationtypekey'],
    include: [{
      relation:'county', 
      scope:{
        fields:['countyid','countyname']
      }
    },
    {
      relation:'offencelocationtype', 
      scope:{
        fields:['offencelocationtypekey','description']
      }
    }
    ,{
      relation:'intakeservicerequestevaluationconfig',
      scope:{
        fields:['intakeservicerequestevaluationid','allegationid'],
        include: {
          relation:'allegation',
          scope:{
            fields:['allegationid','name']
          }
        },
      }
    
    }]
  }
 },
{
 relation:'userprofile',
 scope:{
   fields:['securityuserid','firstname','lastname','displayname','fullname']
 }
},
{
relation:'intakeservicerequestillegalactivity',

 scope:{
   fields:['intakeservicerequestillegalactivityid','intakeservicerequestillegalactivitytypekey','intakeservicerequestid','activeflag'],
   where: {activeflag: 1}
  }
},
{
 relation:'intakeservicerequestactor',
   scope:{
     fields:['intakeservicerequestactorid','actorid','intakeservicerequestpersontypekey','rapersontypekey','intakeserviceid', 'isheadofhousehold'],
     include: {
       relation:'actor',
       scope:{
         fields:['actorid','activeflag','personid','actortype'],
         include: {
           relation:'Person',
             scope:{
               //where: {dangerlevel: 1},
               fields:['activeflag','firstname','lastname','dangerlevel','dangerreason','dob', 'middlename', 'suffix'],
               include: {
                 relation:'personaddress',
                   scope:{
                     //where: {danger: 1},
                     fields:['personaddressid','personid','activeflag','personaddresstypekey','address','zipcode','city','state','country','county','address2','danger','dangerreason']
                   }
               }
             }
         }

       }
     }
   }
}
]
}
)); 
if (teamtypekey == 'DJS')
{
  prs.push(new Promise((resolve, reject) => {
    const requestData = {where:{servicerequestid:id,assessmentstatus:null}};
    requestData.page = 1;
    requestData.limit = 10;
    requestData.nolimit = true;
    app.models.Assessment.list(requestData, (err, data) => {
      err ? reject(err) : resolve(data);  
    })
  }));
}

return Promise.all(prs)
.then (data=> {
  let summary = JSON.parse(JSON.stringify(data[0]));
  if (teamtypekey == 'DJS'){
    summary = buildDjsSummary(summary, data[1]);
  }
  return getSupervisorName(summary);
})
};

// DJS intakes carry an evaluation config and assessment list that the generic
// summary must not expose; everything here applies only to that team type.
function buildDjsSummary(summary, assessments) {
  if (summary.intakeservicerequestevaluation && summary.intakeservicerequestevaluation.intakeservicerequestevaluationconfig) {
    summary.intakeservicerequestevaluation.allegations = filterAllegations(summary);
    delete summary.intakeservicerequestevaluation.intakeservicerequestevaluationconfig;
  }

  summary = checkDOB(summary);
  summary.assessments = assessments.filter(assessment => assessment.intakassessment);
  if (summary.assessments.length > 0) {
    summary.assessments.forEach(x => x.intakassessment.splice(1));
  }

  return summary;
}

function getSupervisorName(summary) {
  if(summary && summary.intakenumber){
    var objectId = summary.intakenumber
    var sql = 'select fullname as supervisorname from userprofile where securityusersid in (select tosecurityusersid from routing where objectid=$1 and activeflag = 1)';
    return util.executeDBQuery(sql, [objectId])
    .then(data => {
      if (data!=null&& data.length>0){
        summary.supervisorname = data[0].supervisorname;
      }
        return summary;
    })
    .then((result) => {
      var intakedastagingSql = 'select jsondata from intakedastaging where intakenumber=$1 and activeflag=1';
      return util.executeDBQuery(intakedastagingSql, [objectId])
      .then(stagingResponse => {
        if (stagingResponse != null && stagingResponse.length > 0){
          result.jsondata = stagingResponse[0].jsondata;
        }
        return result;
      })
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
  }
  else
  {return summary;}
}

function filterAllegations(summary){
  return summary.intakeservicerequestevaluation.intakeservicerequestevaluationconfig.map(allegeds => {
    if (allegeds.allegation && allegeds.allegation.name)
     {return allegeds.allegation.name;}
  });
}

function checkDOB(summary) {
  var dob='';
      if(summary.intakeservicerequestevaluation)
      {
        if(summary.intakeservicerequestactor.length>0)
        {
        //  for(var j=0;j<summary.intakeservicerequestactor.length;j++)
          summary.intakeservicerequestactor.forEach(actors => {
            if(actors.intakeservicerequestpersontypekey=="Youth")
            {
              if(actors.actor && actors.actor.Person)
              {
            dob = actors.actor.Person.dob;
              }
            }
          })       
        }
        var evalutionObj = getIntakeEvalution(summary, dob);
        summary.intakeservicerequestevaluation=evalutionObj;
      }
      return summary;
}

function checkevalutionyearofage(evalution, offenceDate, youthDob){
  const timeDiff = new Date(offenceDate) - new Date(youthDob);
  const youthAge = new Date(timeDiff); // miliseconds from epoch

  const offenseMonth = new Date(offenceDate).getMonth();
  const youthMonth = new Date(youthDob).getMonth();

  const monthDiff = offenseMonth - youthMonth;

  let months = (monthDiff >= 0) ? (monthDiff) : (monthDiff + 12);

  months = (new Date(offenceDate).getDate() >= new Date(youthDob).getDate()) ? (months + 1) : months;

  let years = Math.abs(youthAge.getUTCFullYear() - 1970);
  if (months < 0) {
    months = 11;
    years = years - 1;
}
  evalution.yearsofage= years.toString() + ' Years ' + ((months > 0) ? months + ' Months' : '');
  return evalution;
}

function getIntakeEvalution(summary, dob){
  return summary.intakeservicerequestevaluation.map(evalution => {
    if (evalution)
    {
    var offenceDate="";
    var youthDob="";
    if(evalution.unknownrange==0)
    {
       offenceDate=evalution.offensedate;
    }
    else if(evalution.unknownrange==2)
    {
       offenceDate=evalution.begindate;
    }
    youthDob= dob;
    if(youthDob!="" && offenceDate!="")
    {
      evalution = checkevalutionyearofage(evalution, offenceDate, youthDob);

  }
 
  else {
  evalution.yearsofage= "";
  }
}
    return evalution;
  });
}

Intakeservicerequest.addupdate= function(id, request) {
        var prs = [];
        var nowDate = new Date();
        if(request.narrative != undefined){
          prs.push(Intakeservicerequest.updateAll(
            {intakeserviceid:id},
            {servicerequestincidenttypekey:request.servicerequestincidenttypekey,suspiciousdeath:request.suspiciousdeath,missingpersons:request.missingpersons,narrative:request.narrative}
          ));

        }else{
          prs.push(Intakeservicerequest.updateAll(
            {intakeserviceid:id},
            {servicerequestincidenttypekey:request.servicerequestincidenttypekey,suspiciousdeath:request.suspiciousdeath,missingpersons:request.missingpersons}
          ));
        }

      const illegalActivities = request.intakeservicerequestillegalactivity;
      prs.push(
        app.models.Intakeservicerequestillegalactivity.updateAll({intakeservicerequestid: id}, {activeflag: 0, expirationdate: nowDate.toJSON()})
      );
      prs.push(
        illegalActivities.filter(x => x.intakeservicerequestillegalactivityid===undefined).map(newIllegalActivity => app.models.Intakeservicerequestillegalactivity.create(newIllegalActivity))
      );
      prs.push(
        illegalActivities.filter(x => x.intakeservicerequestillegalactivitytypekey).map(x_updateActivity => {
          return app.models.Intakeservicerequestillegalactivity.updateAll({intakeservicerequestillegalactivitytypekey: x_updateActivity.intakeservicerequestillegalactivitytypekey,intakeservicerequestid:id}, {activeflag: 1, expirationdate: null,effectivedate:nowDate.toJSON() });
      }
      ));

      var flatPrs = prs.reduce((a,b) => a.concat(b), []);
        return Promise.all(flatPrs)
        .then(data => data)
        .catch(err =>err);
};


Intakeservicerequest.remoteMethod(
  'addupdate',
        {
          http: {
              path: '/update/:id',
              verb: 'put'
          },
         accepts : [
          {
            arg: 'id',
           type: 'string',
            required: true,
            http: {source: 'path'}
        },
          {arg : 'data',type : 'object',
             http : {source : 'body'}}
              ],
          returns: {
            type : 'object',
          root : true
          }

  });

  Intakeservicerequest.remoteMethod('entityroletypes', {
    accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        },
        {
          arg: 'data',
          type: 'object',
          required: true,
          http: {source: 'query'}
      }

 ],
    http: {"verb": "get", "path": "/entityroletypes/list/:id"},
 returns : {
  type : 'Object',
  root : true
 }
 });

 Intakeservicerequest.entityroletypes = (id, data) => {
  const isragencyid = data.where.intakeservicerequestagencyid;
  return Promise.all([entityroletypelist(id), app.models.Intakeservicerequestagency.entityroletypedetails(isragencyid)])
  .then(data1=>{
    return {roleTypes: data1[0], selectedRoleTypes: data1[1]};
  });
 }

 const entityroletypelist = id => Intakeservicerequest.findById(id, {
  where: {activeflag: true},
  fields: ['intakeserviceid','servicerequestnumber','intakeservreqtypeid','intakeservicerequestclassid'],
})
.then(irs => {
  return app.models.Servicerequesttypeconfig.find({
    fields:['servicerequesttypeconfigid','intakeservreqtypeid','servicerequestsubtypeid','intakeservicerequestplantypekey','activeflag'],
    where: {
      and: [{activeflag:1},{intakeservreqtypeid:irs.intakeservreqtypeid}, {servicerequestsubtypeid: irs.intakeservicerequestclassid}]
    },
    include :
    {
      relation:'servicerequesttypeconfigrole',
      scope:{
        where :{
          and: [{activeflag:1},{entityroletype:'EntityRoleType'}]
        },
        fields:['servicerequesttypeconfigroleid','servicerequesttypeconfigid','entityroletype','entityroletypekey','activeflag'],
    include :
    {
      relation:'agencyroletype',
      scope:{
        where :{
          and: [{activeflag:1}]
        },
        fields:['agencyroletypekey','typedescription','activeflag']
      }
    }

  }
}
  })
})
.then(srtconfigsraw=> {
  const srtconfigs = JSON.parse(JSON.stringify(srtconfigsraw));
  return srtconfigs
    .map(srtconfig => srtconfig.servicerequesttypeconfigrole);
})
.then(configroles => [].concat.apply([], configroles)
  .map(configrole => configrole.agencyroletype).filter(x => x)
)
.catch(err => err);

Intakeservicerequest.remoteMethod('investigationactivities', {
  accepts : [{
          arg: 'id',
          type: 'string',
          required: true,
          http: {source: 'path'}
      }

],
  http: {"verb": "get", "path": "/investigationactivities/list/:id"},
returns : {
type : 'Object',
root : true
}
});


Intakeservicerequest.investigationactivities = (id) => (Intakeservicerequest.findById(id, {
 where: {activeflag: true},
 fields: ['intakeserviceid'],
 include : {
   relation:'investigation',
   scope:{
     fields:['investigationid','intakeserviceid'],
     include : {
      relation:'activity',
      scope:{
        fields:['activityid','description','activitystatustypekey','amactivityid','ammappingid','objectid','activitytypekey','activeflag']
      }
   }
   }
}
}
));


Intakeservicerequest.remoteMethod('dispositionlist', {
    accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        },
        {
          arg: 'filter',
          type: 'object',
          required: true,
          http: {source: 'query'}
      },
      ],
    http: {"verb": "get", "path": "/dispositionlist/list/:id"},
 returns : {
  type : 'Object',
  root : true
 }
 });

Intakeservicerequest.dispositionlist =  (id,request) => (Intakeservicerequest.findById(id, {
	 where:{ activeflag: true},
	 fields: ['intakeserviceid','intakeservicerequestclassid','intakeserreqstatustypeid','intakeservreqtypeid']
}).then(reqid=>{
	        return app.models.Servicerequesttypeconfig.find({
	        	fields:['servicerequesttypeconfigid','servicerequestsubtypeid','intakeservreqtypeid','intakeserreqstatustypeid'],
	        	 where:{ and:[{activeflag: true},{intakeservreqtypeid:reqid.intakeservreqtypeid}, {servicerequestsubtypeid: reqid.intakeservicerequestclassid}]},
	        	 include:{
	        		 relation:'servicerequesttypeconfigdispositioncode',
	        		 scope:{ fields:['servicerequesttypeconfigid','intakeserreqstatustypeid','description','dispositioncode','servicerequesttypeconfigiddispostionid'],
	        			  where: {and:[{activeflag: true},{intakeserreqstatustypeid:request.where.intakeserreqstatustypeid}]}

	        		 }
	        	 }
	        });
})
)
.then (data=> {
  const intakeservicerequests = JSON.parse(JSON.stringify(data));
   return intakeservicerequests.map(dispositioncodes => dispositioncodes.servicerequesttypeconfigdispositioncode)
   .reduce((a,b) => a.concat(b), []);

})
.catch(err => err);

Intakeservicerequest.remoteMethod('statuslist', {
    accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        }],
    http: {"verb": "get", "path": "/statuslist/list/:id"},
 returns : {
  type : 'Object',
  root : true
 }
 });


Intakeservicerequest.statuslist =  (id) => (Intakeservicerequest.findById(id, {
	 where:{ activeflag: true},
	 fields: ['intakeserviceid','intakeservicerequestclassid','intakeserreqstatustypeid','intakeservreqtypeid']
}).then(reqid=>{
	        return app.models.Servicerequesttypeconfig.find({
	       	fields:['servicerequesttypeconfigid','servicerequestsubtypeid','intakeservreqtypeid','intakeserreqstatustypeid'],
	        	 where:{ and:[{activeflag: true},{intakeservreqtypeid:reqid.intakeservreqtypeid}, {servicerequestsubtypeid: reqid.intakeservicerequestclassid}]},

	        });
}).then (configobjs=>{
	return Promise.all(configobjs.map(configobj=>app.models.Servicerequesttypeconfigdispositioncode.find({
		 fields:['intakeserreqstatustypeid'],
		  where: { and:[{activeflag: true},{servicerequesttypeconfigid:configobj.servicerequesttypeconfigid}]},
	 })
	 ));
}).then (items => {
	var flatitems = items.reduce((a,b) => a.concat(b), []);
	const statusTypeIdArr = flatitems.map(item => item.intakeserreqstatustypeid);

	    const statuslist = Array.from (new Set(statusTypeIdArr));
	    return app.models.Intakeserreqstatustype.find({
	    	where :{and:[{ intakeserreqstatustypeid: {inq:statuslist}}, {activeflag:true}] }
	    })


	 })
.catch(err=>err)
)

Intakeservicerequest.getsystemauditlog = (id, data) => {
  const limit = data.limit;
  const page = data.page;
  const sql = 'select * from getsystemauditlog($1, $2, $3)';

  return util.executeDBQuery(sql, [id, page, limit])
    .then(data1 => {
        let count=0;
        if (data1.length > 0)
          {count = data1[0].count;}
        data1.forEach(x => delete x.count);

        return {
          count: count,
          data: data1
        };
    })
    .catch(err2 => err2);
};


Intakeservicerequest.getpsscoreanddateseen = (id,request) =>{
  const serviceReqType = request.where.intakeservreqtypekey;

  return app.models.Intakeservicerequestdispositioncode.find({
     where : {intakeserviceid:id ,intakeserreqstatustypeid:{"neq": null}},
     fields: ["intakeservicerequestdispositioncodeid","intakeserviceid","insertedon","insertedby","dateseen","activeflag"],
     include : [{relation : "userprofile"}]
  })
  .then(data =>{
    var dispositionItems = checkDispositionItems(data);
    

    if(serviceReqType === 'ANE'){
dispositionItems.sort(compare);

      if(dispositionItems.length>=1 ){
      var creationrow = dispositionItems[0];
      for(var x=0; x < dispositionItems.length ; x++){
        if(creationrow.intakeservicerequestdispositioncodeid === dispositionItems[x].intakeservicerequestdispositioncodeid){
            dispositionItems.splice(x,1);
        }
      }
      }

      return Promise.all(dispositionItems.map(dispositionItem => {
        var sql = 'select * from getloadnumberassigneduserbydate($1,$2)';
        var date = new Date(dispositionItem.insertedon);
        const insertDate = date.toISOString();
        return util.executeDBQuery(sql,[dispositionItem.insertedby,insertDate])
        .then(data1 => {
            LOGGER.info(data1);
            var tempData = JSON.stringify(dispositionItem);
              var userprofileStringify = JSON.parse(tempData).userprofile;
              return {
                "date" : dispositionItem.insertedon,
                "action" : "Date Seen",
                "dateseen" : dispositionItem.dateseen,
                "score" : "NA",
                "user" : userprofileStringify.displayname,
                "Title" : data1[0].title,
                "position" : data1[0].loadnumber
            };
        })
        .catch(err1 => {
            LOGGER.error(err1)
        })
      }));
  }
})
  .then(finaldata => {
    return finaldata;
  })
  .catch(err => err);
};

function checkDispositionItems(data){
  var dispositionItems = [];
    for(const a of data){
    dispositionItems.push(a);
  }
  var removeDispositionItems = [];

  for(var i=0;i < dispositionItems.length-1 ; i++){
    var thisitem = dispositionItems[i].dateseen ? dispositionItems[i].dateseen:"" ;
    var previousitem =  dispositionItems[i+1].dateseen ? dispositionItems[i+1].dateseen:"";
    if(thisitem === previousitem){
        var item = dispositionItems[i+1];
        removeDispositionItems.push(item);
    }
  }
  for(const element of removeDispositionItems){
    for(var n=0;n<dispositionItems.length ; n++){
      if(element.intakeservicerequestdispositioncodeid === dispositionItems[n].intakeservicerequestdispositioncodeid)
      {
        dispositionItems.splice(n,1);
      }
    }
  }
  return dispositionItems;
}

function compare(a,b) {
  if (a.insertedon < b.insertedon)
    {return -1;}
  if (a.insertedon > b.insertedon)
    {return 1;}
     return 0;
}

Intakeservicerequest.remoteMethod('getsystemauditlog', {
  http: {
        path: '/getsystemauditlog/:id',
        verb: 'get'
  },
  accepts : [
  {
    arg : 'id',
    type : 'string',
    required: true,
    http : {source : 'path'}
},
{
    arg : 'filter',
    type : 'object',
    http : {source : 'query'}
  }],
  returns: {
      type : 'object',
        root : true
  }
  });


Intakeservicerequest.remoteMethod('getpsscoreanddateseen', {
      http: {
            path: '/getpsscoreanddateseen/:id',
            verb: 'get'
      },
      accepts : [
      {
        arg : 'id',
        type : 'string',
        required: true,
        http : {source : 'path'}
    },
    {
        arg : 'data',
        type : 'object',
        http : {source : 'query'}
      }],
      returns: {
          type : 'object',
            root : true
      }
      });

      Intakeservicerequest.remoteMethod('getcalendarevents', {
        http: {
          'verb': 'get',
          'path': '/getcalendarevents'
          },
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
              source : 'query'
            }
        }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }],
        returns : {
          type : 'Object',
          root : true
          }
      });

      Intakeservicerequest.remoteMethod('SRUnacknowledwork', {
        http: {
          'verb': 'get',
          'path': '/SRUnacknowledwork'
          },
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
              source : 'query'
            }
        },
        returns : {
          type : 'Object',
          root : true
          }
      });


      Intakeservicerequest.SRUnacknowledwork = function(data) {
        var Totalcount = 0;
        var countPromise = Promise.resolve();
        if (data.page == 1) {
          var Count = 'select * from srunacknowledgedwork_rptcnt()';
          countPromise = util.executeDBQuery(Count, [])
            .then(data1 => {
              Totalcount = data1[0].srunacknowledgedwork_rptcnt;
            });
        }

          var sql =  'select * from srunacknowledgedwork_rpt($1, $2)';
          return countPromise
            .then(() => util.executeDBQuery(sql, [data.page, data.limit]))
            .then(data2 => {
              return {
                'data' : data2,
                'count' : Totalcount
              };
            })
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
      };


  //select * from  AreaTeamMemberServiceRequest  where RoutingStatusTypeKey <> 'Acc' and ActiveFlag = 1
      Intakeservicerequest.getcalendarevents=function(data, reqctx){
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        var currentUser = (data&&data.securityuserid?data.securityuserid: _securityusersid);
        LOGGER.debug("currentUser",currentUser);
          var sql = 'SELECT * FROM getcalendarevents($1)';
          return util.executeDBQuery(sql, [currentUser])
             .then(response => {
                  LOGGER.debug(response);
                  return response;
             })
             .catch(err => {
               LOGGER.error('>>>>ERROR:', err);
               throw err;
             });
      };

      Intakeservicerequest.getIntakeId = (intakereqnum) => {
        return Intakeservicerequest.findOne({
          fields: ['intakeserviceid'],
          where:{servicerequestnumber: intakereqnum}
        })
        .then(intakeId => intakeId)
        .catch(err => util.logError(err));
      };

      Intakeservicerequest.getIntakeNum = (intakereqid) => {
        return Intakeservicerequest.findById(intakereqid, {
          fields: ['servicerequestnumber']
        })
        .then(intakeNum => {
          return intakeNum.servicerequestnumber;
        })
        .catch(err => util.logError(err));
      };

      Intakeservicerequest.getIntakeDetails = (intakereqid) => {
        return Intakeservicerequest.findById(intakereqid, {
          fields: ['servicerequestnumber','narrative']
        })
        .then(intakeNum => {
          return intakeNum;
        })
        .catch(err => util.logError(err));
      };

        Intakeservicerequest.getdatimeline = (id, request) => {
        const isExp = request && request.isExpungementSuperUser ? request.isExpungementSuperUser : 0;
        const iscaseexpunged = request && request.iscaseexpunged ? request.iscaseexpunged : 0;
      
        const sql = 'SELECT * FROM getdatimeline($1,$2,$3)';

        return util.executeSecondaryNodeDBQuery(sql, [id,isExp,iscaseexpunged])
        .then(data2 => {
          const result = JSON.parse(JSON.stringify(data2));
          result.forEach(x => {
            delete x.intaketype;
          })
          return result;
        })
        .catch(err2 => { LOGGER.error('>>>>ERROR:', err2); return util.logError(err2); });
      };
       
      Intakeservicerequest.remoteMethod('getdatimeline', {
        accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
          },
          {
            arg: 'filter',
            type: 'Object',
            http: {source: 'query'},
            required: false
          },
          {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }
        ],
        http: {"verb": "get", "path": "/getdatimeline/:id"},
        returns: {
          type: 'object',
          root : true
        }
      });    
  // Auditlog for  intake priors
  Intakeservicerequest.beforeRemote('priors', function(ctx, data, next) {
    if (ctx.req) {
      _ipaddress = ctx.req.connection.remoteAddress;  
    }
    next();
  });
     
     Intakeservicerequest.remoteMethod('priors', {
      http: {
            path: '/priors',
            verb: 'post'
      },
     accepts : [{
        arg : 'data',
        type : 'object',
        http : {source : 'body'}
     }],
      returns: {
          type : 'object',
            root : true
      }
     });

     Intakeservicerequest.priors = (request) =>{
      var description,Servicerequestnumber;
      var logtypekey = "PV";
      Servicerequestnumber = request.obj.danumber;
      description = "Prior DA#"+ request.obj.priordanumber +" has been reviewed from DA#";
      var logJson = {
        "data": {
          "obj":{}
        }
     };
      logJson.data = request.obj; 
      var newadd = {
        "description":description,
        "logtypekey":logtypekey ,
        "servicerequestnumber":Servicerequestnumber,
        "metadata":logJson,
        "ipaddress":_ipaddress
      }
      // Auditlog Recording Added here 
      return app.models.Auditlogtype.find(
        {where:{logtypekey:request.logtypekey},fields:['logtypekey']})
        .then(data=>{
          return app.models.Auditlog.create(newadd)
        })
 }

 Intakeservicerequest.getdatimelinedjs = id => {
  var sql = 'SELECT * FROM getdatimeline_djs($1)';
  return util.executeDBQuery(sql, [id])
  .catch(err => util.logError(err));
};

Intakeservicerequest.remoteMethod('getdatimelinedjs', {
  accepts : [{
          arg: 'id',
         type: 'string',
          required: true,
          http: {source: 'path'}
      }
],
  http: {"verb": "get", "path": "/getdatimelinedjs/:id"},
     returns: {
         type: 'object',
         root : true
     }
});
 
    Intakeservicerequest.remoteMethod('prepopasmtprepostdiacharge', {
      accepts : [{
              arg: 'id',
            type: 'string',
              required: true,
              http: {source: 'path'}
          },
          {
            arg: 'reqctx',
       type: 'object',
        http: {source: 'context'}
        }
    ],
      http: {"verb": "get", "path": "/prepopasmtprepostdiacharge/:id"},
        returns: {
            type: 'object',
            root : true
        }
    });

    Intakeservicerequest.prepopasmtprepostdiacharge = function(data,reqctx){
      let suserid=undefined;
      if(reqctx && reqctx.req &&reqctx.req.headers){
        suserid=reqctx.req.headers.securityusersid
      }
      var securityuserid = suserid;
        var sql = 'select * from prepopasmtprepostdiacharge($1, $2)';
        return util.executeDBQuery(sql, [data, securityuserid])
          .catch(err2 => util.logError(err2));
      };

      Intakeservicerequest.remoteMethod('prepopasmtdrai', {
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
        http: {"verb": "get", "path": "/prepopasmtdrai"},
          returns: {
              type: 'object',
              root : true
          }
      });
  
      Intakeservicerequest.prepopasmtdrai = function(data, reqctx){
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }  
        var securityuserid = (data && data.securityuserid?data.securityuserid: _securityusersid);
        var personid = '';
        if(data.where) {
          personid = data.where.personid;
        }

        var sql = 'select * from prepopasmtdrai($1, $2)';
        return util.executeDBQuery(sql, [personid, securityuserid])
          .then(data2 => {
            if(data2.length > 0 && data2[0].prepopasmtdrai.length > 0)
              {return data2[0].prepopasmtdrai[0];}
            return data2;
          })
          .catch(err2 => util.logError(err2));
        };

        Intakeservicerequest.remoteMethod('updatecpsresponsetimeruntimely', {
          accepts:
           [ {
              arg: 'id',
              type: 'string',
              required: true,
              http: { source: 'path' }
            }, {
              arg: 'reqctx',
              type: 'object',
               http: {source: 'context'}
              }
          ],
    
            http: { "verb": "patch", "path": "/updatecpsresponsetimeruntimely/:id" },
            returns: {
              type: 'Object',
              root: true
            }
        });

        Intakeservicerequest.updatecpsresponsetimeruntimely = (id,reqctx) => {
          let suserid=undefined;
          if(reqctx && reqctx.req &&reqctx.req.headers){
            suserid=reqctx.req.headers.securityusersid
          }
          const sql = ` UPDATE intakeservicerequest
                      SET responsetimer = now(), untimely = true, updatedby = $2, updatedon = now()
                      WHERE intakeserviceid= $1 and responsetimer is null`;
          return util.executeDBQuery(sql, [id, suserid])
            .then(data => data)
            .catch(err => {
              LOGGER.error('>>>>ERROR:', err);
              throw err;
            });
        }

        Intakeservicerequest.remoteMethod('updatefolderchange', {
          http: {
            path: '/updatefolderchange/:id',
            verb: 'patch',
          },
          accepts: [
            {
              arg: 'id',
              type: 'data',
              required: true,
              http: {source: 'path'},
            },
            {
              arg: 'data',
              type: 'object',
              http: {source: 'body'},
            },
            {
              arg: 'reqctx',
              type: 'object',
              http: {
                source: 'context'
              }
            }
          ],
          returns: {
            type: 'string',
            root: true,
          },
        });

        Intakeservicerequest.updatefolderchange = function(id, request, reqctx)    {
          let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }  
      var securityusersid = (request && request.securityuserid?request.securityuserid: _securityusersid);
      request.insertedby = securityusersid;
      request.updatedby = securityusersid;
      
          return Intakeservicerequest.updateAll({
            intakeserviceid: id}, request);
        };

  function searchpriordsQuery(isCompact, personid, mdm_id, cisclientid, type, securityuserid, isExpungementSuperUser, cjamspid){    // NOSONAR
    let sql='';
    let params=[];
    if (isCompact) {
      sql = 'select * from searchpriorcaselists($1,$2, $3, $4)';
      params = [personid, mdm_id, cisclientid, securityuserid]
    } else {
      sql = 'select * from searchpriordsdsaction($1,$2, $3, $4, $5, $6)';
      params = [personid, mdm_id, cisclientid, securityuserid, isExpungementSuperUser, cjamspid]
    }
    switch (type) {
      case 'servicecase':
        sql = 'select * from searchpriordsdsaction_servicecase($1,$2)';
        params = [personid, securityuserid]
        break;
      case 'referral':
        sql = 'select * from searchpriordsdsaction_referral($1,$2)';
        params = [personid, securityuserid]
        break;
      case 'adoptioncase':
        sql = 'select * from searchpriordsdsaction_adoptioncase($1,$2)';
        params = [personid, securityuserid]
        break;
      case 'intake':
        sql = 'select * from searchpriordsdsaction_intake($1,$2)';
        params = [personid, securityuserid]
        break;
      case 'cps':
        sql = 'select * from searchpriordsdsaction_cps($1,$2)';
        params = [personid, securityuserid]
        break;
      case 'roa':
        sql = 'select * from searchpriordsdsaction_roa($1,$2)';
        params = [personid, securityuserid]
        break;
    }
    return { sql, params }
  }

  function runPriorDsQuery(sql, params, isCompact) {
    return util.executeSecondaryNodeDBQuery(sql, params)
      .then(response => {
        if (isCompact) {
          const types = [...new Set(response.map(item => item.datype))];
          return { data: types.map(item => ({"daTypeName": item})) };
        }
        return { data: getResponseObj(response) };
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Intakeservicerequest.searchpriordsdsactionsbyperson = function (personid, cisclientid, mdm_id, data, compact, type, reqctx) {  // NOSONAR
      const isExpungementSuperUser = data?.where?.isExpungementSuperUser === 1 || data?.where?.isExpungementSuperUser === '1' ? 1 : 0;
      const cjamspid = data?.where?.cjamspid || null;

      const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;

      var sql;
      var params = [];
      var securityuserid = _securityusersid;
      var isCompact = compact && compact === 1 ? true : false;
      if(personid === undefined || personid === '')
      {
        personid = null;
      }

      const resQuery = searchpriordsQuery(isCompact, personid, mdm_id, cisclientid, type, securityuserid, isExpungementSuperUser, cjamspid)
      sql = resQuery.sql;
      params = resQuery.params;

      return runPriorDsQuery(sql, params, isCompact);
      };

Intakeservicerequest.searchpriordsdsactionsprovider = function (cjamspid, reqctx) {
  var sql;
  sql = 'select * from prov.getpersonproviderlist($1, null, null, $2);';

  return util.executeSecondaryNodeDBQuery(sql, [cjamspid, true])
    .then(response => {
      return { data: response };
    })
    .catch(err => {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    });

  };

  Intakeservicerequest.remoteMethod('searchpriordsdsactionsprovider', {
    accepts: [{
      arg: 'cjamspid',
      type: 'string',
      required : false
      }, {
      arg: 'reqctx',
      type: 'object',
      http: {source: 'context'}
      }],
    http: {
      "verb": "get",
      "path": "/searchpriordsdsactionsprovider"
    },
    returns: {
      type: 'object',
      root : true
    }
  });

  Intakeservicerequest.searchpriordsdsactionsAS = function (cjamspid, reqctx){
    const _securityusersid = util.getSecurityDetails(cjamspid, reqctx).securityuserid;
    var sql;
    sql = 'select * from as_searchpriordsdsaction_cw($1, $2);';

    return util.executeSecondaryNodeDBQuery(sql, [cjamspid, _securityusersid])
      .then(response => {
        return { data: response };
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

    };

    Intakeservicerequest.remoteMethod('searchpriordsdsactionsAS', {
      accepts: [{
        arg: 'cjamspid',
        type: 'string',
        required : false
        }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      http: {
        "verb": "get",
        "path": "/searchpriordsdsactionsAS"
      },
      returns: {
        type: 'object',
        root : true
      }
    });

      Intakeservicerequest.searchpriordsdsactionsbypersonexpunged = function (personid, cisclientid, mdm_id, data, compact, type, reqctx)
      {
        const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
        const cjamspid = data?.where?.cjamspid || null;
        var sql;
        var params = [];
        var securityuserid = _securityusersid;
        var isCompact = compact && compact === 1 ? true : false;
        if(personid === undefined || personid === '')
        {
          personid = null;
        }

        sql = 'select * from searchpriordsdsaction_expunge($1,$2,$3,$4,$5)';
        params = [personid,mdm_id,cisclientid,securityuserid,cjamspid];

        return runPriorDsQuery(sql, params, isCompact);
        };

        Intakeservicerequest.remoteMethod('searchpriordsdsactionsbypersonexpunged', {
          accepts: [{
            arg: 'personid',
            type: 'string',
            required : false
            },{
              arg: 'cisclientid',
              type: 'string',
              required : false
             },{
              arg: 'mdm_id',
              type: 'string',
              required : false
            },{
              arg: 'filter',
              type: 'object'
          }, {
              arg: 'compact',
              type: 'number',
              http: {
                source: 'query'
              }
            }, {
              arg: 'type',
              type: 'string',
              http: {
                source: 'query'
              }
            }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
            }],
          http: {
            "verb": "get",
            "path": "/searchpriordsdsactionsbypersonexpunged"
          },
          returns: {
            type: 'object',
            root : true
          }
        });

  function getResponseObj(response) {
    let data = new Array();
    if (!Array.isArray(response) || response.length === 0) {
      return data;
    }
    let temp_map = new Map();
    response.forEach(item => {
      const itemkey = item.datype;
      let obj = {
        "intakeserviceid": item.objectid,
        "danumber": item.danumber,
        "adoptionplanid": item.daplanningid,
        "description": item.description,
        "roles": item.roles,
        "datereceived": item.datereceived,
        "datecreated": item.datecreated,
        "datecompleted": item.datecompleted,
        "status": item.status,
        "county": item.county,
        "dasubtype": item.dasubtype,
        "datype": item.datype,
        "outcomes": item.outcomes,
        "relationshiparray": item.relationshiparray,
        "workername": item.workername,
        "headofhousehlod": item.headofhousehlod,
        "allegedmaltreator": item.allegedmaltreator,
        "restrictedstatus": item.restrictstatus,
        "workerdetails": item.workerdetails
      }
      let arr = [];
      if (temp_map.get(itemkey) !== undefined) {
        arr = temp_map.get(itemkey);
      }
      arr.push(obj);
      temp_map.set(itemkey,arr);
    });

    for (const [k,value] of temp_map) {
      let finalResponseObj = {
        "daTypeName": k,
        "daDetails": value,
      };
      data.push(finalResponseObj);
    }
    return data;
  }

    Intakeservicerequest.remoteMethod('searchpriordsdsactionsbyperson', {
      accepts: [{
        arg: 'personid',
        type: 'string',
        required : false
        },{
          arg: 'cisclientid',
          type: 'string',
          required : false
         },{
          arg: 'mdm_id',
          type: 'string',
          required : false
        },{
          arg: 'filter',
          type: 'object'
      }, {
          arg: 'compact',
          type: 'number',
          http: {
            source: 'query'
          }
        }, {
          arg: 'type',
          type: 'string',
          http: {
            source: 'query'
          }
        }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
        }],
      http: {
        "verb": "get",
        "path": "/searchpriordsdsactionsbyperson"
      },
      returns: {
        type: 'object',
        root : true
      }
    });

    Intakeservicerequest.remoteMethod('getadoptionsummarydtls', {
      accepts : [{
              arg: 'id',
             type: 'string',
              required: true,
              http: {source: 'path'}
          }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }
    ],
      http: {"verb": "get", "path": "/getadoptionsummarydtls/:id"},
         returns: {
             type: 'object',
             root : true
         }
    });
  Intakeservicerequest.getadoptionsummarydtls = function(data, reqctx){
    let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  

        const sql = 'select * from getadoptioncasesummarydtlsdashboard($1, $2)';
        return util.executeDBQuery(sql, [data, _securityusersid])
          .then(data2 => data2)
          .catch(err2 => err2);
    }

    Intakeservicerequest.getcpscase = function(request, reqctx){
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }      
            const sql = 'select * from getcpscase($1, $2, $3)';
            return util.executeDBQuery(sql, [request.where.servicerequestnumber, request.pagenumber,request.pagesize])
              .then(data1 => data1)
              .catch(err1 => err1);
        }
  
      Intakeservicerequest.remoteMethod('getcpscase', {
          accepts: [{
            arg: 'filter',
            type: 'object',
            required : true
            }, {
              arg: 'reqctx',
              type: 'object',
              http: {source: 'context'}
              }],
          http: {
            "verb": "get",
            "path": "/getcpscase"
          },
          returns: {
            type: 'object',
            root : true
          }
        });

        Intakeservicerequest.getmultiplevendorlist = async (request, reqctx) => {
          var _email;
          if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.user_email_captureby_application){
            _email = reqctx.req.headers.user_email_captureby_application;
		      }  
          var requestuserinfo = {'token': '', 'email': _email};
          var caseNumber = request.where.daNumber;
          var clientid = request.where.clientid;
          var page = request.page?request.page:1;
          var limit = request.limit?request.limit:10;
          var nolimit = request.where['nolimit'];
          if(nolimit){
            page = null;
            limit = null;
          }
          var sroletypekey ;
          await util.getuserinfo(requestuserinfo).then (data => {
            sroletypekey = data.roletypekey;
          });  
          const dataQuery = 'SELECT * FROM get_multiples_provider_service_log($1,$2,$3,$4,$5)';
          return util.executeDBQuery(dataQuery, [caseNumber,sroletypekey,[clientid],page,limit])
            .then(result => {
              LOGGER.debug('success');
              LOGGER.debug(result, 'result');
              return result;
            })
            .catch(err1 => util.logError(err1));
      };
      Intakeservicerequest.remoteMethod('getmultiplevendorlist', {
          http: {
              path: '/getmultiplevendorlist',
              verb: 'get'
          },
          accepts: [{
              arg: 'filter',
              type: 'Object',
              http: {
                  source: 'query'
              }
          },
          {
            arg: 'reqctx',
           type: 'object',
            http: {source: 'context'}}],
          returns: {
              arg: 'servicelogData',
              type: 'Object'
          }
      });

    Intakeservicerequest.getrohsenuntimelycriteria = function(request, reqctx) {
      const sql = 'select * from getrohsenuntimelycriteria($1,$2,$3,$4,$5)';
      return util.executeDBQuery(sql, [request.where.servicecaseid,request.where.progressnoteid,request.where.safecassessmentid,request.where.mfiraassessmentid,request.where.objecttype])
        .then(data1 => data1)
        .catch(err1 => err1);
    }
    
    Intakeservicerequest.remoteMethod('getrohsenuntimelycriteria', {
      accepts: [{
        arg: 'filter',
        type: 'object',
        required : true
        }, {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
          }],
      http: {
        "verb": "get",
        "path": "/getrohsenuntimelycriteria"
      },
      returns: {
        type: 'object',
        root : true
      }
    });
  
    Intakeservicerequest.addsenuntimelycompletionreason = function(request, reqctx){
      let _securityusersid = undefined;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }   
      let req = JSON.stringify(request.where.data);
      const sql = 'select * from updatesenuntimelycompletionreason($1,$2)';
      return util.executeDBQuery(sql, [req,_securityusersid])
        .then(data1 => data1)
        .catch(err1 => err1);
    }
    
    Intakeservicerequest.remoteMethod('addsenuntimelycompletionreason', {
      accepts: [
        {
          arg: 'data',
          type: 'object',
          http: { source: 'body' }
        }, 
        {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
        }],
      http: { "verb": "post", "path": "/addsenuntimelycompletionreason" },
      returns: {
        type: 'Object',
        root: true
      }
    });

    Intakeservicerequest.senuntimelyreasoncreteriaupdate = function(request, reqctx){
      let _securityusersid ;
      if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
        _securityusersid = reqctx.req.headers.securityusersid;
      }   
      const sql = 'select * from senuntimelyreasoncreteriaupdate($1,$2,$3,$4)';
      return util.executeDBQuery(sql, [request.servicecaseid,_securityusersid,request.inputsource,request.inputsourceid])
        .then(data1 => data1)
        .catch(err1 => err1);
    }
    
    Intakeservicerequest.remoteMethod('senuntimelyreasoncreteriaupdate', {
      accepts: [
        {
          arg: 'data',
          type: 'object',
          http: { source: 'body' }
        }, 
        {
          arg: 'reqctx',
          type: 'object',
          http: {source: 'context'}
        }],
      http: { "verb": "post", "path": "/senuntimelyreasoncreteriaupdate" },
      returns: {
        type: 'Object',
        root: true
      }
    });

    Intakeservicerequest.getcaseexpungedflag = function(request, reqctx){
      const sql = 'select * from iscaseexpunged($1, $2)';
      return util.executeDBQuery(sql, [request.where.objecttype, request.where.objectid])
        .then(data1 => data1)
        .catch(err1 => {
          LOGGER.error(err1);
        });
    }
  
    Intakeservicerequest.remoteMethod('getcaseexpungedflag', {
        accepts: [{
          arg: 'filter',
          type: 'object',
          required : true
          }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
            }],
        http: {
          "verb": "get",
          "path": "/getcaseexpungedflag"
        },
        returns: {
          type: 'object',
          root : true
        }
      });
    Intakeservicerequest.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequest.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequest.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
function returnCseAndUseridFn(reqctx, casetype) {
  let suserid = undefined;
  if (reqctx && reqctx.req && reqctx.req.headers) {
    suserid = reqctx.req.headers.securityusersid;
  }

  var scasetype = casetype;
  var securityuserid = suserid;
  let isExpungementSuperUser = reqctx?.req?.query?.isExpungementSuperUser === '1' ? 1 : 0;
  let iscaseexpunged = reqctx?.req?.query?.iscaseexpunged ?? 0;
  return { securityuserid, isExpungementSuperUser, iscaseexpunged, scasetype };
}

