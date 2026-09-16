'use strict';
var loopback = require('loopback');
var app = require('../../server/server');
const crypto = require('crypto');
const ensalt ='c6|KM2';
var config = require('../../server/config.json');
var moment = require('moment');
const btoa = require("btoa");
const nodemailer = require('nodemailer');

const LOGGER = require('log4js').getLogger("utils");
const loggermsg = "request :: ";

module.exports.emptyUUID = '00000000-0000-0000-0000-000000000000';

module.exports.connect = () => {
  let connection;
  let isConnected;
  if (config.issecondarynodesearchenabled) {
    connection = app.dataSources.secondarynodesearch;
    isConnected = connection.connect().then(data => Promise.resolve(connection.connected));
  } else {
    connection = app.dataSources.hcuewelfare;
    isConnected = Promise.resolve(true);
  }

  return isConnected.then(connected => {
    if (!connected) { // If connection is not active, call the primary node
      connection = app.dataSources.hcuewelfare;
    }
    return Promise.resolve(connection);
  });
}

function logError(err) {
    const prs = [];
    try {
        const errObj = {};  
        errObj.logtype = 'db'; 
        errObj.requestdata = err.hint ?  err.hint: '';
        errObj.verb = err.severity ? err.severity: 'LOW' ;
        errObj.request = '-';
        errObj.type = "INTERNAL ERROR";
        errObj.errormsg = err.message;
        errObj.responsestatuscode = err.code ?  err.code: '500';
        errObj.stacktrace = err.stack;
        errObj.createdate = new Date().toLocaleString();
        LOGGER.error("*** API Error ", errObj);
        prs.push(app.models.Welfarelog.createErrorLog(errObj)
            .catch(e => {
                LOGGER.error(e);
            }));
    } catch (error) {
        LOGGER.error(error);
    }
    return Promise.all(prs);
}

module.exports.logError = logError;

module.exports.auditLogSave = (referenceid,logtypekey,data) => { 
    var rawData = {
        "description":"information",
        "logtypekey":logtypekey ,
        "referenceid": referenceid,
        "metadata":data,
        "isnew":false,
        "isedit":false,
        "isdelete":false
      }
      LOGGER.debug(logtypekey);
      LOGGER.debug(data);

      if(logtypekey===null){
        if(data.personExamination){
            rawData.logtypekey='PEXAM';
            rawData.metadata=data.personExamination;
            app.models.Auditlog.createLogWithReferenceType(rawData);
        } 
        if(data.personHospitalizationHistory){
            rawData.logtypekey='PHOS';
            rawData.metadata=data.personHospitalizationHistory;
            app.models.Auditlog.createLogWithReferenceType(rawData);
        }
        if(data.personImmunization){
            rawData.logtypekey='PIMM';
            rawData.metadata=data.personImmunization;
            app.models.Auditlog.createLogWithReferenceType(rawData);
        }
        if(data.personBehaviour){
            rawData.logtypekey='PBHVHLTH';
            rawData.metadata=data.personBehaviour;
            app.models.Auditlog.createLogWithReferenceType(rawData);
        }
        if(data.personfamilyHistroy){
            rawData.logtypekey='PFI';
            rawData.metadata=data.personfamilyHistroy;
            app.models.Auditlog.createLogWithReferenceType(rawData);
        }
        if(data.insuranceInfo){
            rawData.logtypekey='PHLTHINS';
            rawData.metadata=data.insuranceInfo;
            app.models.Auditlog.createLogWithReferenceType(rawData);
        }
        checkauditlog(data, rawData);
      } else {
        LOGGER.debug("insert Audit Log -- ",rawData);
        app.models.Auditlog.createLogWithReferenceType(rawData);
        LOGGER.debug("insert Audit Log -End --",rawData);
      }
}

