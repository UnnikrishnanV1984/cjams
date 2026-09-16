'use strict';
const LOGGER = require("log4js").getLogger("tb-agency-program-area");
var server = require('../../server/server');
const util = require('../utils/utils');
var https = require('https');
var config = require('../../server/config.json');
var fs = require('fs');

var sortJsonArray = require('sort-json-array');
var data = {};

module.exports = function(Tbagencyprogramarea) {
    Tbagencyprogramarea.agencyProvidedServices = (request) =>{
    LOGGER.debug('hello');
    const dataQuery = `select 
    ap.agencyprogramareaid,
    ap.programkey as agency_program_area_id,
    ap.programname as agency_program_nm,
    pp.startdate, 
    pp.enddate::date, 
    (select json_agg(a) from (SELECT DISTINCT rv.description AS subprogramname,pac.subprogramkey
     FROM programareaconfig pac 
     INNER JOIN referencevalues rv ON rv.ref_key=pac.subprogramkey AND rv.activeflag=1 AND rv.referencetypeid=12
     WHERE pac.programkey= pp.programkey and pac.subprogramkey= pp.subprogramkey AND pac.activeflag=1 Limit 1) a) as subprogram
    from agencyprogramarea ap 
    join personprogramarea pp on ap.programkey = pp.programkey and pp.activeflag =1
    where ap.activeflag =1 and pp.personid = $1
    order by pp.enddate desc nulls first`;
                return util.executeDBQuery(dataQuery, [request.where.person_id]).then(result => {
                    LOGGER.debug('success');
                    return result;
                }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            };
    Tbagencyprogramarea.remoteMethod ('agencyProvidedServices', {
            accepts : {
                arg : 'filter',
                type : 'Object',
                http : {
                source : 'query'
                },
                required : true
                },
                http : {
                path: '/agencyProvidedServices',
                verb : 'get'
                },
                returns : {
                type : 'Object',
                root : true
                }
                });


    Tbagencyprogramarea.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tbagencyprogramarea.observe('access', (ctx, next) => util.access(ctx, next));
    Tbagencyprogramarea.beforeRemote('*', (ctx,data1, next) => util.beforeremote(ctx, next));
};


