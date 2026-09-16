'use strict';
const LOGGER = require("log4js").getLogger("getdocumentsearchdtls");
var server = require('../../server/server');
var loopback = require('loopback');
var boot = require('loopback-boot');
const util = require('../utils/utils');

module.exports = function(Getdocumentsearchdtls) {

    Getdocumentsearchdtls.getdocumentsearch = function(data) {
        var Totalcount = 0;
        var showCount = false;
         const userid = server.currentUser.id;
        if (data.page === 1) {
            showCount = true;
        }/*  else {                 //SonarQube fix - commented as showCount is already set to false at line no.12
            showCount = false
        }; */
        var newJsonStructure = data.where;
        newJsonStructure["pagenumber"] = data.page;
        newJsonStructure["pagesize"] = data.limit;
        newJsonStructure["userid"] = userid;

        if (newJsonStructure.doctype != null) {
            for (let i = 0; i < newJsonStructure.doctype.length; i++) {
                newJsonStructure["doctype_" + (i + 1)] = newJsonStructure.doctype[i];
            }

            delete newJsonStructure.doctype;
        }
        if (newJsonStructure.assigned != null) {
            for (let i = 0; i < newJsonStructure.assigned.length; i++) {
                newJsonStructure["assigned_" + (i + 1)] = newJsonStructure.assigned[i];
            }
            delete newJsonStructure.assigned;
        }

        const newJsonStructureData = JSON.stringify(newJsonStructure);
        if (showCount) {
            var countQuery = 'select * from documentsearch_cnt($1)';
            return util.executeDBQuery(countQuery,[newJsonStructureData])
            .then(data1 => {
                Totalcount = data1[0].documentsearch_cnt;
                if (Totalcount > 0) {
                    var sql = 'select * from documentsearch($1)';
                    return util.executeDBQuery(sql,[newJsonStructureData])
                    .then(_data => {
                        var result;
                        result = {
                            'data': _data,
                            'count': Totalcount
                        };
                        return result;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        throw err;
                    })
                } else {
                    var result1;
                    result1 = {
                        'data': [],
                        'count': Totalcount
                    };
                    return result1;
                }
            })
            .catch(err => {
                LOGGER.error(err);
                throw err;
            })
        } else {
            var sql1 = 'select * from documentsearch($1)';
            return util.executeDBQuery(sql1,[newJsonStructureData])
            .then(_data => {
                var result2;
                result2 = {
                    'data': _data,
                    'count': _data.length
                };
                return result2;
            })
            .catch(err => {
                LOGGER.error(err);
                throw err;
            })
        }


    }
    Getdocumentsearchdtls.remoteMethod(
        'getdocumentsearch', {
            http: {
                path: '/getdocumentsearch',
                verb: 'post'
            },
            accepts: [{
                arg: 'data',
                type: 'object',
                http: {
                    source: 'body'
                }
            }],
            returns: {
                type: 'object',
                root: true
            }
        }
    );

    Getdocumentsearchdtls.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Getdocumentsearchdtls.observe('access', (ctx, next) => util.access(ctx, next));
    Getdocumentsearchdtls.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};