function checkauditlog(data, rawData){
    if(data.personmedicalPsychotropic){
        rawData.logtypekey='PMED';
        rawData.metadata=data.personmedicalPsychotropic;
        app.models.Auditlog.createLogWithReferenceType(rawData);
    }
    if(data.education){
        rawData.logtypekey='PED';
        rawData.metadata=data.education;
        app.models.Auditlog.createLogWithReferenceType(rawData);
    }
    if(data.educationtesting){
        rawData.logtypekey='PEDT';
        rawData.metadata=data.educationtesting;
        app.models.Auditlog.createLogWithReferenceType(rawData);
    }
    if(data.educationaccomplishment){
        rawData.logtypekey='PEDA';
        rawData.metadata=data.educationaccomplishment;
        app.models.Auditlog.createLogWithReferenceType(rawData);
    }
}
module.exports.transporter=()=>{
let mailerCredentialPshychotropic = '';
if (config.state) {
    const awsMail = config.awsMail;
    awsMail.username =  app.get('apiKeys').awsmail_user;
    awsMail.password = app.get('apiKeys').awsmail_password;
    mailerCredentialPshychotropic = awsMail;
} else {
    mailerCredentialPshychotropic = { host:'email-smtp.us-east-1.amazonaws.com' , port:587,from:"CJAMS@mdthink.maryland.gov", username:  app.get('apiKeys').awsmail_user, password: app.get('apiKeys').awsmail_password};
}
// Create a SMTP transporter object
return  nodemailer.createTransport(
    {
        host: mailerCredentialPshychotropic.host,
        port: mailerCredentialPshychotropic.port,
        auth: { user: mailerCredentialPshychotropic.username, pass: mailerCredentialPshychotropic.password },
    },
    {
        from: config.awsMail.from
    }
);}

module.exports.auditLogSingleSave = (referenceid,logtypekey,data) => { 
    var rawData = {
        "description":"information",
        "logtypekey":logtypekey ,
        "referenceid": referenceid,
        "insertedby" : data.securityuserid ? data.securityuserid : null,
        "updatedby" : data.securityuserid ? data.securityuserid : null,
        "metadata":data,
        "isnew":false,
        "isedit":false,
        "isdelete":false
      }
      LOGGER.debug(logtypekey);
      LOGGER.debug(data);
      LOGGER.debug("insert Audit Log -- ",rawData);
      app.models.Auditlog.createLogWithReferenceType(rawData);
      LOGGER.debug("insert Audit Log -End --",rawData);
      
}

module.exports.aftersave = (ctx,next,logtypekey,referenceid) => { 
    LOGGER.debug("aftersave Start");
    var rawData = {
        "description":"New information",
        "logtypekey":logtypekey ,
        "referenceid": referenceid,
        "metadata":null,
        "isnew":false,
        "isedit":false,
        "isdelete":false
      }
      LOGGER.debug("aftersave Start [0]");
      LOGGER.debug("rawData");
      LOGGER.debug('\x1b[33mAFTER SAVE HOOK START : %s\x1b[0m', JSON.stringify(ctx));
      if (ctx.isNewInstance) //CREATE
      { 
        rawData.isnew = true;
        rawData.metadata=ctx.instance;
        LOGGER.debug("insert1",rawData);
        app.models.Auditlog.createLogWithReferenceType(rawData);
        LOGGER.debug("insert1 -End --");
        
      } else {//UPDATE
         rawData.isedit=true;
         rawData.metadata=ctx.data ? ctx.data : ctx.instance;
         LOGGER.debug("update",rawData);
         app.models.Auditlog.createLogWithReferenceType(rawData);
         LOGGER.debug("update end");
        
      }
      LOGGER.debug("Exit After Save");
      next();
};
 
