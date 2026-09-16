'use strict';

const { PerformanceObserver, constants } = require('perf_hooks');

const obs = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    if (entry.duration > 100) { // only log long GC pauses
      const kind = {
        [constants.NODE_PERFORMANCE_GC_MAJOR]: 'major',
        [constants.NODE_PERFORMANCE_GC_MINOR]: 'minor',
        [constants.NODE_PERFORMANCE_GC_INCREMENTAL]: 'incremental',
        [constants.NODE_PERFORMANCE_GC_WEAKCB]: 'weakcb',
      }[entry.kind] || entry.kind;
      console.error(`[GC] ${kind} pause ${entry.duration.toFixed(1)}ms`);
    }
  }
});
obs.observe({ entryTypes: ['gc'] });

var loopback = require('loopback');
var boot = require('loopback-boot');
var fs = require('fs');
var log4js = require('log4js');
const Xss=require('xss');
const http =require('http');
const fetchDBKeys = require('./awsdbrotation');
const fetchAPIKeys = require('./getapikeys');
var app = loopback();
var config = require('../server/config.json');
const log4jsLocalConfig = require('../config/log4js-local.json');
const log4jsCloudConfig = require('../config/log4js-cloud.json');
const server = http.createServer(app);

log4js.addLayout("json", function(conf){
  return function(logEvent){
    return JSON.stringify(logEvent) + conf.separator;
  };
});

if(config.environment =='state'){
  log4js.configure(log4jsCloudConfig);
}else{
  log4js.configure(log4jsLocalConfig);
}

var schedule = require('node-schedule');
const emailloggermsg = 'app.currentUser.email ';
const headerpath = 'header.html';
const footerpath = 'footer.html';
const securityerrormsg = 'SECURITY ERROR FOR <';
const uuidloggermsg = " fetchemailid Open AM UUID ";
const downloadfromecmsurl = '/api/attachments/downloadFileFromECMS';
const badorinvalidreqmsg = 'Bad or Invalid request';
const downloadfromedmsurl = '/api/attachments/downloadFileFromEDMS';



if (config.production) {
  require('newrelic');
}

/**
 * make a log directory, just in case it isn't there.
 */
try {
  if(config.environment=="state"){
    fs.mkdirSync('/opt/node/outputs/log');
  } else{
    fs.mkdirSync('outputs/log');
  }
} catch (e) {
  if (e.code != 'EEXIST') {
    LOGGER.error("Could not set up log directory, error was: ",e);
  }
}

// Get the logger
var LOGGER = log4js.getLogger("app");

// log4js connect-logger
app.use(log4js.connectLogger(log4js.getLogger("http"),{ level: 'auto' }));

// MAR
var m_color_LogRequest = '\x1b[34m';
var m_color_LogSuccess = '\x1b[32m';
var m_color_LogError = '\x1b[31m';
var m_color_yellow = '\x1b[92m';
var m_color_Reset = '\x1b[0m';

app.start = function(){
  LOGGER.info(`STARTUP - Worker PID=${process.pid} cluster_worker=${process.env.pm_id ?? 'none'} NODE_ENV=${process.env.NODE_ENV}`);
  return server.listen(app.get('port'), function() {
    app.emit('started');
    
    // FIX: Safely grab the URL with a fallback to localhost/port if undefined
    let configuredUrl = app.get('url') || `http://${app.get('host') || 'localhost'}:${app.get('port')}`;
    let baseUrl = configuredUrl.replace(/\/$/, '');
    
    app.baseurl=baseUrl;
    if (app.get('loopback-component-explorer')) {
      let explorerPath = app.get('loopback-component-explorer').mountPath;
      LOGGER.debug('Browse your REST API at %s%s', baseUrl, explorerPath);}
  });
}

