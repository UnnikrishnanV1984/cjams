'use strict';
const LOGGER = require("log4js").getLogger("intakeservicerequestpurpose");
let app = require('../../server/server');
const util = require('../utils/utils');
let email = require('../models/email');

module.exports = function(Intakeservicerequestpurpose) {

    Intakeservicerequestpurpose.list = function(request) {
      let result;
      const IntakeagencypurposeSearchObj = {
             fields: 'intakeservreqtypeid',
            include: {
                relation: 'intakeservicerequesttype',
                scope: {
                    fields: ['intakeservreqtypeid','description','intakeservreqtypekey'],
                    order: 'description',
                    nolimit:true
                }
            }
        
        };

        let teamtypekey = '';
        teamtypekey  = request.where.teamtypekey;
        IntakeagencypurposeSearchObj.where = {teamtypekey: teamtypekey};
        return app.models.Intakeagencypurpose.find(IntakeagencypurposeSearchObj)
        .then(data => {
            result = JSON.parse(JSON.stringify(data));
           
            const prs = result.map(x => {

              return  app.models.Intakeagencyserv.find({
                where:{ intakeservreqtypeid: x.intakeservreqtypeid}
              })
            });
            return Promise.all(prs);
          })
            .then(response=>{
              const data = JSON.parse(JSON.stringify(response));
                var dispositionItems = [];
                for(var i=0; i<data.length; i++) {
                  if(data[i].length > 0){
                    if(result[i].intakeservicerequesttype){
                        result[i].intakeservicerequesttype.isserviceavailable = true;
                    }
                    dispositionItems.push(result[i].intakeservicerequesttype);
                  }
                  else
                  {
                    if(result[i].intakeservicerequesttype)
                    {
                        result[i].intakeservicerequesttype.isserviceavailable = false;
                    }
                  
                    dispositionItems.push(result[i].intakeservicerequesttype);
                  }

                }
                return dispositionItems.filter(value => value !== undefined);
              })

        .catch(err => util.logError(err));
    };

    Intakeservicerequestpurpose.remoteMethod('list', {
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
            type : 'string',
            root : true
        }
    });

    Intakeservicerequestpurpose.sendEmailContact = function(request)
    { 
            var subject='Report For '+request.caseNumber;   
            var htmlheader = '<html><head><style> .table-bordered { border: 1px solid #D8D8D8; border-left-width: 0; border-right-width: 0; } </style></head><body>'
            var htmlfooter = '</body></html>'
            var body=htmlheader+request.body.replace('style="display: none "','')+htmlfooter;
          return Promise.resolve(email.SendEmail(request.email,subject,body ));
    };
        
    Intakeservicerequestpurpose.remoteMethod('sendEmailContact', {
            http: {
                            path: '/sendemailcontact',
                            verb: 'post'
            },
            accepts : [ {arg : 'data',type : 'object',
                    http : {source : 'body'}} ],
            returns: {
                    type : 'string',
                    root : true
            }
    });

    Intakeservicerequestpurpose.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservicerequestpurpose.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservicerequestpurpose.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