module.exports.beforesave = (ctx, next ) => {
    const currentDate = new Date().toLocaleString();
    LOGGER.debug("BEFORE SAVE HOOK START: ", ctx.Model.modelName );
 
    if (ctx.Model!=null && ctx.Model!=undefined && 
        ctx.Model.config.dataSource.settings.schema != null && ctx.Model.config.dataSource.settings.schema != undefined) {
        ctx.Model.definition.settings.postgresql.schema = ctx.Model.config.dataSource.settings.schema;
    }
    if (ctx.isNewInstance) //CREATE   
    { 
        LOGGER.debug("BEFORE SAVE HOOK CREATE METHOD START: ",currentDate);
        ctx.instance.insertedon = currentDate;
        ctx.instance.updatedon = currentDate;
        if(ctx.instance.effectivedate === null || ctx.instance.effectivedate === undefined)  {ctx.instance.effectivedate = currentDate;}
        if(ctx.instance.activeflag === null || ctx.instance.activeflag === undefined) {ctx.instance.activeflag = 1;}
    }
    else if (ctx.data !=null && ctx.data != undefined ) //UPDATE
     {
        LOGGER.debug("BEFORE SAVE HOOK UPDATE METHOD SET DEFAULTS START: ",currentDate);
        ctx.data.updatedon = currentDate;
        if (ctx.data.activeflag != null && ctx.data.activeflag != undefined && ctx.data.activeflag ==0){
              ctx.data.expirationdate = currentDate;}
    }
    else
    {
        LOGGER.debug("BEFORE SAVE HOOK OTHER THAN CREATE AND EDIT METHOD");
        
    }
    LOGGER.debug("BEFORE SAVE HOOK END: ", ctx.Model.modelName );
    next();
};
 
module.exports.access = (ctx, next ) => {
    LOGGER.debug("ACCESS HOOK START: ", ctx.Model.modelName, JSON.stringify(ctx.query.where));
    /*Override schema*/
    if (ctx.Model != null && ctx.Model != undefined && 
        ctx.Model.config.dataSource.settings.schema != null && ctx.Model.config.dataSource.settings.schema != undefined) {
        ctx.Model.definition.settings.postgresql.schema = ctx.Model.config.dataSource.settings.schema;
    }
   
    var limit = config.defaultPaginationLimit;
    var filter = ctx.query;

    if(!filter) { ctx.query = filter = {}; }
    if(!filter.nolimit) {
        if(!filter.limit || filter.limit > limit) {filter.limit = limit;}
        
        if(!filter.page) {filter.page = 1;}
    }
    if (filter.where!=null  && filter.where !=undefined) {if(filter.where.activeflag ==null || filter.where.activeflag ==undefined ) {filter.where.activeflag = 1;}}
    LOGGER.debug("ACCESS HOOK END: ", ctx.Model.modelName, JSON.stringify(filter));
    
    next();
};

module.exports.beforeremote = (ctx , next ) => {
    LOGGER.debug('\x1b[33mBEFORE REMOTE HOOK START : %s\x1b[0m', ctx.methodString, JSON.stringify(ctx.args.data));
    /*Override schema*/
    if ( ctx.Model != null && ctx.Model != undefined && 
            ctx.Model.config.dataSource.settings.schema != null && ctx.Model.config.dataSource.settings.schema != undefined) {
        ctx.Model.definition.settings.postgresql.schema = ctx.Model.config.dataSource.settings.schema;
    }

    var filter = {};

    if (ctx.args.data!=undefined) {
        filter = ctx.args.data
    }
    else  if (ctx.args.filter!=undefined) {
        filter = ctx.args.filter
    }
  
    //@Simar: The above scenarios work fine when query parameters have the filter.
    //But In some situations the values are sent in the 'request' payload,
    //So explicitly checking if the request has nolimit flag set.
    if (ctx.args.request != undefined && ctx.args.request.nolimit != undefined) {
        filter.nolimit = ctx.args.request.nolimit
    }

    var limit = config.defaultPaginationLimit;

   //@Simar: The above scenarios work fine for query parameters having the filter
   //In some situations the values are sent in the 'request' payload
   //So explicitly checking if the request has nolimit flag set
    if (ctx.args.request!= undefined && ctx.args.request.nolimit!=undefined){
        filter.nolimit = ctx.args.request.nolimit
    }
   
    filter = filterLimitcheck(filter, limit);
   
   if (filter.where == null  || filter.where == undefined) {
       filter.where={};
    }

    // Add a default activeflag value in the where clause if none is specified.
    if (filter.where != null  && filter.where != undefined) {
        if(filter.where.activeflag == null || filter.where.activeflag == undefined ) {
            filter.where.activeflag = 1;
        }
    }
  
    LOGGER.debug('\x1b[33mBEFORE REMOTE HOOK END : %s\x1b[0m', ctx.methodString, JSON.stringify(filter));
    
    next();
};