//Add Counts Mixin to loopback
require('loopback-counts-mixin')(app);
//to get DB security Keys from secrets manager
//fetchDBKeys().then((res,err1)=>{
//to get API/WEB security Keys from secrets manager
fetchAPIKeys().then((result,err) => {
  var apikeys = result;  //we are doing parse
  app.set("apiKeys",apikeys); //seting keys to app
  initializeSecretsAndConfigFn(err);
  // Bootstrap the application, configure models, datasources and middleware.
  // Sub-apps like REST API are mounted via boot scripts.
  app.set("LOCALFILE_ACCESS_URL",config.localfile_accessurl); //seting acces url to app varable

  boot(app,{
    'appRootDir': __dirname
    /*bootDirs - Commented by Poongodi to resolve Placement finance issue*/
    ,
    'bootDirs': [
      `${__dirname}/boot`,
      `${__dirname}/boot/definitions`,
      `${__dirname}/boot/remotes`,
      `${__dirname}/boot/controllers`
    ],
  },function (err2) {
    LOGGER.debug('STARTUP - running boot function.');
    if (err2) {
      throw err2;
    }

    // enable CORS!
    app.use(enableCORS);

    //Middleware for normal flow
    app.use(middlewareNormalFn);

    //Middleware for error
    app.use(middlewareErrorFn);

    // start the server if `$ node server.js`
    if (require.main === module) {
      LOGGER.debug('STARTUP - inside main startup.');
      app.start();

    }

    // Catch all exception here to avoid application crash and continue
    process.on('uncaughtException',function (err1) {

      LOGGER.debug("Application NOT Exiting...");
      const errObj = {};
      errObj.type = "uncaughtException";
      errObj.message = err1.message;
      errObj.statusCode = 500;
      errObj.stack = err1.stack;
      LOGGER.error(err1);
      return app.models.Welfarelog.writeToErrorlogFile(errObj,null,null);
    });

    process.on('unhandledRejection', function(reason) {
      const errObj = buildErrorPayloadFn(reason);
      return app.models.Welfarelog.writeToErrorlogFile(errObj, null, null);
    });

  });
});

const createSecurityError = (statusCode, errorCode, email, errorMsg) => {
  const sanitizedEmail = sanitizeInput(email || '');
  const sanitizedError = sanitizeInput(errorMsg || '');
  return {
    status: statusCode,
    ERROR_CODE: errorCode,
    MESSAGE: btoa(encodeURIComponent('SECURITY ERROR FOR EMAIL ID OPENAM <' + sanitizedEmail + '> : ' + sanitizedError))
  };
};

const handleLoginEndpoint = (req, res, next) => {
  LOGGER.debug('MIDDLEWARE - running login/getaccesstoken functions.');
  fetchUser(req)
    .then(x => {
      LOGGER.debug("data base");
      next();
      return x;
    }).catch(err => {
      // Honour the status the failure carries instead of calling everything a
      // 500: an unknown or deactivated OpenAM email is a 401, same as
      // handleProtectedEndpoint already reports for the identical rejection.
      const requestedEmail = app.currentUser
        ? (app.currentUser.email || app.currentUser.requestedEmail)
        : null;
      // sanitizeInput() returns '' for anything that is not a string, so
      // passing the Error object blanked out the reason in MESSAGE.
      const errorMsg = err?.message || err;
      const error = createSecurityError(err?.statusCode || 500, "100001", requestedEmail, errorMsg);
      res.status(error.status);
      LOGGER.error(securityerrormsg + requestedEmail + '> : ' + errorMsg);
      return res.send({ ERROR_CODE: error.ERROR_CODE, MESSAGE: error.MESSAGE });
    });
};

