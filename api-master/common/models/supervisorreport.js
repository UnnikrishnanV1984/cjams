'use strict';
const util = require('../utils/utils');
var fs = require('fs');
var app = require('../../server/server');
const config = require('../../server/config.json');
const pdf = require('../models/pdf');
var Excel = require('exceljs');

const centerAlign = {
    vertical: 'middle',
    horizontal: 'center'
};
const titleSize = {
    size: 20
};
const subHeaderSize = {
    size: 16
};
const headerStyle = {
    type: 'pattern',
    pattern: 'solid',
    fgColor: {
        argb: 'ffcccccc'
    }
};
const contenttypestr = 'Content-Type';
const spreadsheetcontenttype = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
const contentdispositionstr = "Content-Disposition";
const attachmentstr = "attachment; filename=";

module.exports = function (Supervisorreport) {
    Supervisorreport.generate = (type, request, res,reqctx) => {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        switch (type) {
            case 'court':
                return module.exports.courtListReport(request, 'generate', res);
            case 'level':
                return module.exports.levelReport(request, 'generate', res);
            case 'census':
                return module.exports.censusReport(request, 'generate', res);
            case 'contactsupport':
                return module.exports.contactSupportReport(request, suserid,res);
            case 'releasenotes':
                return module.exports.releaseNotesReport(request, res);
        }
        return Promise.resolve({ message: 'Unsupported report type: ' + type });
    };

    Supervisorreport.list = (type, request) => {
        switch (type) {
            case 'court':
                return module.exports.courtListReport(request, 'list');
            case 'level':
                return module.exports.levelReport(request, 'list');
            case 'census':
                return module.exports.censusReport(request, 'list');
        }
        return Promise.resolve({ message: 'Unsupported report type: ' + type });
    };

    Supervisorreport.remoteMethod('generate', {
        http: {
            path: '/generate/:type',
            verb: 'post'
        },
        accepts: [{
                arg: 'type',
                type: 'string',
                required: true,
                http: {
                    source: 'path'
                }
            }, {
                arg: 'data',
                type: 'Object',
                http: {
                    source: 'body'
                }
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res'
                }
            },{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              }
        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    });

    Supervisorreport.remoteMethod('list', {
        accepts: [{
            arg: 'type',
            type: 'string',
            required: true,
            http: {
                source: 'path'
            }
        }, {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        }],
        http: {
            path: '/list/:type',
            verb: 'get'
        },
        returns: {
            type: 'string',
            root: true
        }
    });
}

module.exports.courtListReport = function (request, operation, res = null) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const status = request.where.status;

    const nolimit = !!request.nolimit;
    let skip;
    let limit;
    if (!nolimit) {
        skip = (request.page - 1) * request.limit;
        limit = request.limit;
    }


    const sql = "select * from getcourtliasonreport($1, $2, $3, $4, $5, $6)";
    return util.executeDBQuery(sql, [startdate, enddate, status, limit, skip, nolimit])
    .then(data => {
        return data;
    })
        .then(resp => {
            return new Promise((resolve, reject) => {
                if (operation === 'list') {
                    resolve({
                        totalcount: getTotalCount(resp).reccount,
                        data: resp
                    });
                } else if (operation === 'generate') {
                    const reportType = request.where.type;
                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            const reqjson = getCLRReportGrid(resp, request, reqjson);
                            const html = fs.readFileSync('./documenttemplates/reports/supervisor/court-list.html', 'utf8');
                            res = pdf.generatepdf(request, html, reqjson, {
                                type: 'report',
                                res: res
                            });
                            resolve(res);
                        } else {
                            getCLRWorksheet(request, reportType, resp, res);
                        }
                    }
                }
            })
        })
        .catch(err => {
            util.logError(err);
            LOGGER.error(err);
            return err;
        });
};

