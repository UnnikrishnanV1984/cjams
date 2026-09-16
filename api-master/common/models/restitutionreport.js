'use strict';
const LOGGER = require("log4js").getLogger("restitutionreport");
const util = require('../utils/utils');
var fs = require('fs');
var app = require('../../server/server');
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

const offendernamestr = 'Offender Name';
const contenttypestr = 'Content-Type';
const spreadsheetcontenttype = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
const contentdispositionstr = "Content-Disposition";
const attachmentstr = "attachment; filename=";

module.exports = function (Restitutionreport) {
    Restitutionreport.generate = (type, request, res) => {
        switch (type) {
            case 'newcase':
                return module.exports.newCaseReport(request, 'generate', res);
            case 'ccu':
                return module.exports.ccuReport(request, 'generate', res);
            case 'paymentLog':
                return module.exports.paymentLogReport(request, 'generate', res);
            case 'exceptionReport':
                return module.exports.exceptionReport(request, 'generate', res);
            case 'ccuList':
                return module.exports.ccuListReport(request, 'generate', res);
            case 'summaryReport':
                return module.exports.summaryReport(request, 'generate', res);
            case 'caseClosingReport':
                return module.exports.caseClosingReport(request, 'generate', res);
            case 'paymentMatchesReport':
                return module.exports.paymentMatchesReport(request, 'generate', res);
            case 'openCaseSummaryReport':
                return module.exports.openCaseSummaryReport(request, 'generate', res);
            case 'workerPopulationSheetReport':
                return module.exports.workerPopulationSheetReport(request, 'generate', res);
        }
        return Promise.resolve({ message: 'Unsupported report type: ' + type });
    };

    Restitutionreport.list = (type, request) => {
        switch (type) {
            case 'newcase':
                return module.exports.newCaseReport(request, 'list');
            case 'ccu':
                return module.exports.ccuReport(request, 'list');
            case 'paymentLog':
                return module.exports.paymentLogReport(request, 'list');
            case 'exceptionReport':
                return module.exports.exceptionReport(request, 'list');
            case 'summaryReport':
                return module.exports.summaryReport(request, 'list');
            case 'caseClosingReport':
                return module.exports.caseClosingReport(request, 'list');
            case 'paymentMatchesReport':
                return module.exports.paymentMatchesReport(request, 'list');
            case 'openCaseSummaryReport':
                return module.exports.openCaseSummaryReport(request, 'list');
            case 'workerPopulationSheetReport':
                return module.exports.workerPopulationSheetReport(request, 'list');
        }
        return Promise.resolve({ message: 'Unsupported report type: ' + type });
    };

    Restitutionreport.remoteMethod('generate', {
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
            }
        ],
        returns: {
            arg: 'data',
            type: 'Object'
        }
    });

    Restitutionreport.remoteMethod('list', {
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

module.exports.newCaseReport = function (request, operation, res = null) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;

    const nolimit = !!request.nolimit;
    let skip;
    let limit;
    if (!nolimit) {
        skip = (request.page - 1) * request.limit;
        limit = request.limit;
    }


    const sql = "select * from getnewcasereport($1, $2, $3, $4, $5)";
    return util.executeDBQuery(sql, [startdate, enddate, limit, skip, nolimit])
        .then(resp => {
            return new Promise((resolve, reject) => {
                if (operation === 'list') {
                    let totalcount = 0;
                    if (resp.length > 0) {
                        totalcount = resp[0].reccoount;
                    }
                    resolve({
                        totalcount: totalcount,
                        data: resp
                    });
                } else if (operation === 'generate') {
                    generatenewcasereport(resp, request, startdate, enddate, res);
                }
            })
        })
        .catch(err => util.logError(err));
};

function generatenewcasereport(resp, request, startdate, enddate, res){
    const reportType = request.where.type;
    if (resp.length > 0) {
        if (reportType === 'pdf') {
            const reqjson = {};
            let reportGrid = '';
            for (const row of resp) {
                LOGGER.debug(row);
                reportGrid += `<tr><td colspan="6" style="text-align: left; font-weight: 700;">${row.area}</td></tr>`;
                const areaJSON = row.restitutions;
                areaJSON.forEach(area => {
                    reportGrid +=
                        `<tr style="background: #edeff2;">
                    <td></td>
                    <td>${area.area}</td>
                    <td>$${area.amount}</td>
                    <td>${area.acctnumber}</td>
                    <td>${area.offendername}</td>
                    <td>${util.formatDate(area.initialentrydate)}</td>
                </tr>`;
                });
                reportGrid += `<tr style="background: #cccccc;">
            <td colspan="4"><b>Total ${row.area} Amount : </b>&nbsp;${'$' + row.totalamount}</td>
            <td colspan="2"><b>Total Cases : </b>&nbsp;${row.totalcase}</td>
        </tr>`;
            }
            reqjson.newCaseDetails = reportGrid;
            reqjson.startdate = startdate;
            reqjson.enddate = enddate;
            const html = fs.readFileSync('./documenttemplates/reports/restitution/new-case.html', 'utf8');
            res.on('data', function (chunk) {
                LOGGER.debug('BODY: ' + chunk);
            });
            res = pdf.generatepdf(request, html, reqjson, {
                type: 'report',
                res: res
            });
            resolve(res);
        } else {
            genrateWorksheetnewcasereport(request, resp, startdate, enddate, res);
        }
    }
}

function genrateWorksheetnewcasereport(request, resp, startdate, enddate, res) {
    const reportType = request.where.type;
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('D1','J1');
        worksheet.getCell('D1').value = `NEW CASE BY PERIOD (${startdate} to ${enddate})`;
        worksheet.getCell('D1').font = titleSize;
        worksheet.getCell('D1').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'areaCode',
        width: 10
    },
    {
        key: 'amount',
        width: 10
    },
    {
        key: 'accountNumber',
        width: 20
    },
    {
        key: 'offender',
        width: 25
    },
    {
        key: 'date',
        width: 20
    }
    ];
    const headerRow = reportType === 'xlsx' ? 3 : 1;
    worksheet.getRow(headerRow).values = [
        'Area Code',
        'Amount',
        'Account Number',
        offendernamestr,
        'Initial Entry Date'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        LOGGER.debug(cell);
        cell.fill = headerStyle;
    });
    for (const row of resp) {
        const areaJSON = row.restitutions;
        areaJSON.forEach(area => {
            worksheet.addRow({
                areaCode: `${row.area}`,
                amount: `$${area.amount}`,
                accountNumber: area.acctnumber,
                offender: area.offendername,
                date: area.initialentrydate ? util.formatDate(area.initialentrydate) : ''
            });
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

module.exports.ccuReport = function (request, operation, res = null) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;

    const nolimit = !!request.nolimit;
    let skip;
    let limit;
    if (!nolimit) {
        skip = (request.page - 1) * request.limit;
        limit = request.limit;
    }

    const sql = "select * from getccurestitution($1, $2, $3, $4, $5)";
    return util.executeDBQuery(sql, [startdate, enddate, limit, skip, nolimit])
        .then(resp => {
            return new Promise((resolve, reject) => {
                if (operation === 'list') {
                    let totalcount = 0;
                    if (resp.length > 0) {
                        totalcount = resp[0].reccoount;
                    }
                    resolve({
                        totalcount: totalcount,
                        data: resp
                    });
                } else if (operation === 'generate') {
                    generateccuReport(request, resp, startdate, enddate, res);
                }
            })
        })
        .catch(err => util.logError(err));
};

function checkEmpty(value){
    return value ? value : '';
}

function checkDate(value){
    return value ? util.formatDate(value) : '';
}

function generateccuReport(request, resp, startdate, enddate, res) {
    let Response;
    const reportType = request.where.type;
    if (resp.length > 0) {
        if (reportType === 'pdf') {
            const reqjson = {};
            let reportGrid = '';
            for (const row of resp) {

                reportGrid += `<tr><td colspan="8" style="text-align: left; font-weight: 700;">${row.area}</td></tr>`;
                const restitutionJSON = row.restitutions;
                restitutionJSON.forEach(restitution => {
                    reportGrid +=
                        `<tr style="background: #edeff2;">
                                    <td></td>
                                    <td>${restitution.casenumber}</td>
                                    <td>${restitution.amount}</td>
                                    <td>${restitution.offendername}</td>
                                    <td>${util.formatDate(restitution.referraldate)}</td>
                                    <td>${restitution.primarydebtor}</td>
                                    <td>${checkEmpty(restitution.secondarydebtor)}</td>
                                    <td>${checkDate(restitution.ccuaccepteddate)}</td>
                                </tr>`;
                });
            }
            reqjson.ccuReport = reportGrid;
            reqjson.startdate = startdate;
            reqjson.enddate = enddate;
            const html = fs.readFileSync('./documenttemplates/reports/restitution/ccu-report.html','utf8');
            Response = pdf.generatepdf(request,html,reqjson,{
                type: 'report',
                res: res
            });
            return Response;
        } else {
            generateWorksheetccuReport(request, resp, startdate, enddate, res);
        }
    }
}

function generateWorksheetccuReport(request, resp, startdate, enddate, res) {
    const reportType = request.where.type;
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1','H1');
        worksheet.getCell('E1').value = `CCU CASE REPORT`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
        worksheet.mergeCells('E2','H2');
        worksheet.getCell('E2').value = `For period from ${startdate} to ${enddate}`;
        worksheet.getCell('E2').font = subHeaderSize;
        worksheet.getCell('E2').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'areaCode',
        width: 10
    },
    {
        key: 'caseNumber',
        width: 10
    },
    {
        key: 'amount',
        width: 10
    },
    {
        key: 'offender',
        width: 25
    },
    {
        key: 'referralDate',
        width: 20
    },
    {
        key: 'primaryDebtor',
        width: 20
    },
    {
        key: 'secondaryDebtor',
        width: 20
    },
    {
        key: 'ccuDate',
        width: 20
    },
    ];
    const headerRow = reportType === 'xlsx' ? 4 : 1;
    worksheet.getRow(headerRow).values = [
        'Area Code',
        'Case Number',
        'Amount',
        offendernamestr,
        'Referral Date',
        'Primary Debtor',
        'Secondary Debtor',
        'CCU Accepted Date'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    for (const row of resp) {

        const areaJSON = row.restitutions;
        areaJSON.forEach(area => {
            worksheet.addRow({
                areaCode: `${row.area}`,
                caseNumber: `${area.casenumber}`,
                amount: `${area.amount}`,
                offender: area.offendername,
                referralDate: util.formatDate(area.referraldate),
                primaryDebtor: area.primarydebtor,
                secondaryDebtor: area.secondarydebtor,
                ccuDate: area.ccuaccepteddate ? util.formatDate(area.ccuaccepteddate) : ''
            });
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

module.exports.paymentLogReport = function (request, operation, res = null) {
    request.nolimit = (operation === 'generate');
    return app.models.Intakeserreqrestitution.getrestitutionpayment(request, (err, data) => {
            resolve(data);
        }).then(resp => {
            return new Promise((resolve, reject) => {
                const restitutions = resp.data;
                if (operation === 'list') {
                    resolve(resp);
                } else if (operation === 'generate') {
                    const reportType = request.where.type;
                    let response;
                    if (restitutions.length > 0) {
                        if (reportType === 'pdf') {
                            resolve(getPLRPDFReport(restitutions, response, res, request));
                        } else {
                            getPLRWorksheet(request, reportType, restitutions, res);
                        }
                    }
                    // return response;
                }
            })
        })
        .catch(err => util.logError(err));
};

function getPLRPDFReport(restitutions, response, res, request) {
    let restitutionAccounts = 0;
    let restitutionAmount = 0.00;
    let amountPaid = 0.00;
    let balance = 0.00;
    if (restitutions.length > 0) {
        const reqjson = {};
        let reportGrid = '';
        restitutionAccounts = restitutions.length;
        reportGrid += `<tr class="text-b">
                    <th style="width: 15%;"><b>RESTITUTION #</b></th>
                    <th style="width: 10%;"><b>TYPE</b></th>
                    <th style="width: 15%;"><b>DATE</b></th>
                    <th style="width: 20%;"><b>AMOUNT</b></th>
                    <th style="width: 20%;"><b>BALANCE</b></th>
                    <th style="width: 20%;"><b>END DATE</b></th>
                </tr>`;
        for (const row of restitutions) {
            restitutionAmount += Number(row.payment);
            balance += Number(row.balanceamount);

            reportGrid += `<tr>
                        <td>${row.restitutionno}</td>
                        <td style="text-transform: capitalize;">${row.restitutiontype}</td>
                        <td>${util.formatDate(row.paymentstartdate)}</td>
                        <td>$${row.payment}</td>
                        <td>$${row.balanceamount}</td>
                        <td>${util.formatDate(row.duedate)}</td>
                    </tr>`;
            const paymentJSON = row.paymentdetails;
            if (paymentJSON) {
                reportGrid += paymentJSON.length ?
                    `<tr>
                            <td colspan="6">
                            <table style="width: 94%;margin-left: 3%; margin-left: 3%;"><tr style="background: #e1e1e1;" class="text-b">
                                <td colspan="2"><u>PAYMENT NUMBER</u></td>
                                <td><u>PAYMENT DATE</u></td>
                                <td colspan="2"><u>PAYMENT AMOUNT</u></td>
                                <td><u>STATUS</u></td>
                            </tr>` : '';
                paymentJSON.forEach(payment => {
                    reportGrid +=
                        `<tr>
                                <td colspan="2">${payment.paymentnumber}</td>
                                <td>${payment.paymentdate}</td>
                                <td colspan="2">$${payment.paymentamount}</td>
                                <td>${payment.restitutionstatus}</td>
                            </tr>`;
                });

                reportGrid += paymentJSON.length ?
                    `</table>
							</td>
							</tr>` : '';
            }
        }
        amountPaid = restitutionAmount - balance;

        reqjson.paymentLog = reportGrid;
        reqjson.youth = request.where.youth;
        reqjson.restitutionAccounts = restitutionAccounts;
        reqjson.restitutionAmount = restitutionAmount;
        reqjson.amountPaid = amountPaid;
        reqjson.balance = balance;
        const html = fs.readFileSync('./documenttemplates/reports/restitution/payment-log.html','utf8');
        response = pdf.generatepdf(request,html,reqjson,{
            type: 'report',
            res: res
        });
        return response;
    }
}

function getPLRWorksheet(request, reportType, restitutions, res) {
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1','H1');
        worksheet.getCell('E1').value = `Payment Log Of ${request.where.youth}`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'resNo',
        width: 10
    },
    {
        key: 'type',
        width: 7
    },
    {
        key: 'date',
        width: 10
    },
    {
        key: 'amount',
        width: 10
    },
    {
        key: 'balance',
        width: 10
    },
    {
        key: 'enddate',
        width: 10
    },
    {
        key: 'paymentNo',
        width: 15
    },
    {
        key: 'paymentDate',
        width: 15
    },
    {
        key: 'paymentAmount',
        width: 15
    },
    {
        key: 'status',
        width: 10
    }
    ];
    const headerRow = reportType === 'xlsx' ? 3 : 1;
    worksheet.getRow(headerRow).values = [
        'Restitution #',
        'Type',
        'Date',
        'Amount',
        'Balance',
        'End Date',
        'Payment Number',
        'Payment Date',
        'Payment Amount',
        'Status'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    for (const row of restitutions) {

        const paymentJSON = row.paymentdetails;
        paymentJSON.forEach(payment => {
            worksheet.addRow({
                resNo: `${row.restitutionno}`,
                type: `${row.restitutiontype}`,
                date: `${util.formatDate(row.paymentstartdate)}`,
                amount: `${row.payment}`,
                balance: `${row.balanceamount}`,
                enddate: util.formatDate(row.duedate),
                paymentNo: payment.paymentnumber,
                paymentDate: payment.paymentdate,
                paymentAmount: `${util.formatDate(payment.paymentamount)}`,
                status: payment.restitutionstatus
            });
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

module.exports.ccuListReport = function (request, operation, res = null) {
    request.nolimit = (operation === 'generate');
    return app.models.Intakeserreqrestitution.getrestitutionccudashboardlist(request, (err, resp) => {
        return new Promise((resolve, reject) => {
            const restitutions = resp.data;
            if (operation === 'generate') {
                const reportType = request.where.type;
                let response;
                if (restitutions.length > 0) {
                    if (reportType === 'pdf') {
                        const reqjson = {};
                        let reportGrid = '';
                        for (const row of restitutions) {
                            reportGrid += `
                            <tr class="text-b">
                                <td>${row.restitutionno}</td>
                                <td>${row.youthpersonname}</td>
                                <td>${row.restitutiontype}</td>
                                <td>${row.victimpersonname}</td>
                                <td>${row.payment}</td>
                                <td>${row.paidamount}</td>
                                <td>${row.balanceamount}</td>
                                <td>${util.formatDate(row.duedate)}</td>
                                <td>${util.formatDate(row.initialpaymentdate)}</td>
                                <td>${row.createdby}</td>
                                <td>${util.formatDate(row.insertedon)}</td>
                            </tr>`;
                        }

                        reqjson.ccuReport = reportGrid;
                        reqjson.landscape = true;
                        const html = fs.readFileSync('./documenttemplates/reports/restitution/ccu-list-report.html', 'utf8');
                        response = pdf.generatepdf(request, html, reqjson, {
                            type: 'report',
                            res: res
                        });
                        resolve(response);
                        // return response;
                    } else {
                        ccuListWorksheet(reportType, request, restitutions, res);
                        
                    }
                }
                return response;
                // return response;
            }
        })
        // .then(res => {
        //     return res;
        // });

    })
    // .then(resp => {

    // })
    //     .catch(err => util.logError(err));
};

function ccuListWorksheet(reportType, request, restitutions, res){
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1', 'H1');
        worksheet.getCell('E1').value = `CCU LIST`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
    }
    worksheet.columns = [{
            key: 'resNo',
            width: 10
        },
        {
            key: 'youth',
            width: 25
        },
        {
            key: 'source',
            width: 10
        },
        {
            key: 'victim',
            width: 25
        },
        {
            key: 'amount',
            width: 10
        },
        {
            key: 'paid',
            width: 15
        },
        {
            key: 'balance',
            width: 15
        },
        {
            key: 'dueDate',
            width: 15
        },
        {
            key: 'lastPaymetDate',
            width: 20
        },
        {
            key: 'submitted',
            width: 15
        },
        {
            key: 'submittedDate',
            width: 15
        }
    ];
    const headerRow = reportType === 'xlsx' ? 3 : 1;
    worksheet.getRow(headerRow).values = [
        'Account ID',
        'Youth',
        'Source',
        'Victim',
        'Amount',
        'Amount Paid',
        'Balance Amount',
        'Due Date',
        'Last Payment Date',
        'Submitted By',
        'Submitted Date'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    for (const row of restitutions) {
        worksheet.addRow({
            resNo: `${row.restitutionno}`,
            youth: `${row.youthpersonname}`,
            source: `${(row.restitutiontype)}`,
            victim: `${row.victimpersonname}`,
            amount: `${row.payment}`,
            paid: `${row.paidamount}`,
            balance: `${row.balanceamount}`,
            dueDate: `${util.formatDate(row.duedate)}`,
            lastPaymetDate: `${row.initialpaymentdate ? util.formatDate(row.initialpaymentdate) : ''}`,
            submitted: `${row.createdby}`,
            submittedDate: `${util.formatDate(row.insertedon)}`
        });
    }

    var fileName = `${request.where.outputfilename}.${request.where.type}`;

    res.setHeader(contenttypestr, spreadsheetcontenttype);
    res.setHeader(contentdispositionstr, attachmentstr + fileName);
    if (reportType === 'xlsx') {
        workbook.xlsx.write(res)
            .then(() => res.end());
    } else if (reportType === 'csv') {
        workbook.csv.write(res)
            .then(() => res.end());
    }
}

module.exports.exceptionReport = function (request, operation, res = null) {
    const ageOver21 = request.where.ageOver21;
    const balanceGreaterThan = request.where.balanceGreaterThan;
    const balanceAmount = request.where.balanceAmount;
    const activeSupervision = request.where.activeSupervision;
    const isCCU = request.where.isCCU;

    const nolimit = !!request.nolimit;
    let skip;
    let limit;
    if (!nolimit) {
        skip = (request.page - 1) * request.limit;
        limit = request.limit;
    }


    const sql = "select * from getexceptionreport($1, $2, $3, $4, $5, $6, $7, $8)";

    return util.executeDBQuery(sql, [ageOver21, balanceGreaterThan, balanceAmount, activeSupervision, isCCU, limit, skip, nolimit])
    .then(data => {
        LOGGER.info(data);
        return data;
    })
        .then(resp => {
            return new Promise((resolve, reject) => {
                if (operation === 'list') {
                    resolve({
                        totalcount: getTotalCount(resp).reccoount,
                        data: resp
                    });
                } else if (operation === 'generate') {
                    let Response;
                    const reportType = request.where.type;
                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            let reqjson = {};
                            reqjson = exceptionReportPDFData(resp, balanceAmount, balanceGreaterThan, isCCU, activeSupervision, reqjson);
                            reqjson.reportName = request.where.reportName;
                            const html = fs.readFileSync('./documenttemplates/reports/restitution/exception.html', 'utf8');
                            Response = pdf.generatepdf(request, html, reqjson, {
                                type: 'report',
                                res: res
                            });
                            resolve(Response);
                        } else {
                            const amt = checkBalance(balanceAmount, balanceGreaterThan);
                            exceptionReportWorkSheet(request, reportType, amt, isCCU, activeSupervision, resp, res);
                        }
                    }
                }
            })
        })
        .catch(err => {
            LOGGER.error(err);
            util.logError(err);
            return err;
        });
};

function getTotalCount(resp){
    let totalcount = 0;
    if (resp.length > 0) {
        totalcount = resp[0];
    }
    return totalcount;
}

function exceptionReportPDFData(resp, balanceAmount, balanceGreaterThan, isCCU, activeSupervision, reqjson) {
    let reportGrid = '';
    for (const row of resp) {

        reportGrid += `<h5 class="text-b font-16">${row.username}</h6>`;
        const under21JSON = row.under21;
        if (under21JSON) {
            reportGrid +=
                `<div class="clearfix">
                                <h6 class="font-14 text-s-b"><u>Under 21</u></h6>
                                        <table>
                                            <thead>
                                                <tr class="text-b">
                                                    <th style="width: 20%">Offender Name</th>
                                                    <th>CJAMS ID</th>
                                                    <th>Account#</th>
                                                    <th>Amount</th>
                                                    <th>Balance</th>
                                                    <th>Entry Date</th>
                                                    <th>Last Pay</th>
                                                    <th>CCU Date</th>
                                                    <th>Judgement</th>
                                                </tr>
                                            </thead>
                                            <tbody>`;
            under21JSON.forEach(data => {
                reportGrid +=
                    `<tr>
                                        <td>${data.offendername}</td>
                                        <td>${data.assistid}</td>
                                        <td>${data.accountnumber}</td>
                                        <td>${data.amount}</td>
                                        <td>${data.balance}</td>
                                        <td>${util.formatDate(data.entrydate)}</td>
                                        <td>${util.formatDate(data.lastpay)}</td>
                                        <td>${util.formatDate(data.ccudate)}</td>
                                        <td>${util.nullcheck(data.judgement)}</td>
                                    </tr>`;
            });
        }
        const over21JSON = row.over21;
        if (over21JSON) {
            reportGrid +=
                `<div class="clearfix">
                                <h6 class="font-14 text-s-b"><u>Over 21</u></h6>
                                        <table>
                                            <thead>
                                                <tr class="text-b">
                                                    <th style="width: 20%">Offender Name</th>
                                                    <th>CJAMS ID</th>
                                                    <th>Account#</th>
                                                    <th>Amount</th>
                                                    <th>Balance</th>
                                                    <th>Entry Date</th>
                                                    <th>Last Pay</th>
                                                    <th>CCU Date</th>
                                                    <th>Judgement</th>
                                                </tr>
                                            </thead>
                                            <tbody>`;
            over21JSON.forEach(data1 => {
                reportGrid +=
                    `<tr>
                                        <td>${data1.offendername}</td>
                                        <td>${data1.assistid}</td>
                                        <td>${data1.accountnumber}</td>
                                        <td>${data1.amount}</td>
                                        <td>${data1.balance}</td>
                                        <td>${util.formatDate(data1.entrydate)}</td>
                                        <td>${util.formatDate(data1.lastpay)}</td>
                                        <td>${util.formatDate(data1.ccudate)}</td>
                                        <td>${util.nullcheck(data1.judgement)}</td>
                                    </tr>`;
            });
        }
        reportGrid += `</tbody>
                                        </table>
                                <p class="pull-right m-t-30 m-b-30"><b>TOTAL BALANCE FOR COUNSELOR : </b>&nbsp;${row.totalbalance}</p>
                                </div>`;
    }
    reqjson.exceptionReport = reportGrid;
    let balanceGreaterThan1 = balanceGreaterThan ? '>=' : '<=';
    reqjson.balance = (balanceAmount) ?
        `<h5 class="text-center text-b">
                        Balance ${balanceGreaterThan1} ${balanceAmount}
                    </h5>` :
        '';
    reqjson.ccu = (isCCU) ?
        `<h5 class="text-center text-b">
                        CCU referral or judgement
                    </h5>` :
        `<h5 class="text-center text-b">
                        No CCU referral or judgement
                    </h5>`;
    reqjson.supervision = (activeSupervision) ?
        `<h5 class="text-center text-b">
                        Open supervision folder
                    </h5>` :
        `<h5 class="text-center text-b">
                        No open supervision folder
                    </h5>`;

    return reqjson;
}

function checkBalance(balanceAmount, balanceGreaterThan){
    if(balanceamount){
        return `Balance ${balanceGreaterThan ? '>=' : '<='} ${balanceAmount}`
    }else{ return ''}
}

function exceptionReportWorkSheet(request, reportType, balanceAmount, isCCU, activeSupervision, resp, res) {
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1','H1');
        worksheet.getCell('E1').value = request.where.reportName;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
        worksheet.mergeCells('E2','H2');
        worksheet.getCell('E2').value = balanceAmount;
        worksheet.getCell('E2').font = subHeaderSize;
        worksheet.getCell('E2').alignment = centerAlign;
        worksheet.mergeCells('E3','H3');
        worksheet.getCell('E3').value = (isCCU) ?
            `CCU referral or judgement` :
            `No CCU referral or judgement`;
        worksheet.getCell('E3').font = subHeaderSize;
        worksheet.getCell('E3').alignment = centerAlign;
        worksheet.mergeCells('E4','H4');
        worksheet.getCell('E4').value = (activeSupervision) ?
            `Open supervision folder` :
            `No open supervision folder`;
        worksheet.getCell('E4').font = subHeaderSize;
        worksheet.getCell('E4').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'worker',
        width: 10
    },
    {
        key: 'over21',
        width: 7
    },
    {
        key: 'offender',
        width: 20
    },
    {
        key: 'cjamsId',
        width: 15
    },
    {
        key: 'accountNo',
        width: 10
    },
    {
        key: 'amount',
        width: 10
    },
    {
        key: 'balance',
        width: 15
    },
    {
        key: 'entryDate',
        width: 15
    },
    {
        key: 'lastDate',
        width: 15
    },
    {
        key: 'ccuDate',
        width: 10
    },
    {
        key: 'judgement',
        width: 10
    },
    {
        key: 'total',
        width: 20
    }
    ];
    const headerRow = reportType === 'xlsx' ? 6 : 1;
    worksheet.getRow(headerRow).values = [
        'Worker',
        'Over 21',
        offendernamestr,
        'CJAMS ID',
        'Account #',
        'Amount',
        'Balance',
        'Entry Date',
        'Last Pay',
        'CCU Date',
        'Judgement',
        'Total Amount - Worker'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle
    });
    for (const row of resp) {

        const under21JSON = row.under21;
        if (under21JSON) {
            under21JSON.forEach(youth => {
                worksheet.addRow({
                    worker: `${row.username}`,
                    over21: `No`,
                    offender: `${(youth.offendername)}`,
                    cjamsId: `${youth.assistid}`,
                    accountNo: `${youth.accountnumber}`,
                    amount: `${youth.amount}`,
                    balance: `${youth.balance}`,
                    entryDate: `${util.formatDate(youth.entrydate)}`,
                    lastDate: `${util.formatDate(youth.lastpay)}`,
                    ccuDate: `${util.formatDate(youth.ccudate)}`,
                    judgement: util.nullcheck(youth.judgement),
                    total: `${row.totalbalance}`
                });
            });
        }
        const over21JSON = row.over21;
        if (over21JSON) {
            over21JSON.forEach(youth => {
                worksheet.addRow({
                    worker: `${row.username}`,
                    over21: `Yes`,
                    offender: `${(youth.offendername)}`,
                    cjamsId: `${youth.assistid}`,
                    accountNo: `${youth.accountnumber}`,
                    amount: `${youth.amount}`,
                    balance: `${youth.balance}`,
                    entryDate: `${util.formatDate(youth.entrydate)}`,
                    lastDate: `${util.formatDate(youth.lastpay)}`,
                    ccuDate: `${util.formatDate(youth.ccudate)}`,
                    judgement: util.nullcheck(youth.judgement),
                    total: `${row.totalbalance}`
                });
            });
        }
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

module.exports.summaryReport = function (request, operation, res = null) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const sql = "select * from restitutionsummaryreport($1,$2)";
    return util.executeDBQuery(sql, [startdate, enddate])
    .then(data => {
        LOGGER.info(data);
        return data;
    })
        .then(resp => {
            return new Promise((resolve, reject) => {
                if (operation === 'list') {
                resolve({
                        totalcases: getTotalCount(resp).totalcases,
                        data: resp
                    });
                } else if (operation === 'generate') {
                    let Response;
                    const reportType = request.where.type;

                    if (reportType === 'pdf') {
                        let reqjson = {};
                        let reportGrid = '';

                        for (const row of resp) {
                            const restitutionJSON = row.details;
                            restitutionJSON.forEach(restitution => {
                                reportGrid +=
                                    `<tr style="background: #edeff2;">
                                    <td>${restitution.youthname}</td>
                                    <td>${restitution.youthid}</td>
                                    <td>${restitution.payaccount}</td>
                                    <td>${restitution.payamount}</td>
                                    <td>${restitution.balance}</td>
                                    <td>${util.formatDate(restitution.startdate)}</td>
                                    <td>${util.formatDate(restitution.paydate)}</td>
                                    <td>${util.formatDate(restitution.ccuapprovedate)}</td>
                                    <td>${util.formatDate(restitution.judgementdate)}</td>
                            </tr>`;
                            });
                        }
                        reqjson.summaryReport = reportGrid;
                        reqjson.cms = `${resp.cw_name}`;
                        reqjson.startdate = startdate;
                        reqjson.enddate = enddate;

                        reqjson = getSRData(reqjson, resp);
                        
                        reqjson.startdate = startdate;
                        reqjson.enddate = enddate;
                        const html = fs.readFileSync('./documenttemplates/reports/restitution/summary-report.html', 'utf8');
                        Response = pdf.generatepdf(request, html, reqjson, {
                            type: 'report',
                            res: res
                        });
                        resolve(Response);
                    } else {
                        summaryReportWorksheet(request, reportType, resp, res);
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

function getSRData(reqjson, resp) {
    reqjson.totalcases = resp.totalcases ?
        `<h5 class="text-center text-b brd-btm">
                    Grand Total Cases: ${resp.totalcases}
                </h5>` : "";
    reqjson.totalcases = resp.totalcases ?
        `<h5 class="text-center text-b brd-btm">
                    Grand Total Cases: ${resp.totalcases}
                </h5>` : "";
    reqjson.totalrestitutionamount = resp.totalrestitutionamount ?
        `<h5 class="text-center text-b brd-btm">
                    Grand Total Restitution Amount : ${resp.totalrestitutionamount}
                </h5>` : "";
    reqjson.totalbalance = resp.totalbalance ?
        `<h5 class="text-center text-b brd-btm">
                    Grand Total Balance : ${resp.totalbalance}
                </h5>` : "";
    return reqjson;
}

function summaryReportWorksheet(request, reportType, resp, res) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1','H1');
        worksheet.getCell('E1').value = `RESTITUTION SUMMARY REPORT`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
        worksheet.mergeCells('E2','H2');
        worksheet.getCell('E2').value = `For period from ${startdate} to ${enddate}`;
        worksheet.getCell('E2').font = subHeaderSize;
        worksheet.getCell('E2').alignment = centerAlign;
        worksheet.getCell('C3').value = `CMS`;
        worksheet.getCell('C3').font = subHeaderSize;
        worksheet.getCell('C3').alignment = centerAlign;
        worksheet.getCell('D4').value = `${resp.cw_name}`;
        worksheet.getCell('D4').font = subHeaderSize;
        worksheet.getCell('D4').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'offenderName',
        width: 10
    },
    {
        key: 'assistID',
        width: 10
    },
    {
        key: 'account',
        width: 10
    },
    {
        key: 'amount',
        width: 25
    },
    {
        key: 'balance',
        width: 20
    },
    {
        key: 'entrydate',
        width: 20
    },
    {
        key: 'lastpay',
        width: 20
    },
    {
        key: 'ccudate',
        width: 20
    },
    {
        key: 'judgementdate',
        width: 20
    }
    ];
    const headerRow = reportType === 'xlsx' ? 6 : 1;
    worksheet.getRow(headerRow).values = [
        offendernamestr,
        'Assist ID',
        'Account#',
        'Amount',
        'Balance',
        'Entry Date',
        'Last Pay',
        'CCU Date',
        'Judgement Date',
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    for (const row of resp) {
        const RestitutionJSON = row.details;
        RestitutionJSON.forEach(area => {
            worksheet.addRow({
                offenderName: `${area.youthname}`,
                assistID: `${area.youthid}`,
                account: `${area.payaccount}`,
                amount: `${area.payamount}`,
                balance: `${area.balance}`,
                entrydate: `${util.formatDate(area.startdate)}`,
                lastpay: `${util.formatDate(area.paydate)}`,
                ccudate: `${util.formatDate(area.ccuapprovedate)}`,
                judgementdate: `${util.formatDate(area.judgementdate)}`
            });
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

module.exports.caseClosingReport = function (request, operation, res = null) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const sql = "select * from restitutioncaseclosingreport($1,$2)";
    return util.executeDBQuery(sql, [startdate, enddate])
    .then(data => {
        return data;
    })
       .then(resp => {
            return new Promise((resolve, reject) => {
                if (operation === 'list') {
                    resolve({
                        data: resp
                    });
                } else if (operation === 'generate') {
                    let Response;
                    const reportType = request.where.type;
                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            const reqjson = {};
                        reqjson.summaryReport = CCRReportgrid(resp, null, false);
                            reqjson.area = checkEmpty(resp[0].accountarea);
                            reqjson.counselor = checkEmpty(resp[0].cw_name);

                            reqjson.startdate = startdate;
                            reqjson.enddate = enddate;
                            const html = fs.readFileSync('./documenttemplates/reports/restitution/case-closing-report.html', 'utf8');
                            Response = pdf.generatepdf(request, html, reqjson, {
                                type: 'report',
                                res: res
                            });
                            resolve(Response);
                        } else {
                            caseClosingReportWorksheet(request, reportType, resp, res);
                        }
                    }
                }
            })
        })
        .catch(err1 => {
            util.logError(err1);
            LOGGER.error(err1);
            return err1;
        });
};

function CCRReportgrid(resp, worksheet, isworksheet){
    let reportGrid = '';
    if(isworksheet && worksheet){
        for (const row of resp) {
            worksheet.addRow({
                offenderName: `${row.youthname}`,
                payaccount: `${row.payaccount}`,
                vendor: `${row.liableperson_name}`
            });
        }
    }else{
        for (const row of resp) {
            reportGrid +=
                `<tr>
                <td>${row.youthmname}</td>
                <td>${row.payaccount}</td>
                <td>${row.liableperson_name}</td>
            </tr>`;
        }
    }
    return reportGrid;
}

function caseClosingReportWorksheet(request, reportType, resp, res) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1','H1');
        worksheet.getCell('E1').value = `CASE CLOSING REPORT`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
        worksheet.mergeCells('E2','H2');
        worksheet.getCell('E2').value = `For period from ${startdate} to ${enddate}`;
        worksheet.getCell('E2').font = subHeaderSize;
        worksheet.getCell('E2').alignment = centerAlign;
        worksheet.mergeCells('K2','M2');
        worksheet.getCell('K2').value = `Account Area ${checkEmpty(resp[0].accountarea)}`;
        worksheet.getCell('K2').font = subHeaderSize;
        worksheet.getCell('K2').alignment = centerAlign;
        worksheet.mergeCells('E3','H3');
        worksheet.getCell('E3').value = `Generated At ${startdate}`;
        worksheet.getCell('E3').font = subHeaderSize;
        worksheet.getCell('E3').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'offenderName',
        width: 10
    },
    {
        key: 'payaccount',
        width: 10
    },
    {
        key: 'vendor',
        width: 10
    }
    ];
    const headerRow = reportType === 'xlsx' ? 4 : 1;
    worksheet.getRow(headerRow).values = [
        offendernamestr,
        'Acc#',
        'Vendor'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    CCRReportgrid(resp, worksheet, true);
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

module.exports.paymentMatchesReport = function (request,operation,res = null) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;

    const sql = "select * from paymentmatchesreport($1,$2)";
    return util.executeDBQuery(sql,[startdate,enddate])
        .then(data => {
            return data;
        })
        .then(resp => {
            return new Promise((resolve,reject) => {
                if (operation === 'list') {
                    resolve({
                        data: resp
                    });
                } else if (operation === 'generate') {
                    let Response;
                    const reportType = request.where.type;
                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            const reqjson = {};
                            reqjson.paymentMatches = PMRReportgrid(resp,null,false);
                            reqjson.accountarea = checkEmpty(resp[0].accountarea);
                            reqjson.generatedat = "";
                            reqjson.totalnoofrecords = resp.length;

                            reqjson.startdate = startdate;
                            reqjson.enddate = enddate;
                            const html = fs.readFileSync('./documenttemplates/reports/restitution/payment-matches-report.html','utf8');
                            Response = pdf.generatepdf(request,html,reqjson,{
                                type: 'report',
                                res: res
                            });
                            resolve(Response);
                        } else {
                            paymentMatchesReportWorksheet(request,reportType,resp,res);
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

function PMRReportgrid(resp, worksheet, isworksheet){
    let reportGrid = '';
    if(isworksheet && worksheet){
        for (const row of resp) {
            worksheet.addRow({
                paymentNumber: `${row.payno}`,
                accountNumber: `${row.accountno}`,
                paymentDate: `${row.paydate}`,
                allocation: `${row.allocatedamount}`,
                amountOfPayment: `${row.payamount}`,
                vendorNumber: `${row.vendor_id}`,
                balance: `${row.balance}`,
                offender: `${row.youthname}`,
                counselor: `${row.cw_name}`
            });
        }
    }else{
        for (const row of resp) {
            reportGrid +=
                `<tr>
                <td>${row.payno}</td>
                <td>${row.accountno}</td>
                <td>${row.paydate}</td>
                <td>${row.allocatedamount}</td>
                <td>${row.payamount}</td>
                <td>${row.vendor_id}</td>
                <td>${row.balance}</td>
                <td>${row.youthname}</td>
                <td>${row.cw_name}</td>
            </tr>`;
        }
    }
    return reportGrid;
}

function paymentMatchesReportWorksheet(request, reportType, resp, res) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1','H1');
        worksheet.getCell('E1').value = `Payment Matches REPORT`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
        worksheet.mergeCells('E2','H2');
        worksheet.getCell('E2').value = `For period from ${startdate} to ${enddate}`;
        worksheet.getCell('E2').font = subHeaderSize;
        worksheet.getCell('E2').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'paymentNumber',
        width: 10
    },
    {
        key: 'accountNumber',
        width: 10
    },
    {
        key: 'paymentDate',
        width: 10
    },
    {
        key: 'allocation',
        width: 10
    },
    {
        key: 'amountOfPayment',
        width: 10
    },
    {
        key: 'vendorNumber',
        width: 10
    },
    {
        key: 'balance',
        width: 10
    },
    {
        key: 'offender',
        width: 10
    },
    {
        key: 'counselor',
        width: 10
    }

    ];
    const headerRow = reportType === 'xlsx' ? 4 : 1;
    worksheet.getRow(headerRow).values = [
        'Payment Number',
        'Account Number',
        'Payment Date',
        'Allocation',
        'Amount Of Payment',
        'Vendor Number',
        'Balance',
        'Offender',
        'Counselor',
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });    
    PMRReportgrid(resp, worksheet, true);
    
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

module.exports.openCaseSummaryReport = function (request,operation,res = null) {
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const areacode = request.where.areacode;

    const sql = "select * from opencasesummaryreport($1,$2,$3)";
    return util.executeDBQuery(sql,[startdate,enddate,areacode])
        .then(data => {
            return data;
        })
        .then(resp => {
            return new Promise((resolve,reject) => {
                if (operation === 'list') {
                    resolve({
                        data: resp
                    });
                } else if (operation === 'generate') {
                    let Response;
                    const reportType = request.where.type;
                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            const reqjson = {};
                            reqjson.accountarea = checkEmpty(resp[0].account_area);
                            reqjson.generatedat = checkEmpty(resp[0].todaydate);
                            reqjson.totalnumberofopencases = checkEmpty(resp[0].opencases);
                            reqjson.totalbalance = checkEmpty(resp[0].balamount);

                            reqjson.startdate = startdate;
                            reqjson.enddate = enddate;
                            const html = fs.readFileSync('./documenttemplates/reports/restitution/open-case-summary-report.html','utf8');
                            Response = pdf.generatepdf(request,html,reqjson,{
                                type: 'report',
                                res: res
                            });
                            resolve(Response);
                        } else {
                            openCaseSummaryReportWorksheet(request,reportType,resp,res);
                        }
                    }
                }
            })
        })
        .catch(err2 => {
            util.logError(err2);
            LOGGER.error(err2);
            return err2;
        });
}

function openCaseSummaryReportWorksheet(request, reportType, resp, res){
    const startdate = request.where.startdate;
    const enddate = request.where.enddate;
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1', 'I1');
        worksheet.getCell('E1').value = `OPEN CASE SUMMARY REPORT`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
        worksheet.mergeCells('C2', 'E2');
        worksheet.getCell('C2').value = `For period from ${startdate} to ${enddate}`;
        worksheet.getCell('C2').alignment = centerAlign;
        worksheet.mergeCells('H2', 'J2');
        worksheet.getCell('H2').value = `Account Area ${resp[0].account_area}`;
        worksheet.getCell('H2').alignment = centerAlign;
        worksheet.mergeCells('F2', 'G2');
        worksheet.getCell('F2').value = `Generated At ${resp[0].todaydate}`;
        worksheet.getCell('F2').alignment = centerAlign;
        worksheet.mergeCells('B4', 'E4');
        worksheet.getCell('B4').value = `TOTAL  NUMBER  OF  OPEN  CASES: `;
        worksheet.getCell('B4').alignment = centerAlign;
        worksheet.getCell('F4').value = `${resp[0].opencases}`;
        worksheet.getCell('F4').alignment = centerAlign;
        worksheet.mergeCells('B5', 'E5');
        worksheet.getCell('B5').value = `TOTAL  BALANCE:$ `;
        worksheet.getCell('F5').alignment = centerAlign;
        worksheet.getCell('F5').value = `${resp[0].balamount}`;
        worksheet.getCell('F5').alignment = centerAlign;
    }

    var fileName = `${request.where.outputfilename}.${request.where.type}`;

    res.setHeader(contenttypestr, spreadsheetcontenttype);
    res.setHeader(contentdispositionstr, attachmentstr + fileName);
    if (reportType === 'xlsx') {
        workbook.xlsx.write(res)
            .then(() => res.end());
    } else if (reportType === 'csv') {
        workbook.csv.write(res)
            .then(() => res.end());
    }
}

module.exports.workerPopulationSheetReport = function (request,operation,res = null) {
    const roleid = request.where.roleid;
    const pid = request.where.pid;
    const location = request.where.location;
    const pageoffset = request.pageoffset;
    const pagesize = request.pagesize;
    const sql = "select * from getworkerpopulationreport($1,$2,$3,$4,$5,$6)";
    return util.executeDBQuery(sql,[roleid,pid,location,pageoffset,pagesize,request.limit])
        .then(data => {
            return data;
        })
        .then(resp => {
            return new Promise((resolve,reject) => {
                if (operation === 'list') {
                    resolve({
                        data: resp
                    });
                } else if (operation === 'generate') {
                    let Response;
                    const reportType = request.where.type;

                    if (resp.length > 0) {
                        if (reportType === 'pdf') {
                            const reqjson = {};
                            reqjson.workerpopulationreport = getWPSRReportGrid(resp);
                            reqjson.workerclienttotal = "";

                            const html = fs.readFileSync('./documenttemplates/reports/restitution/worker-population-sheet-report.html','utf8');
                            Response = pdf.generatepdf(request,html,reqjson,{
                                type: 'report',
                                res: res
                            });
                            resolve(Response);
                        } else {
                            getWPSRWorksheet(request,reportType,resp,res);
                        }
                    }
                }
            })
        })
        .catch(err5 => {
            util.logError(err5);
            LOGGER.error(err5);
            return err5;
        });
};

function getWPSRWorksheet(request, reportType, resp, res) {
    const workbook = new Excel.Workbook();
    const worksheet = workbook.addWorksheet(request.where.outputfilename);
    if (reportType === 'xlsx') {
        worksheet.mergeCells('E1','H1');
        worksheet.getCell('E1').value = `Individual Worker Population Sheet`;
        worksheet.getCell('E1').font = titleSize;
        worksheet.getCell('E1').alignment = centerAlign;
    }
    worksheet.columns = [{
        key: 'youthname',
        width: 10
    },
    {
        key: 'pid',
        width: 10
    },
    {
        key: 'em',
        width: 10
    },
    {
        key: 'lvl',
        width: 10
    },
    {
        key: 'dob',
        width: 10
    },
    {
        key: 'los',
        width: 10
    },
    {
        key: 'admitdate',
        width: 10
    },
    {
        key: 'jurisdiction ',
        width: 10
    },
    {
        key: 'region',
        width: 10
    },

    {
        key: 'paroleofficer',
        width: 10
    },
    {
        key: 'courtdate',
        width: 10
    },
    {
        key: 'hearingtype',
        width: 10
    },
    {
        key: 'charges',
        width: 10
    },
    {
        key: 'parent',
        width: 10
    },
    {
        key: 'w',
        width: 10
    },
    {
        key: 's',
        width: 10
    },
    {
        key: 'youthaddress',
        width: 10
    },
    {
        key: 'parentaddress',
        width: 10
    }
    ];                              
    const headerRow = reportType === 'xlsx' ? 4 : 1;
    worksheet.getRow(headerRow).values = [
        'Youth Name',
        'PID',
        'EM',
        'Community Detection Level',
        'D:O:B',
        'Length Of Stay',
        'Admit Date',
        'Jurisdiction',
        'Region',
        'Parole Officer',
        'Court Date',
        'Hearing Type',
        'Charges',
        'Parent',
        'W',
        'School Name',
        'Youth Address',
        'Parent Address'
    ];
    worksheet.getRow(headerRow).eachCell(cell => {
        cell.fill = headerStyle;
    });
    for (const row of resp) {
        worksheet.addRow({
            youthname: util.nullcheck(row.youthsname),
            pid: util.nullcheck(row.youthspid),
            em: ``,
            lvl: util.nullcheck(row.communitydetentionlevel),
            dob: util.formatDate(row.dob),
            los: util.nullcheck(row.los),
            admitdate: util.formatDate(row.admissiondate),
            jurisdiction: util.nullcheck(row.jurisdiction),
            region: util.nullcheck(row.region),
            paroleofficer: util.nullcheck(row.paroleofficername),
            courtdate: ``,
            hearingtype: util.nullcheck(row.hearingtype),
            charges: util.nullcheck(row.charges),
            parent: util.nullcheck(row.parentname),
            w: ``,
            s: util.nullcheck(row.schoolname),
            youthaddress: util.nullcheck(row.homeaddress),
            parentaddress: util.nullcheck(row.parentguardiancontactnumber),
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

function getWPSRReportGrid(resp) {
    let reportGrid = '';
    for (const row of resp) {

        reportGrid += row.memofield ? `<div class="col-xs-12"><h4>Memo</h4> <span>${row.memofield}</span></div>` : `<div class="col-xs-12"><label>Memo <span></span></div>`;
        reportGrid += `<div class="row">`;
        reportGrid += row.youthsname ? `<div class="col-xs-4"><label>Youth Name</label> <span>${row.youthsname} </span></div> ` : `<div class="col-xs-4"><label>Youth Name <span></span></div>`;
        reportGrid += row.youthspid ? `<div class="col-xs-2"><label> PID <span>${row.youthspid} </span></div>` : `<div class="col-xs-2"><label>PID <span></span></div>`;
        reportGrid += `<div class="col-xs-2"><label> EM<span </label></span></div>`;
        reportGrid += row.communitydetentionlevel ? `<div class="col-xs-2"><label> lvl </label><span>${row.communitydetentionlevel}</span></div>` : `<div class="col-xs-2"><label>D:O:B</label> <span></span></div>`;
        reportGrid += row.dob ? `<div class="col-xs-2"><label> D:O:B </label><span>${util.formatDate(row.dob)}</span></div>` : `<div class="col-xs-2"><label>D:O:B </label><span></span></div>`;
        reportGrid += row.los ? `<div class="col-xs-2"><label> LOS</label><span>${row.los}</span></div>` : `<div class="col-xs-2"><label>LOS</label><span></span></div>`;
        reportGrid += `</div>`;
        reportGrid += `<div class="row">`;
        reportGrid += row.admissiondate ? `<div class="col-xs-3"><label> Admit Date </label><span>${util.formatDate(row.admissiondate)}</span></div>` : `<div class="col-xs-3"><label>Admit Date </label><span></span></div>`;
        reportGrid += getWPSRReportGrid2(row);
    }
    return reportGrid;
}

function getWPSRReportGrid2(row){
    let reportGrid = '';
    reportGrid += row.jurisdiction ? `<div class="col-xs-3"><label> J:</label> <span> ${row.jurisdiction} </span></div>` : `<div class="col-xs-3"><label>J: </label><span></span></div>`;
        reportGrid += row.region ? `<div class="col-xs-3"><label> R:</label><span>${row.region}  </span></div>` : `<div class="col-xs-3"><label>R:</label><span></span></div>`;
        reportGrid += row.paroleofficername ? `<div class="col-xs-3"><label> PO:</label><span> ${row.paroleofficername} </span></div>` : `<div class="col-xs-3"><label>PO:</label><span></span></div>`;
        reportGrid += `</div>`;
        reportGrid += `<div class="row">`;
        reportGrid += `<div class="col-xs-3"><label>Court Date </label><span></span></div>`;
        reportGrid += row.hearingtype ? `<div class="col-xs-2"><label>Hearing Type</label><span>${row.hearingtype}</span></div>` : `<div class="col-xs-2"><label>Hearing Type</label><span></span></div>`;
        reportGrid += row.charges ? `<div class="col-xs-2"><label>Charges:</label><span>${row.charges} </span></div>` : `<div class="col-xs-2"><label>Charges:</label><span></span></div>`;
        reportGrid += row.parentname ? `<div class="col-xs-2"><label>Parent:</label><span>${row.parentname} </span></div>` : `<div class="col-xs-2"><label>Parent:</label><span></span></div>`;
        reportGrid += `<div class="col-xs-2"><label>W:</label><span></span></div>`;
        reportGrid += `</div>`;
        reportGrid += `<div class="row">`;
        reportGrid += row.homeaddress ? `<div class="col-xs-2"><label>Home Address:</label><span>${row.homeaddress}</span></div>` : `<div class="col-xs-2"><label>Home Address:</label><span></span></div>`;
        reportGrid += row.schoolname ? `<div class="col-xs-2"><label>S:</label><span>${row.schoolname}</span></div>` : `<div class="col-xs-2"><label>S:</label><span></span></div>`;
        reportGrid += row.youthcontactnumber ? `<div class="col-xs-2"><label>Youth Contact:</label><span>${row.youthcontactnumber}</span></div>` : `<div class="col-xs-2"><label>Youth Contact:</label><span></span></div>`;
        reportGrid += row.parentguardiancontactnumber ? `<div class="col-xs-2"><label>Parent Contact:</label><span>${row.parentguardiancontactnumber}</span></div>` : `<div class="col-xs-2"><label>Parent Contact:</label><span></span></div>`;
        reportGrid += `</div>`;
        return reportGrid;
}
