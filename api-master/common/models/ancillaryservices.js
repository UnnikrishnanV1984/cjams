'use strict';
const util = require('../utils/utils');
const app = require('../../server/server');

const trylatermsg = 'Please try again later';

const dbFailure = err => {
    util.logError(err);
    return {
        message: trylatermsg,
        success: false
    };
};

module.exports = function(Ancillaryservices) {

    Ancillaryservices.remoteMethod('addupdate', {
        http: {
                path: '/addupdate',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Ancillaryservices.addupdate = request => {
        const sql = 'select * from addupdateancillaryservices($1::json)';
        return util.executeDBQuery(sql, [request])
            .then(result => result[0])
            .catch(dbFailure);
    };

    Ancillaryservices.remoteMethod('list', {
        http: {
                path: '/list',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'Object',
            http : {source : 'body'}} ],
        returns: {
            type : 'Object',
            root : true
        }
    });

    Ancillaryservices.list = request => {
        const sql = 'select * from getancillaryserviceslist($1, $2, $3, $4, $5)';
        const input = request.where;
        return util.executeDBQuery(sql, [input.securityuserid, input.userrole, input.status, input.pagenumber, input.pagesize])
            .then(result => ({
                success: true,
                data: result[0].getancillaryserviceslist ? result[0].getancillaryserviceslist : []
            }))
            .catch(dbFailure);
    };

}