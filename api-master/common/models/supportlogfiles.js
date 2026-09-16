'use strict';
const LOGGER = require("log4js").getLogger("supportlogfiles");
const util = require('../utils/utils');
const _ = require('lodash');
const fs = require('fs');
const tmp = require('tmp');
const archiver = require('archiver');
const moment = require('moment');
const Excel = require('exceljs');
const app = require('../../server/server');

const contenttypestr = 'Content-Type';

const mimeTypes = {
    "image/bmp": ".bmp",
    "text/css": ".css",
    "text/csv": ".csv",
    "application/msword": ".doc",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document": ".docx",
    "image/gif": ".gif",
    "text/html": ".html",
    "image/jpeg": ".jpeg",
    "application/vnd.oasis.opendocument.presentation": ".odp",
    "application/vnd.oasis.opendocument.spreadsheet": ".ods",
    "application/vnd.oasis.opendocument.text": ".odt",
    "image/png": ".png",
    "application/pdf": ".pdf",
    "application/vnd.ms-powerpoint": ".ppt",
    "application/vnd.openxmlformats-officedocument.presentationml.presentation": ".pptx",
    "application/rtf": ".rtf",
    "text/plain": ".txt",
    "application/vnd.ms-excel": ".xls",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet": ".xlsx",
    "application/zip": ".zip",
}

