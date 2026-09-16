'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Familymeetingtype) {



  Familymeetingtype.list =request => {

    return Familymeetingtype.find({
	where :{activeflag: 1},
      fields:['familymeetingtypekey','typedescription'],
			include: {
				relation: 'familymeetingsubtype',
				scope: {
					fields: ['familymeetingsubtypeid','familymeetingtypekey','familymeetingsubtypekey','typedescription'],
				}
			}
		})
		.then(data => {
			return data;
		})
		.catch(err => err);

  }




	Familymeetingtype.remoteMethod('list', {
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


    Familymeetingtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Familymeetingtype.observe('access', (ctx, next) => util.access(ctx, next));
    Familymeetingtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
