'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
module.exports = function(Teamtype) {
	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	Teamtype.list = (request)=> {	

		var returndata ={"ismanualrouting":""};
		const prs=[];

	  return app.models.Agencyconfig.find({
		fields:['teamtypekey','ismanualrouting'],
		  include:{
			relation:'teamtype',
			where:request	
		  }
	  }).then(data=>{
		  var result  =JSON.parse(JSON.stringify(data));
		  for(const element of result){
			  returndata = element.teamtype;
			  returndata.ismanualrouting = element.ismanualrouting;
			  prs.push(returndata);
		  }
		return prs; 
	  })
		.catch(err => err)
	};

	Teamtype.remoteMethod('list', {
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

	Teamtype.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Teamtype.observe('access', (ctx, next) => util.access(ctx, next));
    Teamtype.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