function getCLRReportGrid(resp, request, reqjson) {
    let reportGrid = '';
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    for (const row of resp) {
        reportGrid += `
                    <tr style="background: #edeff2;">
                        <td>${row.youthfirstname}&nbsp;${row.youthlastname}</td>
                        <td>${util.nullcheck(row.providername)}</td>
                        <td>${util.nullcheck(row.youthlivingunit)}</td>
                        <td>${row.scheduledhearingdate}</td>
                        <td>${row.scheduledhearingtime}</td>
                        <td>${util.nullcheck(row.courtjurisdiction)}</td>
                        <td>${util.nullcheck(row.hearinglocation)}</td>
                        <td>${util.nullcheck(row.hearingtype)}</td>
                        <td>${util.nullcheck(row.petitionid)}</td>
                        <td>${row.casenumber}</td>
                        <td>${row.transportationscheduled}</td>
                    </tr>`;
    }
    reqjson.courtList = reportGrid;
    reqjson.hearingstatus = request.where.status ? `<h6 class="text-center text-b"> Hearing Status : ${request.where.status}</h6>` : "";
    reqjson.startdate = startdate;
    reqjson.enddate = enddate;
    reqjson.landscape = true;
    return reqjson;
}

function getCLRWorksheet(request, reportType, resp, res) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const status = request.where.status;
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('D1','J1');
        worksheet.getCell('D1').value = `Court List Report (${startdate} to ${enddate})`;
        worksheet.getCell('D1').font = titleSize;
        worksheet.getCell('D1').alignment = centerAlign;
        worksheet.getCell('D3').value = (status) ?
            `Hearing Status : ${status}` :
            ``;
        worksheet.getCell('D3').font = subHeaderSize;
        worksheet.getCell('D3').alignment = centerAlign;
    }
    /*if we need to do any change on worksheet.columns 
    1)we need to take the value of worksheet.columns and update the json 
    2)do btoa(JSON.stringify(UPDATED_JSON comes here)) 
    3)give the output of second step as input to Buffer.from();
    */
    const worksheetencode = Buffer.from('W3sia2V5IjoieW91dGgiLCJ3aWR0aCI6MzB9LHsia2V5IjoicHJvdmlkZXJuYW1lIiwid2lkdGgiOjIwfSx7ImtleSI6InlvdXRobGl2aW5ndW5pdCIsIndpZHRoIjoyMH0seyJrZXkiOiJzY2hlZHVsZWRoZWFyaW5nZGF0ZSIsIndpZHRoIjoyMH0seyJrZXkiOiJzY2hlZHVsZWRoZWFyaW5ndGltZSIsIndpZHRoIjoyMH0seyJrZXkiOiJjb3VydGp1cmlzZGljdGlvbiIsIndpZHRoIjoxNX0seyJrZXkiOiJoZWFyaW5nbG9jYXRpb24iLCJ3aWR0aCI6MTV9LHsia2V5IjoiaGVhcmluZ3R5cGUiLCJ3aWR0aCI6MTV9LHsia2V5IjoicGV0aXRpb25pZCIsIndpZHRoIjoxMH0seyJrZXkiOiJjYXNlbnVtYmVyIiwid2lkdGgiOjIwfSx7ImtleSI6InRyYW5zcG9ydGF0aW9uc2NoZWR1bGVkIiwid2lkdGgiOjI1fV0=','base64');
    worksheet.columns = JSON.parse(worksheetencode);
    let headerRow;
    
    if(status){ headerRow = (reportType === "xlsx" ? 5 : 1); }
    if(!status){ headerRow = (reportType === "xlsx" ? 3 :1); }

    worksheet.getRow(headerRow).values = [
        'Youth',
        'Provider Name',
        'Youth Living Unit',
        'Scheduled Hearing Date',
        'Scheduled Hearing Time',
        'Court Jurisdiction',
        'Hearing Location',
        'Hearing Type',
        'Petition ID',
        'Case Number',
        'Transportation Scheduled'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    for (const row of resp) {
        worksheet.addRow({
            youth: `${row.youthfirstname} ${row.youthlastname}`,
            providername: `${util.nullcheck(row.providername)}`,
            youthlivingunit: util.nullcheck(row.youthlivingunit),
            scheduledhearingdate: row.scheduledhearingdate,
            scheduledhearingtime: row.scheduledhearingtime,
            courtjurisdiction: `${util.nullcheck(row.courtjurisdiction)}`,
            hearinglocation: `${util.nullcheck(row.hearinglocation)}`,
            hearingtype: util.nullcheck(row.hearingtype),
            petitionid: util.nullcheck(row.petitionid),
            casenumber: row.casenumber,
            transportationscheduled: row.transportationscheduled
        });
    }

    var fileName = `${request.where.outputfilename}.${request.where.type}`;

    res.setHeader(contenttypestr,spreadsheetcontenttype);
    res.setHeader(contentdispositionstr,attachmentstr + fileName);
    if (reportType === 'xlsx') {
        workbook.xlsx.write(res)
            .then(() => res.end());
    } else if (reportType === 'csv') {
        workbook.csv.write(res)
            .then(() => res.end());
    }
}