const handleProtectedEndpoint = (req, res, next) => {
  fetchUser(req)
    .then(x => {
      if (!app.currentUser.email && checkoriginalUrl(req)) {
        const error = createSecurityError(401, "401", app.currentUser ? app.currentUser.requestedEmail : null, 'No valid user found');
        res.status(error.status);
        LOGGER.error('SECURITY ERROR FOR EMAIL ID OPENAM <' + (app.currentUser ? app.currentUser.requestedEmail : null) + '> : No valid user found');
        return res.send({ ERROR_CODE: error.ERROR_CODE, MESSAGE: error.MESSAGE });
      }
      LOGGER.debug('MIDDLEWARE - authenticated user, proceeding.');
      next();
      return x;
    })
    .catch(err => {
      const errorMsg = err?.message || err;
      const error = createSecurityError(401, "401", app.currentUser?.requestedEmail, errorMsg);
      res.status(error.status);
      LOGGER.error('SECURITY ERROR FOR EMAIL ID OPENAM <' + (app.currentUser?.requestedEmail || 'unknown') + '> : ' + errorMsg);
      return res.send({ ERROR_CODE: error.ERROR_CODE, MESSAGE: error.MESSAGE });
    });
};

const isLoginEndpoint = (url) => {
  return url && (url.includes('/api/users/login') || url.includes('/api/admin/userprofile/generateAccessToken'));
};

const middlewareNormalFn = (req,res,next) => {
  LOGGER.debug('MIDDLEWARE - starting');

  LOGGER.debug(`${req.method} ${req.originalUrl} - Request started`);

  logInfo(req);
  if(req?.body){
    LOGGER.debug('MIDDLEWARE - sanitizing request.');
    sanitizeObject(req);
  }

  if (!sanityCheckRequest(req, res)) {
    return; // Stop execution if sanity check fails
  }
  app.requrl = req.protocol + '://' + req.headers.host;
  LOGGER.debug(req.headers.host);
  LOGGER.debug('req.headers: ' + req.headers);
  app.headers = req.headers;
  app.currentUser = {};
  app.currentUser.requestedEmail = fetchemailid(req);
  LOGGER.debug(emailloggermsg+ app.currentUser.requestedEmail);

  if(config.state) {
    const log = 'CJAMS timestamp:' + new Date() + ': email: ' + app.currentUser.requestedEmail +  ': headers :' + JSON.stringify(req.headers);
    LOGGER.debug('log '+ log);
    if(!fetchemailid(req) && checkoriginalUrl(req) ){
      const error = createSecurityError(401, "401", app.currentUser.requestedEmail, 'missing or unresolvable user email on request');
      res.status(error.status);
      return res.send({ ERROR_CODE: error.ERROR_CODE, MESSAGE: error.MESSAGE });
    }
  }

  LOGGER.debug('app.currentUser.tokenId ' + app.currentUser.tokenId,'requested emailID :' + app.currentUser.requestedEmail);

  if (isLoginEndpoint(req.originalUrl)) {
    return handleLoginEndpoint(req, res, next);
  }

  // For protected endpoints, identity must be derived from server-side validation.
  if (!unsecuredURL(req.originalUrl || '') && (req.originalUrl.includes('/api/users/login') || req.originalUrl.includes('/api/admin/userprofile/generateAccessToken'))) {
    return handleProtectedEndpoint(req, res, next);
  }

  LOGGER.debug('MIDDLEWARE - unsecured endpoint, proceeding.');
  next();
}

const middlewareErrorFn = (err,req,res,next) => {
  LOGGER.error(`MIDDLEWARE ERROR - ${req.method} ${req.originalUrl}`);
  LOGGER.error('Error details:', {
    message: err.message,
    stack: err.stack,
    code: err.code,
    errno: err.errno,
    sqlState: err.sqlState
  });

  // Check if response already sent to prevent "Callback was already called" error
  if (res.headersSent) {
    LOGGER.error('Response already sent, cannot handle error');
    return;
  }

  if (isLoginOrTokenGenerationUrlFn(req)) {
    fetchUser(req)
      .then(x => {
        LOGGER.error('Error logging block');
        logError(err,req,res);
        if (!res.headersSent) {
          res.status(500).send("Welfare custom error.");
        }
        return x;
      })
      .catch(err1 => {
        LOGGER.error('Error in fetchUser:', err1);
        if (!res.headersSent) {
          res.status(500);
          var _customeError = {};
          _customeError.ERROR_CODE = "100001";
          // Sanitize the email and error message to prevent XSS
          const { sanitizedEmail, sanitizedError } = returnEmailAndErrorFn(err1);
          LOGGER.debug(securityerrormsg + sanitizedEmail + '> : ' + sanitizedError);
          _customeError.MESSAGE = btoa(encodeURIComponent(securityerrormsg + sanitizedEmail + '> : ' + sanitizedError));
          res.send(_customeError);
        }
      });
  } else {
    // Log non-login errors with context
    LOGGER.error(`Unhandled error on ${req.originalUrl}:`, err);
    if (!res.headersSent) {
      next(err);
    }
  }
}


