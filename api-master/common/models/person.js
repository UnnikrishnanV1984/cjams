'use strict';

const LOGGER = require("log4js").getLogger("person");
const app = require('../../server/server');
const util = require('../utils/utils');
var SmartyStreets = require('smartystreets-api');
var actordesc ; // Added for audit log
const axios = require('axios');
const dateTime = require('date-time');
var config = require('../../server/config.json');
const commonapi = require('../models/commonapi');

const jsoncontenttype = "application/json";
const loggermsg = '### data full';
const roletypestr = " (Roletype:";


const getpersonsbyservicecasesql = 'SELECT * FROM getpersonsbyservicecase($1, $2, $3)'; 

const withCount = rows => ({
    'data': rows,
    'count': (rows != null && rows.length > 0) ? rows[0].totalcount : 0
});

module.exports = function(Person) {

  /**
   * Get unique MDM Identifier of person
   * 
   * @param   id     string  a persons cjamspid
   * @return  mdmId  string  corresponding mdmId 
   */
  Person.getMdmId = async (id) => {
    const PersonIdentifier = app.models.Personidentifier;

    // get Person by CjamsPID
    const person = await Person.findOne({where: {"cjamspid": id}});
    const personId = person.personid;

    // get PersonIdentifier MDM ID entry
    const personIdentifier = await PersonIdentifier.findOne({where: {
      "personid": personId,
      "personidentifiertypekey": "MDM_ID"
    }});

    if (! personIdentifier) { 
        return null; }
    return personIdentifier.personidentifiervalue;
  }

  

    /** Start Remote Create Record **/
    Person.remoteMethod(
        'create',
        {
        accepts: [{arg: 'data', type: 'object', http: { source: 'body' }}],
        returns: {type: 'object', root: true}
        }
    );

	/** End Remote Create Record **/

	/** Start Remote upsert Record **/
    Person.remoteMethod(
        'upsert',
        {
        accepts: [{arg: 'data', type: 'object', http: { source: 'body' }}],
        returns: {type: 'object', root: true}
        }
    );

    function checkAuthDetails(data) {
        let auth_id = '';
        let auth_token = '';
        const settings = JSON.parse(JSON.stringify(data));
        let arr_settings = [];

        if (settings.length > 0) {
            arr_settings = settings[0].settingvalue.split(';');
            auth_id = arr_settings[0];
            if (arr_settings.length > 1) {
                auth_token = arr_settings[1];
            }
        }
        return {
            auth_id,
            auth_token
        }
    }

  Person.validateaddress = async (data) => {

    let address = data.where;
    let responseObj = { isValidAddress: false };

    if (address.street) {
      const piplsearchQuery = "select settingvalue from settings where settingname = 'smartystreets'";
      return util.executeDBQuery(piplsearchQuery,[])
      .then(result => {
          return result;
      })
        .then(data1 => {
            const auth = checkAuthDetails(data1);
          const auth_id = auth.auth_id;
          const auth_token = auth.auth_token;
          return new Promise((resolve, reject) => {
            var smartyStreets = SmartyStreets(auth_id, auth_token, []);
            smartyStreets.address(address, function (err, _data, raw) {
                if (err) {
                    return reject(err);}
                  resolve(_data);
            });
          });
        }).then(data2 => {

          const result = JSON.parse(JSON.stringify(data2));
          if (result.length > 0) {
            responseObj.data = result;
            if (responseObj.data) {
              return app.models.Addresskeylkup.find({
                fields: ['fieldid', 'fieldname'],
                where: {},
                include: {
                  relation: 'addresskeydetaillkup',
                  scope: {
                    fields: ['keyid', 'fielid', 'keyvalue', 'definition', 'activeflag','status'],
                    where: {}
                  }
                }
              })
                .then(datas => {
                 responseObj = footnotes(datas, responseObj)
                  return responseObj.data
                })
            }
            responseObj.isValidAddress = true;
            return responseObj;
          }
          else{
            return responseObj;}
        })
      .catch(err => {
        util.logError(err)
        LOGGER.error(err)
        return err;
    });
    }
    else{
      return responseObj;}
  };

  function footnotes(datas, responseObj){
    const output = JSON.parse(JSON.stringify(datas));

    output.map(res => {
      //footnotes.push(res.footnotes)
      Object.keys(responseObj.data[0].analysis).forEach(key => {
        if (key === res.fieldname) {
          var tempFootnotes = "";
          res.addresskeydetaillkup.map(value => {

            responseObj = checkValue(value, responseObj, key);
            if(key === 'footnotes'){
                                                                      //SonarQube fix - removed the unused assignment
              responseObj.data[0].analysis[key].split('#')
              .map(x => x.concat('#'))
              .map(tempkey => {
                if(tempkey === value.keyvalue)
                {
                  tempFootnotes += value.definition+"_"+value.status
                  responseObj.data[0].analysis[key] = tempFootnotes;
                }
              })
            }

            return responseObj;

          })
        }
      })

    });
    return responseObj;
  }

  function checkValue(value, responseObj, key){
    if (value.keyvalue === responseObj.data[0].analysis[key]) {
        responseObj.data[0].analysis[key] = value.definition+"_"+value.status;
    }
    return responseObj;
  }

    Person.suggestaddress = data => {

      var suggest = data.where;
      suggest.prefer_ratio = 50;
      suggest.prefer = 'MD';
      suggest.prefer_states = 'MD';

      const piplsearchQuery = "select settingvalue from settings where settingname = 'smartystreets'";

      return util.executeDBQuery(piplsearchQuery, []).then(data4 => {
            let auth_id = '';
            let auth_token = '';
            const settings = JSON.parse(JSON.stringify(data4));
            let arr_settings = [];
            if(settings.length > 0) {
                arr_settings = settings[0].settingvalue.split(';');
                auth_id = arr_settings[0];
                if(arr_settings.length > 1){
                    auth_token = arr_settings[1];}
            }
          return new Promise((resolve, reject) => {
              var smartyStreets = SmartyStreets(auth_id, auth_token, []);
              smartyStreets.suggest(suggest, function (err, data5, raw) {
                  if (err) {
                    return reject(err);}
                  resolve(data5);
              });
          })
        })

      .then(data6 => {
         
          var result = JSON.parse(JSON.stringify(data6));
          if(JSON.stringify(result) === '{}'){
              result = [];
          }
              return result;
      })
      .catch(err => util.logError(err));
  };

Person.postgoldenrecord = (data, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    var securityusersid =(data && data.securityuserid?data.securityuserid: _securityusersid);
    const sql = "SELECT * FROM mdmpersonaddupdate($1,$2)";
    var cjamspid = parseInt(data.sourceKey);
    data.sourceKey=cjamspid;
    return util.executeDBQuery(sql, [JSON.stringify(data),securityusersid])
        .then(result => {
            return {
                navigationFlowRequested : true,
                status: 'Data processed successfully',
                errorId: 1234,
                errorDetail: 'No error',
                message: 'Data processed successfully'
                };
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            // Thrown as an Error so the stack is preserved; the properties the
            // MDM caller expects are kept on it, so the response body is unchanged.
            const error = new Error('Data process failed');
            error.navigationFlowRequested = true;
            error.status = 'Data process failed';
            error.errorId = 1111;
            error.errorDetail = err;
            throw error;
        });
};

  Person.remoteMethod('postgoldenrecord', {
    http: {
            path: '/postgoldenrecord',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
    returns: {
        type : 'object',
        root : true
    }
});

    Person.remoteMethod('validateaddress', {
        http: {
                path: '/validateaddress',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Person.remoteMethod('suggestaddress', {
      http: {
              path: '/suggestaddress',
              verb: 'post'
      },
      accepts : [ {arg : 'data',type : 'object',
          http : {source : 'body'}} ],
      returns: {
          type : 'object',
          root : true
      }
  });

    Person.updatebasicinfo = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        const personid = request.personid;
        var securityusersid =(request && request.securityuserid?request.securityuserid: _securityusersid);
        const sql = 'select * from personupdatebasicinfo($1, $2, $3, $4)';
        return util.executeDBQuery(sql, [personid, request, null, securityusersid])
        .then(data => {
            if(data.length > 0){
                return data[0].personupdatebasicinfo;
            }else {return ""}
        })
        .catch(err => util.logError(err));
    };

    Person.remoteMethod('updatebasicinfo', {
        http: {
                path: '/updatebasicinfo',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Person.add = (request, reqctx) => {
        const v_securityusersid = util.getSecurityDetails(request, reqctx).v_securityuserid;
        const people = request.People;                                              //SonarQube fix - removed the unused assignent
        if(people.personid === undefined){
    	var prs = [];

        var record;
        let personId="";
        let gperson ={};

    	return app.models.Person.create(people)
	      .then(person=>{
	    	  gperson = person
              personId = person.personid;
              
                prs = createPersonidentifier(people, personId, v_securityusersid, prs);
                     const personrole = request.Personrole;

            prs = createPersonDetails(request, personId, prs, v_securityusersid);
            prs.reduce(function(a,b){ 
                return a.concat(b) }, []);        //SonarQube fix - removed this unused assignent

    	      return Promise.all(prs)
    	      .then(result=>{
                  LOGGER.debug(result + "result");
                  var actorid  = result[0].actorid;
                  var prsint = [];

                 for (const element of personrole)
                 {
                        prsint.push( app.models.Intakeservicerequestactor.create({
                            intakeserviceid:people.intakeserviceid,
                            actorid:actorid,
                            intakeservicerequestpersontypekey:element.rolekey,
                            ramentalhealth:people.ramentalhealth,
                            ramentalretarted:people.ramentalretarted,
                            isprimary:false,
                            insertedby: v_securityusersid,
                            updatedby: v_securityusersid  
                        }));
                 }

    	    	var intact = prsint.reduce(function(a,b){ 
                    return a.concat(b) }, []);

    	    		return Promise.all(intact)
    	    		.then(reqactor=>{

    	    			prsint = createActorRelation(reqactor, request, prsint, v_securityusersid);

        	      const Personaddresses = request.Personaddresses;

        	      if(Array.isArray(Personaddresses)){
        	    	  Personaddresses.forEach(Personaddresses1=>Personaddresses1.personid=personId);
            	      prs.push(
            	    		  Personaddresses.map(newpersonaddresses => app.models.Personaddress.create(newpersonaddresses))
            	      );
        	      }

        	      prs = createPersonPhone(request,personId,prs);

        	      var flatPrs = prs.reduce(function(a,b){ 
                    return a.concat(b) }, []);

          	     return Promise.all(flatPrs)

    	    		})

    	      })
    	      .then(data => {
                  record = data;
                  if(people.role !== undefined){

                    var actor = data[0];
                    var actor_id = actor.actorid;
                    var actortype = actor.actortype;
                   var is_primary = true;
                     return  app.models.Intakeservicerequestactor.create({
                      intakeserviceid:people.intakeserviceid,
                      actorid:actor_id,
                      intakeservicerequestpersontypekey:actortype,
                      ramentalhealth:people.ramentalhealth,
                      ramentalretarted:people.ramentalretarted,
                      isprimary:is_primary
                  }).then(resactrelation=>{
                      LOGGER.debug(resactrelation +"resactrelation")
                      var intakeservicerequestactorid = resactrelation.intakeservicerequestactorid
                      return app.models.Actorrelationship.create({
                          intakeservicerequestactorid:intakeservicerequestactorid,
                          relationshiptypekey:people.relationshiptorA,
                          insertedby: v_securityusersid,
                          updatedby: v_securityusersid  
                      })
                  })
                  }
        }).then(resp =>{
            const returnData = {};
            returnData.person = gperson;
            returnData.data = record;
            return returnData
            })
            .catch(err =>err);
        })
    }

        return Promise.resolve('Invalid request');
    }

    function createPersonPhone(request,personId,prs) {
        const Personphonenumber = request.Personphonenumber;
        if (Array.isArray(Personphonenumber)) {
            Personphonenumber.forEach(Personphonenumber1 => Personphonenumber1.personid = personId);
            prs.push(
                Personphonenumber.map(newpersonphonenumber => app.models.Personphonenumber.create(newpersonphonenumber))
            );
        }
        return prs;
    }

    function createPersonidentifier(people, personId, v_securityusersid, prs) {
        if (people.role !== undefined) {

            const actor = people.role;

            prs.push(app.models.Actor.create({
                personid: personId,
                actortype: actor,
                ismentalillness: people.ismentalillness,
                mentalillnessdetail: people.mentalillnessdetail,
                ismentalimpair: people.ismentalimpair,
                mentalimpairdetail: people.mentalimpairdetail,
                ramentalhealth: people.ramentalhealth,
                ramentalretarted: people.ramentalretarted,
                insertedby: v_securityusersid,
                updatedby: v_securityusersid
            }))
        }

        if (people.ssn !== undefined && people.ssn !== null) {

            const personidentifierssn = people.ssn;

            prs.push(app.models.Personidentifier.create({
                personid: personId,
                personidentifiertypekey: "SSN",
                personidentifiervalue: personidentifierssn,
                insertedby: v_securityusersid,
                updatedby: v_securityusersid
            })
            );
        }

        if (people.dcn !== undefined && people.dcn !== null) {

            const personidentifierdcn = people.dcn;

            prs.push(app.models.Personidentifier.create({
                personid: personId,
                personidentifiertypekey: "DCN",
                personidentifiervalue: personidentifierdcn,
                insertedby: v_securityusersid,
                updatedby: v_securityusersid
            })
            );
        }

        if (people.alias !== undefined && people.alias !== null) {

            const alias = people.alias;

            prs.push(app.models.Alias.create({
                personid: personId,
                firstname: alias,
                insertedby: v_securityusersid,
                updatedby: v_securityusersid
            })
            );
        }
        return prs;
    }

    function createActorRelation(reqactor, request, prsint, v_securityusersid) {
        var intactor = reqactor.reduce(function (a,b) {
            return a.concat(b)
        },[]);
        var actorrelation = request.Personrole;

        if (Array.isArray(actorrelation)) {
            for (const elements of intactor) {
                actorrelation.intakeservicerequestactorid = elements.intakeservicerequestactorid;
                for (const element of actorrelation) {
                    actorrelation.relationshipkey = element.relationshipkey;
                    prsint.push(app.models.Actorrelationship.create({
                        intakeservicerequestactorid: actorrelation.intakeservicerequestactorid,
                        relationshiptypekey: actorrelation.relationshipkey,
                        insertedby: v_securityusersid,
                        updatedby: v_securityusersid
                    }));
                }
            }
        }
        return prsint;
    }

    function createPersonDetails(request, personId, prs, v_securityusersid) {
        const Email = request.Personemail;
        if (Array.isArray(Email)) {

            Email.forEach(Email1 => Email1.personid = personId);

            prs.push(Email.map(newemail => app.models.Personemail.create({
                personid: personId,
                personemailtypekey: newemail.personemailtypekey,
                email: newemail.email,
                insertedby: v_securityusersid,
                updatedby: v_securityusersid
            })));
        }
        const School = request.School;

        if (Array.isArray(School)) {

            School.forEach(School1 => School1.personid = personId);

            prs.push(School.map(newschool => app.models.Personeducation.create(newschool)));
        }

        const Personeducationtesting = request.Testing;

        if (Array.isArray(Personeducationtesting)) {

            Personeducationtesting.forEach(Personeducationtesting1 => Personeducationtesting1.personid = personId);

            prs.push(Personeducationtesting.map(newtesting => app.models.Personeducationtesting.create(newtesting)));
        }

        const Personaccomplishment = request.Accomplishment;

        if (Array.isArray(Personaccomplishment)) {

            Personaccomplishment.forEach(Personaccomplishment1 => Personaccomplishment1.personid = personId);

            prs.push(Personaccomplishment.map(newaccomplishment => app.models.Personaccomplishment.create(newaccomplishment)));
        }

        const Personeducationvocation = request.Vocation;

        if (Array.isArray(Personeducationvocation)) {

            Personeducationvocation.forEach(Personeducationvocation1 => Personeducationvocation1.personid = personId);

            prs.push(Personeducationvocation.map(newvocation => app.models.Personeducationvocation.create(newvocation)));
        }
        return prs;
    }


    Person.remoteMethod('add', {
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
            type : 'object',
            root : true
        }
    });


    Person.addperson =(request) =>{
    const people = request.People;
    var prs = [];
    let personId="";
    let getperson ={};
    if(people.personid === undefined){
    	return app.models.Person.create(people)
	      .then(person=>{
	    	  getperson = person
	       personId = person.personid;
	    	  LOGGER.debug(personId);

               const personidentifier =request.Personidentifier;
               if(Array.isArray(personidentifier)){
                    personidentifier.forEach(personidentifier2=>personidentifier2.personid=personId);
                     prs.push(
                             personidentifier.map(newpersonidentifier => app.models.Personidentifier.create(newpersonidentifier))
                     );
               }


               const Personaddresses = request.Personaddresses;

               if(Array.isArray(Personaddresses)){
                   Personaddresses.forEach(Personaddresses2=>Personaddresses2.personid=personId);
                   prs.push(
                           Personaddresses.map(newpersonaddresses => app.models.Personaddress.create(newpersonaddresses))
                   );
               }

               const Personphonenumber = request.Personphonenumber;

        	      if(Array.isArray(Personphonenumber)){
        	    	   Personphonenumber.forEach(Personphonenumber2=>Personphonenumber2.personid=personId);

             	      prs.push(
             	    		  Personphonenumber.map(newpersonphonenumber => app.models.Personphonenumber.create(newpersonphonenumber))
             	      );
        	      }
            const alias =request.Alias;
            if(Array.isArray(alias)){
                alias.forEach(alias2 => alias2.personid = personId);

                prs.push(
                        alias.map(newAlias => app.models.Alias.create(newAlias))
                );
            }



            var flatPrs = prs.reduce(function(a,b){ 
                return a.concat(b) }, []);

            return Promise.all(flatPrs)
 }) .then(data => {
    const returnData = {};
    returnData.person = getperson;
    returnData.data = data;
    return returnData
    })
    .catch(err =>err);

   }
    return Promise.resolve('Invalid request');
}

Person.remoteMethod('addperson', {
    http: {
            path: '/addperson',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} ],
    returns: {
        type : 'object',
        root : true
    }
});
 
Person.logpersonmdm =(request,requestid, payloadtype) =>{
    var values = [];
    var query ='';
    if (request.hasOwnProperty('mdmId')) {
        query = 'insert into mdmlog (requestid,typeofpayload,payload,mdmid,insertedby,updatedby) values ($1,$2,$3,$4,$5,$6)';
        values = [requestid,payloadtype,request,request.mdmId,'MDM log','MDM log'];
    }
    else{
        query = 'insert into mdmlog (requestid,typeofpayload,payload,insertedby,updatedby) values ($1,$2,$3,$4,$5)';
        values = [requestid,payloadtype,request,'MDM log','MDM log'];
    }
   return util.executeDBQuery(query, values)
    .then(result => {
        LOGGER.debug(result);
        return result;
    })
    .catch(err => util.logError(err));
}


Person.addPersonToMDM = (request, _securityusersid, mdmType) =>{ //NOSONAR
    
   
    const requestToMdm = request[0];
    const personIdToMDM = request[0].personid;
    const newflag = request[0].newflag ? request[0].newflag : false;
    const suid = _securityusersid ? _securityusersid : 'user';
    delete requestToMdm.personid;
    delete requestToMdm.newflag;
    var Final = requestToMdm.requestId;
    LOGGER.debug("Final Value",Final);
    var options = {
        url: config.integrationConfig.urlMDM,
       // json: true,
        headers: {"Content-Type": jsoncontenttype,
                  "Authorization": app.get('apiKeys').postmdm_config_bearer_token},
        body: JSON.stringify(requestToMdm),
      };
      LOGGER.debug(options);
      Person.logpersonmdm(requestToMdm, Final, 'request');
      const externalapidata4 = {}; 
      externalapidata4.details =  {
        objectid: personIdToMDM,
        objecttype: mdmType || 'mdm_addupdate',
        updatedby: suid,
        insertedby: suid
      }
      externalapidata4.resstatus = '';
      externalapidata4.request = requestToMdm;
      externalapidata4.response = null;
      externalapidata4.status = 'add';
      var v_externalapilogsid = null;  
      if(config.integrationConfig.enableMDM) {   
        commonapi.addupdateexternalapilogs(externalapidata4).then(data1 => {
            v_externalapilogsid = data1;   
            return new Promise((resolve, reject) => {
                axios.post(options.url, options.body, {
                    headers: options.headers
                })
                .then((res) => {
                    const datajson = res.data; 
                    if (datajson.returnStatus != '10' && datajson.returnStatus != '14' && datajson.returnStatus != '15') {
                        Person.logpersonmdm(datajson, Final, 'response');
                        const externalapidata6 = {};
                        externalapidata6.details =  {
                            externalapilogsid: v_externalapilogsid,
                            objecttype: mdmType || 'mdm_addupdate',
                            updatedby: suid,
                            insertedby: suid,                                        }

                        externalapidata6.info = null;
                        externalapidata6.status = 'update';
                        externalapidata6.resstatus = 'error';
                        externalapidata6.response = datajson;
                        commonapi.addupdateexternalapilogs(externalapidata6);
                        reject(res.status);
                    } else {
                        Person.logpersonmdm(res.data, Final, 'response');
                        LOGGER.debug(loggermsg, datajson);
                        const externalapidata7 = {};
                        externalapidata7.details =  {
                            externalapilogsid: v_externalapilogsid,
                            objecttype: mdmType || 'mdm_addupdate',
                            updatedby: suid,
                            insertedby: suid,                                        }

                        externalapidata7.info = null;
                        externalapidata7.status = 'update';
                        externalapidata7.resstatus = 'success';
                        externalapidata7.response = datajson;
                        commonapi.addupdateexternalapilogs(externalapidata7);
                        resolve(datajson);
                    }
                })
                .catch((err) => {
                    const externalapidata6 = {};
                    externalapidata6.details =  {
                        externalapilogsid: v_externalapilogsid,
                        objecttype: mdmType || 'mdm_addupdate',
                        updatedby: suid,
                        insertedby: suid
                    }

                    externalapidata6.info = null;
                    externalapidata6.status = 'update';
                    externalapidata6.resstatus = 'error';
                    if(err.response) {
                        Person.logpersonmdm(err.response, Final, 'response');
                        externalapidata6.response = err.response;
                        commonapi.addupdateexternalapilogs(externalapidata6);
                        reject(err.response.status);
                    } else {
                        Person.logpersonmdm(err, Final, 'response');
                        externalapidata6.resstatus = 'error';
                        externalapidata6.response = err;
                        commonapi.addupdateexternalapilogs(externalapidata6);
                        reject(err);
                    }
                });
            })
            .then(data => { LOGGER.debug(loggermsg, data);
                var securityuserid =_securityusersid;
                var sql = "select * from sp_save_update_mdm_id($1,$2,$3,$4,$5::character varying)";
                util.executeDBQuery(sql,[personIdToMDM,data.mdmId,securityuserid, newflag, data.returnStatus])
                .then(result => {
                    LOGGER.info(result);
                    return data;
                })
                .catch(err => {
                    LOGGER.error('sp_save_update_mdm_id',err)
                    return err;
                })
            })
            .catch(err => util.logError(err));
        });
      } else {
          return "MDM is not configured"
      }
}

    Person.addpersonmdm = (request,reqctx) => {
        const _securityusersid = util.getSecurityDetails(request,reqctx).securityuserid;
        const requestToMdm = request;
        var datetime = dateTime();
        var dateandtimeArray = datetime.split(" ",2);
        var time = dateandtimeArray[1];
        var timeArray = time.split(":",3);
        var finaltime = timeArray.join('');
        var Final = finaltime.toString();
        LOGGER.debug(Final);
        request.Dob = request.Dob.replace('/','-');
        request.Dob = request.Dob.replace('/','-');
        request = checkRequest(request);

        const cjamsAddress = getcjamsAddress(request);
        const cjamsMail = getcjamsMail(request);
        const cjamsPhone = getcjamsPhone(request);
        const fullname = getFullName(request);

        LOGGER.info(cjamsAddress, cjamsMail, cjamsPhone, fullname);

        var options = {
            url: config.integrationConfig.urlMDM,
            // json: true,
            headers: {
                "Content-Type": jsoncontenttype,
                "Authorization": "Bearer 829a2ad1-9941-3a0d-b767-48378643a56a"
            },
            body: JSON.stringify(requestToMdm),
        };
        LOGGER.debug(options);
        Person.logpersonmdm(requestToMdm,Final,'request');
        if (config.integrationConfig.enableMDM) {
            return new Promise((resolve,reject) => {
                axios.post(options.url, options.body, {
                    headers: options.headers
                })
                .then((res) => {
                    resolve(res.data);
                })
                .catch((err) => {
                    if(err.response) {
                        reject(err.response.status);
                    } else {
                        reject(err);
                    }
                    err.code = err.code || 'REQUEST_ERROR';
                    return reject(err);
                });
            })
                .then(data => {
                    LOGGER.debug(loggermsg,data);
                    Person.logpersonmdm(data,Final,'response');
                    var securityuserid = _securityusersid;
                    if (data.mdmId) {
                        var sql = "select * from sp_save_update_mdm_id($1,$2,$3,$4,$5)";
                        util.executeDBQuery(sql,[personids.Personid,data.mdmId,securityuserid,false,null])
                            .then(data6 => {
                                LOGGER.info(data6);
                                return data6;
                            })
                            .catch(err => {
                                LOGGER.error(err);
                                throw err;
                            })
                    }
                })
                .catch(err => util.logError(err));
        } else {
            // Resolved promise so every path of this function returns a promise.
            return Promise.resolve("MDM is not configured");
        }
    }

    function checkRequest(request){
        if (request.Gender === 'TG' || request.Gender === 'TGIF' || request.Gender === 'TGIM') {
            request.Gender = 'O';
        }
        request.dateofdeath = checkDate(request.dateofdeath);
        
        if (request.maritalstatustypekey) {
            switch (request.maritalstatustypekey) {
                case 'D':
                    request.maritalstatustypekey = 'DV';
                    break;
                case 'M':
                    request.maritalstatustypekey = 'MR';
                    break;
                case '1570':
                    request.maritalstatustypekey = 'LS';
                    break;
                case 'S':
                    request.maritalstatustypekey = 'SG';
                    break;
                case 'U':
                    request.maritalstatustypekey = 'UK';
                    break;
                case 'W':
                    request.maritalstatustypekey = 'WD';
                    break;
            }
        }
        if (request.Race) {
            switch (request.Race) {
                case '1002-5':
                case '3005':
                    request.Race = 'AI';
                    break;
                case '2028-9':
                    request.Race = 'AS';
                    break;
                case '2054-5':
                    request.Race = 'BA';
                    break;
                case '2076-8':
                    request.Race = 'PI';
                    break;
                case '2106-3':
                    request.Race = 'WH';
                    break;
                case '2008-9':
                    request.Race = 'UN';
                    break;
                case '3004':
                    request.Race = 'DC';
                    break;
            }
        }
        if (request.Ethicity && request.Ethicity === 'N') {
            request.Ethicity = 'X';
        }
        if (request.SSN === '') {
            request.SSN = null;
        }
        if (request.suffix === '') {
            request.suffix = null;
        }
        return request;
    }

    function getFullName(request){
        var fullname;
        if (request.Middlename === null || request.Middlename === '') {
            fullname = request.Firstname + ' ' + request.Lastname;
        }
        else {
            fullname = request.Firstname + ' ' + request.Middlename + ' ' + request.Lastname;
        }
        return fullname;
    }

    function getcjamsPhone(request){
        var cjamsPhone = [];
        if (request.contacts && request.contacts.length > 0) {
            for (const element of request.contacts) {
                switch (element.contacttype) {
                    case '1664':
                    case '1667':
                        element.contacttype = 'PERSNL';
                        break;
                    case '1672':
                    case '1663':
                        element.contacttype = 'BSNS';
                        break;
                    default:
                        element.contacttype = '';
                }
                if (element.contacttype !== '') {
                    cjamsPhone.push({
                        "phoneType": element.contacttype,
                        "phoneNumber": element.contactnumber
                    });
                }
            }
        }
        else if (request.contacts && (request.contacts.length <= 0 || cjamsPhone.length <= 0)) {
            cjamsPhone = null;
        }
        return cjamsPhone;
    }

    function getcjamsMail(request){
        let cjamsMail = [];
        if (request.contactsmail && request.contactsmail.length > 0) {
            for (const element of request.contactsmail) {
                if (element.mailtype === 'P') {
                    element.mailtype = 'PERSNL';
                } else if (element.mailtype === 'S') {
                    element.mailtype = 'BSNS';
                } else {
                    element.mailtype = '';
                }
                if (element.mailtype !== '') {
                    cjamsMail.push({
                        "emailType": element.mailtype,
                        "emailAddress": element.mailid
                    });
                }
            }
        }
        else if (request.contactsmail && (request.contactsmail.length <= 0 || cjamsMail.length <= 0)) {
            cjamsMail = null;
        }
        return cjamsMail;
    }

    function getcjamsAddress(request){
        let cjamsAddress = [];
        if (request.address && request.address.length > 0) {
            for (const element of request.address) {
                if (element.addresstype === '36') {
                    element.addresstype = 'MAI';
                } else if (element.addresstype === '39') {
                    element.addresstype = 'RES';
                    // else if(request.address[i].addresstype === '3359')
                    // request.address[i].addresstype = 'WORK';
                } else {
                    element.addresstype = '';
                }
                element.startDate = checkDate(element.startDate);
                element.endDate = checkDate(element.endDate);
    if (element.addresstype !== '') {
                    cjamsAddress.push({
                        "addressType": element.addresstype,
                        "addressLine1": element.address1,
                        "addressLine2": element.Address2,
                        "addressCity": element.city,
                        "addressState": element.state,
                        "addressCounty": element.county,
                        "addressZip": element.zipcode,
                        "addressCountry": "USA",
                        "addressEffectiveBeginDate": element.startDate,
                        "addressEffectiveEndDate": element.endDate
                    });
                }
            }
        }
        else if (request.address && (request.address.length <= 0 || cjamsAddress.length <= 0)) {
            cjamsAddress = null;
        }
        return cjamsAddress;
    }

    function  checkDate(dt){
        if (dt) {
            dt = dt.replace('/','-');
            dt = dt.replace('/','-');
        }
        else if (!dt) {
            dt = "";
        }
        return dt;
    }

Person.remoteMethod('addpersonmdm', {
    http: {
            path: '/addpersonmdm',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
    returns: {
        type : 'object',
        root : true
    }
});

Person.deleteperson = id => {
    var prs=[];
    prs.push(Person.updateAll({personid: id}, {activeflag: 0}));
    prs.push(app.models.Personidentifier.updateAll({personid: id}, {activeflag: 0}));
    prs.push(app.models.Personaddress.updateAll({personid: id}, {activeflag: 0}))
    prs.push(app.models.Personphonenumber.updateAll({personid: id}, {activeflag: 0}))
    return Promise.all(prs).then(data => data).catch(err => err);
};




Person.remoteMethod(
    'deleteperson',
        {
            http: {
                    path: '/deleteperson/:id',
                    verb: 'delete'
            },
            accepts : [ {
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        } ],

        returns: {
            type : 'object',
            root : true
        }

});


Person.updatepersondtl =(request) =>{
const people = request.People;
let prs = [];

let getperson ={};
if(people.personid !== undefined){
    return app.models.Person.upsert(
        {
             personid:people.personid,
            dangerlevel: people.dangerlevel,
            dangerreason:  people.dangerreason,
            dob: people.dob,
            ethnicgrouptypekey: people.ethnicgrouptypekey,
            firstname: people.firstname,
            firstnamesoundex:people.firstnamesoundex,
            gendertypekey: people.gendertypekey,
            incometypekey: people.incometypekey,
            interpreterrequired: people.interpreterrequired,
            lastname: people.lastname,
            lastnamesoundex: people.lastnamesoundex,
            maritalstatustypekey:people.maritalstatustypekey,
            middlename: people.middlename,
            nameSuffix: people.nameSuffix,
           primarylanguageid: people.primarylanguageid,
            racetypekey:people.racetypekey,
            secondarylanguageid:people.secondarylanguageid,
        })
        .then(data => {
            getperson = data;
          const person = data.personid;

          
          prs = upsertpersonidentifier(request,prs);
          prs = upsertPersonaddresses(request, prs);

   
            const Personphonenumber = request.Personphonenumber;
            if (Personphonenumber.length > 0 && Array.isArray(Personphonenumber)) {
                Personphonenumber.forEach(Personphonenumber3 => Personphonenumber3.personid = person);
                prs.push(
                    Personphonenumber.map(newpersonphonenumber => {

                        if (newpersonphonenumber.personphonenumberid !== null
                            && newpersonphonenumber.personphonenumberid !== undefined) {
                            return app.models.Personphonenumber.upsert(
                                {
                                    personphonenumberid: newpersonphonenumber.personphonenumberid,
                                    personphonetypekey: newpersonphonenumber.personphonetypekey,
                                    phonenumber: newpersonphonenumber.phonenumber,
                                    phoneextension: newpersonphonenumber.phoneextension

                                })
                        }
                    })
                );
            }
   var flatPrs = prs.reduce((a,b) => a.concat(b), []);
   return Promise.all(flatPrs)

  }).then (data => {
    const returndata = {};
    returndata.data = data;
    returndata.person = getperson;
    return  returndata;
  })
  .catch(err => err)
 }
    return Promise.resolve('Invalid request');
}

    function upsertPersonaddresses(request,prs) {
        const Personaddresses = request.Personaddresses;
        LOGGER.debug(Personaddresses + "Personaddresses");
        if (Personaddresses.length > 0 && Array.isArray(Personaddresses)) {
            Personaddresses.forEach(Personaddresses3 => Personaddresses3.personid = person);
            prs.push(
                Personaddresses.map(newpersonaddresses => {
                    LOGGER.debug(newpersonaddresses + "newpersonaddresses");
                    if (newpersonaddresses.personaddressid !== null
                        && newpersonaddresses.personaddressid !== undefined) {
                        return app.models.Personaddress.upsert(
                            {
                                personaddressid: newpersonaddresses.personaddressid,
                                personaddresstypekey: newpersonaddresses.personaddresstypekey,
                                address: newpersonaddresses.address,
                                zipcode: newpersonaddresses.zipcode,
                                city: newpersonaddresses.city,
                                state: newpersonaddresses.state,
                                country: newpersonaddresses.country,
                                county: newpersonaddresses.county,
                                address2: newpersonaddresses.address2,
                                directions: newpersonaddresses.directions,
                                danger: newpersonaddresses.danger,
                                dangerreason: newpersonaddresses.dangerreason
                            })
                    }
                })
            );
        }
        return prs;
    }

    function upsertpersonidentifier(request,prs) {
        const personidentifier = request.Personidentifier;
        LOGGER.debug(personidentifier + "personidentifier");
        if (personidentifier.length > 0 && Array.isArray(personidentifier)) {
            personidentifier.forEach(personidentifier4 => personidentifier4.personid = person);
            prs.push(
                personidentifier.map(newpersonidentifier => {
                    if (newpersonidentifier.personidentifierid !== null
                        && newpersonidentifier.personidentifierid !== undefined) {
                        return app.models.Personidentifier.upsert(
                            {
                                personidentifierid: newpersonidentifier.personidentifierid,
                                personidentifiertypekey: newpersonidentifier.personidentifiertypekey,
                                personidentifiervalue: newpersonidentifier.personidentifiervalue,
                            })
                    }
                })
            );
        }
        return prs;
    }



    Person.remoteMethod('updatepersondtl', {
        http: {
                path: '/updatepersondtl',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });





Person.updateperson = (id,request) => {
        var UpdatePersonQuery = 'select * from updatepersondtls($1)';
        LOGGER.debug(UpdatePersonQuery + "UpdatePersonQuery");
        return util.executeDBQuery(UpdatePersonQuery,[JSON.stringify(request)])
    .then(data => {
        return data[0].updatepersondtls;
    })
    .catch(err => err);
}
    Person.remoteMethod('updateperson', {
        accepts : [{
                arg: 'id',
                type: 'string',
                required: true,
                http: {source: 'path'}
            },
            {
                arg: 'data',
                type: 'Object',
                required: false,
                http: {source: 'body'}
            }
        ],
        http: {"verb": "patch", "path": "/updateperson/:id"},
        returns : {
            type : 'Object',
            root : true
        }
    });

	/** End Remote Create Record **/
    /*Getting Whole PersonDetails for Case worker Edit*/
    Person.getwholepersondetials = (id,data) =>{
        var FinalResponse = {};
        var req_intakeserviceid = '00000000-0000-0000-0000-000000000000';

        var actordata ;
        if(data !== undefined){
            req_intakeserviceid = data.where.intakeserviceid;
        }

        return Person.findById(id,{
            include: [{
                relation: "personaddress",
                scope:{
                  include :{
                    relation:  "Personaddresstype",
                    scope:{
                        fields:['typedescription','personaddresstypekey']
                    }
                  }
               }
            },{
                relation: "personphonenumber",
                scope:{
                    include:{
                        relation:"personphonetype",
                        scope:{
                            fields:['typedescription','personphonetypekey']
                        }
                    }
                }
            },{
                 relation: "personidentifier",
                   scope:{
                   include:{
                    relation: "personidentifiertype",
                    scope:{
                     fields:['typedescription','personidentifiertypekey']
                 }
                   }


                }
             },{
                relation: "alias"
            },{
                relation: "actor"
             },
             {
                 relation: "personeducation",
                 scope:{
                       include:{
                           relation:'educationtype',
                           scope:{
                            fields:['typedescription','educationtypekey']
                           }

                       }
                 }
                 },
                 {
                 relation: "personrole"
                 },
                 {
                 relation: "personeducationvocation"
                 },

                 {
                 relation: "personeducationtesting",
                 scope:{
                    include:{
                        relation:'testingtype',
                        scope:{
                            fields:['typedescription','testingtypekey']
                        }
                    }
                 }
                 },
                 {
                relation: "personaccomplishment",
                scope:{
                    include:{
                        relation:'highestgrade',
                        scope:{
                            fields:['typedescription','highergradetypekey']
                        }

                    }
                }
                },
                
                {
                    relation: "personemail",
                    scope:{
                        include:{
                            relation :"Personemailtype",
                            scope:{
                                fields:['typedescription','personemailtypekey']
                            }
                        }
                    }
                },
               
               
            ]
        })
        .then(res1 => {
                FinalResponse.personbasicdetails = res1;

            return app.models.Actor.findOne({
                where:{
                    personid:id
                },
                fields:['actorid','actortype','ismentalillness',
                'mentalillnessdetail','ismentalimpair','mentalimpairdetail',
                'iscollateralcontact','ishousehold','intakeserviceid']
             }).then(res =>{
                   actordata =res;
                 var actor_id = res.actorid
                 return app.models.Intakeservicerequestactor.find({
                    where:{and:[{
                        intakeserviceid:req_intakeserviceid,
                        actorid:actor_id
                    }]},
                    fields:['intakeservicerequestactorid','intakeservicerequestpersontypekey','isprimary'],

                    include:{
                        relation: "actorrelationship",
                        scope: {
                                   fields: ['intakeservicerequestactorid','relationshiptypekey'],
                        }
                    }
                 })
             })

    }).then(res2 => {
                var routingAddressid = null;
               if(res2 !== null){

                var returnactor ={"actor":{}};

                returnactor.actor.actorid =actordata.actorid;
                returnactor.actor.intakeserviceid = actordata.intakeserviceid;
                returnactor.actor.actortype =actordata.actortype;
                returnactor.actor.ismentalillness =actordata.ismentalillness;
                returnactor.actor.mentalillnessdetail =actordata.mentalillnessdetail;
                returnactor.actor.ismentalimpair =actordata.ismentalimpair;
                returnactor.actor.mentalimpairdetail =actordata.mentalimpairdetail;
                
                returnactor.actor.intakeservicerequestactor = JSON.parse(JSON.stringify(res2));

                FinalResponse.personroledetails = returnactor;
                if(res2.length > 0){
                    routingAddressid = res2[0].routingaddressid;
                }
             }
                var personAddressArray = [];
                var tempJSONconvert =JSON.parse(JSON.stringify(FinalResponse.personbasicdetails));
                personAddressArray = tempJSONconvert.personaddress;

                /*For Appending Routing Address Flag to PersonAddress Array */
                personAddressArray.forEach(
                    addressArr=>{
                            addressArr.routingAddressidflag = "0";
                           if(addressArr.personaddressid === routingAddressid )
                           {
                               addressArr.routingAddressidflag = "1";
                           }/* else
                           {
                               addressArr.routingAddressidflag = "0";
                           } */
                /*For converting danger flag from true/false to 0/1 as needed by front-end*/
                            addressArr.danger = "0";
                           if(addressArr.danger === true){
                               addressArr.danger = "1";
                           }/* else if(addressArr.danger == false){
                               addressArr.danger = "0";
                           } */
                    }
                );
                tempJSONconvert.personaddress = personAddressArray;
                FinalResponse.personbasicdetails = tempJSONconvert;
                return FinalResponse;
           })
        .catch(err => err)
    };
    Person.afterRemote('getwholepersondetials', function(ctx, data, next) {
        if (ctx.result) {
            ctx.result = {
                'data' : data
            };
        }
        next();
    });
    Person.remoteMethod('getwholepersondetials', {
        http: {
            path: '/getwholepersondetials/:id',
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
    /*End*/
    Person.logdetailedsearch = (type, payload,suserid) => {

        var d = new Date();
        var final = d.getTime();
        var sql = `insert into sdrlog (servicetype, requestid, typeofpayload, payload,activeflag,insertedby,insertedon,updatedby,updatedon)
                                    values ('detailed search log',$1,$2,$3,1,$4,now(),$4,now())`;
        return util.executeDBQuery(sql, [final, type, payload, suserid]).then(data => {
            return data;
        }).catch(err => util.logError(err));

      };

    Person.getpersonprograms = (id,reqctx) => {
         if ( id == null || id == undefined || id ==''|| id =='null'){
           return  Promise.resolve([])
        }
        
        let suserid=undefined;
        if(reqctx && reqctx.req &&reqctx.req.headers){
            suserid=reqctx.req.headers.securityusersid
        }
        const requestbody = {
                "es_mdmId" : id,
                "es_section" : "program",
                "es_sourceSystem" : "CJAMS"
            };
        var options = {
            url: config.personSearchConfig.detailedSearch,
            json: true,
            body: requestbody,
            headers: {
              //  Authorization: config.personSearchConfig.authorization,
                cookie: config.personSearchConfig.cookie,
                role: config.personSearchConfig.role,
                uid: config.personSearchConfig.uid,
                'content-type': jsoncontenttype 
            }
          };
          let externalapidata = {};   
          externalapidata.details =  {
            objectid: id,
            objecttype: 'programassignment_view',
            objectsubtype: null,
            updatedby: suserid,
            insertedby: suserid
          }
          externalapidata.resstatus = '';
          externalapidata.request = requestbody;
          externalapidata.response = null;
          externalapidata.status = 'add';
          var v_externalapilogsid = null;
          Person.logdetailedsearch('request', options,suserid);
          commonapi.addupdateexternalapilogs(externalapidata).then(data => {
            v_externalapilogsid = data;   
          });       
          return new Promise((resolve, reject) => {
            axios.post(options.url, options.body, {
                    headers: options.headers
                })
                .then((res) => {
                    resolve(res.data);
                })
                .catch((err) => {
                    const externalapidata8 = {};
                    externalapidata8.details =  {
                        externalapilogsid: v_externalapilogsid,
                        objecttype: 'programassignment_view',
                        updatedby: suserid,
                        insertedby: suserid                           
                    }
                    externalapidata8.info = null;
                    externalapidata8.status = 'update';
                    externalapidata8.resstatus = 'error';
                    if(err.response) {
                        LOGGER.error('MDM Program Search 2 Start..... ******');
                        LOGGER.error(res);
                        LOGGER.error(data);
                        LOGGER.error('MDM Program Search 2 end..... ******');
                        externalapidata8.response = err.response;
                        commonapi.addupdateexternalapilogs(externalapidata8);
                        reject(err.response.status);
                    } else {
                        externalapidata8.response = err;
                        commonapi.addupdateexternalapilogs(externalapidata8);
                        reject(err);
                    }
                });
          }).then(data => {
            Person.logdetailedsearch('response', data,suserid);
            const result = [];
            let tempResult = [];
            if(data){
            tempResult = tempResult.concat(data.moraProgramList, data.cjamsProgramList, data.eeProgramList, data.csesProgramList,
                data.csmsProgramList, data.caresProgramList, data.cjamsAsProgramList);
            tempResult.forEach(function(program) {
            if(program){
            result.push(
                {
                    id: program.caseId,
                    source: program.source,
                    program: program.program_desc,
                    subProgram: program.program_sub_type,
                    status: program.case_status,
                    start: program.effective_begin_date,
                    end: program.effective_end_date,
                    worker: program.case_worker,
                    supervisor: program.case_worker_supervisor,
                    localOffice: program.local_office_desc
                }
                );
            } 
            });
            }
            externalapidata = {};
            externalapidata.details =  {
                externalapilogsid: v_externalapilogsid,
                objecttype: 'programassignment_view',
                updatedby: suserid,
                insertedby: suserid
            }
            externalapidata.info = null;
            externalapidata.status = 'update';
            externalapidata.response = 'success';
            externalapidata.resstatus = 'success';
            commonapi.addupdateexternalapilogs(externalapidata);
            return result;
        }).catch(err => {
            Person.logdetailedsearch('response', err,suserid);
            externalapidata = {};
            externalapidata.details =  {
                externalapilogsid: v_externalapilogsid,
                objecttype: 'programassignment_view',
                updatedby: suserid,
                insertedby: suserid                           
            }
            externalapidata.info = null;
            externalapidata.status = 'update';
            externalapidata.resstatus = 'error';
            externalapidata.response = err;
                commonapi.addupdateexternalapilogs(externalapidata);
            util.logError(err);
        });
    };
    Person.remoteMethod('getpersonprograms', {
        http: {
            path: '/getpersonprograms/:id',
            verb: 'get'
        },
        accepts : [
        {
        arg : 'id',
        type : 'string',
        required: true,
        http : {source : 'path'}
    } ,{
        arg: 'reqctx',
       type: 'object',
        http: {source: 'context'}
    }],
        returns: {
            type : 'object',
            root : true
        }
    });


    /**
     * Person program case specific details
     */
    Person.getpersonprogramcasedetails = request => {
        const caseid  = request.where.caseid;
        var sql = 'SELECT * FROM getpersonprogramcasedetails($1)';
        return util.executeDBQuery(sql, [caseid])
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Person.remoteMethod('getpersonprogramcasedetails', {
        http: {
              path: '/getpersonprogramcasedetails',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
    });
	  
    Person.getpersonbasicdetails = (id,data) =>{
     var personbasicdetails = {};    
    return Person.findById(id,{
        include: [{
             relation: "personidentifier",
             fields: ['personidentifiertypekey'],
               scope:{
               include:{
                relation: "personidentifiertype",
                scope:{
                 fields:['typedescription','personidentifiertypekey']
             }
               }
            }
         },
         {
            relation: "personaddress",
            scope:{
              include :{
                relation:  "Personaddresstype",
                scope:{
                    fields:['typedescription','personaddresstypekey']
                }
              }
           }
        },{
            relation: "personphonenumber",
            scope:{
                include:{
                    relation:"personphonetype",
                    scope:{
                        fields:['typedescription','personphonetypekey']
                    }
                }
            }
        },
        {
            relation: "personemail",
            scope:{
                include:{
                    relation :"Personemailtype",
                    scope:{
                        fields:['typedescription','personemailtypekey']
                    }
                }
            }
        },
         {
            relation: "personphysicalattribute",
            fields: ['physicalattributetypekey'],
              scope:{
              include:{
               relation: "physicalattributetype",
               scope:{
                fields:['description','physicalattributetypekey']
            }
              }
           }
        },
        {
            relation: "nationalitytype",
            scope:{
                fields:['description']
            }
        },
        {
            relation: "gendertype",
            scope:{
                fields:['typedescription']
            }
        },
        {
            relation: "ethnicgrouptype",
            scope:{
                fields:['typedescription']
            }
        },{
            relation: "maritalstatustype",
            scope:{
                fields:['typedescription']
            }
        },
        {
            relation: "racetype",
            scope:{
                fields:['typedescription']
            }
        },
        {
            relation: "religiontype",
            scope:{
                fields:['typedescription']
            }
        },
         {
            relation: "alias",
            scope:{
                fields:['firstname','lastname', 'middlename']
            }
        },{
            relation: "personnickname",
            scope:{
                fields:['nickname']
            }
        },{
            relation: "personrelation",
            scope:{
                fields: ['personrelativeid', 'actorrelationshipkey', 'relationcategory', 'incustody', 'livingwith'],
            include: [{
                relation: 'actorrelationship',
                scope: {
                    fields: ['relationshiptypekey', 'description']
                }
            },{
                relation: 'personrelative',
                scope: {
                    fields: ['personid', 'firstname', 'lastname', 'userphoto']
                }
            }]
            }
        }
        ]
    })
    .then(res1 => {
         personbasicdetails = res1;
         if(res1.suffix != null){
            return app.models.Referencevalues.findOne({
                where:{
                    ref_key:res1.suffix
                },
            fields:['description','ref_key']
         }).then(data3 =>{
           personbasicdetails.suffix = data3.description;
            personbasicdetails.suffixkey = data3.ref_key;
            return personbasicdetails;
         })
         }else{
           personbasicdetails.suffix = null;
           personbasicdetails.suffixkey = null;
            return personbasicdetails;
         }
         
     }).catch(err => util.logError(err));
};

Person.getAllPersonRelationsForSdm = request => {

    var sql = 'select * from allrelationshipdetails($1, $2, $3)';
       const maltreatorlist = JSON.stringify(request.where.maltreatorlist).replace('[', '{').replace(']', '}');
       const victimlist = JSON.stringify(request.where.victimList).replace('[', '{').replace(']', '}');
       
    return util.executeDBQuery(sql,[request.where.intakeserviceid, victimlist, maltreatorlist ])
    .then(data => data)
    .catch(err => { LOGGER.error(err); return err; });
 };


 Person.remoteMethod('getAllPersonRelationsForSdm', {
    http: {
          path: '/getAllPersonRelationsForSdm',
          verb: 'get'
    },
   accepts : [{
      arg : 'filter',
      type : 'object',
      http : {source : 'query'}
   }],
    returns: {
        type : 'object',
          root : true
    }
  });

Person.remoteMethod('getpersonbasicdetails', {
    http: {
        path: '/getpersonbasicdetails/:id',
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

    /*Check for the person role already added for particular intake */
    Person.checkpersonrole = (id,data) =>{
        var req_intakeServiceId = id;
        var req_personId = data.where.personid;
        var req_personRole = data.where.personrole;
        return app.models.Actor.find({
            where : {personid:req_personId ,actortype :req_personRole},
            fields: ["actorid"]
       })
       .then(actorids => {
        const resActorIds = actorids.map(res => res.actorid);
        return app.models.Intakeservicerequestactor.find({
            where : {intakeserviceid:req_intakeServiceId ,actorid :{inq : resActorIds}}
        })
        .then(res =>{
            LOGGER.debug(res.length);
            return res.length>0 ? false : true;
        })
        .catch(err => err)
       })
       .catch(err => err)
    }

    Person.remoteMethod('checkpersonrole', {
        http: {
              path: '/checkpersonrole/:id',
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
          required: true,
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
       });


    /*End */

    Person.remoteMethod('getPerpetratorDemographics', {
        http: {
              path: '/getPerpetratorDemographics',
              verb: 'get'
        },
       accepts : [{
          arg : 'data',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
       });

    Person.getPerpetratorDemographics = (request) => {
        const fromDate = request.fromdate;
        const toDate = request.todate;

        const rptQuery = 'select * from PerpetratorDemographics('+fromDate+', '+toDate+')';
        return util.executeDBQuery(rptQuery, [fromDate, toDate])
        .then(data => data)
        .catch(err => err);
    };
            // Audit Log for Intake person add update delete
    Person.remoteMethod('intakeperson', {
        http: {
              path: '/intakeperson',
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

       Person.intakeperson = (request) =>{
            var description,referenceid,Servicerequestnumber,displayname ,isnew,isdelete,isedit ;
            referenceid = request.personid;
            var logJson = {
                "data": {"obj":{}}
            }
            isnew = request.isnew;
            isedit = request.isedit;
            isdelete = request.isdelete;

            displayname = "'"+request.firstname+", "+request.lastname+"'";
            if(isnew){
            description =  "Person "+displayname +roletypestr+request.role +")  added to DA#";}
            if(isedit){
            description =  "Person "+displayname +roletypestr+request.role +")  updated to DA#";}
            if(isdelete){
            description =  "Person "+displayname +roletypestr+request.role +")  deleted from DA#";}
            Servicerequestnumber = request.intakenumber;

            var logtypekey = "IP";
             logJson.data = request.obj;
            var newadd = {
                "description":description,
                "logtypekey":logtypekey ,
                "referenceid": referenceid,
                "servicerequestnumber":Servicerequestnumber,
                "metadata":logJson,
                "isnew":isnew,
                "isedit":isedit,
                "isdelete":isdelete
            }
            return app.models.Auditlogtype.find({
                where:
                {logtypekey:logtypekey},
                fields:['logtypekey']
            }).then(data =>{
                return app.models.Auditlog.create(newadd);
            })

       }
       Person.remoteMethod(
        'getpersondetail', {
            http: {
                path: '/getpersondetail',
                verb: 'get'
            },
            accepts: [{
                arg: 'filter',
                type: 'object',
                http: {
                    source: 'query'
                }
            }
            ,{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );

    Person.remoteMethod(
        'getpersondetailcw', {
            http: {
                path: '/getpersondetailcw',
                verb: 'get'
            },
            accepts: [{
                arg: 'filter',
                type: 'object',
                http: {
                    source: 'query'
                }
            },{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }
        ],
            returns: {
                type: 'object',
                root: true
            }
        }
    );
    Person.getpersondetailcw = (request,reqctx) => {    // NOSONAR
        var req_personid = request.where.personid;
        var req_intakeserviceid = request.where.intakeserviceid;
        var req_servicecaseid = request.where.servicecaseid;
        var req_intakenumber = request.where.intakenumber;
        var req_servicerequestnumber = request.where.servicerequestnumber;
        var isExpungementSuperUser = request.where.isExpungementSuperUser ? request.where.isExpungementSuperUser : 0;
        var page = request.page;
        var limit = 100;
        var personpagelimit = request.personpagelimit;
        var sql = '';
        var params = [];
        var inputflag = false;

        if ((req_personid !== undefined && req_personid !== null) &&
            (req_intakeserviceid !== undefined && req_intakeserviceid !== null)) {
            return Person.getwholepersondetailscw(req_personid,null, req_intakeserviceid, null);
        }

        if ((req_personid !== undefined && req_personid !== null) &&
            (req_servicecaseid !== undefined && req_servicecaseid !== null)) {
            return Person.getwholepersondetailscw(req_personid, null,null, req_servicecaseid);
        }

        if ((req_personid !== undefined && req_personid !== null) &&
            (req_intakenumber !== undefined && req_intakenumber !== null)) {
            return Person.getwholepersondetailscw(req_personid, req_intakenumber,null,null);
         }

        
        inputflag = checkinputFlag(req_intakeserviceid, req_intakenumber, req_servicerequestnumber, inputflag);
        const iscaseexpunged = request.where.iscaseexpunged ?? 0;
        if (inputflag) {
            sql = 'select * from getpersonsbyinvestigationcw($1,$2,$3,$4,$5,$6,$7)';
            params = [ page, limit,req_intakeserviceid,req_intakenumber,req_servicerequestnumber,isExpungementSuperUser,iscaseexpunged];
        }
        if (request.where.objecttypekey == 'servicecase' && (request.where.objectid != null && request.where.objectid != undefined)) {
            sql = getpersonsbyservicecasesql; 
            if(personpagelimit){
                limit = personpagelimit;
            }
            params = [request.where.objectid, page, limit];
        }
        return util.executeSecondaryNodeDBQuery(sql, params)
        .then(withCount)
        .then(data => util.encryptresponse(data))
        .catch(err => {
            util.logError(err)
            LOGGER.error(err);
            return err;
        })
    }

    function checkinputFlag(req_intakeserviceid, req_intakenumber, req_servicerequestnumber, inputflag){
        if((req_intakeserviceid !== undefined && req_intakeserviceid !== null)||(req_intakenumber !== undefined && req_intakenumber !== null)
            ||(req_servicerequestnumber !== undefined && req_servicerequestnumber !== null)){
            inputflag = true;
        }
        return inputflag;
    }

    Person.getwholepersondetailscw = (personid, v_intakenumber,v_intakeserviceid,v_servicecaseid) => { // NOSONAR
        var FinalResponse = {};
        var actordata;
        var whereCondition = {};
        if (v_intakeserviceid) {
            whereCondition = {
                and: [{
                    intakeserviceid: v_intakeserviceid
                },{
                    personid:personid
                }]                  
            }
        }
        if(v_servicecaseid) {
            whereCondition = {
                and: [{
                    servicecaseid: v_servicecaseid
                },{
                    personid:personid
                }]               
            }
        }
        if(v_intakenumber) {
            whereCondition = {
                and: [{
                    intakenumber: v_intakenumber
                },{
                    personid:personid
                }]
                 }
        }
        return Person.findById(personid, {
            include: [{
                relation: "personaddress",
                scope: {
                    include: {
                        relation: "Personaddresstype",
                        scope: {
                            fields: ['typedescription', 'personaddresstypekey']
                        }
                    }
                }
            }, {
                relation: "personphysicalattribute",
                scope: {
                    include: {
                        relation: "physicalattributetype",
                        scope: {
                            fields: ['description', 'physicalattributetypekey']
                        }
                    }
                }
            },
            {
                relation: "personphonenumber",
                scope: {
                    include: {
                        relation: "personphonetype",
                        scope: {
                            fields: ['typedescription', 'personphonetypekey']
                        }
                    }
                }
            }, {
                relation: "personidentifier",
                scope: {
                    include: {
                        relation: "personidentifiertype",
                        scope: {
                            fields: ['typedescription', 'personidentifiertypekey']
                        }
                    }


                }
            },
             {
                relation: "alias"
            }, {
                relation: "actor",
                scope: {
                    where: whereCondition
                }

            },{
                relation: "personrole",
                scope: {
                    include: {
                        relation: 'Personroletype',
                        scope: {
                            fields: ['personroletypeid', 'personroleid', 'roletype', 'isprimary']
                        }

                    },
                    where: whereCondition
                }
            },{
                relation: "personmaritalstatus",
                scope: {
                    "order": "insertedon DESC",
                    "limit": 1,
                  }
            },{
                relation: "personspouseaddress"
            },{
                relation: "mdmgoldenpersondetails",
                scope : {
                    fields : ['is_mdm_sync']
                }
            },
            {
                relation: "personeducation",
                scope: {
                    include: {
                        relation: 'educationtype',
                        scope: {
                            fields: ['typedescription', 'educationtypekey']
                        }

                    }
                }
            },
            {
                relation: "personeducationvocation"
            },
            {
                relation: "personeducationtesting",
                scope: {
                    include: {
                        relation: 'testingtype',
                        scope: {
                            fields: ['typedescription', 'testingtypekey']
                        }
                    }
                }
            },
            {
                relation: "personaccomplishment",
                scope: {
                    include: {
                        relation: 'highestgrade',
                        scope: {
                            fields: ['typedescription', 'highergradetypekey']
                        }

                    }
                }
            },
            {
                relation: "personemail",
                scope: {
                    include: {
                        relation: "Personemailtype",
                        scope: {
                            fields: ['typedescription', 'personemailtypekey']
                        }
                    }
                }
            },
            {
                relation: "personmedicationphyscotropic"
            },
            {
                relation: "personphycisianinfo"
            },
            {
                relation: "personhealthinsurance"
            },
            {
                relation: "personhealthexamination"
            },
            {
                relation: "personmedicalcondition"
            },
            {
                relation: "personbehavioralhealth"
            },
            {
                relation: "personabusehistory"
            },
            {
                relation: "personabusesubstance"
            },
            {
                relation: "persondentalinfo"
            },
            {
                relation: "personguardian",
                where: { activeflag: true },
                scope: {
                    include: {
                        relation: "guardianperson",
                        scope: {
                            fields: ['guadianpersonid', 'firstname', 'lastname']
                        }
                    }
                }
            },

            {
                relation: "personguardianfuneral"
            },

            {
                relation: "personguardiandetails"
            },

            {
                relation: "personguardiancode",
                scope: {

                    include: {
                        relation: "referencevalues",
                        scope: {
                            fields: ['ref_key', 'referencetypeid', 'description', 'value_text']
                        }
                    }
                }
            },
            {
                relation: "emergencycontactperson",
                where: { activeflag: true },
                scope: {
                    fields: ['contactpersonid'],
                    include: {
                        relation: "contactperson",
                        scope: {
                            fields: ['personid', 'firstname', 'lastname']
                        }
                    }
                }
            },
            {
                relation: "personrepresentativepayee",
                scope: {
                    include: [{
                        relation: "payeecontact",
                        scope: {
                            fields: ['personid', 'firstname', 'lastname']
                        }
                    },
                    {
                        relation: "referencevalues",
                        scope: {
                            fields: ['ref_key', 'referencetypeid', 'description', 'value_text']
                        }
                    },
                    {
                        relation: "woker",
                        scope: {

                            fields: ['securityusersid', 'firstname', 'lastname'],

                        }
                    },
                    {
                        relation: "entity",
                        scope: {

                            fields: ['providerid', 'providername'],

                        }
                    }
                    ]


                }

            },
            {
                relation: "personsupport"
            }

            ]
        })
            .then(res1 => {
                var sql = `select prt.racetypekey,rv.value_text from personracetypemap prt 
                            join referencevalues rv on rv.ref_key= prt.racetypekey and rv.activeflag=1 
                            where prt.personid=$1 and prt.activeflag=1 and rv.referencetypeid=171`;
                util.executeDBQuery(sql,[personid])
                .then(data => {
                    LOGGER.debug(JSON.stringify(data)+"res");
                    res1.personracetypemap = data;
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
                FinalResponse.personbasicdetails = res1;
                

                let whereCondition1 = {};
                var iSRAWhereCondition = {};

                if (v_intakeserviceid) {
                    whereCondition1 = {
                        personid: personid,
                        intakeserviceid: v_intakeserviceid
                    }
                    iSRAWhereCondition = {
                        activeflag: 1,
                        intakeserviceid: v_intakeserviceid,
                        actorid: ''
                    }
                }
                if(v_servicecaseid) {
                    whereCondition1 = {
                        personid: personid,
                        servicecaseid: v_servicecaseid
                    }
                    iSRAWhereCondition = {
                        activeflag: 1,
                        servicecaseid: v_servicecaseid,
                        actorid: ''
                    }
                }
                if(v_intakenumber) {
                    whereCondition1 = {
                        personid: personid,
                        intakenumber: v_intakenumber
                    }
                    iSRAWhereCondition = {
                        activeflag: 1,
                        intakenumber: v_intakenumber,
                        actorid: ''
                    }
                }
                
                return app.models.Actor.findOne({
                    where: whereCondition1,
                    fields: ['actorid', 'actortype', 'ismentalillness', 'mentalillnessdetail', 'ismentalimpair', 'mentalimpairdetail',
                            'iscollateralcontact','ishousehold','intakeserviceid','dangerreason', 'dangerlevel','fetalalcoholspctrmdisordflag',
                            'drugexposednewbornflag', 'probationsearchconductedflag', 'sexoffenderregisteredflag']
                }).then(res => {
                    if (res !== null) {
                        actordata = res;

                        iSRAWhereCondition.actorid = res.actorid 

                        return app.models.Intakeservicerequestactor.find({
                            where: iSRAWhereCondition,
                            fields: ['intakeservicerequestactorid', 'intakeservicerequestpersontypekey', 'isprimary','spexpungementflag','personid','isheadofhousehold'],

                            include: {
                                relation: "actorrelationship",
                                scope: {
                                    fields: ['intakeservicerequestactorid', 'relationshiptypekey'],
                                }
                            }
                        })
                    }
                })

            }).then(res2 => {
                var routingAddressid = null;
                if (util.isNullorEmpty(res2)) {
                   FinalResponse = checkFRActor(actordata, res2, FinalResponse);
                }
               

                var personAddressArray = [];
                var tempJSONconvert = JSON.parse(JSON.stringify(FinalResponse.personbasicdetails));
               
                personAddressArray = getpersonAddress(tempJSONconvert, routingAddressid);
                tempJSONconvert.personaddress = personAddressArray;
                  return FinalResponse;
            }).then(res3 =>{
                var sql = ` select la.livingid
                            , la.livingpriortoplacement
                            , la.livingarrangementtypekey
                            , rv.value_text livingarrangementtype
                            , la.livingenddate
                            , la.livingstartdate
                            , la.caregiverclientid
                            , la.livingcomment as remarks
                            , concat(p1.firstname, ' ', p1.lastname) as primarycaregivername
                            , la.partnerid  
                            , concat(p2.firstname, ' ', p2.lastname) as secondarycaregivername
                    from livingarrangement la
                    inner join referencevalues rv on rv.activeflag =  1 and la.livingarrangementtypekey = rv.ref_key and referencetypeid = 76
                    left join person p1 on p1.personid = la.caregiverclientid 
                    left join person p2 on p2.personid = la.partnerid 
                    where la.personid = $1 and la.placementid is null and la.activeflag = 1
                    order by la.livingstartdate desc limit 1; `;
                return util.executeDBQuery(sql,[res3.personbasicdetails.personid])
                    .then(data => {
                        const la = checklivingArragement(data);
                        FinalResponse.personbasicdetails.livingarrangementdesc = la.remarks;
                        FinalResponse.personbasicdetails.livingarrangementkey = la.livingarrangementtypekey;
                        return FinalResponse;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    });
            }).then(res4 =>{
                var sql = ` select birthmatchflag, birthmatchupdatedon, deselectreason, notificationdate, updatedon, updatedby
                from personbirthmatch
                where personid = $1 and activeflag = 1; `;
                return util.executeDBQuery(sql,[res4.personbasicdetails.personid])
                    .then(data => {
                        const birth = checkbirthMatch(data);
                        FinalResponse.personbasicdetails.birthmatchflag = birth.birthmatchflag;
                        FinalResponse.personbasicdetails.notificationdate = birth.notificationdate;
                        FinalResponse.personbasicdetails.deselectreason = birth.deselectreason;
                        FinalResponse.personbasicdetails.birthmatchupdatedon = birth.birthmatchupdatedon;
                        return FinalResponse;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    });
            }).then(res5 => {
                var sql = `select prt.drugexposednewbornflag, prt.drugexposedtypekey from personrole prt where  prt.personid=$1 and prt.activeflag=1 order by updatedon desc limit 1`;
                return util.executeDBQuery(sql,[res5.personbasicdetails.personid])
                    .then(data => {
                        FinalResponse = getFRpersonbasicdetails(FinalResponse, data)
                        
                        return FinalResponse;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    });

            })
            .then(res5 => {
                let sql = `select * from actorrelationship where person1id = $1 and activeflag =1 and caregiverflag = 1 and intakeservicerequestactorid = ANY($2::uuid[])`;
                let id = returnActorId(res5);
                return util.executeDBQuery(sql,[res5.personbasicdetails.personid,id])
                    .then(data => {
                        FinalResponse.personbasicdetails.caregiverData = checkData(data);
                        return FinalResponse;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    })
            })
            .then(res6 => {
                var hasRemoval = `
                    select case when count(*) >= 1 then true else false end as hasremoval 
                    from intakeservreqchildremoval rm
                    where rm.personid = $1
                        and rm.removaldate is not null
                        and rm.exitdate is null
                        and rm.activeflag  = 1
                        and ( select count(*)
                                from routing rur
                            where rur.objectid = rm.intakeservreqchildremovalid::character varying
                                and rur.eventcode = 'CHRR'
                                and rur.activeflag = 1
                                and rur.routingstatustypeid = '16'
                            ) > 0
                `
                return util.executeDBQuery(hasRemoval, [res6.personbasicdetails.personid])
                    .then(data => {
                        if (data && data.length > 0) {
                            FinalResponse.personbasicdetails.hasremoval = data[0].hasremoval;
                        } else {
                            FinalResponse.personbasicdetails.hasremoval = false;
                        }
                        return FinalResponse;
                    })
            })
            .then(res7 => {
                var icwaquery = `
                    SELECT
                    CASE
                        WHEN EXISTS (
                        SELECT 1
                        FROM person pr
                        JOIN (
                            SELECT pa.personjson, pa.insertedon
                            FROM personauditlog pa
                            WHERE pa.personid = $1
                            ORDER BY pa.insertedon DESC
                            LIMIT 1
                        ) pal ON TRUE
                        WHERE
                            pr.personid = $1
                            AND pr.activeflag = 1
                            AND pal.personjson->>'icwaunderdefinition' IS NOT NULL
                            AND pr.icwaunderdefinition = 'UNKNOWN'
                            AND pr.icwastatusinquiry = 'YES'
                            AND pal.personjson->>'icwaunderdefinition' = 'UNKNOWN'
                            AND pal.insertedon <= NOW() - INTERVAL '60 days'
                        ) THEN 'YES'
                        ELSE 'NO'
                    END AS notify_icwa;
                `
                return util.executeDBQuery(icwaquery, [res7.personbasicdetails.personid])
                    .then(data => {
                        if (data && data.length > 0) {
                            FinalResponse.personbasicdetails.notify_icwa = data[0].notify_icwa;
                        } else {
                            FinalResponse.personbasicdetails.notify_icwa = 'NO';
                        }
                        return FinalResponse;
                    })
            })
            .then(res8 => {
                return util.encryptresponse(res8);
            })
            .catch(err => util.logError(err));
    };

    function checkData(data){
        return data && data.length ? data : [];
    }

    function checkFRActor(actordata, res2, FinalResponse){
        const returnactor = { "actor": {} };
        if (actordata !== null) {
            returnactor.actor.actorid = actordata.actorid;
            returnactor.actor.intakeserviceid = actordata.intakeserviceid;
            returnactor.actor.actortype = actordata.actortype;
            returnactor.actor.ismentalillness = actordata.ismentalillness;
            returnactor.actor.mentalillnessdetail = actordata.mentalillnessdetail;
            returnactor.actor.ismentalimpair = actordata.ismentalimpair;
            returnactor.actor.mentalimpairdetail = actordata.mentalimpairdetail;
            returnactor.actor.ishousehold = actordata.ishousehold;
            returnactor.actor.dangerlevel = actordata.dangerlevel;
            returnactor.actor.dangerreason = actordata.dangerreason;
            returnactor.actor.iscollateralcontact = actordata.iscollateralcontact;
            returnactor.actor.fetalalcoholspctrmdisordflag = actordata.fetalalcoholspctrmdisordflag;
            returnactor.actor.drugexposednewbornflag = actordata.drugexposednewbornflag;
            returnactor.actor.probationsearchconductedflag = actordata.probationsearchconductedflag;
            returnactor.actor.sexoffenderregisteredflag = actordata.sexoffenderregisteredflag;
            returnactor.actor.intakeservicerequestactor = JSON.parse(JSON.stringify(res2));
            FinalResponse.personroledetails = returnactor;
        }
        return FinalResponse;
    }

    function checklivingArragement(data) {
        let remarks = null;
        let livingarrangementtypekey = null;
        if (data && Array.isArray(data) && data.length > 0) {
            remarks = data[0].remarks;
            livingarrangementtypekey = data[0].livingarrangementtypekey;
        }
        return {
            remarks,
            livingarrangementtypekey
        }

    }

    function checkbirthMatch(data){
        let birthmatchflag = null;
        let notificationdate = null;
        let deselectreason = null;
        let birthmatchupdatedon = null;
        if (data && Array.isArray(data) && data.length > 0) {
            birthmatchflag = data[0].birthmatchflag;
            notificationdate = data[0].notificationdate;
            deselectreason = data[0].deselectreason;
            birthmatchupdatedon = data[0].birthmatchupdatedon;
        }
        return {
            birthmatchflag,
            notificationdate,
            deselectreason,
            birthmatchupdatedon
        }
    }

    function getFRpersonbasicdetails(FinalResponse,data) {
        FinalResponse.personbasicdetails.drugexposednewbornflag = data && data.length ? data[0].drugexposednewbornflag : null;
        FinalResponse.personbasicdetails.drugexposedtypekey = data && data.length ? data[0].drugexposedtypekey : null;
        return FinalResponse;
    }

    function getpersonAddress(tempJSONconvert, routingAddressid) {
        var personAddressArray = tempJSONconvert.personaddress;
        /*For Appending Routing Address Flag to PersonAddress Array */
        return personAddressArray.forEach(
            addressArr => {
                if (addressArr.personaddressid == routingAddressid) {
                    addressArr.routingAddressidflag = "1";
                } else {
                    addressArr.routingAddressidflag = "0";
                }
                /*For converting danger flag from true/false to 0/1 as needed by front-end*/
                if (addressArr.danger) {
                    addressArr.danger = "1";
                } else if (!addressArr.danger) {
                    addressArr.danger = "0";
                }
            }
        );
    }

    Person.getwholepersondetails = (personid, v_intakeserviceid, v_servicecaseid) => {
        var FinalResponse = {};
        var actordata;
        return Person.findById(personid, {
            include: [{
                relation: "personaddress",
                scope: {
                    include: {
                        relation: "Personaddresstype",
                        scope: {
                            fields: ['typedescription', 'personaddresstypekey']
                        }
                    }
                }
            }, {
                relation: "personphysicalattribute",
                scope: {
                    include: {
                        relation: "physicalattributetype",
                        scope: {
                            fields: ['description', 'physicalattributetypekey']
                        }
                    }
                }
            },
            {
                relation: "personphonenumber",
                scope: {
                    include: {
                        relation: "personphonetype",
                        scope: {
                            fields: ['typedescription', 'personphonetypekey']
                        }
                    }
                }
            }, {
                relation: "personidentifier",
                scope: {
                    include: {
                        relation: "personidentifiertype",
                        scope: {
                            fields: ['typedescription', 'personidentifiertypekey']
                        }
                    }


                }
            }, {
                relation: "alias"
            }, {
                relation: "actor"
            },{
                relation: "personrole",
                scope: {
                    include: {
                        relation: 'Personroletype',
                        scope: {
                            fields: ['personroletypeid', 'personroleid', 'roletype', 'isprimary']
                        }

                    }
                }
            },{
                relation: "personmaritalstatus",
                scope: {
                    "order": "updatedon DESC",
                    "limit": 1,
                  }
            },{
                relation: "personspouseaddress"
            },
            {
                relation: "personeducation",
                scope: {
                    include: {
                        relation: 'educationtype',
                        scope: {
                            fields: ['typedescription', 'educationtypekey']
                        }

                    }
                }
            },
            {
                relation: "personeducationvocation"
            },
            {
                relation: "personeducationtesting",
                scope: {
                    include: {
                        relation: 'testingtype',
                        scope: {
                            fields: ['typedescription', 'testingtypekey']
                        }
                    }
                }
            },
            {
                relation: "personaccomplishment",
                scope: {
                    include: {
                        relation: 'highestgrade',
                        scope: {
                            fields: ['typedescription', 'highergradetypekey']
                        }

                    }
                }
            },
            {
                relation: "personemail",
                scope: {
                    include: {
                        relation: "Personemailtype",
                        scope: {
                            fields: ['typedescription', 'personemailtypekey']
                        }
                    }
                }
            },
            {
                relation: "personmedicationphyscotropic"
            },
            {
                relation: "personphycisianinfo"
            },
            {
                relation: "personhealthinsurance"
            },
            {
                relation: "personhealthexamination"
            },
            {
                relation: "personmedicalcondition"
            },
            {
                relation: "personbehavioralhealth"
            },
            {
                relation: "personabusehistory"
            },
            {
                relation: "personabusesubstance"
            },
            {
                relation: "persondentalinfo"
            },
            {
                relation: "personguardian",
                where: { activeflag: true },
                scope: {
                    include: {
                        relation: "guardianperson",
                        scope: {
                            fields: ['guadianpersonid', 'firstname', 'lastname']
                        }
                    }
                }
            },

            {
                relation: "personguardianfuneral"
            },

            {
                relation: "personguardiandetails"
            },

            {
                relation: "personguardiancode",
                scope: {

                    include: {
                        relation: "referencevalues",
                        scope: {
                            fields: ['ref_key', 'referencetypeid', 'description', 'value_text']
                        }
                    }
                }
            },
            {
                relation: "emergencycontactperson",
                where: { activeflag: true },
                scope: {
                    fields: ['contactpersonid'],
                    include: {
                        relation: "contactperson",
                        scope: {
                            fields: ['personid', 'firstname', 'lastname']
                        }
                    }
                }
            },
            {
                relation: "personrepresentativepayee",
                scope: {
                    include: [{
                        relation: "payeecontact",
                        scope: {
                            fields: ['personid', 'firstname', 'lastname']
                        }
                    },
                    {
                        relation: "referencevalues",
                        scope: {
                            fields: ['ref_key', 'referencetypeid', 'description', 'value_text']
                        }
                    },
                    {
                        relation: "woker",
                        scope: {

                            fields: ['securityusersid', 'firstname', 'lastname'],

                        }
                    },
                    {
                        relation: "entity",
                        scope: {

                            fields: ['providerid', 'providername'],

                        }
                    }
                    ]


                }

            },
            {
                relation: "personsupport"
            },

            ]
        })
            .then(res1 => {
                FinalResponse.personbasicdetails = res1;

                //Build Where clause based case type - pass servicecaseid in case of serivicecase context else intakeserviceid
                var whereCondition = {};

                if (!v_servicecaseid) {
                    whereCondition = {
                        personid: personid,
                        intakeserviceid: v_intakeserviceid
                    }
                }
                else {
                    whereCondition = {
                        personid: personid,
                        servicecaseid: v_servicecaseid
                    }                   
                }
                
                    return app.models.Actor.findOne({
                    where: whereCondition,
                    fields: ['actorid', 'actortype', 'ismentalillness', 'mentalillnessdetail', 'ismentalimpair', 'mentalimpairdetail', 
                            'iscollateralcontact', 'ishousehold','intakeserviceid', 'dangerreason', 'dangerlevel','fetalalcoholspctrmdisordflag',
                            'drugexposednewbornflag', 'probationsearchconductedflag', 'sexoffenderregisteredflag']
                }).then(res => {
                    if (res !== null) {
                        actordata = res;

                        var actor_id = res.actorid

                        return app.models.Intakeservicerequestactor.find({
                            where: {
                                and: [{
                                    actorid: actor_id
                                }]
                            },
                            fields: ['intakeservicerequestactorid', 'intakeservicerequestpersontypekey', 'isprimary'],

                            include: {
                                relation: "actorrelationship",
                                scope: {
                                    fields: ['intakeservicerequestactorid', 'relationshiptypekey'],
                                }
                            }
                        })
                    }
                })

            }).then(res2 => {
                var routingAddressid = null;
                if (res2 !== null && res2 !== undefined) {

                    var returnactor = { "actor": {} };
                    if (actordata !== null) {
                        returnactor.actor.actorid = actordata.actorid;
                        returnactor.actor.intakeserviceid = actordata.intakeserviceid;
                        returnactor.actor.actortype = actordata.actortype;
                        returnactor.actor.ismentalillness = actordata.ismentalillness;
                        returnactor.actor.mentalillnessdetail = actordata.mentalillnessdetail;
                        returnactor.actor.ismentalimpair = actordata.ismentalimpair;
                        returnactor.actor.mentalimpairdetail = actordata.mentalimpairdetail;
                        returnactor.actor.ishousehold = actordata.ishousehold;
                        returnactor.actor.dangerlevel = actordata.dangerlevel;
                        returnactor.actor.dangerreason = actordata.dangerreason;
                        returnactor.actor.iscollateralcontact = actordata.iscollateralcontact;
                        returnactor.actor.fetalalcoholspctrmdisordflag = actordata.fetalalcoholspctrmdisordflag;
                        returnactor.actor.drugexposednewbornflag = actordata.drugexposednewbornflag;
                        returnactor.actor.probationsearchconductedflag = actordata.probationsearchconductedflag;
                        returnactor.actor.sexoffenderregisteredflag = actordata.sexoffenderregisteredflag;
                        returnactor.actor.intakeservicerequestactor = JSON.parse(JSON.stringify(res2));
                        FinalResponse.personroledetails = returnactor;
                    }

                    if (res2.length > 0) {
                        routingAddressid = res2[0].routingaddressid;
                    }
                }

                var personAddressArray = [];
                var tempJSONconvert = JSON.parse(JSON.stringify(FinalResponse.personbasicdetails));
                personAddressArray = getpersonAddress(tempJSONconvert, routingAddressid);
                tempJSONconvert.personaddress = personAddressArray;
                FinalResponse.personbasicdetails = tempJSONconvert;
                return util.encryptresponse(FinalResponse);
            })
            .catch(err => util.logError(err));
    };

    Person.getPersonWithProgramAssignment= (request) => {
        var params =[];
        var sql;
        if (request.where.objectid != null && request.where.objectid != undefined) {
            sql = "select * from getpersonwithprogramassignment($1)";
            params = [request.where.objectid];
            LOGGER.debug(sql);
        }
        return util.executeDBQuery(sql, params)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });

    }

    Person.getpersondetail = (request, reqctx) => {  // NOSONAR
        var sql = '';
        var params = [];
        var personDetails = checkpersonexists(request)
        if(personDetails){
            return personDetails;
        }

        var qryDetail = getQryDetails(request);
        sql = qryDetail.sql;
        params = qryDetail.params;

        return util.executeSecondaryNodeDBQuery(sql, params)
        .then(withCount)
        .then(resp => {
                if(resp.count > 0 && request.where.personids) {
                    const relationSql = `select  caregiverflag, person1id , person2id, * from actorrelationship a
                                            where person2id = any ($1) and activeflag = 1 and caregiverflag = 1`;
                    return util.executeSecondaryNodeDBQuery(relationSql, [request.where.personids])
                        .then(caregiverData => {
                            resp.data.map(element => {
                                const list = caregiverData.filter(item => item.person1id === element.personid);
                                element.iscaregiver = (list.length) ? true : false;
                            })
                            return resp;
                        });
                } else {
                    return Promise.resolve(resp);
                }
        }).then(data => util.encryptresponse(data))
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });

    }

    function checkpersonexists(request){
        var req_personid = request.where.personid;
        var req_intakeserviceid = request.where.intakeserviceid;
        var req_servicecaseid = request.where.servicecaseid;
        if ((req_personid !== undefined && req_personid !== null) &&
            (req_intakeserviceid !== undefined && req_intakeserviceid !== null)) {
            return Person.getwholepersondetails(req_personid, req_intakeserviceid, null);
        }

        if ((req_personid !== undefined && req_personid !== null) &&
            (req_servicecaseid !== undefined && req_servicecaseid !== null)) {
            return Person.getwholepersondetails(req_personid, null, req_servicecaseid);
        }
        return false;
    }

    function getQryDetails(request ){
        var req_intakeserviceid = request.where.intakeserviceid;
        var req_servicerequestnumber = request.where.servicerequestnumber;
        var req_intakenumber = request.where.intakenumber;
        var isExpungementSuperUser = request.where.isExpungementSuperUser;
        const iscaseexpunged = request.where.iscaseexpunged ?? 0;
        var page = request.page;
        var limit = 100;
        var sql = '';
        var params = [];
        if (req_intakeserviceid !== undefined && req_intakeserviceid !== null) {
            sql = 'select * from getpersonsbyinvestigationcw($1,$2,$3,$4,$5,$6,$7)'
            params = [ page, limit,req_intakeserviceid,req_intakenumber,req_servicerequestnumber,isExpungementSuperUser,iscaseexpunged];
        }
        if (request.where.objecttypekey == 'servicecase' && (request.where.objectid != null && request.where.objectid != undefined)) {
            sql = getpersonsbyservicecasesql;
            params = [request.where.objectid, page, limit];
        }
        return {
            sql: sql,
            params: params
        }
    }

Person.remoteMethod(
    'getinvolvedperson', {
        http: {
            path: '/getinvolvedperson',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    }
);

Person.remoteMethod('personhealthaddupdate', {
    http: {
        path: '/personhealthaddupdate',
        verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} , {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    returns: {
        type : 'object',
        root : true
    }
});

Person.personhealthaddupdate = (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    var securityuserid =(request && request.securityuserid?request.securityuserid: _securityusersid);
    var data = request.health;
    var pid = request.pid;
    var isnew = 1
    if (request.isnew !== undefined && request.isnew !== null) {
        isnew = request.isnew;
    }
    
    var sql = "select * from personhealthaddupdate($1,$2,$3,$4)";
    return util.executeDBQuery(sql,[pid,data,securityuserid,isnew])
        .then(data8 => {
            util.auditLogSave(request.pid,null,request.health);
            return data8;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
};
Person.remoteMethod('getpersonwork', {
    http: {
        path: '/getpersonwork',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    } , {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],  
    returns: {
        type : 'object',
        root : true
    } 
});
Person.getpersonwork = (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }                                                       //SonarQube fix - removed this unused assignent
    var pid = request.where.personid;
        var sql = "select * from getpersonwork($1)"
    return util.executeSecondaryNodeDBQuery(sql,[pid])
      .then(res => { return res; })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
};
Person.remoteMethod('getpersonworknarrative', {
    http: {
        path: '/getpersonworknarrative',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      } ],  
    returns: {
        type : 'object',
        root : true
    } 
});
Person.getpersonworknarrative = (request, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }                                                           //SonarQube fix - removed this unused assignent
    var pid = request.where.personid;
        var sql = "select * from getpersonnarrative($1)"
    return util.executeSecondaryNodeDBQuery(sql,[pid])
      .then(res => res)
      .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
};
Person.remoteMethod('addupdatepersonnarrative', {
    http: {
        path: '/addupdatepersonnarrative',
        verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} , {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    returns: {
        type : 'object',
        root : true
    }
});
Person.addupdatepersonnarrative = (request, reqctx) => {
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
    var securityuserid =_securityusersid;
    var data = request.workdetails;
    var pid = request.pid;
    var intakeserviceid = request.intakeserviceid;
    var flag = 1;

    var res_flag = checkflag(data);
    flag = res_flag.flag;
    data = res_flag.data;

    return app.models.Personemployment.findOne({
            where:{personid:pid,activeflag:1,promotedemploymentprogramname:{ilike:data.promotedemploymentprogramname}}
        }).then(function(result){
            LOGGER.debug(result);
            if(result && (!data.personemploymentid || data.personemploymentid==='')) {
                return {error:1,code:305,message:"Program Already Exist"};
            } else {
                var sql = "select * from addupdatepersonnarrative($1,$2,$3,$4,$5)"
                return util.executeDBQuery(sql,[pid,data,intakeserviceid,securityuserid,flag]);
            }
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
};

function checkflag(data){
    var flag = 1;
    if(data.personemploymentid && data.personemploymentid !=null) {
        if(data.delete == 1) {
            flag = 3;
        } 
    }  
    if(data.promotedemploymentprogramstartdate === ""){
        data.promotedemploymentprogramstartdate = null;}
    if(data.promotedemploymentprogramenddate === ""){
        data.promotedemploymentprogramenddate = null;}
    LOGGER.debug(flag);
    return {
        flag: flag,
        data: data
    }
}

Person.remoteMethod('addupdatepersonwork', {
    http: {
        path: '/addupdatepersonwork',
        verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}} , {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
    returns: {
        type : 'object',
        root : true
    }
});
Person.addupdatepersonwork = (request, reqctx) => {
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;  
    var securityuserid =_securityusersid;
    var data = request.workdetails;
    var pid = request.pid;
    var intakeserviceid = request.intakeserviceid;
    var flag = 1;
      if (data.delete == 1) {
        flag = 3;
      }
      else if (data.personworkcarrergoalid && data.personworkcarrergoalid != null) {
        flag = 2;
      }
    LOGGER.debug("flag-----------------------------------------",flag);
    if(data.employerdetails) {
        if(data.employerdetails.enddate == ""){
            data.employerdetails.enddate = null;}
        if(data.employerdetails.startdate == ""){
            data.employerdetails.startdate = null;}
    }
    var sql = "select * from addupdatepersonwork($1,$2,$3,$4,$5)"
    return util.executeDBQuery(sql,[pid,data,intakeserviceid,securityuserid,flag])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
};

 Person.remoteMethod('manageSenHistory', {
    http: {
      path: '/manageSenHistory',
      verb: 'post'
    },
    accepts: [{
      arg: 'data',
      type: 'object',
      http: { source: 'body' }
    }, {
      arg: 'reqctx',
      type: 'object',
      http: { source: 'context' }
    }],
    returns: {
      type: 'object',
      root: true
    }
  });
  
  Person.manageSenHistory = async (request, reqctx) => { // NOSONAR
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;    
    try {
      const id = request?.id;
      const personId = request.personId;
      const senStatus = request.senStatus;
      const approvalStatus = request.approvalStatus || 'Pending';
      const requestedOn = request.requestedOn ? new Date(request.requestedOn) : new Date();
      const reasons = request.reasons ? JSON.stringify(request.reasons) : null;
      const otherReason = request.otherReason;
      const actions = request.actions ? JSON.stringify(request.actions) : null;
      const substanceClasses = request.substanceClasses ? JSON.stringify(request.substanceClasses) : null;
      const servicecaseid = request.servicecaseid;
      const intakeserviceid = request.intakeserviceid;
      const requestedBy = request.requestedBy || _securityusersid;
      const approvedBy = request.approvedBy;
      const activeFlag = request.activeFlag;
      const denialreasonkey = request.denialreasonkey;
      const denialreasondesc = request.denialreasondesc;
      const sencriteria = request.sencriteria ? request.sencriteria : null;
      const birthinghospital = request.birthinghospital ? request.birthinghospital : null;
      const othersubstances = request.othersubstances ? request.othersubstances : null;

      if (!personId) {
        throw new Error('Person ID is required');
      }
    
      if (senStatus === undefined || senStatus === null) {
        throw new Error('SEN status is required');
      }
      
      const operationType = id ? 'update' : 'create';
      
      const sql = `
      SELECT * FROM cjams.managesenhistory(
        $1::uuid, $2::uuid, $3::varchar, $4::timestamp, $5::boolean,
        $6::varchar, $7::text, $8::text, $9::text, $10::text,$11::varchar,$12::varchar,$13::varchar,
        $14::uuid,$15::uuid, $16::varchar, $17::smallint, $18::varchar, $19::varchar
        )`;

      const result = await util.executeDBQuery(sql, [
        nullcheck(id),
        personId,
        requestedBy,
        requestedOn,
        senStatus,
        approvalStatus,
        reasons,
        otherReason,
        actions,
        nullcheck(substanceClasses),
        nullcheck(sencriteria),
        nullcheck(birthinghospital),
        nullcheck(othersubstances),
        nullcheck(servicecaseid),
        nullcheck(intakeserviceid),
        approvedBy,
        activeFlag,
        nullcheck(denialreasonkey),
        nullcheck(denialreasondesc)
      ]);

      LOGGER.info(`SEN history ${operationType}:`, {
        personId: personId,
        senStatus: senStatus,
        approvalStatus: approvalStatus
      });

      return result;
    } catch (error) {
      LOGGER.error(`Error ${request?.id ? 'updating' : 'creating'} SEN history:`, error);
      throw error;
    }
  };

  function nullcheck(value){
    return value || null;
  }
  
  Person.remoteMethod('getSenHistoryByPersonId', {
    http: {
      path: '/getSenHistoryByPersonId',
      verb: 'get'
    },
    accepts: {
      arg: 'filter',
      type: 'object',
      http: { source: 'query' }
    },
    returns: {
      type: 'object',
      root: true
    }
  });
  
  
  Person.getSenHistoryByPersonId = async (filter) => {
    
    try {
      if (!filter?.where?.personId) {
        LOGGER.error('PersonID is required:', error);
        throw new Error('Person ID is required');
      }
      
      const personId = filter.where.personId;
      
      const sql = "SELECT * FROM getsenhistorybyperson($1)";
      const result = await util.executeDBQuery(sql, [personId]);
      
      return {
        success: true,
        data: result
      };
    } catch (error) {
      LOGGER.error('Error fetching SEN history:', error);
      return {
        success: false,
        message: error.message || 'Error fetching SEN history',
        data: []
      };
    }
  };

Person.remoteMethod('addupdatepersoncw', {
    http: {
        path: '/addupdatepersoncw',
        verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
    returns: {
        type : 'object',
        root : true
    }
});

Person.addupdatepersoncw = async (request, reqctx) => {
    const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid; 
    var _email = util.getSecurityDetails(request, reqctx).email;
    var requestuserinfo = {'token': '', 'email': _email}; 
    var role ;
    await util.getuserinfo(requestuserinfo).then (data11 => {
        role = data11.roletypekey;
    });  
    var clientflag = 1;
    var securityuserid =_securityusersid;
    var data = request.persondetails;
    var pid = request.pid;
    var intakeserviceid = request.intakeserviceid;
    var responseObj = {"Personid":"", "status": ""};
    
    clientflag = data.clientflag;
    var iveuserornot = true;
                                        //SonarQube fix - removed this unused assignent
    // CIDM-6991,6992,6993 - Demographic changes for IVE users
    var res_client = checkclientflag(data, role);
    clientflag = res_client.clientflag;
    data.clientflag = res_client.clientflag;
    iveuserornot = res_client.iveuserornot;


    var sql = "select * from sp_pp_addupdatepersoncw_v1($1,$2,$3,$4,$5)" ;
    return util.executeDBQuery(sql,[pid,data,intakeserviceid,securityuserid,iveuserornot])
    .then(data12 => {
        responseObj.Personid = data12[0].savedpersonid;
        responseObj.status = data12[0].v_status;
        return data12[0];
    })
    .then(resp => {
        var sql1 = "select * from cpsresponsetimerupdate($1)" ;
        return util.executeDBQuery(sql1,[intakeserviceid])
        .then(data13 => {
            return resp;
        })
        .catch(err => {
            LOGGER.error('person add/update (cpsresponsetimerupdate) error', err); 
            LOGGER.error(err)
        })
    }).then(res =>{   
        return replaceunknownperson(res, data, securityuserid, clientflag, responseObj);    
      }).then(async res =>{
        if(res && res.length > 0){
            res[0].newflag = pid ? false : true; 
        }
        if(clientflag === 1 || clientflag === 2){
            responseObj.mdmResponse = await Person.addPersonToMDM(res, _securityusersid);
        }
        return responseObj;
      }).catch(err=>{
        LOGGER.debug("Error in sending call to mdm");
        LOGGER.error(err)
        if(responseObj.Personid){
            return responseObj;
        } else if (!responseObj.Personid && responseObj.status) {
            return responseObj;
        }else{
            throw err;
        }
    });
};

function checkclientflag(data, role){
    var iveuserornot = true;
    var firstname = data.Firstname;
    var lastname = data.Lastname;
    var dob = data.Dob;
    var gender = data.gendertypekey;
    var ssn = data.SSN;
    var isapproxdob = data.isapproxdob;
    var clientflag = data.clientflag || 1;
     
    if (role === 'IVESV' || role === 'IVESP' || role === 'IVEQA' || role === 'IVEADMIN' || role === 'IVEEA') {
        iveuserornot = false;
    }
    
    
    if(firstname && lastname && dob && gender && ssn ){
        if(isapproxdob === 0){
            clientflag = data.clientflag || 1;
            data.clientflag = data.clientflag || 1;
        }
    }
    return {
        iveuserornot: iveuserornot,
        clientflag: clientflag
    }
}

function replaceunknownperson(res, data, securityuserid, clientflag, responseObj){
    if (res.savedpersonid && data.unknownperson) {
        var replaceSQL = 'SELECT * from replaceunknownperson($1,$2,$3)';
        return util.executeDBQuery(replaceSQL, [res.savedpersonid,data.unknownperson,securityuserid])
        .then(data14 => {
            return data14;
        })
        .catch(err => {
            LOGGER.error('person add/update (replaceunknownperson) error', err); 
            LOGGER.error(err)
        })
    }
    if (res.savedpersonid && config.integrationConfig.enableMDM && (clientflag === 1 || clientflag === 2)) {
        var mdmSql = 'SELECT * from sp_get_person_mdm($1)';
        return util.executeDBQuery(mdmSql,[res.savedpersonid])
        .then(data15 => {
            return data15;
        })
        .catch(err => {
            LOGGER.error('person add/update (sp_get_person_mdm) error', err); 
            LOGGER.error(err)
        })
    } else if (!res.savedpersonid && res.v_status) {
        return responseObj;
    } else if (clientflag === 0) {
        return responseObj;
    } else{
        return new Promise((resolve,reject)=>{
            LOGGER.error('person add/update (Error in saving person information) error'); 
            reject("Error in saving person information")
        });
    }
}   

Person.createMdmUsingPersonid = (personid, _securityusersid) => {
    if(personid){
        var sql = 'SELECT * from sp_get_person_mdm($1)';
        return util.executeDBQuery(sql, [personid]).then(data => {
            if(data){
                Person.addPersonToMDM(data, _securityusersid);
            }
            return data;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }
}


Person.remoteMethod('listhouseholdaddresses', {
    http: {
        path: '/listhouseholdaddresses',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    } ],  
    returns: {
        type : 'object',
        root : true
    } 
});

Person.listhouseholdaddresses = function(request){
    var intakeserviceid = request.where.intakeserviceid;
    LOGGER.debug('intakeserviceid --',intakeserviceid);
    var sql = "SELECT * from listpersonhouseholdaddresses($1)"
    return util.executeDBQuery(sql,[intakeserviceid])
      .then(res =>{
        return res[0];
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });

    }

Person.remoteMethod('listpersonhealth', {
    http: {
        path: '/listpersonhealth',
        verb: 'get'
    },
    accepts : [ 
    {
        arg : 'filter',
        type : 'object',
        http : {source : 'query'}
    } ],  
    returns: {
        type : 'object',
        root : true
    } 
});

Person.listpersonhealth = function(request){
    var sql = "select * from listpersonhealth($1,$2,$3)"
    return util.executeDBQuery(sql,[request.where.personid,request.page,request.limit])
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
    }

Person.remoteMethod(
    'getPersonWithProgramAssignment', {
        http: {
            path: '/getPersonWithProgramAssignment',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    }
);


Person.personaddupdate = function(data, reqctx){
    const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid; 
    var securityuserid =_securityusersid;
  
  var mdmPerson = JSON.parse(JSON.stringify(data));
    var personstructure = JSON.stringify(data);

  var responseObj = {"Personid":"","Cjamspid":""};
    var servicecaseid = null;
    var objecttypekey = '';
      if (data.objectid !== null && data.objectid !== undefined) {
          servicecaseid = data.objectid;
      }
      if (data.objecttypekey !== null && data.objecttypekey !== undefined) {
          objecttypekey = data.objecttypekey;
      }
      var individualPerson = data.Person[0];
      if((individualPerson.health) != null && (individualPerson.health) != undefined && (individualPerson.Pid) != null && (individualPerson.Pid) != undefined){
        var individualPersonHealth = JSON.stringify(individualPerson.health);
            var healthSql = 'SELECT * from public.personhealthaddupdate($1,$2,$3,0)';
            util.executeDBQuery(healthSql,[individualPerson.Pid , individualPersonHealth, securityuserid])
            .then(res => {
                LOGGER.debug(res);
            })
            .catch(err => {
                LOGGER.error(err)
            })
    }

     var sql = 'SELECT * FROM personaddupdate($1,$2,$3,$4,$5)';
      return util.executeDBQuery(sql,[personstructure,data.intakeserviceid, securityuserid,servicecaseid,objecttypekey])
         .then(function(data16) {
                responseObj.Personid = data16[0].personaddupdate20;
                if (responseObj.Personid && config.integrationConfig.enableMDM && !(mdmPerson.Person[0].hasOwnProperty("activeflag"))) {
                    var mdmSql = 'select cjamspid from person where personid = $1';
                    return util.executeDBQuery(mdmSql,[responseObj.Personid])
                    .then(data17 => {
                        responseObj.Cjamspid = data17[0].cjamspid;
                        Person.addpersonmdm(mdmPerson.Person[0],responseObj);
                        return responseObj ;
                    })
                } else {
                    return responseObj;
                }
          })
         .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
          });
  };


Person.remoteMethod (
  'personaddupdate',
 {
   http: {
       path: '/personaddupdate',
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


  Person.getinvolvedperson=(request)=>{

    var investigaionid =  request.where.intakeserviceid;

    var roles = request.where.actortype;
    if(roles === undefined){
        roles = '';
    }
    var page = request.page;
    var limit = request.limit;

    var sql = '';
    var params = [];

    if (investigaionid !== undefined && investigaionid !== null) {
        sql = 'select * from getpersonsrolebyinvestigation($1,$2,$3,$4)'
        params = [investigaionid, page, limit, roles];
    }
    if (request.where.servicecaseid != null && request.where.servicecaseid != undefined) {
        sql = getpersonsbyservicecasesql;
        params = [request.where.servicecaseid, page, limit];
    }

    return util.executeDBQuery(sql,params)
    .then(withCount)
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
    });
}


             // Audit Log for Caseworker person update
    Person.afterRemote('updateperson', function(ctx,  next) {
        var description,referenceid,Servicerequestnumber,ipaddress,isnew,isdelete,isedit ;
        var logtypekey = "IPP";
        ipaddress = ctx.req.connection.remoteAddress;
        var displayname = "'"+ctx.args.data.People.firstname+","+ctx.args.data.People.lastname+"'";
        var dangerlevel = ctx.args.data.People.dangerlevel;
        isedit = true;
        referenceid = ctx.args.data.People.personid;
        var logJson = {
            "data": {
                "danumber": "",
                "name":"",
                "actortype":"",
                "dangerlevel":"",
                "updatedon": ""
            }
        };

        return app.models.Actor.findOne({where : {personid:ctx.args.id},
                fields:['actorid','actortype'],
                include:{
                    relation:'actortypedesc',
                    scope:{
                        fields:['typedescription','actortype']
                    }
                }
				}).then(data =>{
                    var result = JSON.parse(JSON.stringify(data));
                    const actorid = result.actorid;
                     actordesc = result.actortypedesc.typedescription;
                   return app.models.Intakeservicerequestactor.findOne({
                        where :{actorid:actorid },
                        fields: ['intakeserviceid']
                    })
                }).then(ids =>{
                        const  intakeserviceid = ids.intakeserviceid;
                        logJson.data.name = displayname;
                        logJson.data.actortype = actordesc;
                        logJson.data.dangerlevel = dangerlevel;
                        description =  "Person "+displayname +roletypestr+actordesc +")  updated to DA#";
                        logJson.data.updatedby = app.currentUser.email;
                        var newadd = {
                            "description":description,
                            "logtypekey":logtypekey ,
                            "intakeserviceid": intakeserviceid,
                            "referenceid": referenceid,
                            "servicerequestnumber":Servicerequestnumber,
                            "metadata":logJson,
                            "ipaddress":ipaddress,
                            "isnew":isnew,
                            "isedit":isedit,
                            "isdelete":isdelete
                        }
                        // Auditlog Recording Added here
                        app.models.Auditlog.createlogdetails(newadd)
                        next();
                    }).catch (err => err)
   });

   Person.getpersonrelations = request => {
    const personid = request.where.personid;
    if(personid) {
        return app.models.Personrelation.find({
            where: {personid: personid},
            fields: ['personrelationid', 'personid', 'personrelativeid', 'actorrelationshipkey', 'relationcategory', 'incustody', 'livingwith'],
            include: [{
                relation: 'actorrelationship',
                scope: {
                    fields: ['relationshiptypekey', 'description']
                }
            },{
                relation: 'personrelative',
                scope: {
                    fields: ['personid', 'firstname', 'lastname', 'userphoto']
                }
            }]  
        })
    }
       return Promise.resolve([]);
   };

   Person.addrelation = request => {
       return app.models.Personrelation.count({
           and: [{activeflag: 1}, {personid: request.personid}, {personrelativeid: request.personrelativeid}, {actorrelationshipkey: request.actorrelationshipkey}]
       })
       .then(existingRelationCount => {
           if (existingRelationCount === 0) {
               return app.models.Personrelation.create(request);
           }
           else {
               return "Relation already exists";
           }
       })
       .catch(err => util.logError(err));
   };

   Person.remoteMethod('addrelation', {
        http: {
                path: '/addrelation',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

   Person.updaterelation = request => {
        return app.models.Personrelation.count({
            and: [{activeflag: 1}, 
                {personrelationid: {neq: request.personrelationid}},
                {personid: request.personid}, 
                {personrelativeid: request.personrelativeid}, 
                {actorrelationshipkey: request.actorrelationshipkey}]
        })
        .then(existingRelationCount => {
            if (existingRelationCount === 0) {
                return app.models.Personrelation.updateAll(
                    {personrelationid: request.personrelationid},
                    {personid: request.personid, personrelativeid: request.personrelativeid, 
                        actorrelationshipkey: request.actorrelationshipkey,
                        relationcategory: request.relationcategory,
                        incustody: request.incustody,
                        livingwith: request.livingwith
                    }
                );
            }
            else {
                return "Relation already exists";
            }
        })
        .catch(err => util.logError(err));
    };

    Person.remoteMethod('updaterelation', {
        http: {
                path: '/updaterelation',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Person.deleterelation = request => {

      const piplsearchQuery = "update personrelation set activeflag = 0 where personrelationid = $1";

      return util.executeDBQuery(piplsearchQuery, [request.personrelationid])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Person.remoteMethod('deleterelation', {
        http: {
                path: '/deleterelation',
                verb: 'patch'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
    });

   Person.remoteMethod(
    'getpersonrelations', {
        http: {
            path: '/getpersonrelations',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    }
);

Person.listPersonAuditLogs = request => {
    const personid = request.where.personid;
    const filtercol = request.where.filtercol;
    const page = request.page;
    const limit = request.limit;
    
    if(personid) {
      const auditLogQuery = "select * from listauditmodifiedlogs($1, $2, $3, $4, $5, $6);";
      return util.executeDBQuery(auditLogQuery, [personid, 'IP', filtercol, page, limit, null])
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
      });
    }
    return Promise.resolve([]);
};

Person.remoteMethod(
    'listPersonAuditLogs', {
        http: {
            path: '/listPersonAuditLogs',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    }
);
Person.updatepersonphysicalattribute = (request, reqctx)=>{
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    var personid=request.personid;
    var height=request.height;
    var weight=request.weight;
    var securityuserid=(request && request.securityuserid?request.securityuserid: _securityusersid);
	var attribute = 'select * from updatepersonphysicalattribute($1,$2,$3,$4)';
		return util.executeDBQuery(attribute, [personid,height,weight,securityuserid])
			.then(data => {
				LOGGER.debug(data);
				return "sucess"
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			})

}
Person.remoteMethod (
    'updatepersonphysicalattribute',
   {
     http: {
         path: '/updatepersonphysicalattribute',
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

    
    Person.remoteMethod('listlanguage', {
        http: {
            path: '/listlanguage',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Person.listlanguage =(request)=> {
        var sql = 'select * from listlanguage($1)';
		return util.executeDBQuery(sql, [request.where.languagename])
			.then(withCount)
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
    };

    Person.getpersonalldetails = (id,data) =>{
        
        return Person.findById(id,{
            include: [{
                 relation: "personidentifier",
                 fields: ['personidentifiertypekey'],
                   scope:{
                   include:{
                    relation: "personidentifiertype",
                    scope:{
                     fields:['typedescription','personidentifiertypekey']
                 }
                   }
                }
             },
             {
                relation: "personaddress",
                scope:{
                  include :{
                    relation:  "Personaddresstype",
                    scope:{
                        fields:['typedescription','personaddresstypekey']
                    }
                  }
               }
            },{
                relation: "personphonenumber",
                scope:{
                    include:{
                        relation:"personphonetype",
                        scope:{
                            fields:['typedescription','personphonetypekey']
                        }
                    }
                }
            },
            {
                relation: "personemail",
                scope:{
                    include:{
                        relation :"Personemailtype",
                        scope:{
                            fields:['typedescription','personemailtypekey']
                        }
                    }
                }
            },
             {
                relation: "personphysicalattribute",
                fields: ['physicalattributetypekey'],
                  scope:{
                  include:{
                   relation: "physicalattributetype",
                   scope:{
                    fields:['description','physicalattributetypekey']
                }
                  }
               }
            },
            {
                relation: "nationalitytype",
                scope:{
                    fields:['description']
                }
            },
            {
                relation: "gendertype",
                scope:{
                    fields:['typedescription']
                }
            },
            {
                relation: "incometype",
                scope:{
                    fields:['typedescription']
                }
            },
            {
                relation: "ethnicgrouptype",
                scope:{
                    fields:['typedescription']
                }
            },{
                relation: "maritalstatustype",
                scope:{
                    fields:['typedescription']
                }
            },
            {
                relation: "racetype",
                scope:{
                    fields:['typedescription']
                }
            },
            {
                relation: "religiontype",
                scope:{
                    fields:['typedescription']
                }
            },
             {
                relation: "alias",
                scope:{
                    fields:['firstname','lastname', 'middlename']
                }
            },
            {
                relation: "actor"
            },
            {
                relation: "personeducation",
                scope:{
                      include:{
                          relation:'educationtype',
                          scope:{
                           fields:['typedescription','educationtypekey']
                          }
    
                      }
                    }
            },
            {
                relation: "personeducationvocation"
                },
                {
                relation: "personeducationtesting",
                scope:{
                   include:{
                       relation:'testingtype',
                       scope:{
                           fields:['typedescription','testingtypekey']
                       }
                   }
                }
            },
            {
                relation: "personaccomplishment",
                scope:{
                    include:{
                        relation:'highestgrade',
                        scope:{
                            fields:['typedescription','highergradetypekey']
                        }
    
                    }
                }
            },
            {
                relation: "personmedicationphyscotropic"
            },
            {
                relation: "personphycisianinfo"
            },
            {
                relation: "personhealthinsurance"
            },
            {
                relation: "personhealthexamination"
            },
            {
                relation: "personmedicalcondition"
            },
            {
                relation: "personbehavioralhealth"
            },
            {
                relation: "personabusehistory"
            },
            {
                relation: "personabusesubstance"
            },
            {
                relation: "persondentalinfo"
            },
            {
                relation: "emergencycontactperson",
                where:{activeflag:true},
                scope:{
                    fields:['contactpersonid'],
                    include:{
                        relation:"contactperson",
                        scope:{
                            fields:['personid','firstname','lastname']
                        }
                    }
                }
            },
            {
                relation: "personnickname",
                scope:{
                    fields:['nickname']
                }
            },{
                relation: "personrelation",
                scope:{
                    fields: ['personrelativeid', 'actorrelationshipkey', 'relationcategory', 'incustody', 'livingwith'],
                include: [{
                    relation: 'actorrelationship',
                    scope: {
                        fields: ['relationshiptypekey', 'description']
                    }
                },{
                    relation: 'personrelative',
                    scope: {
                        fields: ['personid', 'firstname', 'lastname', 'userphoto']
                    }
                }]
                }
            }
            ]
        })
        .then(_data => _data)
        .catch(err => util.logError(err));
    };
    
    Person.remoteMethod('getpersonalldetails', {
        http: {
            path: '/getpersonalldetails/:id',
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

    Person.remoteMethod('getpersondisability', {
        http: {
            path: '/getpersondisability',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    Person.getpersondisability =(request)=> {
        var status=null;

       if(request.where.status !== undefined && request.where.status !== null)
       {
         status='Inactive';
       }
        var sql = 'select * from getpersondisabilityfilter($1,$2)';
		
		return util.executeSecondaryNodeDBQuery(sql, [request.where, status])
		.then(datas => datas)
		.catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    };

    Person.remoteMethod(
        'personrepresentativeworkersearch', 
             {
             http: {
                   path: '/personrepresentativeworkersearch',
                   verb: 'post'
             },
             accepts : [ {arg : 'data',type : 'Object',
                    http : {source : 'body'}} ], 
             returns: {
                  type : 'object',
                        root : true
             }
             }
    );
    Person.personrepresentativeworkersearch=(request)=>{
    const sql = 'Select * from personrepresentativeworkersearch($1)';

    return util.executeDBQuery(sql, [JSON.stringify(request.where)])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Person.updatecisclientid = function(data, reqctx) {
        const _usecurityusersid = util.getSecurityDetails(data, reqctx).u_securityuserid;
        const _securityusersid = util.getSecurityDetails(data, reqctx).securityuserid;
        const externalapidata = {}; 
        externalapidata.details =  {
            objectid: data.irn,
            objecttype: 'irn_addupdate',
            updatedby: _usecurityusersid,
            insertedby: _usecurityusersid
        }
        externalapidata.resstatus = '';
        externalapidata.request = data;
        externalapidata.response = null;
        externalapidata.status = 'add';
        var v_externalapilogsid = null;
        return commonapi.addupdateexternalapilogs(externalapidata).then(data1 => {
            v_externalapilogsid = data1;
            if (data.mdmId && data.irn) {
                var sql = "select * from sp_save_update_irn($1,$2,$3)";
                return util.executeDBQuery(sql, [data.mdmId, _securityusersid, data.irn])
                    .then(function (data_v) {
                            const externalapidata2 = {};
                            externalapidata2.details = {
                                externalapilogsid: v_externalapilogsid,
                                objecttype: 'irn_addupdate',
                                updatedby: _usecurityusersid,
                                insertedby: _usecurityusersid
                            }

                            externalapidata2.info = null;
                            externalapidata2.status = 'update';
                            externalapidata2.resstatus = 'success';
                            externalapidata2.response = data_v && data_v.length > 0 ? data_v[0].sp_save_update_irn : null;
                            commonapi.addupdateexternalapilogs(externalapidata2);
                            return externalapidata2.response;
                    })
                    .catch(err => {
                            LOGGER.error('>>>>ERROR:', err);
                            const externalapidata1 = {};
                            externalapidata1.details = {
                                externalapilogsid: v_externalapilogsid,
                                objecttype: 'irn_addupdate',
                                updatedby: _usecurityusersid,
                                insertedby: _usecurityusersid
                            }

                            externalapidata1.info = null;
                            externalapidata1.status = 'update';
                            externalapidata1.resstatus = 'error';
                            externalapidata1.response = err;
                            commonapi.addupdateexternalapilogs(externalapidata1);
                            throw err;
                    });
            } else {
                const externalapidata3 = {};
                externalapidata3.details =  {
                    externalapilogsid: v_externalapilogsid,
                    objecttype: 'irn_addupdate',
                    updatedby: _usecurityusersid,
                    insertedby: _usecurityusersid,                                        }

                externalapidata3.info = null;
                externalapidata3.status = 'update';
                externalapidata3.resstatus = 'error';
                externalapidata3.response = 'mdmId/irn missing';
                commonapi.addupdateexternalapilogs(externalapidata3);
                return {message:"mdmId/irn missing"};
            }
        })
        .catch(err => LOGGER.error(err));
    };

    Person.remoteMethod('updatecisclientid', {
        http: {
                path: '/updatecisclientid',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'object',
            root : true
        }
    });

    Person.personaddupdatefinanceasset=(request, reqctx)=>{
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var mainrequest = request.where;
        mainrequest.currentuser = (request && request.securityuserid?request.securityuserid: _securityusersid);
        const sql = 'Select * from addupdatefinanceassets($1::json)';

    return util.executeDBQuery(sql, [JSON.stringify(mainrequest)])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });

    }

    Person.remoteMethod(
        'personaddupdatefinanceasset', 
             {
             http: {
                   path: '/personaddupdatefinanceasset',
                   verb: 'post'
             },
             accepts : [ {arg : 'data',type : 'Object',
                    http : {source : 'body'}}, {
                        arg: 'reqctx',
                        type: 'object',
                        http: {source: 'context'}
                      } ], 
             returns: {
                  type : 'object',
                        root : true
             }
             }
    );

    Person.getpersondetailsaftersearch=(request)=>{
        var vpersonid = request.where.personid;
        const sql = 'Select * from getpersondetailsaftersearch($1::character varying)';

    return util.executeDBQuery(sql, [vpersonid])
        .then(data => data && data.length > 0 ? data[0] : [])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Person.remoteMethod('getpersondetailsaftersearch', {
        http: {
            path: '/getpersondetailsaftersearch',
            verb: 'get'
        },
        accepts : [{arg : 'filter',
                    type : 'object',
                    http : {source : 'query'}
        }], 
             returns: {
                  type : 'object',
                        root : true
             }
    });


    Person.getfinanceasset=(request)=>{
        var vpersonid = request.where.personid;
        const sql = 'Select * from getfinanceassets($1::character varying)';
 
    return util.executeSecondaryNodeDBQuery(sql, [vpersonid])
        .then(data => data)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Person.remoteMethod('getfinanceasset', {
        http: {
            path: '/getfinanceasset',
            verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
                    http : {source : 'body'}} ], 
             returns: {
                  type : 'object',
                        root : true
             }
    });

    Person.getScheduleH=(request)=>{
        var householdsize = request.where.householdsize;
        const sql = 'select familysize,maximumallowablepayment,standardofneed,grossincomeoneeightyfive,basicneed from tb_scheduleh where familysize=$1::numeric';
        return util.executeDBQuery(sql, [householdsize])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Person.remoteMethod('getScheduleH', {
        http: {
            path: '/getScheduleH',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });


    Person.deletefinanceasset=(request)=>{
        var vpersonassetid = request.where.personassetid;
        const sql = 'UPDATE personasset pa SET  activeflag = 0 where pa.personassetid::character varying= $1';

    return util.executeDBQuery(sql, [vpersonassetid])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Person.remoteMethod('deletefinanceasset', {
        http: {
            path: '/deletefinanceasset',
            verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
                    http : {source : 'body'}} ], 
             returns: {
                  type : 'object',
                        root : true
             }
    });
    Person.addupdatefinanceincome = function(request, reqctx){
        // Reading request.addupdatefinanceincome.personid unguarded threw a
        // TypeError synchronously - before the promise chain below was built - so
        // the .catch never attached, nothing was logged with the '>>>>ERROR:'
        // prefix, and error-logger.js rewrote it to a bare 400. Validate first and
        // reject with a message the caller can actually read: error-logger keeps
        // err.message even though it discards the status.
        var mainrequest = request && request.addupdatefinanceincome;
        if (!mainrequest) {
            const err = new Error('addupdatefinanceincome: request body must contain an "addupdatefinanceincome" object');
            err.statusCode = 400;
            LOGGER.error('>>>>ERROR:', err.message);
            return Promise.reject(err);
        }
        var personid = mainrequest.personid;
        // personid binds to a uuid parameter, so '' fails in the driver as 22P02 -
        // which error-logger relabels 'INTEGER_EXPECTED', pointing at the wrong type.
        if (!personid) {
            const err = new Error('addupdatefinanceincome: personid is required');
            err.statusCode = 400;
            LOGGER.error('>>>>ERROR:', err.message);
            return Promise.reject(err);
        }
        // Same resolution as the inline header check this replaces, minus the
        // null-dereference risk on request.
        var securityuserid = util.getSecurityDetails(request, reqctx).securityuserid;
        var sql = 'select * from addupdatefinanceincome( $1, $2, $3)';
        return util.executeDBQuery(sql,[personid,JSON.stringify(mainrequest),securityuserid])
            .then(function(data){
                return data[0];
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        };
    
    Person.remoteMethod('addupdatefinanceincome', {
        http: {
                path: '/addupdatefinanceincome',
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

    Person.financeincomelist = request => {
        const personid  = request.where.personid;
            var sql = 'select * from getfinanceincome($1)';
            return util.executeSecondaryNodeDBQuery(sql,[personid])
            .then(data => {
                return data[0];
            }).then(function(value){
            return value;
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      };
    Person.remoteMethod('financeincomelist', {
        http: {
              path: '/financeincomelist',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
      });

    Person.financeincomedelete = function(request, reqctx){
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var mainrequest = request.financeincomedelete;
        var personid = mainrequest.personid;
        var incomeid = mainrequest.incomeid;
        var sql = 'select * from deletefinanceincome( $1, $2)';
        return util.executeDBQuery(sql,[incomeid ,personid])
            .then(function(data){
                return data[0];
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        };

    Person.remoteMethod('financeincomedelete', {
        http: {
                path: '/financeincomedelete',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } , {
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
        returns: {
            type : 'string',
            root : true
        }
    });

    Person.addupdatefinancesupportorder = function(request, reqctx){
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var mainrequest = request.addupdatefinancesupportorder;
        var personid = mainrequest.personid;
        var securityuserid =(request && request.securityuserid?request.securityuserid: _securityusersid);
        var sql = 'select * from addupdatefinancesupportorder( $1, $2, $3)';
        return util.executeDBQuery(sql,[personid,JSON.stringify(mainrequest),securityuserid])
            .then(function(data){
                return data[0];
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        };
    
    Person.remoteMethod('addupdatefinancesupportorder', {
        http: {
                path: '/addupdatefinancesupportorder',
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
    
    Person.financesupportorderlist = request => {
        const personid  = request.where.personid;
            var sql = 'select * from getfinancesupportorder($1)';
            return util.executeSecondaryNodeDBQuery(sql,[personid])
            .then(data => {
                return data[0];
            }).then(function(value){
            return value;
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      };

    Person.remoteMethod('financesupportorderlist', {
        http: {
              path: '/financesupportorderlist',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
      });
      Person.get18to21answer = request => {
        const personid  = request.where.personid;
        var return_answer ={hours80:0,barrieractivity:0};
        return new Promise((resolve, reject) => {
            LOGGER.debug(personid);
            app.models.Personemployerdetail.findOne({
                where:{personid:personid,activeflag:1}
            }).then(function(result){
                if(result) {
                   
                        if(result.noofhours && (parseInt(result.noofhours) >= 80)) {
                            return_answer.hours80 = 1;
                        }
                    
                }
                app.models.Personemployment.findOne({
                    where:{personid:personid,activeflag:1,promotedemploymentflag:1}
                }).then(function(result2){
                    if(result2) {
                        return_answer.barrieractivity = 1;
                    }
                    resolve(return_answer);
                }).catch(function(error){
                    resolve(return_answer);

                });
            });
        }).then(function(value){
            return value;
        }).catch(err => {return {}});
      };

    Person.remoteMethod('get18to21answer', {
        http: {
              path: '/get18to21answer',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
      });
      Person.financesupportorderdelete = function(request, reqctx){
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var mainrequest = request.financeincomedelete;
        var personid = mainrequest.personid;
        var csesclientsupportorderid = mainrequest.csesclientsupportorderid;
        var sql = 'select * from deletefinancesupportorder( $1, $2)';
        return util.executeDBQuery(sql,[csesclientsupportorderid ,personid])
            .then(function(data){
                return data[0];
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        };

    Person.remoteMethod('financesupportorderdelete', {
        http: {
                path: '/financesupportorderdelete',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'string',
            root : true
        }
    });
    
   Person.financecseslist = request => {
        const personid  = request.where.personid;
            var sql = 'select * from getfinancecses($1)';
            return util.executeSecondaryNodeDBQuery(sql,[personid])
            .then(data => {
                return data[0];
            }).then(function(value){
            return value;
            }).catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
      };

    Person.remoteMethod('financecseslist', {
        http: {
              path: '/financecseslist',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
      });

      Person.deleteInvolvedPerson = function(request, reqctx){
        let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var personid = request.personid;
        var securityuserid = (request.securityuserid?request.securityuserid: _securityusersid);
        var intakenumber = null
        var intakeserviceid = null;
        var servicecaseid  = null;
        var i_flag ;
        if(request.intakeserviceid != null && request.intakeserviceid != '' && request.intakeserviceid != undefined)
        {
            i_flag = true;
            intakeserviceid= request.intakeserviceid;          
        }
        else
        {
            i_flag = false;
            intakenumber = request.intakenumber;
        }
        
        if(request.servicecaseid != null && request.servicecaseid != '' && request.servicecaseid != undefined)
        {
            servicecaseid=request.servicecaseid;
        }

        var sql = 'select * from deleteinvolvedperson($1,$2,$3,$4,$5,$6)';
        return util.executeDBQuery(sql,[personid,intakeserviceid,intakenumber,i_flag,servicecaseid,securityuserid])
            .then(function(data){
                return data[0];
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
        };

    Person.remoteMethod('deleteInvolvedPerson', {
        http: {
                path: '/deleteInvolvedPerson',
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


    Person.getAllPersonRelationByProvidedPersonID = request => {
        var sql = 'select * from getallpersonrelationbyprovidedpersonid($1, $2, $3, $4)';

        // Safely default to an empty object if request or request.where is missing
        const where = request?.where || {};

        // 1. Determine the first parameter fallback sequence
        let idParam = where.intakeserviceid || where.intakenumber || where.objectid || null;

        // 2. Determine the personid parameter
        let personIdParam = where.personid || null;

        // 3. Determine super user flag (?? handles undefined/null but safely preserves 0)
        let isExpungementSuperUser = where.isExpungementSuperUser ?? null;

        // 4. Determine expunged flag
        let iscaseexpunged = where.iscaseexpunged ?? 0;

        // ALWAYS pass exactly 4 parameters in the array
        var serchParam = [idParam, personIdParam, isExpungementSuperUser, iscaseexpunged];

        return util.executeDBQuery(sql, serchParam)
        .then(function (data) {
            return data[0].getallpersonrelationbyprovidedpersonid;
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            util.logError(err);
            throw err;
        });
    };
    
    Person.remoteMethod('getAllPersonRelationByProvidedPersonID', {
        http: {
              path: '/getallpersonrelationbyprovidedpersonid',
              verb: 'get'
        },
       accepts : [{
          arg : 'filter',
          type : 'object',
          http : {source : 'query'}
       }],
        returns: {
            type : 'object',
              root : true
        }
      });
    Person.getCareGiverPersonChildInfo = request => {
            let sql ='select * from getCareGiverPersonChildInfo($1,$2)';
           return util.executeDBQuery(sql,[request.serviceid, request.personid])
           .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
           });
     };
    Person.remoteMethod('getCareGiverPersonChildInfo', {
        http: {
              path: '/getCareGiverPersonChildInfo',
              verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
      });

      Person.getcaregiverchildinfo = request => {
            let sql ='select * from getcaregiverchildinfo($1)';
           return util.executeDBQuery(sql,[request.serviceid])
           .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
           });
     };
    Person.remoteMethod('getcaregiverchildinfo', {
        http: {
              path: '/getcaregiverchildinfo',
              verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}} ],
        returns: {
            type : 'object',
            root : true
        }
      });

      Person.getPersonAuditLog = (request, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx?.req?.headers?.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
        var updatedfrom ='';
        var updatedto ='';
        var updatedby ='';
        if(request.where.updatedfrom!=undefined){
            updatedfrom=request.where.updatedfrom;
        }
        if(request.where.updatedto!=undefined){
            updatedto=request.where.updatedto;
        }
        if(request.where.updatedby!=undefined){
            updatedby=request.where.updatedby;
        }
        const securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);

           var sql = 'select * from getpersonauditlog($1,$2,$3,$4,$5,$6,$7,$8,$9)';
           return util.executeSecondaryNodeDBQuery(sql,[request.where.personid,securityuserid,request.page,request.limit,
            request.where.sortorder,request.where.sortcolumn,updatedfrom,updatedto,updatedby])
           .then(function(value){
            return util.encryptresponse(value);
        }).catch(err => util.logError(err));
     };

   Person.remoteMethod('getPersonAuditLog', {
       http: {
             path: '/getPersonAuditLog',
             verb: 'get'
       },
      accepts : [{
         arg : 'filter',
         type : 'object',
         http : {source : 'query'}
      }, {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
       returns: {
           type : 'object',
             root : true
       }
     });


     Person.getcollateral = request => {
            var intakeserviceid ='';
            if(request.where.intakeserviceid!=undefined){
                intakeserviceid=request.where.intakeserviceid;
            }
           var sql = ' select * from cjams.getcollateral($1)';
           LOGGER.debug(sql,sql);
           return util.executeDBQuery(sql,[intakeserviceid])
           .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
           });
     };

   Person.remoteMethod('getcollateral', {
       http: {
             path: '/getcollateral',
             verb: 'get'
       },
      accepts : [{
         arg : 'filter',
         type : 'object',
         http : {source : 'query'}
      }],
       returns: {
           type : 'object',
             root : true
       }
     });


     Person.remoteMethod('getmdmpersondetailslist', {
        http: {
            path: '/getmdmpersondetailslist',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });
    
    Person.getmdmpersondetailslist = function(request){
        var sql = "select * from getmdmpersondetailslist($1,$2,$3)"
        return util.executeDBQuery(sql, [request.where.personid,request.page,request.limit])
          .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
          });
        }

        Person.updatepostGoldenRecord = (data, reqctx) => {
            let _securityusersid = undefined;
            if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
              _securityusersid = reqctx.req.headers.securityusersid;
            }  
            var securityusersid =(data && data.securityuserid?data.securityuserid: _securityusersid);
            const sql = "SELECT * FROM mdmupdatetopersondetails($1,$2)";
            return util.executeDBQuery(sql, [JSON.stringify(data),securityusersid])
                .catch(err => {
                    LOGGER.error('>>>>ERROR:', err);
                    throw err;
                });
        };
        
          Person.remoteMethod('updatepostGoldenRecord', {
            http: {
                    path: '/updatepostGoldenRecord',
                    verb: 'post'
            },
            accepts : [ {arg : 'data',type : 'object',
                http : {source : 'body'}}, {
                    arg: 'reqctx',
                    type: 'object',
                    http: {source: 'context'}
                  } ],
            returns: {
                type : 'object',
                root : true
            }
        });
    

    Person.remoteMethod('getAllCareGiverPersonIds', {
        http: {
            path: '/getallcaregiverpersonids',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: { source: 'query' }
        }],
        returns: {
            type: 'object',
            root: true
        }
    });

    Person.getAllCareGiverPersonIds = request => {
            var sql = 'select * from getallcaregiverpersonids($1)';
            return util.executeDBQuery(sql, [request.where.objectid])
            .then(function (data) {
                return data[0].getallcaregiverpersonids;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };

    Person.updatebirthmatch = (data, reqctx) => {
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}
        const _personbirthmatchids = Array.isArray(data.personbirthmatchids) ? data.personbirthmatchids : [data.personbirthmatchids];
        var securityusersid =(data && data.securityuserid?data.securityuserid: _securityusersid);
        const sql = " update personbirthmatch set nevershowagain = true, updatedby = $2, updatedon = now() where personbirthmatchid = any($1)";
        return util.executeDBQuery(sql, [_personbirthmatchids,securityusersid])
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };
    
    Person.remoteMethod('updatebirthmatch', {
    http: {
            path: '/updatebirthmatch',
            verb: 'post'
    },
    accepts : [ {arg : 'data',type : 'object',
        http : {source : 'body'}}, {
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
    returns: {
        type : 'object',
        root : true
    }
});

Person.updatesennotification = (data, reqctx) => {
    let _securityusersid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      _securityusersid = reqctx.req.headers.securityusersid;
    }  
    var securityusersid =(data && data.securityuserid?data.securityuserid: _securityusersid);
    const sql = `INSERT INTO cjams.senhistorynotifications(personid, senstatusflag, notificationdate, workerdetails, insertedby, insertedon,
                 updatedby, updatedon, activeflag, nevershowagain) values ($1,$2,now(),$3,$4,now(),$5,now(),$6,$7)`;
    return util.executeDBQuery(sql, [data.senpersonids,1,securityusersid, securityusersid, securityusersid,1 ,true])
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
};

Person.remoteMethod('updatesennotification', {
http: {
        path: '/updatesennotification',
        verb: 'post'
},
accepts : [ {arg : 'data',type : 'object',
    http : {source : 'body'}} , {
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
returns: {
    type : 'object',
    root : true
}
}); 

Person.remoteMethod(
    'getpersonexists', {
        http: {
            path: '/getpersonexists',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    }
);

Person.getpersonexists = (request) => {
    var req_personid = request.where.personid;
    var req_intakeserviceid = request.where.intakeserviceid ? request.where.intakeserviceid : '';
    var req_servicecaseid = request.where.servicecaseid ? request.where.servicecaseid : '';
    var req_intakenumber = request.where.intakenumber? request.where.intakenumber : '';

    var params = [];

    var sql = `select count(1) from intakeservicerequestactor where personid = $1
                and (case when $2 != '' then intakenumber = $2 else true end)
                and (case when $3 != '' then intakeserviceid = $3::uuid else true end)
                and (case when $4 != '' then servicecaseid = $4::uuid else true end) and activeflag = 1`;
    params = [req_personid, req_intakenumber, req_intakeserviceid, req_servicecaseid]

    return util.executeDBQuery(sql, params)
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
}

Person.remoteMethod(
    'getexpungedpersondetailcw', {
        http: {
            path: '/getexpungedpersondetailcw',
            verb: 'get'
        },
        accepts: [{
            arg: 'filter',
            type: 'object',
            http: {
                source: 'query'
            }
        }],
        returns: {
            type: 'object',
            root: true
        }
    }
);

Person.getexpungedpersondetailcw = (request) => {
    let req_personid = request.where.personid;
    let req_intakeserviceid = request.where.intakeserviceid;
    var req_servicecaseid = request.where.servicecaseid;
    var req_intakenumber = request.where.intakenumber;
    var req_servicerequestnumber = request.where.servicerequestnumber;
    var isExpungementSuperUser = request.where.isExpungementSuperUser;
    const iscaseexpunged = request.where.iscaseexpunged ?? 0;
    var page = request.page;
    var limit = 100;
    var personpagelimit = request.personpagelimit;
    var sql = '';
    var params = [];
    var inputflag = false;

    if ((req_personid !== undefined && req_personid !== null) &&
        (req_intakeserviceid !== undefined && req_intakeserviceid !== null)) {
        return Person.getexpungedwholepersondetailscw(req_personid,null, req_intakeserviceid, null, isExpungementSuperUser);
    }

    if ((req_personid !== undefined && req_personid !== null) &&
        (req_servicecaseid !== undefined && req_servicecaseid !== null)) {
        return Person.getexpungedwholepersondetailscw(req_personid, null,null, req_servicecaseid, isExpungementSuperUser);
    }

    if ((req_personid !== undefined && req_personid !== null) &&
        (req_intakenumber !== undefined && req_intakenumber !== null)) {
        return Person.getexpungedwholepersondetailscw(req_personid, req_intakenumber,null,null, isExpungementSuperUser);
     }


    inputflag = checkinputFlag(req_intakeserviceid, req_intakenumber, req_servicerequestnumber, inputflag);

    if (inputflag) {
        sql = 'select * from getpersonsbyinvestigationcw($1,$2,$3,$4,$5,$6,$7)';
        params = [ page, limit,req_intakeserviceid,req_intakenumber,req_servicerequestnumber,isExpungementSuperUser,iscaseexpunged];
    }
    if (request.where.objecttypekey == 'servicecase' && (request.where.objectid != null && request.where.objectid != undefined)) {
        sql = getpersonsbyservicecasesql;
        if(personpagelimit){
            limit = personpagelimit;
        }
        params = [request.where.objectid, page, limit];
    }

    return util.executeSecondaryNodeDBQuery(sql, params)
    .then(withCount)
    .then(data => util.encryptresponse(data))
    .catch(err => {     // NOSONAR
        util.logError(err)
        LOGGER.error(err);
        return err;
    })
}

Person.getexpungedwholepersondetailscw = (personid, v_intakenumber,v_intakeserviceid,v_servicecaseid, isExpungementSuperUser) => {
    var FinalResponse = {};
    var actordata;
    // sonar issue fix call the helper here instead of the 3 'if' statements
    var whereCondition = getIncludeWhereCondition(personid, v_intakenumber, v_intakeserviceid, v_servicecaseid);    
    return Person.findById(personid, {
        include: [{
            relation: "personaddress",
            scope: {
                include: {
                    relation: "Personaddresstype",
                    scope: {
                        fields: ['typedescription', 'personaddresstypekey']
                    }
                }
            }
        }, {
            relation: "personphysicalattribute",
            scope: {
                include: {
                    relation: "physicalattributetype",
                    scope: {
                        fields: ['description', 'physicalattributetypekey']
                    }
                }
            }
        },
        {
            relation: "personphonenumber",
            scope: {
                include: {
                    relation: "personphonetype",
                    scope: {
                        fields: ['typedescription', 'personphonetypekey']
                    }
                }
            }
        }, {
            relation: "personidentifier",
            scope: {
                include: {
                    relation: "personidentifiertype",
                    scope: {
                        fields: ['typedescription', 'personidentifiertypekey']
                    }
                }


            }
        },
         {
            relation: "alias"
        },{
            relation: "personrole",
            scope: {
                include: {
                    relation: 'Personroletype',
                    scope: {
                        fields: ['personroletypeid', 'personroleid', 'roletype', 'isprimary']
                    }

                },
                where: whereCondition
            }
        },{
            relation: "personmaritalstatus",
            scope: {
                "order": "insertedon DESC",
                "limit": 1,
              }
        },{
            relation: "personspouseaddress"
        },{
            relation: "mdmgoldenpersondetails",
            scope : {
                fields : ['is_mdm_sync']
            }
        },
        {
            relation: "personeducation",
            scope: {
                include: {
                    relation: 'educationtype',
                    scope: {
                        fields: ['typedescription', 'educationtypekey']
                    }

                }
            }
        },
        {
            relation: "personeducationvocation"
        },
        {
            relation: "personeducationtesting",
            scope: {
                include: {
                    relation: 'testingtype',
                    scope: {
                        fields: ['typedescription', 'testingtypekey']
                    }
                }
            }
        },
        {
            relation: "personaccomplishment",
            scope: {
                include: {
                    relation: 'highestgrade',
                    scope: {
                        fields: ['typedescription', 'highergradetypekey']
                    }

                }
            }
        },
        {
            relation: "personemail",
            scope: {
                include: {
                    relation: "Personemailtype",
                    scope: {
                        fields: ['typedescription', 'personemailtypekey']
                    }
                }
            }
        },
        {
            relation: "personmedicationphyscotropic"
        },
        {
            relation: "personphycisianinfo"
        },
        {
            relation: "personhealthinsurance"
        },
        {
            relation: "personhealthexamination"
        },
        {
            relation: "personmedicalcondition"
        },
        {
            relation: "personbehavioralhealth"
        },
        {
            relation: "personabusehistory"
        },
        {
            relation: "personabusesubstance"
        },
        {
            relation: "persondentalinfo"
        },
        {
            relation: "personguardian",
            where: { activeflag: true },
            scope: {
                include: {
                    relation: "guardianperson",
                    scope: {
                        fields: ['guadianpersonid', 'firstname', 'lastname']
                    }
                }
            }
        },

        {
            relation: "personguardianfuneral"
        },

        {
            relation: "personguardiandetails"
        },

        {
            relation: "personguardiancode",
            scope: {

                include: {
                    relation: "referencevalues",
                    scope: {
                        fields: ['ref_key', 'referencetypeid', 'description', 'value_text']
                    }
                }
            }
        },
        {
            relation: "emergencycontactperson",
            where: { activeflag: true },
            scope: {
                fields: ['contactpersonid'],
                include: {
                    relation: "contactperson",
                    scope: {
                        fields: ['personid', 'firstname', 'lastname']
                    }
                }
            }
        },
        {
            relation: "personrepresentativepayee",
            scope: {
                include: [{
                    relation: "payeecontact",
                    scope: {
                        fields: ['personid', 'firstname', 'lastname']
                    }
                },
                {
                    relation: "referencevalues",
                    scope: {
                        fields: ['ref_key', 'referencetypeid', 'description', 'value_text']
                    }
                },
                {
                    relation: "woker",
                    scope: {

                        fields: ['securityusersid', 'firstname', 'lastname'],

                    }
                },
                {
                    relation: "entity",
                    scope: {

                        fields: ['providerid', 'providername'],

                    }
                }
                ]


            }

        },
        {
            relation: "personsupport"
        }

        ]
    })
        .then(async res1 => {
            var sql = `select prt.racetypekey,rv.value_text from personracetypemap prt
                        join referencevalues rv on rv.ref_key= prt.racetypekey and rv.activeflag=1
                        where prt.personid=$1 and prt.activeflag=1 and rv.referencetypeid=171`;
            util.executeDBQuery(sql,[personid])
            .then(data => {
                LOGGER.debug(JSON.stringify(data)+"res");
                res1.personracetypemap = data;
            })
            .catch(err => {
                LOGGER.error(err);
                return err;
            })
            FinalResponse.personbasicdetails = res1;

            // Sanitize parameters to prevent SQL injection
            const sanitizedPersonId = String(personid).replace(/'/g, "''"); // Escape single quotes
            let whereCondition1 = '';
            let iSRAWhereCondition = {};
            if (v_intakeserviceid) {
                const sanitizedIntakeServiceId = String(v_intakeserviceid).replace(/'/g, "''");
                whereCondition1 = `WHERE personid = '${sanitizedPersonId}' AND intakeserviceid = '${sanitizedIntakeServiceId}'`;
                iSRAWhereCondition = `WHERE intakeserviceid = '${sanitizedIntakeServiceId}'`;
            }
            if(v_servicecaseid) {
                const sanitizedServiceCaseId = String(v_servicecaseid).replace(/'/g, "''");
                whereCondition1 = `WHERE personid = '${sanitizedPersonId}' AND servicecaseid = '${sanitizedServiceCaseId}'`;
                iSRAWhereCondition = `WHERE servicecaseid = '${sanitizedServiceCaseId}'`;
            }
            if(v_intakenumber) {
                const sanitizedIntakeNumber = String(v_intakenumber).replace(/'/g, "''");
                whereCondition1 = `WHERE personid = '${sanitizedPersonId}' AND intakenumber = '${sanitizedIntakeNumber}'`;
                iSRAWhereCondition = `WHERE intakenumber = '${sanitizedIntakeNumber}'`;
            }
           let fromClause = '';
           let actionQuery = '';
            fromClause = ` FROM (
                SELECT actorid, personid, servicecaseid, intakenumber, actortype, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, iscollateralcontact, ishouseholdmember as ishousehold, intakeserviceid, dangertoworkerreason as dangerreason, isdangertoworker as dangerlevel, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag 
                FROM expunge.actor_expunge where activeflag = 1
                UNION
                SELECT actorid, personid, servicecaseid, intakenumber, actortype::character varying, ismentalillness, mentalillnessdetail::character varying, ismentalimpair, mentalimpairdetail::character varying, iscollateralcontact, ishouseholdmember, intakeserviceid, dangertoworkerreason, isdangertoworker, fetalalcoholspctrmdisordflag, drugexposednewbornflag, probationsearchconductedflag, sexoffenderregisteredflag 
                FROM actor where activeflag = 1
                )`;

            actionQuery = `Select
                actorid,
                actortype,
                ismentalillness,
                mentalillnessdetail,
                ismentalimpair,
                mentalimpairdetail,
                iscollateralcontact,
                ishousehold,
                intakeserviceid,
                dangerreason,
                dangerlevel,
                fetalalcoholspctrmdisordflag,
                drugexposednewbornflag,
                probationsearchconductedflag,
                sexoffenderregisteredflag
                ${fromClause}
                ${whereCondition1}
                `;
        //    }

              return util.executeDBQuery(actionQuery,[])
                    .then(res => {
                       if (res !== null && res.length > 0) {
                          actordata = res[0];

                          // Sanitize actorid to prevent SQL injection
                          const sanitizedActorId = String(res[0].actorid).replace(/'/g, "''");
                          iSRAWhereCondition += `AND actorid = '${sanitizedActorId}'`;
                          let fromintakeactorClause = '';
                          fromintakeactorClause = ` FROM (
                            SELECT intakeserviceid, personid, servicecaseid, intakenumber, actorid, intakeservicerequestactorid, intakeservicerequestpersontypekey,isprimary FROM expunge.intakeservicerequestactor_expunge isra
                            where activeflag = 1
                            UNION
                            SELECT intakeserviceid, personid, servicecaseid, intakenumber,actorid,intakeservicerequestactorid,intakeservicerequestpersontypekey,isprimary FROM intakeservicerequestactor isra
                            where activeflag = 1
                            ) iar`;
            
                          let intakeservicerequestactorSql = `Select
                          iar.intakeservicerequestactorid, iar.intakeservicerequestpersontypekey,iar.isprimary,
                          (SELECT json_agg(json_build_object(
                            'intakeservicerequestactorid', ar.intakeservicerequestactorid,
                            'relationshiptypekey',	ar.relationshiptypekey
                            )) actorrelationship 
                            from actorrelationship ar 
                            where ar.intakeservicerequestactorid = iar.intakeservicerequestactorid and ar.activeflag = 1)
                          ${fromintakeactorClause}
                          ${iSRAWhereCondition}
                          `;    

                          return util.executeDBQuery(intakeservicerequestactorSql,[])
                          .then(res21 => {
                             return res21

                          }).catch(err => {
                             LOGGER.error(err);
                             return err;
                          })

                       }
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    });

        }).then(res2 => {     // NOSONAR
            var routingAddressid = null;
            if (util.isNullorEmpty(res2)) {
               FinalResponse = checkFRActor(actordata, res2, FinalResponse);
            }


            var personAddressArray = [];
            var tempJSONconvert = JSON.parse(JSON.stringify(FinalResponse.personbasicdetails));

            personAddressArray = getpersonAddress(tempJSONconvert, routingAddressid);
            tempJSONconvert.personaddress = personAddressArray;
              return FinalResponse;
        }).then(res3 =>{
            var sql = ` select la.livingid
                        , la.livingpriortoplacement
                        , la.livingarrangementtypekey
                        , rv.value_text livingarrangementtype
                        , la.livingenddate
                        , la.livingstartdate
                        , la.caregiverclientid
                        , la.livingcomment as remarks
                        , concat(p1.firstname, ' ', p1.lastname) as primarycaregivername
                        , la.partnerid
                        , concat(p2.firstname, ' ', p2.lastname) as secondarycaregivername
                from livingarrangement la
                inner join referencevalues rv on rv.activeflag =  1 and la.livingarrangementtypekey = rv.ref_key and referencetypeid = 76
                left join person p1 on p1.personid = la.caregiverclientid
                left join person p2 on p2.personid = la.partnerid
                where la.personid = $1 and la.placementid is null and la.activeflag = 1
                order by la.livingstartdate desc limit 1; `;
            return util.executeDBQuery(sql,[res3.personbasicdetails.personid])
                .then(data => {      // NOSONAR
                    const la = checklivingArragement(data);
                    FinalResponse.personbasicdetails.livingarrangementdesc = la.remarks;
                    FinalResponse.personbasicdetails.livingarrangementkey = la.livingarrangementtypekey;
                    return FinalResponse;
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                });
        }).then(res4 =>{
            var sql = ` select birthmatchflag, birthmatchupdatedon, deselectreason, notificationdate, updatedon, updatedby
            from personbirthmatch
            where personid = $1 and activeflag = 1; `;
            return util.executeDBQuery(sql,[res4.personbasicdetails.personid])
                .then(data => {      // NOSONAR
                    const birth = checkbirthMatch(data);
                    FinalResponse.personbasicdetails.birthmatchflag = birth.birthmatchflag;
                    FinalResponse.personbasicdetails.notificationdate = birth.notificationdate;
                    FinalResponse.personbasicdetails.deselectreason = birth.deselectreason;
                    FinalResponse.personbasicdetails.birthmatchupdatedon = birth.birthmatchupdatedon;
                    return FinalResponse;
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                });
        }).then(res5 => {      // NOSONAR
            var sql = `select prt.drugexposednewbornflag, prt.drugexposedtypekey from personrole prt where  prt.personid=$1 and prt.activeflag=1 order by updatedon desc limit 1`;
            return util.executeDBQuery(sql,[res5.personbasicdetails.personid])
                .then(data => {      // NOSONAR
                    FinalResponse = getFRpersonbasicdetails(FinalResponse, data)

                    return FinalResponse;
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                });

        })
        .then(res5 => {     // NOSONAR
            let sql = `select * from actorrelationship where person1id = $1 and activeflag =1 and caregiverflag = 1 and intakeservicerequestactorid = ANY($2::uuid[])`;
            let id = returnActorId(res5);
            return util.executeDBQuery(sql,[res5.personbasicdetails.personid, id])
                .then(data => {
                    FinalResponse.personbasicdetails.caregiverData = checkData(data);
                    return FinalResponse;
                })
                .catch(err => {
                    LOGGER.error(err);
                    return err;
                })
        })
        .then(res6 => {
            return res6 
        })
        .catch(err => util.logError(err));
};

    

    Person.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Person.observe('access', (ctx, next) => util.access(ctx, next));
    Person.observe('after save', (ctx, next) => util.aftersave(ctx, next,'PHLTH',
    ctx.isNewInstance?ctx.instance.personid:ctx.data.personid));
    Person.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};

function returnActorId(res5){
        const intakeactors = res5.personroledetails && res5.personroledetails.actor && res5.personroledetails.actor.intakeservicerequestactor && res5.personroledetails.actor.intakeservicerequestactor.length > 0 ?
            res5.personroledetails.actor.intakeservicerequestactor.map(({ intakeservicerequestactorid }) => intakeservicerequestactorid) : [];

            if(intakeactors.length > 0) {
               return intakeactors.map(id => id.replaceAll("'", ""));               
            }
            return null;
    }

function getIncludeWhereCondition(personid, v_intakenumber, v_intakeserviceid, v_servicecaseid){
    let condition = {};
    if (v_intakeserviceid) {
        condition = { and: [{ intakeserviceid: v_intakeserviceid }, { personid: personid }] };
    }
    if (v_servicecaseid) {
        condition = { and: [{ servicecaseid: v_servicecaseid }, { personid: personid }] };
    }
    if (v_intakenumber) {
        condition = { and: [{ intakenumber: v_intakenumber }, { personid: personid }] };
    }
    return condition;
}