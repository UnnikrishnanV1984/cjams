'use strict';
const LOGGER = require("log4js").getLogger("publicproviderhomestudyvisit");
var app = require('../../server/server');
const util = require('../utils/utils');
var config = require('../../server/config.json');
var email = require('./email');

module.exports = function (Publicproviderhomestudyvisit) {


  

  Publicproviderhomestudyvisit.remoteMethod('add', {
    http: {
            path: '/add',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}
        ,{
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  }  ],
    returns: {
        type : 'string',
        root : true
    }
});


Publicproviderhomestudyvisit.add = (request,reqctx)=>{
  const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
  var  reshomestudyvistid = null; 
  var persons=request.persons;       
  const prs =[];
 

 
  if(request.home_study_visit_id === null && request.home_study_visit_id === undefined)
  {

  return   app.models.Publicproviderhomestudyvisit.create(
     
      {

        object_id:request.object_id,
        interview_date:request.interview_date, 
        interview_start_time:request.interview_start_time, 
        interview_end_time:request.interview_end_time, 
        duration:request.duration, 
        interview_location:request.interview_location, 
        narrative:request.narrative, 
        islocationhome:request.islocationhome,  
        create_user_id: suserid,
        update_user_id: suserid         


    }
    ).then(data =>{

      reshomestudyvistid = data.home_study_visit_id;

      if(Array.isArray(persons)){
        persons.forEach(persons1 =>{
            prs.push(
                app.models.Publicproviderhomestudyhouseholdmapping.create({

                  home_study_visit_id :reshomestudyvistid, 
                  personid:persons1.personid,      
                  create_user_id: suserid,
                  update_user_id: suserid
                
                })
            )
        });
    }
   return Promise.all(prs);

}).then(data1 => {

  request.securityuserid = suserid;
  var schdappoint1 = 'select * from inserthousevistapplcommunication($1)';
  return util.executeDBQuery(schdappoint1, [request]);
})
.catch(err => {
  LOGGER.error('>>>>ERROR:', err);
  throw err;
})
}else {
    request.securityuserid = suserid;
    var schdappoint = 'select * from updatehomevisitdetails($1,$2)';
    return util.executeDBQuery(schdappoint, [request.home_study_visit_id,request.object_id])
    .then(data => {
        LOGGER.info(data);
        request.home_study_visit_id=null;
        return data;
    })
    .then(data =>{

      return   app.models.Publicproviderhomestudyvisit.create(
     
        {
  
          object_id:request.object_id,
          interview_date:request.interview_date, 
          interview_start_time:request.interview_start_time, 
          interview_end_time:request.interview_end_time, 
          duration:request.duration, 
          interview_location:request.interview_location, 
          narrative:request.narrative, 
          islocationhome:request.islocationhome,  
          create_user_id: suserid,
          update_user_id: suserid         
  
  
      }
      ).then(data3 =>{
  
        reshomestudyvistid = data3.home_study_visit_id;
  
        if(Array.isArray(persons)){
          persons.forEach(persons2 =>{
              prs.push(
                  app.models.Publicproviderhomestudyhouseholdmapping.create({
  
                    home_study_visit_id :reshomestudyvistid, 
                    personid:persons2.personid,
                    create_user_id: suserid,
                    update_user_id: suserid
                  
                  })
              )
          });
      }
     return Promise.all(prs);
  
  }).then(data4 => {
  
    request.securityuserid =  suserid;
    var schdappoint3 = 'select * from inserthousevistapplcommunication($1)';
    return util.executeDBQuery(schdappoint3, [request])
    .then(data5 => {
        return data5;
    })
    .catch(err => {
        LOGGER.error(err);
        return err;
    })
  })

    })
    .catch(err => {
      LOGGER.error(err);
      return err;
    })
    
}

}

  Publicproviderhomestudyvisit.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Publicproviderhomestudyvisit.observe('access', (ctx, next) => util.access(ctx, next));
  Publicproviderhomestudyvisit.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}