module.exports.levelReport = function (request,operation,res = null) {
    const cjamsid = request.where.cjamsid;
    const providername = request.where.providername;
    const addmissisiontype = request.where.addmissisiontype;

    const nolimit = !!request.nolimit;
    let skip;
    let limit;
    if (!nolimit) {
        skip = (request.page - 1) * request.limit;
        limit = request.limit;
    }
    const sql = "select * from getlevelreport($1, $2, $3, $4, $5, $6)";

    return util.executeDBQuery(sql,[cjamsid,providername,addmissisiontype,limit,skip,nolimit])
        .then(data => {
            return data;
        })
        .then(resp => {
            return new Promise((resolve,reject) => {
                if (operation === 'list') {
                    resolve({
                        totalcount: getTotalCount(resp).reccount,
                        data: resp
                    });
                } else if (operation === 'generate') {
                    const reportType = request.where.type;
                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            const reqjson = getLRreportGrid(request,cjamsid,providername,reqjson,resp);
                            const html = fs.readFileSync('./documenttemplates/reports/supervisor/level.html','utf8');
                            res = pdf.generatepdf(request,html,reqjson,{
                                type: 'report',
                                res: res
                            });
                            resolve(res);
                        } else {
                            getLRWorksheet(request,reportType,resp,addmissisiontype,cjamsid,providername,res);
                        }
                    }
                }
            })
        })
        .catch(err2 => {
            util.logError(err2);
            LOGGER.error(err2);
            return err2;
        })
};

function getHeader(addmissisiontype, cjamsid, providername, reportType){
    let headerRow;
    if (addmissisiontype == null && cjamsid == null && providername == null) {
        headerRow = reportType === 'xlsx' ? 3 : 1;
    } else {
        headerRow = reportType === 'xlsx' ? 5 : 1;
    }
    return headerRow;
}

function getLRWorksheet(request, reportType, resp, addmissisiontype, cjamsid, providername, res) {
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('D1','J1');
        worksheet.getCell('D1').value = `Level Report`;
        worksheet.getCell('D1').font = titleSize;
        worksheet.getCell('D1').alignment = centerAlign;
        worksheet.getCell('B3').value = request.where.addmissisiontype ? `Level: ${resp[0].level}` : "";
        worksheet.getCell('B3').font = subHeaderSize;
        worksheet.getCell('B3').alignment = centerAlign;
        worksheet.getCell('D3').value = request.where.cjamsid ? `PID: ${cjamsid}` : "";
        worksheet.getCell('D3').font = subHeaderSize;
        worksheet.getCell('D3').alignment = centerAlign;
        worksheet.getCell('F3').value = request.where.providername ? `Provider Name : ${providername}` : "";
        worksheet.getCell('F3').font = subHeaderSize;
        worksheet.getCell('F3').alignment = centerAlign;
    }

    worksheet.columns = [{
        key: 'pid',
        width: 10
    },
    {
        key: 'clientname',
        width: 20
    },
    {
        key: 'dob',
        width: 20
    },
    {
        key: 'level',
        width: 20
    },
    {
        key: 'region',
        width: 20
    },
    {
        key: 'phonenumber',
        width: 15
    },
    {
        key: 'admitdate',
        width: 15
    },
    {
        key: 'releasedate',
        width: 15
    }
    ];
    const headerRow = getHeader(addmissisiontype, cjamsid, providername, reportType);

    worksheet.getRow(headerRow).values = [
        'PID',
        'Client',
        'DOB',
        'Level',
        'Region',
        'Phone #',
        'Admit Date',
        'Release Date'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    for (const row of resp) {
        worksheet.addRow({
            pid: `${row.pid}`,
            clientname: `${row.clientname}`,
            dob: util.formatDate(row.dob),
            level: row.level,
            region: util.nullcheck(row.region),
            phonenumber: `${row.phonenumber}`,
            admitdate: `${util.formatDate(row.admitdate)}`,
            releasedate: util.formatDate(row.releasedate)
        });
    }

    var fileName = `${request.where.outputfilename}.${request.where.type}`;

    res.setHeader(contenttypestr,spreadsheetcontenttype);
    res.setHeader(contentdispositionstr,attachmentstr + fileName);
    if (reportType === 'xlsx') {
        workbook.xlsx.write(res)
            .then(() => res.end());
    } else if (reportType === 'csv') {
        workbook.csv.write(res)
            .then(() => res.end());
    }
}

