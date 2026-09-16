'use strict';
const LOGGER = require("log4js").getLogger("tb_prov_program_facility");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_prov_program_facility) {

    Tb_prov_program_facility.getprogramfacilitydetials = (request) => {
        var program_id = request.where.program_id;
        var sql = 'select * from getprogramfacilitydetials($1)';

		return util.executeDBQuery(sql, [program_id])
		.then(datas => datas)
		.catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };

    Tb_prov_program_facility.remoteMethod('getprogramfacilitydetials', {
        http: {
            path: '/getprogramfacilitydetials',
            verb: 'get'
        },
        accepts : [ 
        {
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        } ],  
        returns: {
            type : 'object',
            root : true
        } 
    });


    Tb_prov_program_facility.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_prov_program_facility.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_prov_program_facility.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}