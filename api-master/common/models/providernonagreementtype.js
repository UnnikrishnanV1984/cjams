'use strict';
const util = require('../utils/utils');

module.exports = function(Providernonagreementtype) {

	/**
	 * Execute the Count - if count is zero don't execute the listing else
	 * return the list also *
	 */
	
	Providernonagreementtype.list = request => {
		let totalCount = 0;

		if (request.page !== 'undefined') {
			request.skip = (request.page - 1) * request.limit;
		}
		
		const prs = [];
		prs.push(Providernonagreementtype.find(request));
		if (request.page !== 'undefined' && request.page === 1){
			prs.push(Providernonagreementtype.count(request.where));
		}
		return Promise.all(prs)
		.then(data => {
			if(data.length > 0){
				totalCount = data[1];}
			return {
				data : data[0],
				count : totalCount
			};
			//return data;					// SonarQube commented this line as it is not reachable
		})
		.catch(err => util.logError(err));

	};

	Providernonagreementtype.remoteMethod('list', {
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			},
			required : true
		},
		http : {
			verb : 'GET'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

};
