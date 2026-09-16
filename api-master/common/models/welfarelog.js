'use strict';

var app = require('../../server/server');
var loopback = require('loopback');
var boot = require('loopback-boot');
const util = require('../utils/utils');
const moment = require('moment');
const fs = require('fs');
var endOfLine = require('os').EOL;
var config = require('../../server/config.json');

const LOGGER = require('log4js').getLogger("welfarelog");
const unknownusermsg = 'UNKNOWN-USER';

function returnResponseStatusCodeFn(errObj, resObj) {
    let responseStatusCode = "";
    if (errObj) {
        responseStatusCode = errObj.statusCode || errObj.responsestatuscode;
    } else if (resObj) {
        responseStatusCode = resObj.statusCode;
    }
    return responseStatusCode;
}
 
module.exports = Welfarelog => {

    const simpleReqInfo = err => {
        let userid = "";
        if(app.currentUser !== undefined){
        return util.getuserinfo(app.currentUser)
		.then(data => {
			if(data){
			userid = data.id;
            return {
                request: "",
                verb: err.type,
                requestdata: "",
                insertedby: userid,
                errormsg: err.messsage,
                stacktrace: err.stack,
                responsestatuscode: err.statusCode
            }
         }
        });}
    };

    const formatReqInfo = (reqObj, resObj, errObj) => {
        var requestObj = "";
        var reqUrl = "";
        var reqMethod = "";
        const tokenid ="";
        const errorMsg = "";
        const stackTrace = "";
        const responseStatusCode = '200';
       
        return {
            request: reqUrl,
            verb: reqMethod,
            requestdata: requestObj,
            errormsg: errorMsg,
            stacktrace: stackTrace,
            responsestatuscode: responseStatusCode,
            tokenid: tokenid
        }
    };

    const formatLogReqInfo = (reqObj, resObj, errObj) => {
        var data = reqObj.method === "GET" ? JSON.stringify(reqObj.query) : JSON.stringify(reqObj.body);
        let stokenid ="";
        if ( reqObj.headers!=undefined &&  reqObj.headers.access_token!=undefined){
            stokenid = reqObj.headers.access_token; 
        }
        var logtxt = new Date().toISOString() + "\t";
        logtxt += (app.currentUser? app.currentUser.email : unknownusermsg)  + "\t";
        logtxt += "Level: " + config.loglevel + "\t";
        logtxt += "tokenid: " + stokenid  + "\t";
        logtxt += "request: " + reqObj.originalUrl + "\t";
        logtxt += "verb: " + reqObj.method + "\t";
        logtxt += "requestdata: " + data + "\t";
       
        logtxt += endOfLine  ;

        return logtxt;
    }
    const formatErrReqInfo = (reqObj, resObj, errObj) => {
    
        let stokenid =""; 
        if (reqObj && reqObj.headers && reqObj.headers!=undefined &&  reqObj.headers.access_token!=undefined){
            stokenid = reqObj.headers.access_token; 
        }
        // util.logError hands over a flattened object whose stack lives on
        // .stacktrace, so reading only .stack left this undefined and the
        // .toString() below threw -- taking the whole log write down with it.
        const stackTrace = (errObj && (errObj.stack || errObj.stacktrace)) || "";
        let responseStatusCode = returnResponseStatusCodeFn(errObj, resObj);

        var logtxt = new Date().toISOString() + "\t";
        logtxt += (app.currentUser? app.currentUser.email : unknownusermsg)  + "\t";
        logtxt += "Level: " + config.loglevel + "\t";
        logtxt += "tokenid: " + stokenid + "\t";
        // Print the endpoint before the stack: it is the field needed to match a
        // log line against an APM transaction, and a stack ending mid-line used
        // to push it somewhere no grep would find.
        if (reqObj) {
            logtxt += "verb: " + reqObj.method + "\t";
            logtxt += "request: " + reqObj.originalUrl + "\t";
        }
        if (errObj && errObj.type) {
            logtxt += "Error type: " + errObj.type + "\t";
        }
        logtxt += "Error code: " + responseStatusCode + "\t";
        // server.js logs a raw Error (.message); util.logError a flattened one (.errormsg).
        logtxt += "Error message: " + ((errObj && (errObj.errormsg || errObj.message)) || "") + "\t";
        logtxt += "Error stack: " + stackTrace.toString().replace(/\r?\n|\r/g, " ");

        logtxt += endOfLine  ;
        return logtxt;
    };

    Welfarelog.createLog = (reqObj, resObj) => {
            var data = formatReqInfo(reqObj, resObj, null);
            return Promise.resolve(data); 
    };

    Welfarelog.createErrorLog = (errObj , reqObj, resObj) => {
        var logtype = config.logtype;
        LOGGER.error(errObj);
        if (logtype!= null && logtype !=undefined && logtype =="db"){
            return Welfarelog.logtodb(reqObj, resObj,errObj);
        }
        else{ 
           return Welfarelog.logerrortofile(reqObj, resObj,errObj);
        } 
    };

    Welfarelog.logtodb = (reqObj, resObj,errObj) => {
        LOGGER.debug("database logging is disabled, due to database idle connection issue");
    };

    Welfarelog.logtofile = (reqObj, resObj) => {
        var logtxt = formatLogReqInfo(reqObj, resObj, null); 
        var data = formatReqInfo(reqObj, resObj, null);
        return Promise.resolve(Welfarelog.writetofle(logtxt,data,'api')); 
    };

    Welfarelog.logerrortofile = (reqObj, resObj,errObj) => {
        var logtxt = formatErrReqInfo(reqObj, resObj, errObj ); 
        var data = formatReqInfo(reqObj, resObj, errObj); 
        let errappname ="api";
        if (errObj.errorfromweb!=null && errObj.errorfromweb!=undefined){
            errappname ="web";
        }
        return Promise.resolve(Welfarelog.writetofle(logtxt,data,errappname)); 
    };
    
    Welfarelog.createPlainLog = (err) => {
        var data = simpleReqInfo(err);
        return Welfarelog.create(data)
        .then(response => response)
        .catch(err1 => err1);
    };

    // Write exception into flate file 
    // PENDING - LOG_LEVEL needs to be implemented to skip based on configuration 
    Welfarelog.writeToErrorlogFile = (errObj,loglevel) => {
        if ( config.loglevel < loglevel ){
            return null;
        }   
        var errortxt = new Date().toISOString() + "\t";
        errortxt += (app.currentUser? app.currentUser.email : unknownusermsg)  + "\t";
        errortxt += "Level: " + loglevel + "\t";
        errortxt += "Error code: " + errObj.code + "\t";
        errortxt += "Error stack: " + errObj.stack.toString().replace(/\r?\n|\r/g, " ");
        errortxt += endOfLine  ; 
        return Promise.resolve(Welfarelog.writetofle(errortxt,errObj,'api')); 
    };

    Welfarelog.writetofle = (contentObj,data,errappname) => {

        var filename = moment(new Date()).format("MMDDYYYY");
        var dir = app.dataSources.localstorage.settings.root + "/"+errappname+"_log";
        var logfile = dir + "/" + filename + ".txt";
        
         // Create log folder if not exists
         if (!fs.existsSync(dir)){
            fs.mkdirSync(dir);
        }

        // Create a writable stream and append
        var writerStream = fs.createWriteStream(logfile, { flags : 'a' });
        writerStream.write(contentObj, 'UTF8');
        writerStream.end();
       
        // Handle stream events --> finish
        writerStream.on('finish', function() {
            LOGGER.debug("Log appended!");
        });

        // Handle error writing to log
        writerStream.on('error', function(err){
            LOGGER.error(err.stack);
        });
        return data;
    };

    Welfarelog.remoteMethod('createErrorLog', {
		http: {
				path: '/addweblog',
				verb: 'post'
		},
		accepts : [ {arg : 'data',type : 'object',
			http : {source : 'body'}} ],   
			 returns: {
			type : 'object',
			root : true
        }});
        
    Welfarelog.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Welfarelog.observe('access', (ctx, next) => util.access(ctx, next));
    Welfarelog.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};