'use strict';
/* eslint no-console: 0 */

const LOGGER = require("log4js").getLogger("email");
const nodemailer = require('nodemailer');
const config = require('../../server/config.json');
const app = require('../../server/server');
const defaultemail = "chandra.ramasamy2@maryland.gov;";
const successmsg = "Mail sent successfully";
const errmsg = "Message error: " ;
const msgerr = "Message error";
const fs = require('fs');
const email = require('../models/email');
const msg_err = "Message error ";
const mail_sent = "Mail sent successfully";
const configsendmail = config.sendmail;
const configsendmailpshychotropic =config.sendmailpshychotropic;
const util = require('../utils/utils');
const TO_EMAIL_LIST = 'To Email List: ';
const commonapi = require('../models/commonapi');

var mailerCredential = '';
if(config.state && config.sendMail === 1) {
   mailerCredential = config.awsMail;
} else {
   mailerCredential = {host:null,port:null,auth:{user:null,pass:null}};
}
// Create a SMTP transporter object
const transporter = nodemailer.createTransport(
    {
        host: mailerCredential.host,
        port: mailerCredential.port,
        auth: { user: app.get('apiKeys')?.awsmail_user, pass: app.get('apiKeys')?.awsmail_password },
    },
    {
       /*if we need to do any change on  mailerCredential.from
                            1)we need to take the value of mailerCredential.from  
                            2)do btoa(mailerCredential.from) 
                            3)give the output of second step as input to atob();
                            */
                            from: atob('Q0pBTVNAbWR0aGluay5tYXJ5bGFuZC5nb3Y=')

    }
);

LOGGER.debug('SMTP Configured');

module.exports.SendEmail= function (toemail,sub,body)
{
        LOGGER.debug("tomail", toemail);
        /* verified with Debashish that teamtypekey check is not needed in SendEmail
        if (app.currentUser.teamtypekey == 'CW')
        {
            toemail=toemail;
        }else
        {
            toemail =defaultemail;
        }

       if (config.production)
       {
           toemail=toemail;         //SonarQube - removed the self-assignments
       }else*/
       if (!config.production){
           toemail =defaultemail;
       }

 var isendmail = config.sendmail;
 if (config.sendmail==null || config.sendmail ===undefined) {
    isendmail=0;}

var mail = {
  to: toemail,
  subject:sub ,
  text: body,
  html: body
}
LOGGER.debug(mail);
let message = successmsg; //SonarQube fix to reassign value to message 

if (isendmail===1)
{
    transporter.sendMail(mail, function(error, response){
    if(error){
        LOGGER.debug(errmsg+ error);
        LOGGER.debug(error);
        message = msgerr+error;
    }else{
        LOGGER.debug(successmsg);

    }

    transporter.close();

    });
}
return message;
}

module.exports.SendProvrefEmail= function (toemail,sub,body)
{
    LOGGER.debug("tomail", toemail); //SonarQube - removed the self-assignments
    if (!config.production)
    {
        toemail =defaultemail;
    }
 var isendmail = config.sendmail;
 if (config.sendmail==null || config.sendmail ===undefined) {
    isendmail=0;}

var mail = {
  to: toemail,
  subject:sub ,
  text: body,
  html: body
}
LOGGER.debug(mail);
var message = successmsg;

if (isendmail===1)
{
    transporter.sendMail(mail, function(_error, response){
    if(_error){
        LOGGER.debug(_error);
        message = msgerr+_error;
    }else{
        LOGGER.debug(successmsg);

    }

    transporter.close();

    });
}
return message;
}

module.exports.SendAssessmentEmail= function (toemail,sub,body,objecttypekey)
{
    LOGGER.debug("tomail", toemail);
    let sendemailto = '';               //SonarQube fix - removed the self-assignments
    if (config.production && objecttypekey==='assessment')
    {
        sendemailto=toemail;
    }else
    {
        sendemailto = defaultemail;
    }
    toemail = sendemailto;
 var isendmail = config.sendmail;
 if (config.sendmail==null || config.sendmail ===undefined) {
    isendmail=0;}

var mail = {
  to: toemail,
  subject:sub ,
  text: body,
  html:  ''
}
LOGGER.debug(mail);
var message = successmsg;

if (isendmail===1)
{
    transporter.sendMail(mail, function(_error, response){
    if(_error){
        LOGGER.debug(errmsg+ _error);
        message = msgerr+_error;
    }else{
        LOGGER.debug(successmsg);

    }

    transporter.close();

    });
}
return message;
}

module.exports.SendEmailAttachment= function (toemail,sub,body,fname,content)
{
    LOGGER.debug("tomail", toemail);
    if (!config.production)                 //SonarQube fix - removed the self-assignments
    {
        toemail =defaultemail;
    }
    var isendmail = config.sendmail;
    if (config.sendmail==null || config.sendmail ===undefined) {
        isendmail=0;}

    var mail = {
        to: toemail,
        subject:sub,
        text: body,
        html: body,
         //attachments: [{'filename': 'attachment.txt', 'content': 'hello world'}]
        //  attachments:[ 
        //     {   
        //         filename: fname,
        //         path: 'data:application/pdf;base64,'+ content
        //         // filename: fname,
        //         // /path: 'C:/Users/ajithg/Downloads/acknowledgement.txt',
        //         // contentType: 'application/pdf'

        attachments:[
            {
                filename: fname,
                path: 'data:application/pdf;base64,'.concat(content)
            }
        ]
    }
    LOGGER.debug(mail);
    var message = successmsg;

    if (isendmail===1)
    {
        transporter.sendMail(mail, function(_error, response){
        if(_error){
            LOGGER.debug(errmsg+ _error);
            LOGGER.debug(_error);
            message = msgerr+_error;
        }else{
            LOGGER.debug(successmsg);
        }
        transporter.close();
        });
    }
    return message;
}