function getLRreportGrid(request, cjamsid, providername, reqjson, resp) {
    let reportGrid = '';
    for (const row of resp) {
        reportGrid += `
                    <tr style="background: #edeff2;">
                        <td>${row.pid}</td>
                        <td>${row.clientname}</td>
                        <td>${util.formatDate(row.dob)}</td>
                        <td>${row.level}</td>
                        <td>${util.nullcheck(row.region)}</td>
                        <td>${row.phonenumber}</td>
                        <td>${util.formatDate(row.admitdate)}</td>
                        <td>${util.formatDate(row.releasedate)}</td>
                    </tr>`;
    }
    reqjson.levelGrid = reportGrid;
    reqjson.level = request.where.addmissisiontype ? `<h5 class="text-center text-b">
                            Level :${resp[0].level}
                        </h5>` : "";
    reqjson.pid = request.where.cjamsid ? `<h5 class="text-center text-b">
                            PID: ${cjamsid}
                        </h5>` : "";
    reqjson.providername = request.where.providername ? `<h5 class="text-center text-b">
                           Provider Name : ${providername}
                        </h5>` : "";
    reqjson.landscape = true;
    return reqjson;
}

function getTotalCount(resp){
    let totalcount = 0;
    if (resp.length > 0) {
        totalcount = resp[0];
    }
    return totalcount;
}

module.exports.censusReport = function (request,operation,res = null) {
    request.nolimit = !!request.nolimit;
    if (!request.nolimit) {
        request.pageoffset = (request.page - 1) * request.limit;
        request.pagesize = request.limit;
    }
    const sql = "select * from getpopulationreport($1)";
    return util.executeDBQuery(sql,[request])
        .then(data => {
            return data;
        })
        .then(response => {
            return new Promise((resolve,reject) => {
                const resp = response[0].populationreport;
                if (operation === 'list') {

                    resolve({
                        totalcount: getTotalCount(resp).reccoount,
                        data: resp
                    });
                } else if (operation === 'generate') {
                    const reportType = request.where.type;
                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            const reqjson = {};
                            const reportGrid = getCRreportGrid(resp,worksheet,isworksheet)
                            reqjson.census = reportGrid;
                            reqjson.providername = '';
                            reqjson.providerunit = '';
                            reqjson.primaryadmissionreason = '';
                            reqjson.folderworkerfirstname = '';
                            reqjson.folderworkerlastname = '';
                            reqjson.folderoffice = '';
                            reqjson.fieldworkerfirstname = '';
                            reqjson.fieldworkerlastname = '';
                            reqjson.status = '';
                            reqjson.datefilter = '';
                            reqjson.startdate = '';
                            reqjson.enddate = '';
                            reqjson.date = '';
                            reqjson.ethnicity = '';
                            reqjson.residencecounty = '';
                            reqjson.jurisdictioncounty = '';
                            reqjson.jurisdictionoffice = '';

                            reqjson.landscape = true;
                            const html = fs.readFileSync('./documenttemplates/reports/supervisor/census.html','utf8');
                            res = pdf.generatepdf(request,html,reqjson,{
                                type: 'report',
                                res: res
                            });
                            resolve(res);
                        } else {
                            censusReportWorkSheet(request,reportType,resp,res);
                        }
                    }
                }
            })
        })
        .catch(err3 => {
            util.logError(err3);
            LOGGER.error(err3);
            return err3;
        });
};