module.exports.generateAuditData = async (tableName, referenceid) => {
    const ds = app.dataSources.hcuewelfare;
    const sql = `select * from cjams.generate_audit_data('${tableName}','${referenceid}')`;

    const resp =  await new Promise((resolve, reject) => {
        return ds.connector.execute(sql, (err, data) => {
            if (err) {
                LOGGER.error('generate audit data error ' + err);
                reject(err);
            } else {
                LOGGER.debug('generate audit data ' + data);
                resolve(data);
            }
        })
    }).then(data => {
        return !!(data);
    }).catch(err => {
        logError(err)
        return false;
    });
    LOGGER.info(resp);
    return resp;
}

function filterLimitcheck(filter, limit) {
    if (!filter.nolimit) {
        //@Simar: We must remove this bad code -- filter.limit > limit
        //If the UI is explicitly requesting a limit, should honor that limit
        //and not override it with the default limit if requested size is more.
        if (!filter.limit || filter.limit > limit) {
            filter.limit = limit;
        }

        if (!filter.page) {
            filter.page = 1;
        }
    }
    return filter;
}

module.exports.formatRecording = desc => {
    const currentDate = new Date().toLocaleString();
    const currentuser = app.currentUser.username;
    return currentuser +','+currentDate + ', '+ desc;
}
module.exports.encryptresponse = data => {
    var encryptdata ;
    if(data) {
        encryptdata = btoa(encodeURIComponent(JSON.stringify(data)));   
    }
    return encryptdata;
}
module.exports.uniqueArray = a => [...new Set(a.map(o => JSON.stringify(o)))].map(s => JSON.parse(s));

//changes by venkatesh - sprint 1 PI-13
module.exports.formatDate = (inputdate, separator = '-') =>  {
    if(inputdate){
    var d = new Date(inputdate),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();

    if (month.length < 2) {month = '0' + month;}
    if (day.length < 2) {day = '0' + day;}

    return [month,day,year].join(separator);
    }
    else{
        return '';
    }
}

module.exports.formatPhoneNumber = (phoneNumberString) => {
    if(phoneNumberString){
        var cleaned = ('' + phoneNumberString).replace(/\D/g, '');
        var match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/);
        if (match) {
          return '(' + match[1] + ') ' + match[2] + '-' + match[3];
        }
        return '';
    } else {
        return '';
    }
  }

module.exports.formatDateAndTime = inputdate =>  {
    var d = new Date(inputdate),
        month = '' + (d.getMonth() + 1),
        day = '' + d.getDate(),
        year = d.getFullYear();
        var hour = d.getHours();
        var minutes = d.getMinutes();

    if (month.length < 2) {month = '0' + month;}
    if (day.length < 2) {day = '0' + day;}

    if (minutes < 10) {minutes = '0' + minutes;}

    return [month,day,year].join('-') + ", " + [hour,minutes].join(':');
}

module.exports.formatDateAndTimeReport = inputdate =>  {
    if (inputdate === undefined || inputdate === null || inputdate === '') {
        return '';
    }
    let d = new Date(inputdate);
    return moment(d).format('MM/DD/YYYY, h:mm a');
}

module.exports.nullcheck = function (request) {
    LOGGER.debug(loggermsg, request);
    if (request == null || request == undefined){
        return '';
    }else{
        return request;}
};

