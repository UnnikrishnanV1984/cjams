'use strict';
const util = require('../utils/utils');
let server = require('../../server/server');
const LOGGER = require("log4js").getLogger("physicianspecialtytype");
module.exports = function(Physicianspecialtytype) {    

    Physicianspecialtytype.listphysicianspecialtytypes = function(reqctx) {
		const teamtypekey = 'CW';
		let sql = 'select * from listphysicianspecialtytypes($1)';
        return util.executeDBQuery(sql, [teamtypekey])
        .then(data => data)
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
	};

    Physicianspecialtytype.remoteMethod ('listphysicianspecialtytypes', {
        http: {
            path: '/listphysicianspecialtytypes',
            verb: 'get'
        },
        accepts : [{ arg: 'reqctx',
					 type: 'object',
					 http: {source: 'context'}
				}],   
        returns: {
            type: 'Object',
            root : true
        }
    });

    Physicianspecialtytype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Physicianspecialtytype.observe('access', (ctx, next) => util.access(ctx, next));
    Physicianspecialtytype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
