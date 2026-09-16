'use strict';
const LOGGER = require("log4js").getLogger("activity");
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Activity) {

    
    const createElement = element =>{
        var description = element.description;
        var objectid = element.objectid;
        var activitytypekey = element.activitytypekey;
         return  Activity.find(
             {where:{description:description,objectid:objectid,
            activitytypekey:activitytypekey}
            })
        .then(res => {
            if(res.length === 0) {
                return Activity.create(element);
            }else{
                 return Promise.resolve('Activity Name Already Exist for '+element.description);
            }
              
        })
    };

     Activity.add = (request, reqctx)=> {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        var activityreq = request.activity;
        if(Array.isArray(activityreq)){
            var prs = activityreq.map(element => createElement(element));
                return Promise.all(prs)
                .then(result => {
                    result.map(data => {
                       if(data.activityid !== undefined){
                                var securityuserid = _securityusersid;
                                var sql = 'select * from createacttaskandactgoal($1,$2,$3)';
                                return util.executeDBQuery(sql, [data.activityid, data.ammappingid, securityuserid])
                                    .catch(err => {
                                        LOGGER.error('>>>>ERROR:', err);
                                        throw err;
                                    });
                            }
                    })
                    }).then(res => {
                        res = data;
                        return res;
                    }).catch(err => err);
                  
    }
    return Promise.resolve([]);
}

    
      /* NOSONAR  
      var ds = server.dataSources.hcuewelfare;
         LOGGER.debug('coming')
         var prs =[]
        var activityreq = request.activity;
      prs.push(Activity.create(activityreq));
         var result = prs.reduce(function(a,b){ return a.concat(b) }, []);
         return Promise.all(result)
        .then(data =>{
            var result = data.reduce(function(a,b){ return a.concat(b) }, []);
            result.forEach(result => {
              var activityid = result.activityid;
              var ammappingid = result.ammappingid;
              var securityuserid = server.currentUser.securityusersid;

              var sql = 'select * from createacttaskandactgoal(\''+activityid+'\',\''+ammappingid+'\',\''+securityuserid+'\')';
              ds.connector.execute(sql, 
                  function(err, data){
                     if(err) return cb(err);
                     LOGGER.error(err);		      			
                     data = data[0].createacttaskandactgoal; 
             });
      
            });

            return result
        }) 

    }*/



    Activity.remoteMethod('add', {
        http: {
                path: '/add',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],   
        returns: {
            type : 'string',
            root : true
        }
    });




    Activity.observe('after save', function (ctx, next) {
        var intakeserviceid,description ,referenceid,Servicerequestnumber,isnew,isedit,isdelete;
        var logJson ={
            "data": {
                "activityname": "",
                "activitytypekey": "",
                "danumber": ""
            }
        }
        var logtypekey = "IPA"; /**/
        description = "'"+ctx.instance.description+"'"+" of "+ctx.instance.activitytypekey+ " activitytypekey, Activity added to DA#";
          if (ctx.isNewInstance) //CREATE
          { 
            intakeserviceid = ctx.instance.objectid;
            referenceid = ctx.instance.activityid;
            isnew = true;
            logJson.data.activityname = ctx.instance.description;
            logJson.data.activitytypekey = ctx.instance.activitytypekey;
            
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
            
            server.models.Auditlog.createlogdetails(newadd);
            next();
          }
        })
    
   
	Activity.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Activity.observe('access', (ctx, next) => util.access(ctx, next));
    Activity.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
    

};