//Logging the request
const logRequest = (reqObj, resObj) => {
  LOGGER.debug('log reqObj '+reqObj);
  return app.models.Welfarelog.createLog(reqObj, resObj)
  .then(result => {
    LOGGER.debug( m_color_LogRequest
                + "RECEIVED REQUEST : "
                + m_color_Reset
                + JSON.stringify(result).replace(',', ','+ m_color_yellow).replace(',"verb"', m_color_Reset+',"verb"'));
    return result
  })
  .catch(err => {
    LOGGER.debug(m_color_LogError
                + "ERROR DESCRIPTION : "
                + err
                + m_color_Reset);
    return err;
  });
};


const fetchSecurityUserId = (reqObj) => {
  var securityuserid;
  if (reqObj.query && reqObj.query.securityuserid) {
    securityuserid = reqObj.query.securityuserid;
  }
  if (!securityuserid) {
    if (reqObj.get('securityuserid')) {
      securityuserid = reqObj.get('securityuserid');
    } else if (reqObj.body) {
      securityuserid = reqObj.body.securityuserid;
    }
  }

  return securityuserid;
}

const validateClientIdentityAgainstAuthenticatedUser = (authenticatedUser, requestedEmail, requestedSecurityUserId, url) => {
  if (!authenticatedUser) {
    return false;
  }

  // Unsecured endpoints may not have authenticated identity.
  if (unsecuredURL(url || '')) {
    return true;
  }

  if (requestedEmail && authenticatedUser.email
      && requestedEmail.toLowerCase().trim() !== authenticatedUser.email.toLowerCase().trim()) {
    return false;
  }

  if (requestedSecurityUserId && authenticatedUser.securityusersid
      && String(requestedSecurityUserId).trim() !== String(authenticatedUser.securityusersid).trim()) {
    return false;
  }

  return true;
}

const fetchToken = (reqObj) => {
  var tokenId = false;
  if (reqObj.query && reqObj.query.access_token) {
    tokenId = reqObj.query.access_token;
  } else if (reqObj.headers && reqObj.headers.access_token) {
    tokenId = reqObj.headers.access_token
  } else if (reqObj.headers && reqObj.headers.authorization) {
    var btoken = reqObj.headers.authorization;
    if (btoken) {
      tokenId = btoken.replace(/Bearer/g,'');
    }
  }
  LOGGER.debug(" fetchToken ",tokenId);
  return tokenId ? tokenId.trim() : tokenId;
};

const fetchemailid = (reqObj) => {
  var uid;
  if (reqObj.query && reqObj.query.uid) {
    uid = reqObj.query.uid;
  } else if (reqObj.headers && reqObj.headers.uid) {
    uid = reqObj.headers.uid
  }
  if (!uid) {
    if (reqObj.get('uid')) {
      uid = reqObj.get('uid');
    } else if (reqObj.body) {
      uid = reqObj.body.email;
    }
  }
  LOGGER.debug(uuidloggermsg,uid);
  // Security fix: do not trust client-controlled headers for user identity.
  // Identity must only come from OpenAM-provided `uid` sources.
  if (reqObj.headers && reqObj.headers.user_email_captureby_application
    && reqObj.headers.user_email_captureby_application !== uid) {
    LOGGER.warn("Ignoring client email header due to mismatch with OpenAM UID",uid,"=",reqObj.headers.user_email_captureby_application);
  }
  return uid;
}

