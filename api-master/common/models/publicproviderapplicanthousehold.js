'use strict';
const LOGGER = require("log4js").getLogger("publicproviderapplicanthousehold");
var app = require('../../server/server');
const util = require('../utils/utils');
const loopback = require('loopback');
const ds = loopback.createDataSource('memory');
var config = require('../../server/config.json');
var email = require('../models/email');
var Publicproviderapplicanthouseholdbgchecks = require('./Publicproviderapplicanthouseholdbgchecks');

module.exports = function (Publicproviderapplicanthousehold) {

    Publicproviderapplicanthousehold.remoteMethod('listAll', {
        http:{
            path : '/getAll',
            verb: 'get'
        },
        accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
        },
        returns : {
            type : 'object',
            root : true
        }
    });
    Publicproviderapplicanthousehold.listAll = function(request){
        LOGGER.debug("Get All method being invoked....."+ JSON.stringify(request) + "  "+request.where.object_id)
        return Publicproviderapplicanthousehold.find({
           where:{object_id:request.where.object_id },
           include:{
            relation:'household_member_bg_security_list'
        }
        })
        .catch(err => util.logError(err));

    }

/////////////////////////////////
    Publicproviderapplicanthousehold.remoteMethod('add', {
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
                      } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Publicproviderapplicanthousehold.add = function(request,reqctx)
    {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        var securityusersid = (request && request.securityuserid?request.securityuserid: suserid);
        const bgItems = request.household_member_bg_security_list;
        return Publicproviderapplicanthousehold.create({

            object_id: request.object_id,
            household_member_id: request.household_member_id,
            household_member_first_name : request.household_member_first_name  ,
            household_member_middle_name :  request.household_member_middle_name ,
            household_member_last_name :  request.household_member_last_name ,
            household_member_relation : request.household_member_relation  ,
            household_member_dob : request.household_member_dob,
            household_member_ssn : request.household_member_ssn  ,
            
            household_member_suffix :  request.household_member_suffix ,
            household_member_prefix :  request.household_member_prefix ,
            household_member_race :   request.household_member_race,
            household_member_ethnicity :  request.household_member_ethnicity ,
            household_member_gender :   request.household_member_gender,
            household_member_maritalstatus : request.household_member_maritalstatus  ,
            household_member_relation_coapp :  request.household_member_relation_coapp,
            insertedby : securityusersid,
            updatedby:securityusersid
         })
        .then(data=>{
           // LOGGER.debug("Data is "+ data)
            for(const i in bgItems){
                app.models.Publicproviderapplicanthouseholdbgchecks.create({
                            household_member_id : data.household_member_id,
                            security_answer: bgItems[i].bg_question_value,
                           // clearance_date: bgItems[i].bg_clearance_date,
                            security_question: bgItems[i].bg_question
                
                        })

             return data;
            }
            
        }).catch(err =>{ LOGGER.error(err);util.logError(err)});
    }

/////////////////////////////////////////////////////////////////////////
Publicproviderapplicanthousehold.remoteMethod('updateHouseHold', {
    http: {
        path: '/updateHouseHold/:id',
        verb: 'patch'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}
        ,{
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  } ],
    returns: {
        type : 'string',
        root : true
    }
});

Publicproviderapplicanthousehold.updateHouseHold = function(request,reqctx)
{
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    
    var securityusersid = (request && request.securityuserid?request.securityuserid: suserid);
    const bgItems = request.household_member_bg_security_list;
    return Publicproviderapplicanthousehold.upsert({

        object_id: request.object_id,
        household_member_id: request.household_member_id,
        household_member_first_name : request.household_member_first_name  ,
        household_member_middle_name :  request.household_member_middle_name ,
        household_member_last_name :  request.household_member_last_name ,
        household_member_relation : request.household_member_relation  ,
        household_member_dob : request.household_member_dob,
        household_member_ssn : request.household_member_ssn  ,
        
        household_member_suffix :  request.household_member_suffix ,
        household_member_prefix :  request.household_member_prefix ,
        household_member_race :   request.household_member_race,
        household_member_ethnicity :  request.household_member_ethnicity ,
        household_member_gender :   request.household_member_gender,
        household_member_maritalstatus : request.household_member_maritalstatus  ,
        household_member_relation_coapp :  request.household_member_relation_coapp,
        insertedby : securityusersid
     })
    .then(data=>{
       
        for(const i in bgItems){
                      
            app.models.Publicproviderapplicanthouseholdbgchecks.upsert({
                household_bg_id : bgItems[i].household_bg_id,
                household_member_id : data.household_member_id,
                security_answer: bgItems[i].bg_question_value,
               // clearance_date: bgItems[i].bg_clearance_date,
                security_question: bgItems[i].bg_question
    
            })

         
        }
        return data;
    }).catch(err => util.logError(err));
}
    
////////////////////////////////////////////////////////




    Publicproviderapplicanthousehold.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Publicproviderapplicanthousehold.observe('access', (ctx, next) => util.access(ctx, next));
    Publicproviderapplicanthousehold.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};
