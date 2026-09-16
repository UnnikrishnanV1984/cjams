'use strict';
const LOGGER = require("log4js").getLogger("fiscalCode");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function (fiscalCode) {
    fiscalCode.agencyservices = (request) => {
        LOGGER.debug('hello');
        var providerid = request.where.provideridCheck ? request.where.provideridCheck : null;
        const dataQuery = `SELECT TRIM(fiscal_category_cd) as fiscalCateforyCd, fiscal_category_desc as fiscalCategoryDesc,fcm.eligibility_cd,fcm.start_dt, fcm.end_dt, tpai.is_cfe as approvalCfe,max(fcm.additional_description) as additional_description
        from tb_fiscal_category_master fcm
        join programcategorylink pcl on Trim(pcl.fiscalcategoryid :: character varying)  = Trim(fcm.fiscal_category_id :: character varying) and pcl.activeflag =1
        join agencyprogramarea apa on apa.agencyprogramareaid = pcl.agencyprogramareaid
        left join prov.tb_provider_additional_info tpai on tpai.provider_id = $2 
        where apa.programkey = $1 and fcm.delete_sw = 'N' group by fiscalCateforyCd,fiscalCategoryDesc,fcm.eligibility_cd,fcm.start_dt, fcm.end_dt, tpai.is_cfe  order by fcm.fiscal_category_desc`;
        return util.executeDBQuery(dataQuery, [request.where.agencyprogramareaid, providerid])
            .then(result => {
                LOGGER.debug('success');
                LOGGER.debug(result, 'result');
                return result;
            }).catch(err => util.logError(err));
    };
    fiscalCode.remoteMethod('agencyservices', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            path: '/agencyservices',
            verb : 'get'
        },
        returns : {
            type : 'string',
            root : true
        }
    });

    fiscalCode.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    fiscalCode.observe('access', (ctx, next) => util.access(ctx, next));
    fiscalCode.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};