module.exports.getFullName = function (person) {
    LOGGER.debug(loggermsg, person);
    if (person == null || person == undefined){
        return '';
    }else{
        const nameKeys = [  'prefx' , 'firstname' , 'middlename' , 'lastname' ,'suffix'];
        let name = '';
        if(person){
            nameKeys.forEach(key => {
                if (person.hasOwnProperty(key) && person[key] != undefined && person[key] != null && person[key] != 'null' && person[key] != '' ) {
                name = name + person[key] + ' ';
                }
            });
        }
        return name;
    }
};

module.exports.removeBizarreCharacters = function (request) {
    LOGGER.debug(loggermsg, request);
    if (request == null || request == undefined){
        return '';
    }else{
        var s = String(request);
        s = s.replace(/“/g,'"');
        s = s.replace(/”/g,'"');
        s = s.replace(/[^\x20-\xFF]+/g, ''); // Characters that are not in ASCII range x20 to xFF will be removed
        s = s.replace(/↵/g,'<br>');
        s = s.replace(/\n/g,'<br>');
        s = s.replace(/↵/g,'<br>');
        s = s.replace(/\r/g,'');
        s = s.replace(//g,'');
        s = s.replace(/<0x1a>/g,'');
        return s;
    }
};

module.exports.ssnformat= function (value) 
{  
  if (String(value).match('^[0-9]{9}$')) {
    return (String(value).substring(0, 3) + '-' + String(value).substring(3, 5) + '-' + String(value).substring(5, 9));
} else { return ''; }
};
module.exports.addextradays= function (request) 
{ 
var date = new Date(request);
    var newdate = new Date(date);

    newdate.setDate(newdate.getDate() + 10);
    
    var dd = newdate.getDate();
    var mm = newdate.getMonth();
    var y = newdate.getFullYear();
    var mL = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return mL[mm] +' '+ dd + ',' + y;
};
module.exports. decrypt =function( data) {
    var decipher = crypto.createDecipher('aes-256-cbc', ensalt);
    var decrypted = decipher.update(data, 'hex', 'utf-8');
    decrypted += decipher.final('utf-8');
  
    return decrypted;
  };
// Encryption using crypto
const algorithm =  app.get('apiKeys').beacon_alg;

const iv =  app.get('apiKeys').beacon_iv;

const secretKey = app.get('apiKeys').beacon_scrkey;

  module.exports.cipherencrypt =function( data) {
      try{
        const keyBytes = Buffer.from(secretKey, 'utf8');
        const ivBytes = Buffer.from(iv, 'utf8');
        const cipher = crypto.createCipheriv(algorithm, keyBytes, ivBytes);

        // Encrypt the data
        let data1 = JSON.stringify(data); 
        let encrypted = cipher.update(data1, 'utf8', 'base64'); // Input as UTF-8, output as Base64
        encrypted += cipher.final('base64'); // Finalize encryption

        return encrypted;

} catch (error) {
    LOGGER.info('Encryption failed:', error.message);
    
}
  };

  module.exports.cipherdecrypt = function(data) {
    try {

         const encryptedData  = data;

         const keyBytes = Buffer.from(secretKey, 'utf8');
         const ivBytes = Buffer.from(iv, 'utf8');
         const decipher = crypto.createDecipheriv(algorithm, keyBytes, ivBytes);
            let decrypted = decipher.update(encryptedData, 'base64', 'utf8');
            decrypted += decipher.final('utf8');
        return decrypted; // Return the plain text
    } catch (error) {
        LOGGER.info('Decryption failed', error.message);
    }
};

module.exports.subtractDays = function (request,numofdays) {
    var result = new Date(request);
    var res = result.setDate(result.getDate() - numofdays);
    var date = new Date(res);
    return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate() + " " + date.getHours() + ":" + (date.getMinutes()) + ":" + (date.getSeconds());
}

module.exports.formatTime = inputdate => {
    if (inputdate) {
        var d = new Date(inputdate);
        var hours = d.getHours();
        var minutes = d.getMinutes();
        const ampm = hours >= 12 ? 'PM' : 'AM';
        hours = hours % 12;
        hours = hours ? hours : 12;
        hours = hours < 10 ? '0' + hours : hours;
        minutes = minutes < 10 ? '0' + minutes : minutes;
        return [hours,minutes].join(':') + " " + ampm;
    } else {
        return '';
    }
}
module.exports.initialCaps= function (sentence) {
    if(sentence == null || sentence == undefined){
        return '';}
    const words = sentence.split(' ');
    let returnValue = '';
    for(const word of words)
    {
        if(word.length > 1)
        {
            const wordlc = word.toLowerCase();
            returnValue += wordlc[0].toUpperCase() + wordlc.substring(1, wordlc.length) + ' ';
        }
        else
        {
            returnValue += word.toUpperCase() + ' ';
        }
        
    }
    return returnValue;
}

module.exports.getuserinfo = async (request) =>  {
    const ds = app.dataSources.hcuewelfare;
    var sql = "select * from getuserinfo($1,$2)";
    
   return new Promise((resolve, reject) => {    
        return ds.connector.execute(sql, [request.tokenId, request.email], (err, data) => {
          if (err){
            LOGGER.debug('getuserinfo Error '+ err);
            reject(err);
          } else {
            LOGGER.debug('user data '+data);
            resolve(data);
          }
        })
      }).then(result => {
        if (!result || !result.length) {
          throw new Error('getuserinfo returned no rows');
        }
        if (result[0].responsecode != 200) {
          // This branch used to read `unsecuredURL(url)`; neither identifier is
          // declared in this module or globally, so instead of reporting the
          // real failure it raised "ReferenceError: unsecuredURL is not
          // defined". The catch below swallows that into a resolved undefined,
          // so callers doing `data.teamtypekey` then hit a TypeError and
          // error-logger flattens it to a bare 400. Report the actual message.
          throw new Error(result[0].responsemsg);
        } else {
          LOGGER.debug(JSON.stringify(result[0].userdata));
          const user = JSON.parse(JSON.stringify(result[0].userdata));
          LOGGER.debug('user '+user);
          return result[0].userdata;
        }
    }).catch(err => {
        logError(err)
    });
}

module.exports.getSecurityDetails = function (request, reqctx) {
    let _securityusersid = undefined;
    if (reqctx?.req?.headers?.securityusersid) {
        _securityusersid = reqctx.req.headers.securityusersid || ' ';
    }
    return {
        securityuserid: request?.securityuserid ? request?.securityuserid : _securityusersid,
        v_securityuserid: request?.v_securityusersid ? request?.v_securityusersid : _securityusersid,
        email: reqctx?.req?.headers?.user_email_captureby_application || '',
        u_securityuserid: _securityusersid ? _securityusersid : 'user'
    }
}

module.exports.isNullorEmpty = function (x) {
    return (x !== null && x !== undefined && x !== "") ? true : false;
}

module.exports.executeDBQuery = function (sqlQuery, data) {
    const ds = app.dataSources.hcuewelfare;

    return new Promise((resolve, reject) => {
        ds.connector.execute(sqlQuery, data, (err, results) => {
            if (err) {
                LOGGER.error('Writer DB query failed', err);
                return reject(err);
            }
            resolve(results);
        });
    });
};

module.exports.executeSecondaryNodeDBQuery = async function(sqlQuery, data) {
    const readerEnabled = config.issecondarynodesearchenabled;

    const readerDS = app.dataSources.secondarynodesearch;
    const writerDS = app.dataSources.hcuewelfare;

    try {
        if (readerEnabled) {
            return await executeQuery(readerDS, sqlQuery, data);
        }
    } catch (err) {
        LOGGER.error('Reader node failed, falling back to writer', err);
    }

    return executeQuery(writerDS, sqlQuery, data);
};

function executeQuery(ds, sqlQuery, data) {
    return new Promise((resolve, reject) => {
        ds.connector.execute(sqlQuery, data, (err, results) => {
            if (err) return reject(err);
            resolve(results);
        });
    });
}

module.exports.getWebSafeAwsConfig = apiKeys => {
    const safeConfig = {};
    if (!apiKeys || typeof apiKeys !== 'object') {
        return safeConfig;
    }

    const allowList = Array.isArray(config.webAwsPublicFields) ? config.webAwsPublicFields : [];
    allowList.forEach(key => {
        if (Object.prototype.hasOwnProperty.call(apiKeys, key)) {
            safeConfig[key] = apiKeys[key];
        }
    });

    return safeConfig;
}

module.exports.normalizeCompactUpperKey = function(value) {
    return (value || '')
        .toString()
        .trim()
        .replace(/[-_\s/()]+/g, '')
        .toUpperCase();
}

module.exports.normalizeCompactLowerKey = function(value) {
    return (value || '')
        .toString()
        .trim()
        .toLowerCase()
        .replace(/[\s_\-\/]+/g, '');
}

// documentproperties.s3bucketpathname and userprofile/person.userphoto are meant to
// hold an api-root-relative path ('/attachments/downloadFileFromECMS?docId=...'), and
// the screens that display them prepend '/api' or the api host. Several of those
// screens prefix the value in place and then post it back, so a polluted value grows
// on every save: the request that lands here becomes
// '/api/apihttps://<host>/api/api/attachments/downloadFileFromECMS'. No route serves
// that, so loopback#urlNotFound raises a 404 that error-logger rewrites to
// statusCode 400 -- APM shows only "HttpError 400, No stack trace".
//
// Strip any origin and repeated '/api' segments so the column always holds the bare
// relative path. Absolute urls on another host (the EDMS upload path stores
// result.uploadUrl) carry no '/api' segment and are returned untouched.
const API_PREFIX_NOISE = /^(?:https?:\/{1,2}[^/]+)?(?:\/api)+/i;

module.exports.apiResourcePath = function(url) {
    let path = (url === null || url === undefined) ? '' : url.toString();
    let stripped = path.replace(API_PREFIX_NOISE, '');
    while (stripped !== path) {
        path = stripped;
        stripped = path.replace(API_PREFIX_NOISE, '');
    }
    return path;
}

module.exports.formatISODateOnly = function(inputDate) {
    if (!inputDate) {
        return null;
    }

    if (inputDate instanceof Date) {
        return Number.isNaN(inputDate.getTime()) ? null : inputDate.toISOString().slice(0, 10);
    }

    const text = inputDate.toString().trim();
    if (!text) {
        return null;
    }

    const isoPrefix = text.match(/^(\d{4}-\d{2}-\d{2})/);
    if (isoPrefix && isoPrefix[1]) {
        return isoPrefix[1];
    }

    const usFormat = text.match(/^(\d{1,2})\/(\d{1,2})\/(\d{4})$/);
    if (usFormat) {
        const [, month, day, year] = usFormat;
        const mm = month.padStart(2, '0');
        const dd = day.padStart(2, '0');
        if (Number(mm) >= 1 && Number(mm) <= 12 && Number(dd) >= 1 && Number(dd) <= 31) {
            return `${year}-${mm}-${dd}`;
        }
    }

    const parsed = new Date(text);
    return Number.isNaN(parsed.getTime()) ? null : parsed.toISOString().slice(0, 10);
}

module.exports.deriveApiObjectSubtype = function(endpoint, method, prefix = 'api') {
    const normalizedMethod = (method || '').toUpperCase();
    const actionMap = {
        GET: 'get',
        POST: 'create',
        PUT: 'update',
        PATCH: 'update',
        DELETE: 'delete'
    };
    const action = actionMap[normalizedMethod] || normalizedMethod.toLowerCase() || 'call';
    const cleanPath = (endpoint || '').split('?')[0].replace(/^\/+|\/+$/g, '');
    if (!cleanPath) {
        return `${prefix}_${action}`;
    }

    const segments = cleanPath.split('/').filter(Boolean);
    let resource = segments[segments.length - 1] || prefix;
    if (/^\d+$/.test(resource) && segments.length > 1) {
        resource = segments[segments.length - 2];
    }

    return `${resource}_${action}`;
}