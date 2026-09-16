'use strict';
const LOGGER = require("log4js").getLogger("personmedicalcondition");
var server = require('../../server/server');
const util = require('../utils/utils');
var app = require('../../server/server');
const moment = require('moment');
const { test } = require("ramda");

module.exports = function(Personmedicalcondition) {

    Personmedicalcondition.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {
                  source: 'context'
                }
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });
    
    Personmedicalcondition.remoteMethod('hcdmdelete', {
        http: { 
                path: '/hcdmdelete/:id',
                verb: 'delete'
              },
		accepts:
			  [{
				arg: 'id',
				type: 'string',
				required: true,
				http: { source: 'path' }
			  },
              {
                arg: 'reqctx',
             type: 'object',
              http: {source: 'context'}
            }],
        returns: 
             {
			    type: 'Object',
			    root: true
		     }
    });

    Personmedicalcondition.hcdmdelete = (id,reqctx) => {
        let suserid=undefined;
        if(reqctx && reqctx.req &&reqctx.req.headers){
          suserid=reqctx.req.headers.securityusersid
        }
		var sql = 'update healthcaredecisionmakerinformation set activeflag = 0, updatedon= now(),updatedby =\''+suserid+'\' WHERE healthcaredecisionmakerinformationid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Personmedicalcondition.remoteMethod('personmedicalconditiondelete', {
        http: { 
                path: '/personmedicalconditiondelete/:id',
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

    Personmedicalcondition.remoteMethod('list', {
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

    Personmedicalcondition.addupdate = function(request, reqctx)
    {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
		
		request.updatedby = _securityusersid;
	  
        if(request.personmedicalconditionid === null || request.personmedicalconditionid === undefined)
        {
            return Personmedicalcondition.create(request).then(res => {
                request.medicalcondition.map(typekey=>{
                app.models.Personmedicalconditioninfo.create({
                personmedicalconditionid:res.personmedicalconditionid,
                insertedby: _securityusersid,
                updatedby: _securityusersid,
                insertedon: new Date().toLocaleString(),
                updatedon: new Date().toLocaleString(),
                 medicalconditiontypekey: typekey.medicalconditiontypekey});
                });
                return res;
            });
        }
        else
        {
            return Personmedicalcondition.updateAll({personmedicalconditionid:request.personmedicalconditionid},request)
            .then(res =>{
                let sql ='update personmedicalconditioninfo set activeflag = 0, updatedon= now(),updatedby= \''+_securityusersid+'\'   WHERE personmedicalconditionid =$1';
                return util.executeDBQuery(sql,[request.personmedicalconditionid])
                .then(() => {
                    if ( request.medicalcondition!=null &&  request.medicalcondition !=undefined)
                    {
                       request.medicalcondition.map(typekey=>{
                       app.models.Personmedicalconditioninfo.create({
                       personmedicalconditionid:request.personmedicalconditionid,
                       insertedon: new Date().toLocaleString(),
                       updatedon: new Date().toLocaleString(),
                       medicalconditiontypekey: typekey.medicalconditiontypekey});
                       });
                    }
                    return request;
                })
                .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            });
        }
    };

    Personmedicalcondition.personmedicalconditiondelete = (id) => {
		var sql = 'update personmedicalcondition set activeflag = 0, updatedon= now() WHERE personmedicalconditionid =\''+id+'\'';
        return util.executeDBQuery(sql, [])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
 
    Personmedicalcondition.list = request => {
        const personid = request.where.personid;
        const startDateRequest = request.where.startDate;
        const endDateRequest = request.where.endDate;
        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var limit = request.limit;
        var totalcount = 0;
        var sql = `select pmc.*, (select json_agg(x) from (select pmci.medicalconditiontypekey from personmedicalcondition pmc join personmedicalconditioninfo pmci 
            on pmc.personmedicalconditionid = pmci.personmedicalconditionid and  pmc.personid ='${personid}' and pmc.activeflag=1 and pmci.activeflag=1 ) as x )  as personmedicalconditioninfo,
            (SELECT json_agg(docs) FROM  (SELECT dp.documentpropertiesid, dp.objecttypekey, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
            (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby), dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename
            , (SELECT row_to_json(x) AS documentattachment FROM (SELECT dat.documentpropertiesid,dat.attachmenttypekey, dat.attachmentclassificationtypekey, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
            (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat WHERE dat.documentpropertiesid = dp.documentpropertiesid ) x),dp.uploadstatus,dp.finalstatus,dp.ecmsdocumentid
            from documentproperties dp where dp.additionalobjectid = pmc.personmedicalconditionid::varchar and dp.additionalobjecttype = 'personmedicalcondition' and dp.activeflag in (1,4,3,5) )docs) as uploadpath
            from personmedicalcondition pmc where pmc.personid ='${personid}' and pmc.activeflag = 1 limit $1 offset $2`;
      
        return util.executeSecondaryNodeDBQuery(sql, [limit, request.skip])
            .then(data => {
                if (data !== null && data.length > 0) {
                    totalcount = data[0].totalcount;
                }
                var result;
                result = {
                    'data': data,
                    'count': totalcount
                };
                return result;
            })
            .then(data => {
                if (startDateRequest && endDateRequest) {
                    let personmedicalcondition = getPersonMedicalList(data, startDateRequest, endDateRequest, 'list');
                    return {data: personmedicalcondition, count: personmedicalcondition.length};
                  } else {
                      return data;
                  }

            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personmedicalcondition.remoteMethod('personsecondarymedicallist', {
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'body'
            },
            required : true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        http : {
            verb : 'post'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    Personmedicalcondition.personsecondarymedicallist = (request,reqctx) => {
        const personid = request.where.personid;

        var sql = `select  * from getpsychotropicmedicationshealthcaredecision($1) `

        return util.executeSecondaryNodeDBQuery(sql,[personid])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personmedicalcondition.remoteMethod('gethcdmfromcourt', {
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'body'
            },
            required : true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        http : {
            verb : 'post'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    Personmedicalcondition.gethcdmfromcourt = (request,reqctx) => {
        const personid = request.where.personid;

        var sql = `select * from cjams.gethcdminfo($1) `

        return util.executeDBQuery(sql, [personid])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personmedicalcondition.remoteMethod('getlatesthealthcare', {
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'body'
            },
            required : true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        http : {
            verb : 'post'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    Personmedicalcondition.getlatesthealthcare = (request,reqctx) => {
        const personid = request.where.personid;
        const courtorderid = request.where.courtorderid;
        var sql = `select * from cjams.getlatesthealthcare($1,$2) `

        return util.executeDBQuery(sql, [personid,courtorderid])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personmedicalcondition.remoteMethod('auditTrailhcdm', {
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'body'
            },
            required : true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        http : {
            verb : 'post'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    Personmedicalcondition.auditTrailhcdm = (request,reqctx) => {
        
        const courtorderid = request.where.objectid;
        var sql = `select * from cjams.getaudittrailhcdm($1) `

        return util.executeDBQuery(sql, [courtorderid])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personmedicalcondition.remoteMethod('personmedicallist', {
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

    Personmedicalcondition.personmedicallist = request => {
        const personid = request.where.personid;
        const startDateRequest = request.where.startDate;
        const endDateRequest = request.where.endDate;
        const sortcolumn = request.where.sortcolumn ?? 'Updated on';
        const sortorder= request.where.sortorder ?? 'desc';
        const sortcolumnlist ={
            'Medication Name':'a.medicationname',
             'Date Prescribed':'a.medicationeffectivedate',
             'Updated on' :'a.updatedon'
        }
const column =  sortcolumnlist[sortcolumn]      

        if (request.page !== 'undefined') {
            request.skip = (request.page - 1) * request.limit;
        }
        var limit = request.limit;
        var totalcount = 0;
        var sql = `select count(1) over() as totalcount, a.*,max(hd.healthcaredecisionmaker) as healthcaredecisionmaker, (select fullname from userprofile where securityusersid = a.updatedby) as username,
            (case when a.uploadedFiles is null then (SELECT json_agg(docs) FROM  (SELECT dp.documentpropertiesid, dp.objecttypekey,dp.activeflag,dp.ecmsdocumentid, dp.title, dp.actualdocumentdate, dp.documenttypekey, dp.insertedon, dp.updatedon,
            (select up.fullname as insertedby from userprofile up where up.securityusersid = dp.insertedby),dp.updatedby, dp.documentdate, dp.mime, dp.s3bucketpathname, dp.description, dp.other,dp.filename,dp.numberofbytes, dp.originalfilename,dp.uploadstatus,dp.finalstatus
            , (SELECT row_to_json(x) AS documentattachment FROM (SELECT dat.documentpropertiesid,dat.attachmenttypekey, dat.attachmentclassificationtypekey,dat.activeflag, dat.attachmentclassificationsubtypekey, dat.assessmenttemplateid,
            (select up.fullname as updatedby from userprofile up where up.securityusersid = dat.updatedby) from documentattachment dat WHERE dat.documentpropertiesid = dp.documentpropertiesid ) x)
            from documentproperties dp where dp.additionalobjectid = a.personmedicpshychotropicid::varchar and dp.additionalobjecttype = \'personmedicpshychotropic\' and dp.activeflag in (1,3,4,5) and dp.documentpropertiesid in (
                select    (max(documentpropertiesid::varchar))::uuid  from documentproperties dc where   dc.additionalobjectid::uuid = a.personmedicpshychotropicid::uuid and  dc.additionalobjecttype = \'personmedicpshychotropic\' group by dc.ecmsdocumentid 
                ) )docs) else a.uploadedFiles end) as uploadedFiles
            from cjams.personmedicpshychotropic a 
            left join  cjams.healthcaredecisionmakerinformation hd on hd.objectid ::uuid =a.personmedicpshychotropicid and hd.objecttype ='psychotropic' and hd.activeflag =1
            where a.activeflag=1 and a.personid=$1 
            and (a.renewal =false or a.renewal is NULL) 
            and ($2::date is null or a.insertedon >= $2::date) 
            and ($3::date is null or a.insertedon < ($3::date + interval '1 day')) 
            group by (a.personmedicpshychotropicid ) 
            ORDER BY 
              CASE WHEN a.medicationexpirationdate IS NULL THEN 0 ELSE 1 END ASC,
              ${column} ${sortorder} NULLS LAST,
             CASE WHEN a.dosage ~ '^[0-9]+$' THEN a.dosage::numeric ELSE 0 END DESC NULLS LAST
            limit $4 offset $5`;

    return util.executeSecondaryNodeDBQuery(
        sql,
        [
            personid,
            startDateRequest || null,
            endDateRequest || null,
            limit,
            request.skip
        ]
    )
            .then(data => { // NOSONAR
                if (data !== null && data.length > 0) {
                        totalcount = data[0].totalcount;
                    }
                var result;
                result = {
                    'data': data,
                    'count': totalcount
                };
                return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
    Personmedicalcondition.remoteMethod('personmedicalrenewallist', {
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

    Personmedicalcondition.personmedicalrenewallist = request => {
        const personid = request.where.personid;
            var sql = `select  
            a.personmedicpshychotropicid ,a.personid ,a.medicationname ,a.medicationeffectivedate ,a.medicationexpirationdate ,
            a.dosage ,a.frequency ,a.prescribingdoctor ,a.lastdosetakendate ,a.medicationcomments ,a.prescriptionreasontypekey ,
            a.informationsourcetypekey ,a.activeflag ,a.updatedby ,a.updatedon ,a.insertedby ,a.insertedon ,a.effectivedate ,
            a.expirationdate ,a.startdate ,a.enddate ,a.compliant ,a.reportedby ,a.medicationtypekey ,a.isprescribedmedication ,
            a.medicationtype ,a.prescribedduration ,a.prescribedreason ,a.ismedicationpsychotropic ,a.classification ,a.diagnosis ,
            a.targetedsymptoms ,a.targetedother ,a.informedconsent ,a.renewal ,a.specifyfrequencyhour ,a.specifyduration ,
            a.otherspecifyduration ,a.otherreason ,a.datemedicationstarted ,a.isprescribercheck ,a.compliantcomments ,
            a.dateofrefill ,a.changeofdate ,a.diagnosisfromsecond ,a.secondaryreviewcompleted ,a.pshychotropicid, a.personmedicpshychotropicparentid,          
            max(hd.healthcaredecisionmaker) as healthcaredecisionmaker,
             (select fullname from userprofile where securityusersid = a.updatedby) as username
             from cjams.personmedicpshychotropic a 
            left join  cjams.healthcaredecisionmakerinformation hd on hd.objectid ::uuid =a.personmedicpshychotropicid 
            and hd.objecttype ='psychotropic' and hd.activeflag =1
            where a.activeflag=1 and a.personid=$1 and a.renewal =true group by (a.personmedicpshychotropicid )
            order by a.dateofrefill desc`;
      

        return util.executeSecondaryNodeDBQuery(sql, [personid])
            .then(res => { return {data:res} })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    }
    function getPersonMedicalList(data, startDateRequest, endDateRequest, medType) {
        const startDate = moment(startDateRequest).startOf('day');
        const endDate = moment(endDateRequest).startOf('day');
        return data?.data?.filter(e => {
            let strtDateKey = '';
            let endDateKey = '';
            if(medType == 'personmedicallist') {
                strtDateKey = e.datemedicationstarted;
                endDateKey = e.medicationexpirationdate;
            } else{
                strtDateKey = e.begindate;
                endDateKey = e.enddate;
            }
            const mStartDate = moment(strtDateKey).startOf('day');
            const mEndDate = moment(endDateKey).startOf('day');

            const condition1 = mStartDate.isValid() && mEndDate.isValid() ? (mStartDate.isBetween(startDate,endDate,null,'[]') || mEndDate.isBetween(startDate,endDate,null,'[]')) : false;

            const condition2 = !mStartDate.isValid() && !mEndDate.isValid();

            const condition3 = !mStartDate.isValid() && mEndDate.isValid() ? mEndDate.isBetween(startDate,endDate,null,'[]') : false;

            const condition4 = !mEndDate.isValid() && mStartDate.isValid() ? mStartDate.isSameOrBefore(endDate) : false;

            return (condition1 || condition2 || condition3 || condition4);
        });
    }

    Personmedicalcondition.remoteMethod('personmedidocumentlist', {
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        http : {
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });
    
    Personmedicalcondition.medicationPsychotrophicpdf = request => {
        const personid = request.where.personid;
        var sql = "select * from getpersonmedicalpdf($1)";

        return util.executeDBQuery(sql, [personid])
            .then(data => {
                var result;
                result = {
                    'data': data[0].getpersonmedicalpdf
                };
                return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
    Personmedicalcondition.remoteMethod('medicationPsychotrophicpdf', {
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        http : {
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });
    Personmedicalcondition.personmedidocumentlist = (request,reqctx) => {
        const personid = request.where.personid;

        var sql = ` select json_agg(x) as data from (select d.*, (select row_to_json(y) as documentattachment
        from (select * from documentattachment da where da.documentpropertiesid=d.documentpropertiesid limit 1) as y)
        from documentproperties d where (title='Informed Consent' or title='Psychotropic Medication Informed Consent') and objectid=$1 and actualdocumentdate > $2
        and activeflag=1 and d.documentpropertiesid in (
        select    (max(documentpropertiesid::varchar))::uuid  from documentproperties
        where (title='Informed Consent' or title='Psychotropic Medication Informed Consent') and objectid=$1
        and activeflag=1 and actualdocumentdate > $2
        group by ecmsdocumentid
        )
        ) as x`

        return util.executeDBQuery(sql, [personid,request.where.date])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personmedicalcondition.remoteMethod('personmedicalhistory', {
        accepts : [{
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
        http : {
            verb : 'get'
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

    Personmedicalcondition.personmedicalhistory = (request,reqctx) => {
        const personmedicpshychotropicid = request.where.id;

        var sql = 'select b.fullname ,p.updatedon ,p.medicationeffectivedate,p.medicationexpirationdate ,p.lastdosetakendate   from personmedicpshychotropic_history  p LEFT JOIN  userprofile b on p.updatedby  = b.securityusersid where personmedicpshychotropicid  = $1 order by p.updatedon desc ';

        return util.executeSecondaryNodeDBQuery(sql, [personmedicpshychotropicid])
            .then(data => data)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Personmedicalcondition.remoteMethod('getpersonimmunizationlist', {
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

    Personmedicalcondition.getpersonimmunizationlist=(request)=>{

        var totalcount = 0;
        const pageno = request.page;
        const pagesize = request.limit;
        var sql= 'select * from getpersonimmunizationlist($1,$2,$3)';
        return util.executeDBQuery(sql, [request.where.personid, pageno, pagesize])
            .then(getpersonimmunizationlistdata => {
                if (getpersonimmunizationlistdata!==null && getpersonimmunizationlistdata.length>0) {totalcount= getpersonimmunizationlistdata[0].totalcount;}
                var result;
                result = {
                    'data' : getpersonimmunizationlistdata,
                    'count' : totalcount
                };
                return result;
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

    };


    Personmedicalcondition.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Personmedicalcondition.observe('access', (ctx, next) => util.access(ctx, next));
    Personmedicalcondition.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PMED',
    ctx.isNewInstance?ctx.instance.personid:ctx.data.personid));
    Personmedicalcondition.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};