function censusReportWorkSheet(request, reportType, resp, res) {
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('D1','J1');
        worksheet.getCell('D1').value = `Census Report`;
        worksheet.getCell('D1').font = titleSize;
        worksheet.getCell('D1').alignment = centerAlign;
    }

    const worksheetencode = Buffer.from('W3sia2V5IjoidW5pdCIsIndpZHRoIjoyMH0seyJrZXkiOiJiZWQiLCJ3aWR0aCI6NX0seyJrZXkiOiJwcm92aWRlcm5hbWUiLCJ3aWR0aCI6NDB9LHsia2V5IjoiY2xpZW50aWQiLCJ3aWR0aCI6MTV9LHsia2V5IjoiY2xpZW50Iiwid2lkdGgiOjIwfSx7ImtleSI6ImRvYiIsIndpZHRoIjoxNX0seyJrZXkiOiJyYWNlIiwid2lkdGgiOjEwfSx7ImtleSI6InNleCIsIndpZHRoIjoxMH0seyJrZXkiOiJwcmltYXJ5YWRtaXNzaW9ucmVhc29uIiwid2lkdGgiOjMwfSx7ImtleSI6ImFkbWlzc2lvbmRhdGUiLCJ3aWR0aCI6MTV9LHsia2V5IjoicmVsZWFzZWRhdGUiLCJ3aWR0aCI6MTV9LHsia2V5IjoicmVsZWFzZXRvIiwid2lkdGgiOjIwfSx7ImtleSI6InRyYW5zZmVyZGF0ZSIsIndpZHRoIjoxNX0seyJrZXkiOiJ0cmFuc2ZlcnRvIiwid2lkdGgiOjIwfSx7ImtleSI6InByb2plY3RlZHJlbGVhc2VkYXRlIiwid2lkdGgiOjI1fSx7ImtleSI6ImNvdW50eWp1cmlzZGN0aW9uIiwid2lkdGgiOjIwfSx7ImtleSI6ImFkbWlzc2lvbnR5cGUiLCJ3aWR0aCI6MjV9XQ==','base64');
    worksheet.columns = JSON.parse(worksheetencode);

    const headerRow = reportType === 'xlsx' ? 3 : 1;
    worksheet.getRow(headerRow).values = [
        'Unit',
        'Bed',
        'Provider Name',
        'Client ID',
        'Client Name',
        'DOB ',
        'Race ',
        'Sex ',
        'Primary Admission Reason ',
        'Admission Date ',
        'Release Date',
        'Release to',
        'Transfer Date ',
        'Transfer to ',
        'Projected Release Date ',
        'County Jurisdiction ',
        'Admission Type ',
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    getCRreportGrid(resp,worksheet,true);
    var fileName = `${request.where.outputfilename}.${request.where.type}`;

    res.setHeader(contenttypestr,spreadsheetcontenttype);
    res.setHeader(contentdispositionstr,attachmentstr + fileName);
    if (reportType === 'xlsx') {
        workbook.xlsx.write(res)
            .then(() => res.end());
    } else if (reportType === 'csv') {
        workbook.csv.write(res)
            .then(() => res.end());
    }
}

