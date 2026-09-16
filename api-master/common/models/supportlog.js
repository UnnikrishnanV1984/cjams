'use strict';
const LOGGER = require("log4js").getLogger("supportlog");

const Duplex = require('stream').Duplex;
const moment = require('moment');
const fs = require('fs');
const tmp = require('tmp');
const util = require('../utils/utils');
const app = require('../../server/server');
const config = require('../../server/config.json');
const commonapi = require('../models/commonapi');
const email = require('../models/email');
const axios = require('axios');
const FormData = require('form-data');

const contenttypejson = "application/json";
const loggermsg = "Error while creating JIRA ticket: ";
const waitingforuserresponse = 'Waiting for User Response';
module.exports = (Supportlog) => {

    Supportlog.ticketnotification = (request,reqctx) => {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        } 
        var fromuserid = (request && request.securityuserid?request.securityuserid: suserid);
        var sub = 'Support ticket submitted for review';
        var priority = 'Normal';   
        if (request.priority === "10100" || request.priority === "2") {
            priority = "High";
        }
        if (request.priority === "3") {
            priority = "Normal";
        }
        if (request.priority === "4") {
            priority = "Low";
        } 
        const sql1 = 'select * from send_notification($1, $2, $3, $4, $5, $6, $7, $8, $9)';
        var params = ['',fromuserid,'','System',priority,sub,request.notes,request.supportnumber,false];

        return util.executeDBQuery(sql1, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
 }

    Supportlog.remoteMethod('add', {
        http: {
            path: '/add',
            verb: 'post'
        },
        accepts: [
            { arg: 'req', type: 'object', http: { source: 'req' } },{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }],
        returns: {
            type: 'string',
            root: true
        }
    });

    Supportlog.add = (request, reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        request.body.tokenid = request.accessToken ? request.accessToken.id : '';
        request = request.body;
        request.jiraenv =  request.jiraEnv ?  request.jiraEnv : config.jiraenv;
        request.insertedby = suserid;
        let smailbody = '<html><table><thead></thead><tbody><tr><td>Reporting User :</td><td>';
        smailbody += app.currentUser.username;
        smailbody += '</td></tr><tr><td>User Role:</td><td>';
        smailbody += util.nullcheck(request.userrole);
        smailbody += '</td></tr><tr><td>Email:</td><td>';
        smailbody += util.nullcheck(request.frommailid);
        smailbody += '</td></tr><tr><td>Created Date:</td><td>';
        smailbody += new Date(request.supportlogdate).toLocaleDateString() + " " + new Date(request.supportlogdate).toLocaleTimeString();
        smailbody += '</td></tr><tr><td>Screening/Case/Provider ID:</td><td>';
        smailbody += util.nullcheck(request.cjamsid);
        smailbody += '</td></tr><tr><td>Client ID:</td><td>';
        smailbody += util.nullcheck(request.clientid);
        smailbody += '</td></tr><tr><td>Case ID:</td><td>';
        smailbody += util.nullcheck(request.caseid);
        smailbody += '</td></tr><tr><td>Subject:</td><td>';
        smailbody += util.nullcheck(request.subject);
        smailbody += '</td></tr><tr><td>Description:</td><td>';
        smailbody += util.nullcheck(request.notes);
        smailbody += '</td></tr><tr><td>Page Url:</td><td>';
        smailbody += util.nullcheck(request.pageurl);
        smailbody += '</td></tr><tr><td>Page Name:</td><td>';
        smailbody += util.nullcheck(request.pagename);
        smailbody += '</td></tr><tr><td>Severity:</td><td>';
        smailbody += util.nullcheck(request.severity);
        smailbody += '</td></tr></tbody>County</table></html>';
        smailbody += util.nullcheck(request.ldssregion);
        smailbody += '</td></tr></tbody>Program Area</table></html>';
        smailbody += util.nullcheck(request.application);
        smailbody += '</td></tr></tbody>Program Group</table></html>';
        smailbody += util.nullcheck(request.program);
        smailbody += '</td></tr></tbody>Focus Area</table></html>';
        smailbody += util.nullcheck(request.focus);
        smailbody += '</td></tr></tbody></table></html>';
        request.emailbody = smailbody;
        request.environment = process.env && process.env.APP_ENV ? process.env.APP_ENV : 'local';
    
        request.toemailid = (config.supportmailid !== null && config.supportmailid !== undefined) ? config.supportmailid : "maryland-testing@cardinality.ai";
        request.emailsubject = 'CJAMS Support request acknowledge #';
    
        request.buildname = util.nullcheck(config.buildname);
        request.versionnumber = util.nullcheck(config.version);
    
        const sql = 'SELECT * FROM getrequestlog($1)';
        
        // To Ensure single callback execution by chaining promises correctly
        return util.executeDBQuery(sql, [request.tokenid])
            .then(data => {
                if (data != null && data.length > 0) {
                    request.requestdata = data[0].getrequestlog;
                }
                return data;
            })
            .then(() => {
                if (request.filedata != null) {
                    request.requestdata = { data: request.filedata };
                }
                request.application = 'CW';
                // Create support log
                return Supportlog.create(request);
            })
            .then(supportLogData1 => {
                return Supportlog.find({ where: { supportlogid: supportLogData1.supportlogid } });
            })
            .then(supportLogDataArr => {
                const supportLogData = supportLogDataArr[0];
                let agency = "";
                switch (true) {
                    case request.frommailid.includes(".djs"):
                        agency = "DJS";
                        break;
                    case request.frommailid.includes(".as"):
                        agency = "AS";
                        break;
                    case request.frommailid.includes(".cw"):
                        agency = "CW";
                        break;
                }
                request.supportnumber = supportLogData.supportno;
                const sheetData = {};
                sheetData.supportno = supportLogData.supportno;
                sheetData.clientid = request.clientid;
                sheetData.subject = request.subject;
                sheetData.notes = request.notes;
                sheetData.agency = agency;
                sheetData.triaged = "N";
                sheetData.frommailid = request.frommailid;
                sheetData.effectivedate = moment(new Date(supportLogData.effectivedate)).format("MM/DD/YYYY");
                sheetData.environment = request.environment;
                sheetData.pageurl = request.pageurl;
                sheetData.severity = request.severity;
                sheetData.priority = request.priority;
                sheetData.jiraenv = request.jiraEnv;
                sheetData.issuetype = request.issuetype;
                sheetData.caseid = request.caseid;
                sheetData.ldssregion = request.ldssregion;
                sheetData.application = request.application;
                sheetData.program = request.program;
                sheetData.focus = request.focus;
                LOGGER.debug("Calling sendJiraRequest() with request: ", request);
    
                createSupportlog(request, supportLogData, suserid);

                Supportlog.ticketnotification(request, reqctx)
                    .catch(err => LOGGER.error("Supportlog.ticketnotification failed:", err));

                // Finally, returning the result only once
                return supportLogData;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    };
    
function createSupportlog(request, supportLogData, suserid){
    // If file exists, asynchronouslly perform below tasks as it takes time to process
    if (request.filedata != null) {
        app.models.Supportlog.find({ where: { supportno: supportLogData.supportno } }).then(records => {
            if (records != null && records.length > 0) {
                try {
                    // upload binary file to a table in database
                    app.models.Supportlogfiles.create({
                        supportlogid: records[0].supportlogid,
                        filaname: request.filaname,
                        filedata: request.filedata,
                        insertedby: suserid,
                        updatedby: suserid,
                        insertedon: new Date().toLocaleString(),
                        updatedon: new Date().toLocaleString()
                    });
                } catch (error) {
                    LOGGER.error(error);
                }
            }
        });
    } 
}

Supportlog.approveorreject = (request,reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
    const supportlogid = request.supportlogid;
    const approveOrReject = request.approveOrReject;
    const v_securityuserid = request.securityuserid;
    var sql = 'select priority,issuetype,subject,notes,frommailid as email,up.fullname,supportno,severity,jiraenv,requestdata->>\'data\' as filedata,stlf.filaname,caseid, program, ldssregion, focus,  supervisor.fullname as caseworkerdefaultsupervisorid,approved.fullname as approvedsupervisorid from defecttracking.supportlog stl ' +
    ' inner join userprofile up on up.securityusersid=stl.insertedby '+
    ' left outer join defecttracking.supportlogfiles stlf on stl.supportlogid = stlf.supportlogid '+
    ' left join userprofile supervisor ON supervisor.securityusersid = stl.caseworkerdefaultsupervisorid::character varying AND supervisor.activeflag = 1 '+
    ' left join userprofile approved ON approved.securityusersid = $2 AND approved.activeflag = 1 '+
    ' where stl.supportlogid = $1';
    return util.executeDBQuery(sql, [supportlogid,suserid])
        .then(data => {
            if (data != null && data.length) {
                updateTicketNotification(data[0].supportno,v_securityuserid,suserid);
                
                if(approveOrReject === 'Approved') {
                    data[0].supportlogid = supportlogid;
                    data[0].v_securityuserid = v_securityuserid;
                    return sendJiraRequest(data[0],suserid);
                }else{
                    updateApprovalRecord(request,suserid);
                    return data[0];
                }                   
            } else {
                return null;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

};

function updateTicketNotification(sno,securityuserid,suserid) {
    
    let securityuserid1 = (securityuserid ? securityuserid : suserid);
    let sql = 'update cjams.usernotification  set activeflag = 0, updatedby=$1, updatedon=now()' +
            'where objectid = $2 ';
    return util.executeDBQuery(sql, [securityuserid1, sno])
        .then(data => {
            if (data != null) {
                return data;
            } else {
                return null;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

}

function updateApprovalRecord(request,suserid) {
    const supportlogid = request.supportlogid;
    const approveOrReject = request.approveOrReject;
    var securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
    var sql = '';
    if (approveOrReject == 'Rejected'){
        sql = 'update defecttracking.supportlog  set rejecteddate = now()::date, jirarequestsent = $1, updatedby=$2, approvedsupervisorid=$3::uuid, updatedon=now() where supportlogid = $4 ';
    } else {
        sql = 'update defecttracking.supportlog  set approveddate = now()::date, jirarequestsent = $1, updatedby=$2, approvedsupervisorid=$3::uuid, updatedon=now() where supportlogid = $4 ';
    }
    return util.executeDBQuery(sql, [approveOrReject,securityuserid, securityuserid, supportlogid])
        .then(data1 => {
            if (data1 != null) {
                return data1;
            } else {
                return null;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

}
async function sendJiraRequest(logDetails, suserid) {
    LOGGER.debug("Inside sendJiraRequest()");
    const priority = logDetails.priority ? logDetails.priority : 4;
    let jiraRequest;
    LOGGER.debug("config.jiraobj.prod: ", config.jiraobj.prod);
    jiraRequest = {
        "serviceDeskId": "24", 
        "requestTypeId": logDetails.issuetype,
        "requestFieldValues": {
            "summary": util.removeBizarreCharacters(logDetails.subject),
            "components": [{ "name": "Child Welfare" }],
            "description": logDetails.caseid + ':' + util.removeBizarreCharacters(logDetails.notes),
            "customfield_12201": logDetails.fullname,
            "customfield_13023": logDetails.email ? logDetails.email : 'CJAMS@mdthink.maryland.gov',
            "customfield_13300": logDetails.supportno,
            "customfield_17400": { "value": logDetails.program },
            "customfield_17401": logDetails.ldssregion,
            "customfield_18400": { "value": logDetails.focus },
            "customfield_10707": { "value": logDetails.severity },
            "customfield_12208": [{ "value": logDetails.jiraenv }],
            "priority": { "id": priority },
            "customfield_20804": logDetails.approvedsupervisorid,
            "customfield_20803": logDetails.caseworkerdefaultsupervisorid
        }
    };

    jiraRequest = updatejiraRequest(logDetails, jiraRequest);

    LOGGER.debug("JIRA request: ", jiraRequest);

    const options = {
        url: config.jiraobj.url,
        headers: {
            "Content-Type": contenttypejson,
            "Authorization": 'Basic ' + new Buffer(app.get('apiKeys')?.jiraobjUserName + ':' + app.get('apiKeys')?.jiraobjPassword).toString('base64')
        },
        body: jiraRequest
    };

    // External API log creation
    const externalapidata = {
        details: {
            objectid: logDetails.supportlogid,
            objecttype: 'jira_request',
            updatedby: logDetails.v_securityuserid,
            insertedby: logDetails.v_securityuserid
        },
        resstatus: '',
        request: jiraRequest,
        response: null,
        status: 'add'
    };

    let v_externalapilogsid = null;
    let parsedJiraApiResponse = null;

    try {
        // Wait for external API log creation to complete before continuing
        v_externalapilogsid = await commonapi.addupdateexternalapilogs(externalapidata);

        // Make the request to external jira API for ticket creation
        const resp = await axios.post(options.url, options.body, {
                    headers: options.headers
                });
        const jiraApiResponse = resp.data;

        // Handle successful response
        const externalapidata1 = {
            details: {
                externalapilogsid: v_externalapilogsid,
                objecttype: 'jira_request',
                updatedby: logDetails.v_securityuserid,
                insertedby: logDetails.v_securityuserid
            },
            info: null,
            status: 'update',
            response: jiraApiResponse,
            resstatus: 'success'
        };

        parsedJiraApiResponse = jiraApiResponse;

        if (parsedJiraApiResponse.issueKey) {
            const request2 = { approveOrReject: 'Approved', supportlogid: logDetails.supportlogid };
            await updateApprovalRecord(request2, suserid);
            await sendJiraAttachment(logDetails, parsedJiraApiResponse.issueId);
            updateJiraRequestNumber(logDetails.supportno, parsedJiraApiResponse.issueKey, parsedJiraApiResponse.currentStatus.status, logDetails.v_securityuserid);
        } else {
            externalapidata1.resstatus = 'error';
            LOGGER.error("Jira request failed", parsedJiraApiResponse);
        }

        // Update external API log with the response
        await commonapi.addupdateexternalapilogs(externalapidata1);

        LOGGER.debug('Response after creating JIRA ticket: ', parsedJiraApiResponse);

        return parsedJiraApiResponse.issueKey ? 'Success' : 'Error';
    } catch (err) {
        // Handle error case
        const externalapidata2 = {
            details: {
                externalapilogsid: v_externalapilogsid,
                objecttype: 'jira_request',
                updatedby: logDetails.v_securityuserid,
                insertedby: logDetails.v_securityuserid
            },
            info: null,
            status: 'update',
            resstatus: 'error',
            response: err
        };

        await commonapi.addupdateexternalapilogs(externalapidata2);

        LOGGER.error("Jira request failed", err);
        if(!parsedJiraApiResponse?.issueKey){
            //If jirarequestno is not created then set defecttracking to pending
            const request1 = { approveOrReject: null, supportlogid: logDetails.supportlogid };
            await updateApprovalRecord(request1, suserid);
        }
        else{
            //If jirarequestno is not created then set defecttracking status to 'Approved'
            const request3 = { approveOrReject: 'Approved', supportlogid: logDetails.supportlogid };
            await updateApprovalRecord(request3, suserid);
        }
        // FIXED: Using LOGGER.error() instead of LOGGER.logError()
        LOGGER.error(err);
        if (util?.logError) {
            util.logError(err);
        }
    }
}

function updatejiraRequest(logDetails, jiraRequest){
    if (!logDetails.focus || logDetails.focus == null){
        delete jiraRequest.requestFieldValues.customfield_18400;
    }
    if (!logDetails.program || logDetails.program == null){
        delete jiraRequest.requestFieldValues.customfield_17400;
    }
    if (!logDetails.caseworkerdefaultsupervisorid || logDetails.caseworkerdefaultsupervisorid == null){
        delete jiraRequest.requestFieldValues.customfield_20803;
    }
    return jiraRequest;
}

Supportlog.getJiraRequest = function(req){
    LOGGER.debug("Inside sendJiraRequest()");
    var baseurl = config.jiraobj.geturl;
    var params = 'jql=project%20%3D%20CJAMS%20AND%20updated%20>%3D%20'+config.jiraobj.interval+'%20ORDER%20BY%20updated%20DESC&fields=status&fields=customfield_13300';
    LOGGER.debug("config.jiraobj.prod: ", config.jiraobj.prod);
    var jiraurl = baseurl + params;
    var options = {
        url: jiraurl,
        headers: {
            "Content-Type": contenttypejson,
            "Authorization": 'Basic ' + new Buffer(app.get('apiKeys')?.jiraobjUserName + ':' + app.get('apiKeys')?.jiraobjPassword).toString('base64')
        }
    };
    return new Promise((resolve, reject) => {
        axios.get(options.url, {
            headers: options.headers
        })
        .then((res) => {
            resolve(res.data);
        })
        .catch((err) => {
            LOGGER.error(loggermsg, err);
            reject(err);
        });
    }).then(data => {
        var str = JSON.stringify(data.issues);
        const sql = 'select * from updateJiraStatus1($1)';
        return util.executeDBQuery(sql, [str])
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    })
    // FIXED: Added ending catch to prevent Unhandled Promise Rejection
    .catch(err => {
        LOGGER.error("Unhandled error in getJiraRequest execution:", err);
    });
    
}


Supportlog.remoteMethod('approveorreject', {
    http: {
        path: '/approveorreject',
        verb: 'post'
    },
    accepts: [
        { arg: 'data', type: 'object', http: { source: 'body' } },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          } ],
    returns: {
        type: 'string',
        root: true
    }
});

Supportlog.remoteMethod('getJiraRequest', {
    http: {
        path: '/getJiraRequest',
        verb: 'get'
    },
    accepts : [ {
        arg: 'arg',
        type: 'Object',
        required: false,
        http: {source: 'query'}
    } ],
    returns: {
        type : 'Object',
        root : true
    }
});

Supportlog.remoteMethod('approveorrejectall', {
    http: {
        path: '/approveorrejectall',
        verb: 'post'
    },
    accepts: [
        { arg: 'data', type: 'object', http: { source: 'body' } }
        ,{
                  arg: 'reqctx',
                  type: 'object',
                  http: {source: 'context'}
                } ],
    returns: {
        type: 'string',
        root: true
    }
});

Supportlog.approveorrejectall = (request,reqctx) => {
    const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
    const supportlogid = request.supportlogid;
    const approveOrReject = request.approveOrReject;

    const supportlogids = supportlogid.map(id => id.replaceAll("'", ""));

    var sql = 'select stl.supportlogid,priority,issuetype,subject,notes,frommailid as email,up.fullname,supportno,severity,jiraenv,requestdata->>\'data\' as filedata,stlf.filaname,caseid, program, ldssregion, focus, supervisor.fullname as caseworkerdefaultsupervisorid, approved.fullname as approvedsupervisorid from defecttracking.supportlog stl ' +
        ' inner join userprofile up on up.securityusersid=stl.insertedby ' +
        ' left outer join defecttracking.supportlogfiles stlf on stl.supportlogid = stlf.supportlogid ' +
        'left join userprofile supervisor ON supervisor.securityusersid = stl.defaultsupervisorid::character varying AND supervisor.activeflag = 1'+
        'left join userprofile approved ON approved.securityusersid = $1 AND approved.activeflag = 1'+
        ' where stl.supportlogid = ANY($2::uuid[])';

    return util.executeDBQuery(sql,[suserid,supportlogids])
        .then(data => {
            return data;
        })
        .then(data => {
            if (data != null && data.length) {
                updateTicketNotificationAll(data.map(e => e.supportno),suserid);

                if (approveOrReject === 'Approved') {
                    data.forEach(rec => {
                        if (rec) {
                            rec['v_securityuserid'] = suserid;
                        }
                        sendJiraRequest(rec,suserid);
                    })
                    return data[0];
                } else {
                    updateApprovalRecordAll(request,suserid);
                    return data[0];
                }
            } else {
                return null;
            }
        })
        .catch(err6 => {
            LOGGER.error('>>>>ERROR:', err6);
            throw err6;
        });

};

function updateTicketNotificationAll(sno,suserid) {
    const snoids = sno.map(id => id.replaceAll("'", ""));
    var sql = 'update cjams.usernotification  set activeflag = 0, updatedby=$1, updatedon=now() where objectid = ANY($2::text[])';
    return util.executeDBQuery(sql, [suserid,snoids])
        .then(data9 => {
            if (data9 != null) {
                return data9;
            } else {
                return null;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

}

function updateApprovalRecordAll(request,suserid) {
    const supportlogid = request.supportlogid;
    const approveOrReject = request.approveOrReject;

    var sql = 'update defecttracking.supportlog  set jirarequestsent = $1, updatedby=$2, updatedon=now() where supportlogid = ANY($3::uuid[])';
    const supportlogids = supportlogid.map(id => id.replaceAll("'", ""));
    return util.executeDBQuery(sql, [approveOrReject, suserid, supportlogids])
        .then(data10 => {
            if (data10 != null) {
                return data10;
            } else {
                return null;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

}

Supportlog.remoteMethod('getcountpendingtickets', {
    http: {
        path: '/getcountpendingtickets',
        verb: 'get'
    },
    accepts: [{
        arg: 'jirarequestno',
        type: 'String',
        required: false,
        http: { source: 'query' }
    },{
        arg: 'reqctx',
        type: 'object',
        http: {source: 'context'}
      }],
    returns: {
        type: 'Object',
        root: true
    }
});

Supportlog.getcountpendingtickets = (request,reqctx) => {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    var securityuserid = (request && request.securityuserid?request.securityuserid: suserid);
    const sql = 'SELECT count(*) FROM ' +
               '    (SELECT distinct s.supportno ' +
                    '	FROM cjams.userprofile up ' +
                    '		JOIN teammemberassignment tma on tma.securityusersid = up.securityusersid and tma.activeflag = 1 ' +
                    '		JOIN teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1 ' +
                    '		JOIN team t on t.teamid = tm.teamid and t.activeflag = 1 ' +
                    '		JOIN county c ON t.countyid = c.countyid::character varying and c.activeflag = 1 ' +
                    '		JOIN defecttracking.supportlog s on s.ldssregion = c.countyname and s.activeflag = 1 ' +
                    '	WHERE up.securityusersid = $1 ' +
                    '		AND s.application = $2 ' +
                    '		AND s.jirarequestsent is null ' +
                    '		AND s.jiraenv = $3 ' +
                    '		AND s.activeflag = 1) e ';
    return util.executeDBQuery(sql, [securityuserid, 'CW', config.jiraenv])
        .then(resp => resp)
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

Supportlog.remoteMethod(
    'getsupportlog',
    {
        http: {
            path: '/getsupportlog',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'object',
            http: {
                source: 'body'
            }
        },{
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }
        ],
        returns: {
            arg: 'data',
            type: 'object'
        }
    });

Supportlog.getsupportlog = function (request,reqctx) {
    let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    }
    var securityusersid = (request && request.securityuserid?request.securityuserid:suserid);
    var filter = request.where;
    filter.input.searchstring = filter.searchString ? filter.searchString : null;
    var jsondata=filter.input;
    jsondata.application = 'CW';
    jsondata.jiraenv = config.jiraenv;
    var sql = 'select * from getsupportlog($1,$2,$3,$4,$5,$6)';
    var params = [JSON.stringify(jsondata), securityusersid, filter.sortcolumn,
        filter.sortorder, filter.pagenumber, filter.pagesize];

    return util.executeDBQuery(sql, params)
        .then(result => {
            return result;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
}

Supportlog.remoteMethod('getJiraStatus', {
    http: {
        path: '/getJiraStatus',
        verb: 'get'
    },
    accepts: [{
        arg: 'jirarequestno',
        type: 'String',
        required: false,
        http: { source: 'query' }
    },{
        arg: 'reqctx',
       type: 'object',
        http: {source: 'context'}
    }],
    returns: {
        type: 'Object',
        root: true
    }
});

Supportlog.getJiraStatus = async (jirarequestno,reqctx) => {
    let suserid=undefined;
    if(reqctx && reqctx.req &&reqctx.req.headers){
      suserid=reqctx.req.headers.securityusersid
    }
    var securityusersid = (suserid);
    var authorization = app.get('apiKeys')?.jiraobjAuthorization;
    var geturl = config.jiraobj.getstatusurl;
    var jiraDetails = {};
    if (!authorization) {
        authorization = 'Basic ' + new Buffer(app.get('apiKeys')?.jiraobjUserName + ':' + app.get('apiKeys')?.jiraobjPassword).toString('base64');
    }
    const headers = {
        method: 'GET',
        headers: {
            "Content-Type": contenttypejson,
            "Authorization": authorization
        }
    }
    
    // FIXED: Wrapped the network calls in a try...catch block
    try {
        const resp = await fetch(geturl + jirarequestno, headers);
        const getJiiraStatus = await resp.json();
        jiraDetails = getjiraDetails(getJiiraStatus, jiraDetails);
    } catch (err) {
        LOGGER.error("Failed to fetch Jira status:", err);
        throw err; // Or return a safe default object if appropriate
    }

    const sql = 'UPDATE defecttracking.supportlog ' +
	            '       SET status = COALESCE($1, status), ' +
	            '	    jiraticketresolution = COALESCE($2, jiraticketresolution), ' +
	            '	    focus = COALESCE($3, focus), ' +
	            '	    cdmticketno = COALESCE($4, cdmticketno), ' +
	            '	    updatedon = now(),  ' +
	            '	    updatedby = $5  ' +
	            '   WHERE jirarequestno=$6 OR cdmticketno = $6';
    return util.executeDBQuery(sql, [jiraDetails.status, jiraDetails.resolution, jiraDetails.focusarea, jiraDetails.cdmticketno, securityusersid, jirarequestno])
        .then(resp1 =>  {
            return jiraDetails;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
}

function nullCheck(value){
    return value ? value : null;
}

function getjiraDetails(getJiiraStatus, jiraDetails){
    if (getJiiraStatus.fields) {
        const jiraVal = getJiraValues(getJiiraStatus);
        jiraDetails.status = jiraVal.status;
        jiraDetails.resolution = jiraVal.resolution;
        jiraDetails.comments = jiraVal.comments;
        jiraDetails.focusarea = jiraVal.focusarea;
        if (getJiiraStatus.fields.issuelinks && getJiiraStatus.fields.issuelinks.length > 0){
            if (getJiiraStatus.fields.issuelinks[0].outwardIssue && getJiiraStatus.fields.issuelinks[0].outwardIssue.key){
                jiraDetails.cdmticketno= getJiiraStatus.fields.issuelinks[0].outwardIssue.key;
            }
        }

        if (jiraDetails.status == 'TRIAGE'){
            jiraDetails.status = 'Triage';
        }

        if (jiraDetails.status.includes(waitingforuserresponse)){
            jiraDetails.status = waitingforuserresponse;
        }

    }
    jiraDetails = checkErrorMsg(getJiiraStatus, jiraDetails)
    return jiraDetails;
}

function getJiraValues(getJiiraStatus){
    return {
        status: getJiiraStatus.fields.status ? nullCheck(getJiiraStatus.fields.status.name) : null,
        resolution: getJiiraStatus.fields.resolution ? nullCheck(getJiiraStatus.fields.resolution.name) : null,
        comments: getJiiraStatus.fields.comment ? nullCheck(getJiiraStatus.fields.comment.comments) : null,
        focusarea: getJiiraStatus.fields.customfield_18400 ? nullCheck(getJiiraStatus.fields.customfield_18400.value) : null
    }
}

function checkErrorMsg(getJiiraStatus, jiraDetails){
    if (getJiiraStatus.errorMessages) {
        if (getJiiraStatus.errorMessages.length > 0){
            if (getJiiraStatus.errorMessages[0] == 'Issue Does Not Exist') {
                jiraDetails.status = 'No Access';
            }
        }
    }
    return jiraDetails;
}

function updateJiraRequestNumber(supportno, jiranumber, status,suserid) {
    var securityuserid = (suserid);

    if (status.includes(waitingforuserresponse)){
        status = waitingforuserresponse;
    }

    let sql = 'update defecttracking.supportlog  set jirarequestno= $1 ,status=$2, updatedby=$3,approvedsupervisorid=$4::uuid, updatedon=now() where supportno = $5 ';
    return util.executeDBQuery(sql, [jiranumber, status, securityuserid, securityuserid, supportno])
        .then(data4 => {
            if (data4 != null) {
                return data4;
            } else {
                return null;
            }
        })
        .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });

}

Supportlog.remoteMethod(
    'getcountyticketcounts',
    {
        http: {
            path: '/getcountyticketcounts',
            verb: 'post'
        },
        accepts: [{
            arg: 'data',
            type: 'Object',
            http: {
                source: 'body'
            }
        }

        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    });

    Supportlog.getcountyticketcounts = function (request) {
        // FIXED: Replaced unsafe property access with optional chaining
        var input = request.where?.filter ? request.where.filter : {};
        if (input && input.identifiedas){
            if (input.identifiedas === "All"){
                input.identifiedas = null;
            }
        }
        input.jiraenv = config.jiraenv;
        var sql = 'select * from cjams.getcountyticketcounts($1)';
        var params = [input];

        return util.executeDBQuery(sql, params)
            .then(result10 => {
                return result10;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }


    Supportlog.remoteMethod('getfocuslist', {
        http: {
            path: '/getfocuslist',
            verb: 'get'
        },
        accepts: [{
            arg: 'arg',
            type: 'Object',
            required: false,
            http: { source: 'query' }
        }],
        returns: {
            type: 'Object',
            root: true
        }
    });

    Supportlog.getfocuslist = function (req) {
        const sql = 'select distinct focus from defecttracking.supportlog where application = $1 ' +
            ' and focus is not null and btrim(focus) != $2 and activeflag = 1 order by focus';
        return util.executeDBQuery(sql, ['CW', ''])
            .then(resp => resp)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Supportlog.remoteMethod('getidentifiedaslist', {
        http: {
            path: '/getidentifiedaslist',
            verb: 'get'
        },
        accepts: [{
            arg: 'arg',
            type: 'Object',
            required: false,
            http: { source: 'query' }
        }],
        returns: {
            type: 'Object',
            root: true
        }
    });

    Supportlog.getidentifiedaslist = function (req) {
        const sql = 'select distinct identifiedas from defecttracking.supportlog where application = $1 ' +
            ' and identifiedas is not null and btrim(identifiedas) != $2 and activeflag = 1 order by identifiedas';
        return util.executeDBQuery(sql, ['CW', ''])
            .then(resp => resp)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Supportlog.remoteMethod('getjirastatuslist', {
        http: {
            path: '/getjirastatuslist',
            verb: 'get'
        },
        accepts: [{
            arg: 'arg',
            type: 'Object',
            required: false,
            http: { source: 'query' }
        }],
        returns: {
            type: 'Object',
            root: true
        }
    });

    Supportlog.getjirastatuslist = function (req) {
        const sql = 'select distinct status from defecttracking.supportlog where application = $1 ' +
            ' and status is not null and btrim(status) != $2 and activeflag = 1 order by status';
        return util.executeDBQuery(sql, ['CW', ''])
            .then(resp => resp)
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    }

    Supportlog.remoteMethod(
        'getsupportlogcounts',
        {
            http: {
                path: '/getsupportlogcounts',
                verb: 'post'
            },
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body'
                }
            },{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }
            ],
            returns: {
                arg: 'data',
                type: 'object'
            }
        });
    
    Supportlog.getsupportlogcounts = function (request,reqctx) {
        let suserid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          suserid = reqctx.req.headers.securityusersid
        }
        var securityusersid = (request && request.securityuserid ? request.securityuserid:suserid);
        var application = 'CW';
        var jiraenv = config.jiraenv;
        var sql = 'select * from getsupportlogcounts($1,$2,$3)';
        var params = [securityusersid, jiraenv,application];

        return util.executeDBQuery(sql, params)
            .then(result2 => {
                return result2;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }

Supportlog.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Supportlog.observe('access', (ctx, next) => util.access(ctx, next));
Supportlog.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}

async function sendJiraAttachment(request, issueId) {
    LOGGER.debug("Inside sendJiraAttachment()");
    
    if (!request?.filedata) {
        LOGGER.warn("No file data provided for JIRA attachment.");
        return;
    }

    try {
        const form = new FormData();
        const filename = `${issueId}.png`;
        
        // Convert base64 straight into a Buffer (No disk I/O / temporary files required)
        const base64Data = request.filedata.replace(/^data:[a-z]+\/[a-z.-]+;base64,/, '');
        const fileBuffer = Buffer.from(base64Data, 'base64');

        // Append the stream/buffer with explicit filename
        form.append('file', fileBuffer, {
            filename: filename,
            contentType: 'image/png'
        });

        const authHeader = 'Basic ' + Buffer.from(
            `${app.get('apiKeys')?.jiraobjUserName}:${app.get('apiKeys')?.jiraobjPassword}`
        ).toString('base64');

        const targetUrl = config.jiraobj.urlattachment.replace('{issueId}', issueId);

        const resp = await axios.post(targetUrl, form, {
            headers: {
                ...form.getHeaders(), // Automatically sets multipart/form-data with correct boundary!
                'X-Atlassian-Token': 'no-check',
                'Accept': contenttypejson,
                'Authorization': authHeader
            }
        });

        LOGGER.debug('Response after creating JIRA attachment: ', resp.data);
        return resp.data;

    } catch (err) {
        LOGGER.error("Error while creating JIRA attachment: ", err?.response?.data || err.message);
        if (util?.logError) {
            util.logError(err);
        }
    }
}