'use strict';
const LOGGER = require("log4js").getLogger("releasenotes");

const util = require('../utils/utils');

// Application identifier for this API module. Pass null to return all applications.
const APPLICATION = 'CW';

// Log the error to the DB audit table, then re-throw a clean serializable Error so LoopBack
// can return a proper HTTP 500 without hitting JSON.stringify circular reference issues.
function logAndThrow(err) {
    const clean = new Error(err && err.message ? err.message : String(err));
    clean.statusCode = 500;
    if (err && err.code)     clean.code     = err.code;
    if (err && err.severity) clean.severity = err.severity;
    if (err && err.hint)     clean.detail   = err.hint;
    return util.logError(err).then(() => { throw clean; });
}

// Extracts the security user id from the request context header.
function getSecurityUserId(request, reqctx) {
    const suserid = reqctx?.req?.headers?.securityusersid ?? undefined;
    return (request && request.securityuserid) ? request.securityuserid : suserid;
}

function buildPagedParams(searchTerm, pReleaseVersion, pStartDate, pEndDate, limitNumber, calculatedOffset, sortcolumn, sortorder, itemtypeParam) { // NOSONAR - arity is fixed by the remoteMethod accepts[] below
    return [
        searchTerm || null, // $1
        pReleaseVersion || null, // $2
        pStartDate || null, // $3
        pEndDate || null, // $4
        limitNumber, // $5: p_limit
        calculatedOffset, // $6: p_offset
        sortcolumn || null, // $7: p_sort_column
        sortorder || 'desc', // $8: p_sort_order
        APPLICATION, // $9: p_application
        itemtypeParam
    ];
}

function buildCountParams(searchTerm, pReleaseVersion, pStartDate, pEndDate) {
    // Count query fetches all matching rows (no limit/offset) for accurate type totals.
    // itemtype is NOT passed here so both story and defect counts are always returned.
    return [
        searchTerm || null,
        pReleaseVersion || null,
        pStartDate || null,
        pEndDate || null,
        null, // p_limit NULL = no limit
        0, // p_offset
        null,
        'desc',
        APPLICATION, // p_application
        null
    ];
}

function getPaginationParams(limit, page, itemtype) {
    const limitNumber = limit || 10;
    const calculatedOffset = ((page || 1) - 1) * limitNumber;
    const itemtypeParam = (itemtype === 'Story' || itemtype === 'Defect') ? itemtype : null;
    return { limitNumber, calculatedOffset, itemtypeParam };
}

function returnTotalcountFn(results) {
    return results.length > 0 && results[0].totalcount ? Number(results[0].totalcount) : 0;
}

function orEmpty(value) { return value || ''; }
function orNull(value) { return value || null; }
function toCount(value) { return value ? Number(value) : 0; } // bigint arrives as string or number depending on driver
function toBool(value) { return typeof value === 'boolean' ? value : false; }