function getCRreportGrid(resp, worksheet, isworksheet){
    let reportGrid = '';
    const gender = {
        'M': 'Male',
        'F': 'Female'
    }
    if(isworksheet && worksheet){
        for (const row of resp) {
            worksheet.addRow({
                unit: `${row.unit}`,
                bed: `${util.nullcheck(row.bed)}`,
                providername: row.providername,
                clientid: row.clientid,
                client: `${row.clientfirstname} ${row.clientlastname}`,
                dob: `${util.formatDate(row.dob)}`,
                race: `${util.nullcheck(row.race)}`,
                sex: gender[row.sex] || '',
                primaryadmissionreason: util.nullcheck(row.primaryadmissionreason),
                admissiondate: util.nullcheck(row.admissiondate),
                releasedate: util.nullcheck(row.releasedate),
                releaseto: util.nullcheck(row.releaseto),
                transferdate: util.nullcheck(row.transferdate),
                transferto: util.nullcheck(row.transferto),
                projectedreleasedate: util.formatDate(row.projectedreleasedate),
                countyjurisdction: row.countyjurisdction,
                admissiontype: row.admissiontype
            });
        }
    }else{
        for (const row of resp) {
            reportGrid += `
            <tr style="background: #edeff2;">
                <td>${row.unit}</td>
                <td>${util.nullcheck(row.bed)}</td>
                <td>${row.providername}</td>
                <td>${row.clientid}</td>
                <td>${row.clientfirstname}&nbsp;${row.clientlastname}</td>
                <td>${util.formatDate(row.dob)}</td>
                <td>${util.nullcheck(row.race)}</td>
                <td>${gender[row.sex] || ''}</td>
                <td>${util.nullcheck(row.primaryadmissionreason)}</td>
                <td>${util.nullcheck(row.admissiondate)}</td>
                <td>${util.nullcheck(row.releasedate)}</td>
                <td>${util.nullcheck(row.releaseto)}</td>
                <td>${util.nullcheck(row.transferdate)}</td>
                <td>${util.nullcheck(row.transferto)}</td>
                <td>${util.formatDate(row.projectedreleasedate)}</td>
                <td>${row.countyjurisdction}</td>
                <td>${row.admissiontype}</td>
            </tr>`;
        }
    }
    return reportGrid;
}

module.exports.contactSupportReport = function (request,suserid, res = null) {
    var securityusersid = suserid;
    request.input.searchstring = request.searchString ? request.searchString : null;
    var jsondata = request.input;
    jsondata.application = 'CW';
    jsondata.jiraenv = config.jiraenv;
    var reporttype = request.doctype ? request.doctype : 'xlsx';

    var sql = 'select * from getsupportlog($1,$2,$3,$4,$5,$6,$7)';
    return util.executeDBQuery(sql, [jsondata, securityusersid, request.sortcolumn,
                request.sortorder, 1, 10, true])
        .then(resp => {
            return new Promise((resolve, reject) => {
                    if (resp.length > 0) {
                        if (reporttype == 'xlsx') {
                            const workbook = new Excel.Workbook();
                            const worksheet = workbook.addWorksheet('Contact_Support_Tickets.xlsx');
                            /*if we need to do any change on worksheet.columns 
                            1)we need to take the value of worksheet.columns and update the json 
                            2)do btoa(JSON.stringify(UPDATED_JSON comes here)) 
                            3)give the output of second step as input to Buffer.from();
                            */
                            const worksheetencode= Buffer.from('W3sia2V5Ijoic3VwcG9ydG5vIiwid2lkdGgiOjIwfSx7ImtleSI6Imlzc3VldHlwZSIsIndpZHRoIjoyMH0seyJrZXkiOiJzZXZlcml0eSIsIndpZHRoIjoyMH0seyJrZXkiOiJwcmlvcml0eSIsIndpZHRoIjoyMH0seyJrZXkiOiJjYXNlaWQiLCJ3aWR0aCI6MjB9LHsia2V5IjoicHJvZ3JhbSIsIndpZHRoIjoyMH0seyJrZXkiOiJmb2N1cyIsIndpZHRoIjoyNX0seyJrZXkiOiJsZHNzcmVnaW9uIiwid2lkdGgiOjI1fSx7ImtleSI6ImZyb21tYWlsaWQiLCJ3aWR0aCI6MzV9LHsia2V5IjoiZWZmZWN0aXZlZGF0ZSIsIndpZHRoIjoyNX0seyJrZXkiOiJqaXJhcmVxdWVzdHNlbnQiLCJ3aWR0aCI6MjV9LHsia2V5Ijoic3ViamVjdCIsIndpZHRoIjo1MH0seyJrZXkiOiJub3RlcyIsIndpZHRoIjo1MH0seyJrZXkiOiJqaXJhcmVxdWVzdG5vIiwid2lkdGgiOjIwfSx7ImtleSI6InN0YXR1cyIsIndpZHRoIjoyMH1d','base64');
                            worksheet.columns= JSON.parse(worksheetencode);
                            const headerRow = 1;
                            worksheet.getRow(headerRow).values = [
                                'Support# ',
                                'Issue Type ',
                                'Severity ',
                                'Priority ',
                                'Intake Case Id ',
                                'Program Area ',
                                'Focus Area ',
                                'County ',
                                'User ',
                                'Date & Time',
                                'Approval Status ',
                                'Subject ',
                                'Comments',
                                'Jira Ticket# ',
                                'Jira Status',
                            ];
                            worksheet.getRow(headerRow).eachCell(cell => {
                                cell.fill = headerStyle;
                            });
                            getCSRreportGrid(resp, worksheet, true);
                            var fileName = `Contact_Support_Tickets.xlsx`;
                            res.setHeader(contenttypestr, spreadsheetcontenttype);
                            res.setHeader(contentdispositionstr, attachmentstr + fileName);
                            workbook.xlsx.write(res)
                                .then(() => res.end());
                        } else {
                            const reqjson = {};
                            const reportGrid = getCSRreportGrid(resp, null, false);
                            
                            reqjson.contactsupport = reportGrid;
                            reqjson.landscape = true;
                            request.where = {
                                'intakenumber': null,
                                'evaluationid': null,
                                'intakeserviceid': null,
                                'isheaderrequired': false,
                                'outputfilename': 'Contact_Support_Tickets.pdf'
                            }
                            request.documntkey = null;
                            const html = fs.readFileSync('./documenttemplates/contactsupport.html', 'utf8');
                            res = pdf.generatepdf(request, html, reqjson, {
                                type: 'report',
                                res: res
                            });
                            resolve(res);
                        }
                            
                    }
            })
        })
        .catch(err => util.logError(err));
};

