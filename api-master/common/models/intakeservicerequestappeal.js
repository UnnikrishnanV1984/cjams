'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Intakeservicerequestappeal) {

    var intakeservreqtypeid,intakeservicerequestclassid;
    var servicerequesttypeconfigid,status,servicerequesttypeconfigiddispositionid;
    var disposition;// added for auditlog

    Intakeservicerequestappeal.add =(request) =>{

        status = request.status;
        disposition =request.dispositioncode;

        return app.models.Intakeservicerequest.findOne({
                    where:{
                      intakeserviceid: request.intakeserviceid
                    }
            }).then(data =>{
                 intakeservreqtypeid = data.intakeservreqtypeid;
                 intakeservicerequestclassid = data.intakeservicerequestclassid;
                if (intakeservicerequestclassid==null || intakeservicerequestclassid==undefined
                ||intakeservicerequestclassid=='')
                {
                    intakeservicerequestclassid='00000000-0000-0000-0000-000000000000';
                }
                 return app.models.Servicerequesttypeconfig.find({
                    where:{
                        intakeservreqtypeid:intakeservreqtypeid,
                        servicerequestsubtypeid:intakeservicerequestclassid
                    },
                    scope:{
                        fields:['servicerequesttypeconfigid']
                    }
                })
            }).then(result =>{
                servicerequesttypeconfigid = result[0].servicerequesttypeconfigid;
                         return app.models.Intakeserreqstatustype.findOne({
                             where:{
                                intakeserreqstatustypekey:request.status
                             },
                             scope:{
                                fields:['intakeserreqstatustypeid']
                             }
                         })
                }).then(data =>{
                    status = data.intakeserreqstatustypeid;
                    return app.models.Servicerequesttypeconfigdispositioncode.findOne({
                        where:{
                            servicerequesttypeconfigid:servicerequesttypeconfigid,
                            dispositioncode:request.dispositioncode,
                            intakeserreqstatustypeid:status
                        },
                        scope:{
                        fields:['servicerequesttypeconfigiddispositionid']
                        }
                    })
                }).then(resp =>{
                 servicerequesttypeconfigiddispositionid = resp.servicerequesttypeconfigiddispostionid;
                 return  Intakeservicerequestappeal.find({
                     where:{
                        intakeserviceid: request.intakeserviceid
                     }
                 })
                }).then(result => {
                    if(result.length === 0){
                        var response ={};
                        response.intakeserviceid = request.intakeserviceid;
                        response.servicerequesttypeconfigdispostionid = servicerequesttypeconfigiddispositionid;
                        response.appealdate = request.appealdate;
                        response.remarks = request.remarks;
                        response.updatedon = new Date().toLocaleString();
                        return Intakeservicerequestappeal.create(response)
                        .then(data => {
                            var sql = 'UPDATE intakeservicerequest SET isappealed=true,intakeserreqstatustypeid =$1  WHERE intakeserviceid =$2';
                            return util.executeDBQuery(sql,[status,request.intakeserviceid])
                                .then(_data1 => data);
                        })
                    } else {
                        return request;
                    }
                })
                .catch(err => err);
            }

    Intakeservicerequestappeal.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });


    Intakeservicerequestappeal.observe('after save', function (ctx, next) {
		var logJson ={
			"data": {
				"status": "",
				"disposition": "",
				"createdby": "",
				"createadon": ""
			}
		}
		var description,isnew;
		var logtypekey = "IR";
        var intakeserviceid = ctx.instance.intakeserviceid;
		if (ctx.isNewInstance){
			 isnew = true;
            description = "Appeal with status:"+ctx.instance.status +" and disposition:"+ctx.instance.dispositioncode+ "added to Intake";
			logJson.data.status = status;
			logJson.data.disposition  = disposition;
			logJson.data.createdby=app.currentUser.email;
			logJson.data.createadon=ctx.instance.insertedon;
		}
		var newadd = {
			"description":description,
            "logtypekey":logtypekey ,
            "intakeserviceid":intakeserviceid,
			"metadata":logJson,
			"isnew":isnew
		}
		// Auditlog Recording Added here
		app.models.Auditlog.createlogdetails(newadd);
		next();
})

    Intakeservicerequestappeal.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestappeal.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestappeal.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
