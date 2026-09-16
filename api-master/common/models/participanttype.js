'use strict';
const util = require('../utils/utils');
var server = require('../../server/server');
module.exports = function(Participanttype) {

  Participanttype.list =request => {

    return Participanttype.find({
      fields:['participanttypekey','typedescription'],
			include: {
				relation: 'participantsubtype',
				scope: {
					fields: ['participantsubtypeid','participanttypekey','participantsubtypekey','typedescription'],
				}
			}
		})
		.then(data => {
			return data;
		})
		.catch(err => err);

  }




	Participanttype.remoteMethod('list', {
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
    Participanttype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Participanttype.observe('access', (ctx, next) => util.access(ctx, next));
    Participanttype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