module.exports = function (Supportlogfiles) {

    function base64MimeType(encoded) {
        var result = null;
        if (typeof encoded !== 'string') {
            return result;
        }
        var mime = encoded.match(/data:([a-zA-Z0-9]+\/[a-zA-Z0-9-.+]+).*,.*/);
        if (mime && mime.length) {
            result = mime[1];
        }
        return result;
    }

    function zipDirectory(source, out) {
        const archive = archiver('zip', {
            zlib: {
                level: 9
            }
        });
        const stream = fs.createWriteStream(out);

        return new Promise((resolve, reject) => {
            archive
                .directory(source, false)
                .on('error', err => reject(err))
                .pipe(stream);

            stream.on('close', () => resolve());
            archive.finalize();
        });
    }

    Supportlogfiles.download = (id, res) => {

        return Supportlogfiles.find({
            where: {
                supportlogfilesid: id
            },
            fields: {
                filedata: true
            }
        }).then(data => {
            if (data && data.length > 0) {

                // File data from database
                const filedata = data[0].filedata;

                // Convert hex to buffer
                const base64 = Buffer.from(filedata, 'hex').toString();

                const base64File = base64.split(",")[1];// Get base64 file
                const mimetype = base64MimeType(base64); // mimetype
                const buff = new Buffer(base64File, 'base64'); // File buffer
                const ext = _.get(mimeTypes, mimetype); // File extension

                var datetime = new Date();
                res.set('Expires', 'Tue, 03 Jul 2001 06:00:00 GMT');
                res.set('Cache-Control', 'max-age=0, no-cache, must-revalidate, proxy-revalidate');
                res.set('Last-Modified', datetime + 'GMT');
                res.set(contenttypestr, mimetype);
                res.set('Content-Disposition', `attachment;filename=${id}${ext}`);
                res.set('Content-Transfer-Encoding', 'string');
                res.send(buff);
            }
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });

    }

    Supportlogfiles.remoteMethod('download', {
        accepts: [{
                arg: 'id',
                type: 'string',
                required: true
            },
            {
                arg: 'res',
                type: 'object',
                'http': {
                    source: 'res'
                }
            }
        ],
        http: {
            verb: "get",
            path: "/download"
        },
        return: {
            arg: 'body',
            type: 'file',
            root: true
        }
    });

    Supportlogfiles.downloadall = (filter, res) => {

        const Supportlog = app.models.Supportlog;
        return Supportlog.find({
            where: filter.where,
            fields: {
                "frommailid": true,
                "notes": true,
                "effectivedate": true,
                "clientid": true,
                "subject": true,
                "supportno": true,
                "caseid": true,
                "jirarequestsent": true,
                "supportlogid": true,
                "severity": true,
                "issuetype": true,
            },
            nolimit:true
        }).then(data => {
            if (data && data.length > 0) {
                tmp.dir((err1, dirPath) => {

                    // Create Excel Sheet
                    const workbook = new Excel.Workbook();
                    const worksheet = workbook.addWorksheet('Defects');
                    const mapData = {};
                    worksheet.columns = [
                        { header: 'frommailid', key: 'frommailid', width: 20},
                        { header: 'effectivedate', key: 'effectivedate', width: 15},
                        { header: 'clientid', key: 'clientid', width: 15},
                        { header: 'severity', key: 'severity', width: 15},
                        { header: 'issuetype', key: 'issuetype', width: 15},
                        { header: 'supportno', key: 'supportno', width: 15},
                        { header: 'caseid', key: 'caseid', width: 15},
                        { header: 'supportlogid', key: 'supportlogid', width: 36},
                        { header: 'subject', key: 'subject', width: 40},
                        { header: 'notes', key: 'notes', width: 80},
                    ];
                    data.forEach(row => {
                        mapData[row.supportlogid] = row.supportno;
                        const issuetypes = {
                            'E': 'Enhancement',
                            'B': 'Bug/Issue/Defect',
                            'Q': 'Question/Policy',
                            'G': 'Gap/Missing from Legacy System'
                        }
                        row.issuetype = issuetypes[row.issuetype];
                    worksheet.addRow(row);
                    });
                    workbook.xlsx.writeFile(`${dirPath}/defects.xlsx`).then(()=>{
                        // Look for attachments
                        Supportlogfiles.find({
                            where: filter.where,
                            fields: {
                                filedata: true,
                                supportlogfilesid: true,
                                supportlogid: true,
                                supportno: true
                            },
                            nolimit:true
                        }, (err2, data1) => {
                            if (data1 && data1.length > 0) {

                                // loop through each blob and write file to disk
                                data1.forEach(element => {
                                    const filedata = element.filedata;
                                    const filename = `${mapData[element.supportlogid]}-${element.supportlogfilesid}`;
                                    const base64 = new Buffer(filedata, 'hex').toString(); // Convert hex to buffer
                                    const base64File = base64.split(",")[1]; // Get base64 file
                                    const mimetype = base64MimeType(base64); // mimetype
                                    const buff = new Buffer(base64File, 'base64'); // File buffer
                                    const ext = _.get(mimeTypes, mimetype); // File extension
                                    fs.writeFileSync(`${dirPath}/${filename}${ext}`, buff);
                                });
                                zipDownload(dirPath, res);

                            }
                        });
                    });
                });
            }
        }).catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    function zipDownload(dirPath, res){
        // Zip all files and force download
        tmp.dir((err, zipFilePath) => {
            if (err) {throw err;}
            const downloadFilename = `download_${moment().format('YYYY-MM-DD')}.zip`;
            const filePath = `${zipFilePath}/${downloadFilename}`;
            zipDirectory(dirPath, filePath).then(() => {
                const filestream = fs.readFileSync(filePath);
                const datetime = new Date();
                res.set('Expires', 'Tue, 03 Jul 2001 06:00:00 GMT');
                res.set('Cache-Control', 'max-age=0, no-cache, must-revalidate, proxy-revalidate');
                res.set('Last-Modified', datetime + 'GMT');
                res.set(contenttypestr, 'application/zip');
                res.set('Content-Disposition', `attachment;filename=${downloadFilename}`);
                res.set('Content-Transfer-Encoding', 'string');
                res.send(filestream);
            }).catch((zipErr) => {
                LOGGER.error('>>>>ERROR:', zipErr);
                throw zipErr;
            });
        });
    }

    Supportlogfiles.remoteMethod('downloadall', {
        accepts: [{
            arg: 'filter',
            type: 'object',
            required: true
        },
        {
            arg: 'res',
            type: 'object',
            'http': {
                source: 'res'
            }
        }],
        http: {
            path: '/downloadall',
            verb: 'get'
        },
        return: {
            arg: 'body',
            type: 'file',
            root: true
        }
    });

    Supportlogfiles.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Supportlogfiles.observe('access', (ctx, next) => util.access(ctx, next));
    Supportlogfiles.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

};