const fetchUser = (reqObj) => {
  var tokenId = '';
  LOGGER.debug(" fetchUser ",reqObj.originalUrl);
  if (checkoriginalUrl(reqObj)) {
    tokenId = fetchToken(reqObj);
  }
  var emailuid = fetchemailid(reqObj);
  var requestedSecurityUserId = fetchSecurityUserId(reqObj);
  var url = reqObj.originalUrl;
  app.currentUser = false;
  app.currentUser = {};
  app.currentUser.tokenId = tokenId;
  app.currentUser.requestedEmail = emailuid;
  app.currentUser.requestedSecurityusersid = requestedSecurityUserId;
  LOGGER.debug('app.currentUser.tokenId ' + app.currentUser.tokenId,'emailID :' + emailuid);
  LOGGER.debug(emailloggermsg + app.currentUser.requestedEmail);
  return getuserinfo(tokenId, emailuid)
  .then(result => {
    const response = result[0];

    if (response.responsecode !== 200) {
      if (!unsecuredURL(url)) {
        LOGGER.debug('error block 1st Deb');
        throw new Error(response.responsemsg);
      }
      return null;
    }

    if (!response.userdata) {
      if (!unsecuredURL(url)) {
        LOGGER.debug('error block 2nd Deb');
        throw new Error('Please review user details.. could not find a valid user');
      }
      return null;
    }

    LOGGER.debug(JSON.stringify(response.userdata));
    const user = JSON.parse(JSON.stringify(response.userdata));
    LOGGER.debug('user ' + user);

    if (!validateClientIdentityAgainstAuthenticatedUser(user, emailuid, requestedSecurityUserId, url)) {
      throw new Error('Request identity does not match authenticated user context');
    }

    setcurrentuser(user, reqObj.originalUrl);
    return user;
  }).catch(err => {
    logError(err,null,null);
    throw err;
  });
};

function buildErrorPayloadFn(reason) {
  const errObj = {};
  errObj.type = 'unhandledRejection';
  errObj.message = reason && reason.message ? reason.message : String(reason);
  errObj.statusCode = 500;
  errObj.stack = reason && reason.stack ? reason.stack : null;
  return errObj;
}
 
function initializeSecretsAndConfigFn(err) {
  if (err) {
    LOGGER.error("not able to fetch api / web keys from aws secret  ", err);
  } else {
    LOGGER.debug('STARTUP - API Keys set.');
  }
  if (config.environment === 'local') {
    LOGGER.debug('STARTUP - Configuring for local environment.');
    const res = config.dbhosturls;
    Object.keys(res).forEach(key => app.set(key, res[key]));
  }
}

function isLoginOrTokenGenerationUrlFn(req) {
  return req.originalUrl && (req.originalUrl.includes('/api/users/login') || req.originalUrl.includes('/api/admin/userprofile/generateAccessToken'));
}

function returnEmailAndErrorFn(err1) {
  const sanitizedEmail = sanitizeInput(app.currentUser.email || '');
  const sanitizedError = sanitizeInput(err1 || '');
  return { sanitizedEmail, sanitizedError };
}

function checkoriginalUrl(reqObj){
  return (reqObj.originalUrl && reqObj.originalUrl.indexOf('login') < 0
    && reqObj.originalUrl.indexOf('updatecisclientid') < 0
    && reqObj.originalUrl.indexOf('updatencpcasenumbers') < 0
    && reqObj.originalUrl.indexOf('personsearch') < 0
    && reqObj.originalUrl.indexOf('maltreatorsearch') < 0
    && reqObj.originalUrl.indexOf('document') < 0
    && reqObj.originalUrl.indexOf('Document') < 0
    && reqObj.originalUrl.indexOf('intakereport') < 0
    && reqObj.originalUrl.indexOf('style') < 0
    && reqObj.originalUrl.indexOf('dhslogo') < 0
    && reqObj.originalUrl.indexOf(headerpath) < 0
    && reqObj.originalUrl.indexOf(footerpath) < 0
    && reqObj.originalUrl.indexOf('generateAccessToken') < 0)
}

