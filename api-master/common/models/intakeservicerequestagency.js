'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestagency");
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Intakeservicerequestagency) {
    var agencyname,agencytype,agencysubtype,ipaddress;   // Added for audit log
    Intakeservicerequestagency.remoteMethod('addagency', {
        http: {
            path: '/addagency',
            verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });
    

	Intakeservicerequestagency.addagency = data => {
        return new Promise((resolve, reject) => {
            const agencyType = data.agencytype;

            LOGGER.debug("agencyType:" + agencyType);
           //Added for audit log agencyname ,agencytype,agencysubtype
            app.models.Agency.findOne({where:{agencyid:data.agencyid},
                fields:['agencyname','agencytypekey','agencysubtypekey']
             }).then(data1 => {
                agencyname = data1.agencyname;
                agencytype = data1.agencytypekey;
                agencysubtype = data1.agencysubtypekey;
                    })

                resolve(data);
        })
        .then(data2 => Intakeservicerequestagency.create(data2))
        .catch(err => err);
    };

    Intakeservicerequestagency.remoteMethod('list', {
         accepts : [
             //{
        //         arg: 'id',
        //         type: 'string',
        //         required: true,
        //         http: {source: 'path'}
        //     },
            {
                arg : 'filter',
                type : 'Object',
                http : {
                    source : 'query'
                },
                required : true
            }
        ],
        http: {"verb": "get", "path": "/list"},
        returns : {
            type : 'Object',
            root : true
        }
    });

	Intakeservicerequestagency.list = data => {
        const intakeserviceid = data.where? data.where.intakeserviceid: emptyUUID;
        const orderby = data.order !== "" ? "agencyname": "";
        
        LOGGER.debug("intakeserviceid:"+JSON.stringify(data.where));
        
        return Intakeservicerequestagency.find({
            where: {intakeserviceid: intakeserviceid},
            fields: ['agencyid','intakeservicerequestagencyid','expirationdate'],
            include: [{
                relation: "agency",
                scope: {
                    fields: ["agencyid","agencyname", "agencycategorykey", "agencytypekey", "agencysubtypekey", "activeflag", "effectivedate", "expirationdate"],
                    "order": orderby,
                    include: [
                    {
                        relation: "agencycategory",
                        scope: {
                            fields: ["description"]
                        }
                    }, 
                    {
                        relation: "agencytype",
                        scope: {
                            fields: ["typedescription"]
                        }
                    }, 
                    {
                        relation: "agencysubtype",
                        scope: {
                            fields: ["typedescription"]
                        }
                    }, 
                    {
                        relation: "agencyalias",
                        scope: {
                            fields: ["name"]
                        }
                    }, 
                    {
                        relation: "agencyservice",
                        scope: {
                            fields: ['agencyserviceid','agencyid','activeflag','servicetypekey','serviceid'],
                            include: {
                                relation: "service",
                                scope: {
                                    fields: ['serviceid','servicename','description','servicetypekey']
                                }
                            }
                        }
                    },
                    {
                        relation: "agencyaddress",
                        scope: {
                            //where: {and: [{agencyaddresstypekey: 'P'}, {activeflag: 1}]},
                            fields: ['agencyaddressid','agencyid','activeflag','agencyaddresstypekey','address','zipcode','city','state','country','county','address2']
                        }
                    }
                    ]
                }
            },
            {
                relation: "intakeserviceagencyroletype",
                scope: {
                    where: {and: [{activeflag: 1}]},
                    fields: ["agencyroletypekey","activeflag"],
                    include: {
                        relation: "agencyroletype",
                        scope: {
                            fields: ["typedescription"]
                        }
                    }
                }
            }]
        })
        .then(isra => {
            return formatRespose(isra);
        })
        .catch(err => err);
    }

    function formatRespose(isra) {
        const isrAgencies = JSON.parse(JSON.stringify(isra));
        const saddresstype = 'P';
        isrAgencies.forEach(isrAgency => {
            if (isrAgency.agency && isrAgency.agency.agencyaddress) {
                if (isrAgency.agency.agencyaddress.length > 0) {
                    let isrDisplayAgency = isrAgency.agency.agencyaddress.filter(x => x.agencyaddresstypekey === saddresstype);
                    if (isrDisplayAgency.length === 0) { isrDisplayAgency = isrAgency.agency.agencyaddress[0]; }

                    if (isrDisplayAgency) { isrAgency.agency.agencyaddress = [isrDisplayAgency]; }
                }
            }
        });
        return isrAgencies;
    }
      
      Intakeservicerequestagency.entityroletypedetails = (id) => (Intakeservicerequestagency.findById(id, {
       fields: ['intakeservicerequestagencyid','intakeserviceid','agencyid','description','agencyroletypekey'],

       include : {
        relation: 'intakeserviceagencyroletype',
                scope: {
                    where: {and: [{activeflag: 1}]},
                    fields: ['intakeserviceagencyroletypeid','intakeservicerequestagencyid','agencyroletypekey','activeflag'],
                    include: {
                        relation: 'agencyroletype',
                        scope: {
                            fields: ['typedescription']
                        }
                    }
                }
            }
        }
      ));

      
      Intakeservicerequestagency.addupdate= function(id, request, reqctx) {
        var prs = [];
        var nowDate = new Date();
        let _securityusersid = undefined;
  if (reqctx && reqctx.req && reqctx.req.headers) {
    _securityusersid = reqctx.req.headers.securityusersid
  }

      const agencyroletypes = request.intakeserviceagencyroletype;
      prs.push(
        app.models.Intakeserviceagencyroletype.updateAll({intakeservicerequestagencyid: id}, {activeflag: 0, expirationdate: nowDate.toJSON(), updatedby: request && request.securityuserid?request.securityuserid: _securityusersid})
      );
      prs.push(
        agencyroletypes.filter(x => x.intakeserviceagencyroletypeid===undefined).map(newagencyroletype => app.models.Intakeserviceagencyroletype.create(newagencyroletype))
      );
      prs.push(
        agencyroletypes.filter(x => x.intakeserviceagencyroletypeid).map(x_updateroletype => {
          return app.models.Intakeserviceagencyroletype.updateAll({intakeserviceagencyroletypeid: x_updateroletype.intakeserviceagencyroletypeid}, {activeflag: 1, expirationdate: null,effectivedate:nowDate.toJSON(), updatedby: request && request.securityuserid?request.securityuserid: _securityusersid });
      }
      )); 

      var flatPrs = prs.reduce((a,b) => a.concat(b), []);
        return Promise.all(flatPrs)
        .then(data => data)
        .catch(err =>err);
};	


Intakeservicerequestagency.remoteMethod(
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
        {
            arg: 'reqctx',
            type: 'object',
            http: {
              source: 'context'
            }
          },
          {arg : 'data',type : 'object',
             http : {source : 'body'}}
              ],   
          returns: {
            type : 'object',
          root : true
          }
        
  });
   //Added for Delete log
   Intakeservicerequestagency.agency =(agencyid) =>{
       return app.models.Agency.findOne({where:{agencyid:agencyid},
       fields:['agencyname','agencytypekey','agencysubtypekey']
    }).then(data => {
        return data;
           }).catch (err=> err);

   }
  
   Intakeservicerequestagency.observe('after save', function (ctx, next) { 
    var intakeserviceid,description ,referenceid,Servicerequestnumber,_ipaddress,isnew,isedit,isdelete;
    var logJson = {
        "data": {
            "agencyname": "",
            "entitycategory": "",
            "entitytype": "",
            "entitysubtype": "",
            "createdby": "",
            "createadon": ""
        }
    };
    var logtypekey = "EEE"; /**/
    description = "Entity (Type: "+agencytype+",agency:"+agencyname+",Subtype :"+agencysubtype+ ") added to DA#";
    
     if (ctx.isNewInstance) //CREATE
    {   intakeserviceid = ctx.instance.intakeserviceid;
        referenceid = ctx.instance.intakeservicerequestagencyid;
        isnew = true;

        
            logJson.data.entitycategory = ctx.instance.agencytype;
            logJson.data.agencyname = agencyname;
            logJson.data.entitytype = agencytype;
            logJson.data.entitysubtype = agencysubtype;
            logJson.data.createdby=ctx.instance.insertedby;
            logJson.data.createadon=ctx.instance.insertedon;
            
            var newadd = {
                "description":description,
                "logtypekey":logtypekey ,
                "intakeserviceid": intakeserviceid,
                "referenceid": referenceid,
                "servicerequestnumber":Servicerequestnumber,
                "ipaddress":_ipaddress,
                "metadata":logJson,
                "isnew":isnew,
                "isedit":isedit,
                "isdelete":isdelete
            }
            
            app.models.Auditlog.createlogdetails(newadd);
            next();
    }
    })

    
    Intakeservicerequestagency.observe('after delete', function (ctx, next) {// Audit log delete
        var intakeserviceid,description,agencyid,referenceid,Servicerequestnumber,isnew,isedit,isdelete;
        isdelete = true;
        var logJson = {"data":{"agencyname":"","entitytype":"","entitysubtype":"","updatedby":""}}
        var logtypekey = "EEE";
        referenceid = ctx.where.intakeservicerequestagencyid;

        Intakeservicerequestagency.findOne({where :{Intakeservicerequestagencyid:ctx.where.intakeservicerequestagencyid},
    fields:['intakeserviceid','agencyid']
        }).then(data => {
            intakeserviceid = data.intakeserviceid;
            agencyid = data.agencyid;
            Intakeservicerequestagency.agency(agencyid)
            .then(res =>{
                agencyname = res.agencyname;
                agencytype = res.agencytypekey;
                agencysubtype = res.agencysubtypekey;
                logJson.data.agencyname = agencyname;
                logJson.data.entitytype = agencytype;
                logJson.data.entitysubtype = agencysubtype;
                logJson.data.updatedby=app.currentUser.email;
                description =  "Entity (Type: "+agencytype+",Subtype :"+agencysubtype+ ") deleted from DA#";
                var newadd = {
                    "description":description,
                    "logtypekey":logtypekey ,
                    "intakeserviceid": intakeserviceid,
                    "referenceid": referenceid,
                    "servicerequestnumber":Servicerequestnumber,
                    "metadata":logJson,
                    "isnew":isnew,
                    "isedit":isedit,
                    "isdelete":isdelete
                }
                app.models.Auditlog.createlogdetails(newadd);
                next();
            });
        })
    })
      
    // for add agency audit log ipaddress
    Intakeservicerequestagency.beforeRemote('addagency', function(ctx, data, next) {
                if (ctx.req) {
                     ipaddress = ctx.req.connection.remoteAddress; 
                }
                LOGGER.info(ipaddress);
                next();
        });

  Intakeservicerequestagency.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Intakeservicerequestagency.observe('access', (ctx, next) => util.access(ctx, next));
  Intakeservicerequestagency.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
