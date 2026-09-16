'use strict';
const util = require('../utils/utils');

module.exports = function(permanencyplantype) {



  permanencyplantype.list =request => {

    return permanencyplantype.find({
      fields:['permanencyplantypekey','description'],where:{activeflag:1},
			include: {
				relation: 'permanencyplansubtype',
				scope: {
					fields: ['permanencyplansubtypeid','permanencyplantypekey','permanencyplansubtypekey','description'],
				}
			}
		})
		.then(data => {
			return data;
		})
		.catch(err => err);

  }




	permanencyplantype.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
  });


    permanencyplantype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    permanencyplantype.observe('access', (ctx, next) => util.access(ctx, next));
    permanencyplantype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