async function getuserinfo(tokenId, emailuid){
  const util = require('../common/utils/utils');
  var sql = "select * from getuserinfo($1,$2)"
  try {
    const data = await util.executeDBQuery(sql, [tokenId, emailuid]);
    LOGGER.debug('user data ' + data);
    const dataResponse = Array.isArray(data) ? data[0] : data;

    if (dataResponse?.responsecode === 401) {
      LOGGER.error('Application Error: ' + dataResponse.responsemsg);
      // Carry the responsecode the DB function chose. getuserinfo returns 401
      // when the OpenAM email has no activeflag=1 userprofile row - a client
      // auth failure, not a server fault - but a bare Error gave the caller no
      // way to tell the two apart, so handleLoginEndpoint reported it as a 500.
      const err = new Error(dataResponse.responsemsg);
      err.statusCode = 401;
      throw err;
    }

    LOGGER.debug('user data ' + JSON.stringify(data));
    return data;
  } catch (err) {
    LOGGER.error('>>>>ERROR:', err);
    throw err;
  }
}

const logInfo = (req) => {
  if (req.originalUrl.indexOf('tb_picklist_values') > -1
    || req.originalUrl.indexOf('Authorizes') > -1
    || req.originalUrl.indexOf('users') > -1
    || req.originalUrl.indexOf('referencetype') > -1) {
    return;
  }

  LOGGER.info({
    'url': req.originalUrl,
    'method': req.method,
    'headers': {
      "uid": req.headers.uid ? req.headers?.uid : req.headers?.User_email_captureby_application,
      "securityuserid": req.headers.securityusersid
    },
    'params': req.params,
    'body': req.body
  });
}

const setcurrentuser = async (user,requrl) => {
  const util = require('../common/utils/utils');
  app.currentUser = user;
  app.currentUser.userprofile = {};
  app.currentUser.userprofile.fullname = user.fullname;
  app.currentUser.userprofile.securityusersid = user.securityusersid;
  app.currentUser.teamname = user.teamname;
  app.currentUser.teamtypekey = user.teamtypekey;
  app.currentUser.teamtypedescription = user.teamtypedesc;
  app.currentUser.teamcounty = user.countyid;
  app.currentUser.roletypekey = user.roletypekey;

  if (app.currentUser.securityusersid && user.securityusersid && user.securityusersid !== app.currentUser.securityusersid) {
    const jsondata = {
      api_url: requrl,
      api_securityusersid: app.currentUser.securityusersid,
      openam: user,
      openam_securityusersid: user.securityusersid
    }
    const sql = ` INSERT INTO cjams.auditlog(logtypekey, description, isnew, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, modifieddata)
                VALUES('INCRTUSERID', 'Securityusersid is different in OpenAM Input and API Input', false, false, false, $1, $1, now(), now(), $2); `
    try {
      return await util.executeDBQuery(sql, [app.currentUser.securityusersid, jsondata]);
    } catch (err) {
      LOGGER.error('>>>>ERROR:', err);
      throw err;
    }
  }

  if (!app.currentUser.securityusersid) {
    app.currentUser.securityusersid = user.securityusersid;
  }
  app.currentUser.email = user.email;
}

const unsecuredURL_ENDPOINTS = [
  '/personsearch',
  '/maltreatorsearch',
  '/updatecisclientid',
  '/updateuploadstatus',
  '/ive/updatencpcasenumbers',
  '/intakereport',
  '/generateAccessToken',
  '/style',
  '/dhslogo',
  '/header.html',
  '/footer.html'
];