function getCSRreportGrid(resp, worksheet, isworksheet){
    let issuetype;
    let reportGrid = '';
    for (const row of resp) {
        issuetype = '';
        if (row.issuetype) {
            const issuetypes = {
                '531': 'Enhancement',
                '528': 'Bug/Issue/Defect',
                '524': 'Application Support/Training'
            }
            issuetype = issuetypes[row.issuetype];
            
        }
        if(isworksheet && worksheet){
            worksheet.addRow({
                supportno: `${row.supportno}`,
                issuetype: `${issuetype}`,
                severity: `${row.severity}`,
                priority: `${row.priority}`,
                caseid: `${row.caseid}`,
                program: util.nullcheck(row.application),
                focus: util.nullcheck(row.focus),
                ldssregion: `${row.ldssregion}`,
                frommailid: `${row.frommailid}`,
                effectivedate: row.effectivedate ? util.formatDateAndTime(row.effectivedate) : '',
                jirarequestsent: checkjirarequest(row.jirarequestsent),
                subject: `${row.subject}`,
                notes: `${row.notes}`,
                jirarequestno: util.nullcheck(row.jirarequestno),
                status: util.nullcheck(row.status),
            });
        }else {
            reportGrid += `
            <tr style="background: #edeff2;">
                <td>${row.supportno}</td>
                <td>${issuetype}</td>
                <td>${util.nullcheck(row.severity)}</td>
                <td>${util.nullcheck(row.priority)}</td>
                <td>${util.nullcheck(row.caseid)}</td>
                <td>${util.nullcheck(row.application)}</td>
                <td>${util.nullcheck(row.focus)}</td>
                <td>${util.nullcheck(row.ldssregion)}</td>
                <td>${util.nullcheck(row.frommailid)}</td>
                <td>${row.effectivedate ? util.formatDateAndTime(row.effectivedate) : ''}</td>
                <td>${util.nullcheck(row.jirarequestsent)}</td>
                <td>${util.nullcheck(row.subject)}</td>
                <td>${util.nullcheck(row.notes)}</td>
                <td>${util.nullcheck(row.jirarequestno)}</td>
                <td>${util.nullcheck(row.status)}</td>
            </tr>`;
        }
    }

    return reportGrid;
}

function checkjirarequest(value){
    return  value ? value : 'Pending';
}