module.exports = (Releasenotes) => {
    Releasenotes.getreleaseversions = function (request, reqctx) {
        const securityusersid = getSecurityUserId(request, reqctx);
        let startdate      = request.where.startdate    || null;
        let   enddate        = request.where.enddate      || null;
        const releaseversion = request.where.releaseversion || null;

        // When only one bound is given, default the missing bound so the DB range
        // predicate doesn't discard all rows due to a NULL value.
        if (startdate && !enddate) {
            enddate = new Date().toISOString().slice(0, 10);
        } else if (enddate && !startdate) {
            startdate = '1900-01-01';
        }
        const sortcolumn    = request.where.sortcolumn   || null;
        const sortorder     = request.where.sortorder    || 'desc';
        const page          = request.page  || 1;
        const limit         = request.limit || 10;
        const application   = 'CW';

        const sql = 'select * from getreleaseversions($1,$2,$3,$4,$5,$6,$7,$8,$9)';
        const params = [startdate, enddate, releaseversion, securityusersid, sortcolumn, sortorder, page, limit, application];

        return util.executeSecondaryNodeDBQuery(sql, params).catch(err => { LOGGER.error(err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('getreleaseversions', {
        http: { path: '/getreleaseversions', verb: 'post' },
        accepts: [
            { arg: 'data',   type: 'Object', http: { source: 'body' } },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        returns: { arg: 'data', type: 'Object' }
    });

    Releasenotes.remoteMethod('getreleasedata', {
        http: { path: '/getreleasedata', verb: 'post' },
        accepts: [
            { arg: 'data', type: 'Object', http: { source: 'body' } }
        ],
        returns: { arg: 'data', type: 'Object' }
    });

    Releasenotes.getreleasedata = function (request) {
        const input = request && request.where ? request.where : {};
        input.nolimit = false;
        input.application = 'CW';
        return util.executeSecondaryNodeDBQuery('select * from getreleasedata($1)', [input])
            .catch(err => { LOGGER.error(err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('publishupdate', {
        http: { path: '/publishupdate', verb: 'post' },
        accepts: [
            { arg: 'data', type: 'object', http: { source: 'body' } }
        ],
        returns: { type: 'object', root: true }
    });

    Releasenotes.publishupdate = function (request) {
        const sql = 'UPDATE defecttracking.releasenotes SET publish = true WHERE releaseversionno =$1 and releasedate = $2::date and activeflag = 1 ';
        return util.executeDBQuery(sql, [request.where.releaseversionno, request.where.releasedate])
            .catch(err => { LOGGER.error(err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('ticketdetailsedit', {
        http: { path: '/ticketdetailsedit', verb: 'post' },
        accepts: [
            { arg: 'data',   type: 'object', http: { source: 'body' } },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        returns: { type: 'object', root: true }
    });

    Releasenotes.ticketdetailsedit = function (request, reqctx) {
        const updatedby = getSecurityUserId(request, reqctx);
        const { itemid, title, description, releasenotesid, supportno, documentlink } = request.where;
        const sql = 'UPDATE defecttracking.releasenotes set itemid=$1, description=$3, title=$2, supportid=$5, documentlink=$6, updatedby=$7, updatedon=now() where releasenotesid=$4';
        return util.executeDBQuery(sql, [itemid, title, description, releasenotesid, supportno, documentlink, updatedby])
            .catch(err => { LOGGER.error(err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('releasenotesaccesscheck', {
        http: { path: '/releasenotesaccesscheck', verb: 'get' },
        accepts: [
            { arg: 'securityusersid', type: 'String', required: false, http: { source: 'query' } },
            { arg: 'reqctx',          type: 'object',                  http: { source: 'context' } }
        ],
        returns: { type: 'Object', root: true }
    });

    Releasenotes.releasenotesaccesscheck = (request, reqctx) => {
        const securityuserid = request ?? reqctx?.req?.headers?.securityusersid ?? undefined;
        return util.executeSecondaryNodeDBQuery('select * from releasenotesaccesscheck($1)', [securityuserid])
            .catch(err => { LOGGER.error(err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('deletereleasenotes', {
        http: { path: '/deletereleasenotes', verb: 'post' },
        accepts: [
            { arg: 'data',   type: 'object', http: { source: 'body' } },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        returns: { type: 'object', root: true }
    });

    Releasenotes.deletereleasenotes = function (request, reqctx) {
        const updatedby = getSecurityUserId(request, reqctx);
        const { releaseversionno, releasedate } = request.where;
        const sql = 'UPDATE defecttracking.releasenotes SET activeflag=0, updatedby=$3, updatedon=now() WHERE releaseversionno=$1 and releasedate=$2::date and activeflag=1 ';
        return util.executeDBQuery(sql, [releaseversionno, releasedate, updatedby])
            .catch(err => { LOGGER.error(err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('savereleasenotes', {
        http: { path: '/savereleasenotes', verb: 'post' },
        accepts: [
            { arg: 'data',   type: 'object', http: { source: 'body' } },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        returns: { type: 'object', root: true }
    });

    Releasenotes.savereleasenotes = function (request, reqctx) {
        const securityusersid = getSecurityUserId(request, reqctx);
        const itemlist = request.itemlist ? JSON.stringify(request.itemlist) : null;
        return util.executeDBQuery('select * from savereleasenotes($1, $2)', [itemlist, securityusersid])
            .then(function(data) {
                if (!data || data.length === 0) {
                    const emptyErr = new Error('savereleasenotes returned no rows');
                    LOGGER.error('savereleasenotes - DB returned empty result set', emptyErr);
                    throw emptyErr;
                }
                return data[0].savereleasenotes;
            })
            .catch(err => { LOGGER.error('savereleasenotes - error', err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('getlatestreleaseinfo', {
        http: { path: '/getlatestreleaseinfo', verb: 'get' },
        accepts: [
            { arg: 'filter', type: 'Object', required: false, http: { source: 'query' } },
            { arg: 'reqctx', type: 'object',                  http: { source: 'context' } }
        ],
        returns: { type: 'Object', root: true }
    });

    Releasenotes.getlatestreleaseinfo = (request, reqctx) => {
        const securityusersid = getSecurityUserId(request, reqctx);
        return util.executeSecondaryNodeDBQuery('select * from getlatestreleaseinfo($1, $2)', [securityusersid, 'CW'])
            .then(function(data) {
                if (!data || data.length === 0) return [];
                if (!securityusersid) data[0].releaseflag = false;
                return data;
            })
            .catch(err => { LOGGER.error(err); return logAndThrow(err); });
    };

    /**
     * Fuzzy search release notes with optional version and date filtering
     */
    Releasenotes.fuzzySearch = function(searchTerm, pReleaseVersion, pStartDate, pEndDate, page, limit, sortcolumn, sortorder, fulldata, itemtype) { // NOSONAR
        const sql = 'SELECT * FROM defecttracking.fuzzysearchreleasenotes($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)';
        const { limitNumber, calculatedOffset, itemtypeParam } = getPaginationParams(limit, page, itemtype);

        const pagedParams = buildPagedParams(searchTerm, pReleaseVersion, pStartDate, pEndDate, limitNumber, calculatedOffset, sortcolumn, sortorder, itemtypeParam);
        const countParams = buildCountParams(searchTerm, pReleaseVersion, pStartDate, pEndDate);

        if (fulldata === false) {
            return util.executeSecondaryNodeDBQuery(sql, pagedParams)
                .then(function(results) {
                    const totalcount = returnTotalcountFn(results);
                    return { rows: formatForReleaseVersion(results), totalcount, totalstorycount: 0, totaldefectcount: 0 };
                })
                .catch(function(err) { LOGGER.error(err); return logAndThrow(err); });
        }

        return Promise.all([util.executeSecondaryNodeDBQuery(sql, pagedParams), util.executeSecondaryNodeDBQuery(sql, countParams)])
            .then(function([pagedResults, allResults]) {
                let totalstorycount = 0;
                let totaldefectcount = 0;
                const distinctReleaseVersions = new Set();

                for (const r of allResults) {
                    if (r.itemtype === 'Story') totalstorycount++;
                    else if (r.itemtype === 'Defect') totaldefectcount++;
                    if (r.releaseversionno) distinctReleaseVersions.add(r.releaseversionno);
                }

                const totaldistinctreleasecount = distinctReleaseVersions.size;

                // totalcount: use type-specific count when filtered, otherwise combined total
                let totalcount;
                if (itemtype === 'Story')       totalcount = totalstorycount;
                else if (itemtype === 'Defect') totalcount = totaldefectcount;
                else                            totalcount = totalstorycount + totaldefectcount;

                return { rows: formatForReleaseData(pagedResults), totalcount, totalstorycount, totaldefectcount, totaldistinctreleasecount };
            })
            .catch(function(err) { LOGGER.error(err); return logAndThrow(err); });
    };

    Releasenotes.remoteMethod('fuzzySearch', {
        accepts: [
            { arg: 'searchTerm',      type: 'string',  required: false, http: { source: 'query' } },
            { arg: 'pReleaseVersion', type: 'string',  required: false, http: { source: 'query' } },
            { arg: 'pStartDate',      type: 'date',    required: false, http: { source: 'query' } },
            { arg: 'pEndDate',        type: 'date',    required: false, http: { source: 'query' } },
            { arg: 'page',            type: 'number',  required: false, http: { source: 'query' } },
            { arg: 'limit',           type: 'number',  required: false, http: { source: 'query' } },
            { arg: 'sortcolumn',      type: 'string',  required: false, http: { source: 'query' } },
            { arg: 'sortorder',       type: 'string',  required: false, http: { source: 'query' } },
            { arg: 'fulldata',        type: 'boolean', required: true,  http: { source: 'query' } },
            { arg: 'itemtype',        type: 'string',  required: false, http: { source: 'query' } }
        ],
        returns: { type: 'object', root: true },
        http: { path: '/search/fuzzy', verb: 'get' }
    });

    Releasenotes.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Releasenotes.observe('access', (ctx, next) => util.access(ctx, next));
    Releasenotes.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));

    /**
     * Formats raw SQL rows to the 4-column release version schema.
     * RETURNS TABLE(totalcount bigint, releaseversionno varchar, releasedate date, publish boolean)
     */
    function formatForReleaseVersion(rows) {
        if (!rows || !Array.isArray(rows)) return [];
        return rows.map(row => ({
            totalcount:       row.totalcount ? Number(row.totalcount) : 0, // bigint arrives as string or number depending on driver
            releaseversionno: row.releaseversionno || '',
            releasedate:      row.releasedate || null,
            publish:          typeof row.publish === 'boolean' ? row.publish : false
        }));
    }

    function formatForReleaseData(rows) {
        if (!rows || !Array.isArray(rows)) return [];

        const out = [];
        for (const row of rows) {
            out.push({
                totalcount: toCount(row.totalcount),
                releaseversionno: orEmpty(row.releaseversionno),
                releasedate: orNull(row.releasedate),
                supportno: orEmpty(row.supportno),
                supportid: orEmpty(row.supportid),
                itemid: orEmpty(row.itemid),
                itemtype: orEmpty(row.itemtype),
                frommailid: orEmpty(row.frommailid),
                releasenotesid: orNull(row.releasenotesid), // UUIDs are treated as strings in JavaScript
                description: orEmpty(row.description),
                title: orEmpty(row.title),
                documentlink: orEmpty(row.documentlink),
                publish: toBool(row.publish),
                displayname: orEmpty(row.displayname),
                raisedby: orEmpty(row.raisedby),
                jirarequestno: orEmpty(row.jirarequestno),
                jirasupportno: orEmpty(row.jirasupportno)
            });
        }
        return out;
    }
};