const unsecuredURL = (url) => {
  return unsecuredURL_ENDPOINTS.some(endpoint => url.includes(endpoint));
};

//Logging the error
const logError = (errObj,reqObj,resObj) => {
  app.models.Welfarelog.createErrorLog(errObj,reqObj,resObj)
    .then(result => {
      return result;
    })
    .catch(err => {
      LOGGER.debug(err);
      return err;
    });
};

/* Enabling Cors and Handled options */
const enableCORS = function (req,res,next) {
  res.header('Access-Control-Allow-Origin','*');
  res.header('Access-Control-Allow-Methods','GET,PUT,POST,DELETE,OPTIONS');
  //res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization, Content-Length, X-Requested-With');
  // intercept OPTIONS method
  if ('OPTIONS' == req.method) {
    res.sendStatus(200);
  }
  else {
    next();
  }
};

function sanitizeObject(obj) {
  obj =JSON.stringify(obj.body);
  var sanitizedObj = {};
    // Sanitize the email and  password to prevent XSS
    sanitizedObj = Xss(obj);
  return sanitizedObj;
}
const sanityCheckRequest = (req, res) => {

  if (req.method == 'GET' && req.query && Object.keys(req.query).length > 0) {
    var qparams = JSON.stringify(req.query);
    
    //Regex to ignore the sanity check for UUID pattern match for e.g.988413c4-4cfc-4cfc-b3ac-aae5cd1384ed
    qparams = qparams.replace(/[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/gi,'');

    //LDAP Check
    var arr = qparams.match('\\b(\\w+)(?:\\W+\\1\\b)+');
    if (arr && arr.length > 0
      //the regex pattern matches any string with repeated patterens so dates like '**-02-02', '**-04-04' are getting flagged and returning error
      //this is causing issue when requests contain same 'mm' & 'dd', so adding an exception specifically for requests with date format 'yyyy-mm-dd'
      && !qparams.match(/\d{4}-\d{2}-\d{2}/)
      //the following api exceptions already existed so for now we are not touching those, ideally these should be made into 'post' requests
      && (!req.url.includes('/api/Documentproperties/getcaseworkerattachments')) && (!req.url.includes('progressnote/getalldarecording'))&& (!req.url.includes('beacon/getbeaconaudit'))  && (!req.url.includes('Meetingrecordings/gethearingdetails')) && (!req.url.includes(downloadfromecmsurl))) {
      const err = {};
      err.ERROR_CODE = "100002";
      err.MESSAGE = badorinvalidreqmsg;
      res.send(err);
      return false;
    }

    //SQL Injection Check
    var arr1 = qparams.match('((select|update|delete|insert|create|drop|truncate)(?:$|\\W))');
    if (arr1 && arr1.length > 0 && !(req.url.includes(downloadfromecmsurl) && !(req.url.includes(downloadfromedmsurl)) )) {
      const err = {};
      err.ERROR_CODE = "100003";
      err.MESSAGE = badorinvalidreqmsg;
      res.send(err);
      return false;
    }

    //Script Injection Check
    var arr2 = qparams.match('((if|sleep|for|switch|while)(?:$|\\W))');
    if (arr2 && arr2.length > 0 && !(req.url.includes(downloadfromecmsurl)) && !(req.url.includes('pagefooter.html')) && !(req.url.includes(downloadfromedmsurl))) {
      const err = {};
      err.ERROR_CODE = "100004";
      err.MESSAGE = badorinvalidreqmsg;
      res.send(err);
      return false;
    }
  }
  return true;
}

function sanitizeInput(str) {
    if (typeof str !== 'string') return '';
    
    const map = {
        '&': '&amp;',
        '<': '&lt;',
        '>': '&gt;',
        '"': '&quot;',
        "'": '&#x27;',
        "/": '&#x2F;'
    };
    
    return str.replace(/[&<>"'/]/g, (match) => map[match]);
}

module.exports = app;