module.exports.releaseNotesReport = function (request, res = null) {
    request.nolimit = true;
    request.sortdirection = 'asc';
    request.sortcolumn = 'itemid';
    request.application = 'CW';
    var reporttype = request.doctype ? request.doctype : 'pdf';

    var sql = 'select * from getreleasedata($1)';
    return util.executeDBQuery(sql, [request])
        .then(resp => {
            return new Promise((resolve, reject) => {
                    if (resp.length > 0) {
                        if (reporttype == 'xlsx'){
                            const workbook = new Excel.Workbook();
                            const worksheet = workbook.addWorksheet('Release_Notes.xlsx');
                            worksheet.mergeCells('A1', 'C1');
                            worksheet.getCell('A1').value = `Release Date: ` + util.formatDate(request.releasedate, '/');
                            worksheet.getCell('A1').font = titleSize;
                            worksheet.mergeCells('A2', 'C2');
                            worksheet.getCell('A2').value = `Release Version: ` + request.releaseversionno;
                            worksheet.getCell('A2').font = titleSize;
                            worksheet.columns = [{
                                    key: 'itemtype',
                                    width: 20
                                },
                                {
                                    key: 'itemid',
                                    width: 20
                                },
                                {
                                    key: 'supportid',
                                    width: 20
                                },
                                {
                                    key: 'raisedby',
                                    width: 20
                                },
                                {
                                    key: 'documentlink',
                                    width: 25
                                },
                                {
                                    key: 'title',
                                    width: 25
                                },
                                {
                                    key: 'description',
                                    width: 35
                                }
                            ];
                            const headerRow = 4;
                            worksheet.getRow(headerRow).values = [
                                'Defect/Story',
                                'JIRA#/Story # ',
                                'Support# ',
                                'Raised By ',
                                'How to Guide ',
                                'Title ',
                                'Description ',
                            ];
                            worksheet.getRow(headerRow).eachCell(cell => {
                                cell.fill = headerStyle;
                            });
                            getreportGrid(resp, worksheet, true);
                            var fileName = `Release_Notes.xlsx`;
                            res.setHeader(contenttypestr, spreadsheetcontenttype);
                            res.setHeader(contentdispositionstr, attachmentstr + fileName);
                                workbook.xlsx.write(res)
                                    .then(() => res.end());
                        } else {
                            const reqjson = {};
                            const reportGrid = getreportGrid(resp, null, false);
                            reqjson.releasenotes = reportGrid;
                            reqjson.releaseversionno = request.releaseversionno;
                            reqjson.releasedate = util.formatDate(request.releasedate, '/');
                            reqjson.landscape = true;
                            request.where = {
                                'intakenumber': null,
                                'evaluationid': null,
                                'intakeserviceid': null,
                                'isheaderrequired': false,
                                'outputfilename': 'Release_Notes.pdf'
                            }
                            request.documntkey = null;
                            const html = fs.readFileSync('./documenttemplates/releasenotes.html', 'utf8');
                            res = pdf.generatepdf(request, html, reqjson, {
                                type: 'report',
                                res: res
                            });
                            resolve(res);
                        }
                    }
            })
        })
        .catch(err => util.logError(err));
};

function getreportGrid(resp, worksheet, isworksheet) {
    let reportGrid = '';
    for (const row of resp) {
        const raisedby = util.nullcheck(row.raisedby);
        const displayname = util.nullcheck(row.displayname);
        if(isworksheet && worksheet){
            worksheet.addRow({
                itemtype: `${row.itemtype}`,
                itemid: `${row.itemid}`,
                supportid: util.nullcheck(row.supportid),
                raisedby: row.itemtype == 'Defect' ? `${displayname}` : `${raisedby}`,
                documentlink: util.nullcheck(row.documentlink),
                title: util.nullcheck(row.title),
                description: util.nullcheck(row.description)
            });
        } else {
            reportGrid += `
                <tr style="background: #edeff2;">
                    <td>${row.itemtype}</td>
                    <td>${row.itemid}</td>
                    <td>${util.nullcheck(row.supportid)}</td>
                    <td>${row.itemtype == 'Defect' ? displayname : raisedby}</td>
                    <td style="width:15% !important; word-wrap:break-word !important; white-space: normal !important; word-break: break-all;">${util.nullcheck(row.documentlink)}</td>
                    <td>${util.nullcheck(row.title)}</td>
                    <td>${util.nullcheck(row.description)}</td>
                </tr>`;
        }
    }
    return reportGrid;
}