//mail send for Finance module

module.exports.SendEmailForFinance= function (toemail,sub,body)
{
        LOGGER.debug("tomail", toemail);
        if (!config.production)              //SonarQube fix - removed the self-assignments
        {
            toemail =defaultemail;
        }


 var isendmail = config.sendmail;
 if (config.sendmail==null || config.sendmail ===undefined) {
    isendmail=0;}

var mail = {
  to: toemail,
  subject:sub ,
  text: body,
  html: body
}
LOGGER.debug(mail);
var message = successmsg;

if (isendmail === 1)
{
    transporter.sendMail(mail, function(error, response){
    if(error){
        LOGGER.debug(errmsg+ error);
        message = msgerr+error;
    }else{
        LOGGER.debug(successmsg);

    }

    transporter.close();

    });
}
return message;
}

module.exports.SendCommonEmail= function (toemail,sub,body)
{
        LOGGER.debug("tomail", toemail);
       if (!config.production)          //SonarQube fix - removed the self-assignments
       {
           toemail =defaultemail;
       }

 var isendmail = config.commonSendmail;
 if (config.sendmail==null || config.sendmail ===undefined) {
    isendmail=0;}

var mail = {
  to: toemail,
  subject:sub ,
  text: body,
  html: body
}
LOGGER.debug(mail);
var message = successmsg;

if (isendmail===1) {
    transporter.sendMail(mail, function(error, response){
    if(error){
        LOGGER.debug(error);
        message = msgerr+error;
    }else{
        LOGGER.debug(successmsg);
    }
    transporter.close();
    });
}
return message;
}


//mail send for pshychotropic module
module.exports.SendEmailPshychotropic = function (toemail, sub, body,apiurl,objectid, objecttype,securityusersid) {
    let message = mail_sent;
    if (toemail === null || toemail.trim() === ''){
        return message;
    }
       //if config.sendmailpshychotropic(isendmail) is 2 then we are sending email for local  and we are using send email list from config.defaultemailspshychotropic
   // if config.sendmailpshychotropic(isendmail) is 1 then we are sending email for prod  and we are using send email list from alternate email column in userprofile table 
    let isendmail = config.sendmailpshychotropic;
    if (configsendmailpshychotropic === null || configsendmailpshychotropic === undefined) { 
        isendmail = 0; 
    }
    
    let mail = {
        to: toemail,
        priority: "high",
        subject: sub,
        text: body,
        html: body
    }
    

    if (isendmail === 2) {
        sub = '**** Test Email *** ' + sub;
         mail = {
            to: config.defaultemailspshychotropic, //to overwrite  send email list from config.defaultemailspshychotropic
            priority: "high",
            subject: sub,
            text: body  + TO_EMAIL_LIST + toemail,
            html: body  + TO_EMAIL_LIST + toemail
        }
    }

    if (isendmail === 1 && (apiurl=='https://cw.cjams.mdthink.maryland.gov' || apiurl=='http://cw.cjams.mdthink.maryland.gov') ) {
        let externalapidata = {};   
        
        externalapidata.objectid= objectid;
        externalapidata.objecttype= objecttype;
        externalapidata.emaillogsid =null;
        externalapidata.securityusersid= securityusersid;
        externalapidata.toemail =toemail;
        externalapidata.body= body;
        externalapidata.response =null;
        externalapidata.responsestatus = null;
        externalapidata.sub=sub;
        externalapidata.addorupdate ='add';
    
	let v_logsid = null;
    commonapi.addupdateemaillog(externalapidata).then(_data => {
        v_logsid = _data;
    });    
        transporterSendMail(mail, externalapidata, v_logsid);
    }

    if(isendmail === 2){
        let externalapidata = {};    
        externalapidata.objectid= objectid;
        externalapidata.objecttype= objecttype;
        externalapidata.emaillogsid =null;
        externalapidata.securityusersid= securityusersid;
        externalapidata.toemail =toemail;
        externalapidata.body= body;
        externalapidata.response =null;
        externalapidata.responsestatus = null;
        externalapidata.sub=sub;
        externalapidata.addorupdate ='add';
    
	let v_logsid = null;
    commonapi.addupdateemaillog(externalapidata).then(_data => {
        v_logsid = _data;
    });
    transporterSendMail(mail, externalapidata, v_logsid);
       
    }

    function transporterSendMail(mails, externalapidata, v_logsid){
        util.transporter().sendMail(mails, function (error, response) {
            if (error) {
                message = msg_err + error;
                email.SendEmailPshychotropic(toemail, sub, body);
                externalapidata = {};   
                externalapidata.objectid =objectid;
                externalapidata.objecttype = objecttype;
                externalapidata.emaillogsid= v_logsid;
                externalapidata.securityusersid= securityusersid;
                externalapidata.toemail =toemail;
                externalapidata.body= body;
                externalapidata.response =error;
                externalapidata.responsestatus = 'error';
                externalapidata.sub=sub;
                externalapidata.addorupdate ='update';
        commonapi.addupdateemaillog(externalapidata);
        } else{
                    externalapidata.objectid =objectid;
                    externalapidata.objecttype = objecttype;
                    externalapidata.emaillogsid= v_logsid;
                    externalapidata.securityusersid= securityusersid;
                    externalapidata.toemail =toemail;
                    externalapidata.body= body;
                    externalapidata.response =response;
                    externalapidata.responsestatus = 'success';
                    externalapidata.sub=sub;
                    externalapidata.addorupdate ='update';
        commonapi.addupdateemaillog(externalapidata);
            } 
            util.transporter().close();
        });
    }
    
    return message;
}
