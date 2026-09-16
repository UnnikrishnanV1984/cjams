'use strict';
const LOGGER = require("log4js").getLogger("personnytdsummary");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(PersonNytdSummary) {
    PersonNytdSummary.list = function (request) {
        if (request.where && request.where.personid !== undefined && 
                request.where.personid !== null && request.where.personid !== '') {
            return PersonNytdSummary.find({
                    where: {
                        personid: request.where.personid
                    },
                    order: 'insertedon desc',
                }).then(resp => {
                    const data = JSON.parse(JSON.stringify(resp));
                    LOGGER.debug("data" + JSON.stringify(resp));
                    return data;
                })
                .catch(err => err);
        } else {
            if (request.where && request.where.reportingperiod !== undefined) {
                return PersonNytdSummary.find({
                    where: {
                        reportingperiod: request.where.reportingperiod,
                        activeflag: 1,
                        validationflag: 1
                    },
                    order: 'insertedon desc',
                }).then(response => {
                    const data = JSON.parse(JSON.stringify(response));
                    LOGGER.debug("data" + JSON.stringify(response));
                    return data;
                })
                .catch(err => err);
            }
        }
        return Promise.resolve([]);
    };

    PersonNytdSummary.remoteMethod('list', {
        http: {
            path: '/list',
            verb: 'get'
        },
        accepts : [{
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        }],  
        returns: {
            type : 'object',
            root : true
        } 
    });

    PersonNytdSummary.reportingperiods = async (request) => {
        try {
            var sql = "select distinct(reportingperiod) from personnytdsummary "+
                        "where activeflag = 1 and validationflag = 1 and personid is not null "+
                        "order by reportingperiod desc";
            const data = await util.executeDBQuery(sql, []);
            LOGGER.info(data);
            return data;
        }
        catch (err) {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        }
    }

    PersonNytdSummary.remoteMethod('reportingperiods', {
        http: {
            path: '/reportingperiods',
            verb: 'get'
        },
        accepts : [{
            arg : 'filter',
            type : 'object',
            http : {source : 'query'}
        }],  
        returns: {
            type : 'object',
            root : true
        } 
    });
}