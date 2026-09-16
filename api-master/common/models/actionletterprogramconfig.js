'use strict';
const LOGGER = require("log4js").getLogger("actionletterprogramconfig");
const util = require('../utils/utils');

module.exports = function(Actionletterprogramconfig) {
  
    Actionletterprogramconfig.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Actionletterprogramconfig.observe('access', (ctx, next) => util.access(ctx, next));
    Actionletterprogramconfig.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

	Actionletterprogramconfig.getprogramheaderconfig = function (request) {
        var actiontypekey = request.where.actiontypekey;
        var programtypekey=request.where.programtypekey
		var sql = 'select * from getprogramheaderconfig ($1,$2)';
		return util.executeDBQuery(sql, [actiontypekey,programtypekey])
			.then(data => data)
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};


    Actionletterprogramconfig.remoteMethod ('getprogramheaderconfig',{
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

}