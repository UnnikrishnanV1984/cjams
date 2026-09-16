'use strict';
const LOGGER = require("log4js").getLogger("socialhistory");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function(Socialhistory) {
    Socialhistory.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Socialhistory.observe('access', (ctx, next) => util.access(ctx, next));
    Socialhistory.observe('after save', (ctx, next) => util.aftersave(ctx, next,'SHIST', ctx.instance.personid_fk));
    Socialhistory.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

    Socialhistory.list = function (request) {
        if (request.where && request.where.personid !== undefined) {
            return Socialhistory.find({
                    where: {
                        personid_fk: request.where.personid
                    },
                    order: 'insertedon desc',
                }).then(resp => {
                    const data = JSON.parse(JSON.stringify(resp));
                    LOGGER.debug("data" + JSON.stringify(resp));
                    return data;
                })
                .catch(err => err);
        }
        return Promise.resolve([]);
    };

    Socialhistory.remoteMethod('list', {
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

   Socialhistory.getlist = function (request) {
        if (request.where && request.where.personid_fk !== undefined) {
            const sql = `select s.*, u2.fullname as updatedby, u.fullname as createdby from socialhistory s left join userprofile u on s.insertedby = u.securityusersid 
            left join userprofile u2 on s.updatedby = u2.securityusersid 
            where s.personid_fk in ( select intakeservicerequestactorid 
                from intakeservicerequestactor
                where actorid =(select actorid from intakeservicerequestactor where intakeservicerequestactorid =$1) 
                ) order by updatedon desc`;
            return util.executeSecondaryNodeDBQuery(sql, [request.where.personid_fk])
            .then(data => {
                return data;
            }) 
          .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
        }
        return Promise.resolve([]);
    };

    Socialhistory.remoteMethod('getlist', {
        accepts : {
            arg : 'filter',
            type : 'Object',
            http : {
                source : 'query'
            },
            required : true
        },
        http : {
            verb : 'get',
            path: '/getlist',
        },
        returns : {
            type : 'Object',
            root : true
        }
    });

}