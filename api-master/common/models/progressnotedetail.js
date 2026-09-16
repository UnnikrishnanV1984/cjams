'use strict';
const LOGGER = require("log4js").getLogger("progressnotedetail");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Progressnotedetail) {
	
	
		
	Progressnotedetail.list = function(id){
		var description =  " split_part(description, '|', 1) AS Providername, split_part(description, '|', 2) AS Action, split_part(description, '|', 3) AS Type";
		var sql = 'SELECT'  +  description  +',insertedby AS AssignedCA  FROM progressnotedetail WHERE  progressnoteid = \''+id+'\''  ;

	return util.executeDBQuery(sql, [])
		.then(data => {
			LOGGER.debug(data);
			return data;
		})
		.catch(err => {
			LOGGER.error('>>>>ERROR:', err);
			throw err;
		});
};

   Progressnotedetail.remoteMethod('list', {
    accepts : [{
            arg: 'id',
            type: 'string',
            required: true,
            http: {source: 'path'}
        }
        
          ],
    http: {"verb": "get", "path": "/list/:id"},
	returns : {
		type : 'Object',
		root : true
	}
});
	
	
Progressnotedetail.observe('before save', (ctx, next) => util.beforesave(ctx, next));
Progressnotedetail.observe('access', (ctx, next) => util.access(ctx, next));
Progressnotedetail.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
	
	
};
