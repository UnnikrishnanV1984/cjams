'use strict';
const LOGGER = require("log4js").getLogger("tb-fmis-payment-detail-interface");
var app = require('../../server/server');
const util = require('../utils/utils');
var fs =require('fs');
const fmispaymentdetailinterfaceoutboundfile = './outboundfiles/fmis/FMIS_PAYMENT_DETAIL_INTERFACE-Outbound.txt';
module.exports = function(Tbfmispaymentdetailinterface) {
    Tbfmispaymentdetailinterface.list = function(request) {
		var proSql = "select * from person";
		return util.executeDBQuery(proSql).then(data => {
				LOGGER.debug("data" ,data);
				fs.writeFile(fmispaymentdetailinterfaceoutboundfile, '', function(){LOGGER.debug('Existing Data Got Cleared')});
				var sql = "select * from TB_FMIS_PAYMENT_DETAIL_INTERFACE";
				return util.executeDBQuery(sql).then(data1 => {
						const Json2csvParser = require('json2csv').Parser;

				LOGGER.debug('data',data1);
				if(data1.length > 0) {
					const json2csvParser = new Json2csvParser({  delimiter: '\n',quote: '',header:false  });
					const csv = json2csvParser.parse(data1);
					LOGGER.debug(csv);

					fs.writeFile(fmispaymentdetailinterfaceoutboundfile, csv, (err2) => {
						if (err2) {
							LOGGER.error(err2);
							return;
						}
						LOGGER.debug("File has been created");
					});
				} else {
					fs.createWriteStream(fmispaymentdetailinterfaceoutboundfile);
				}


					return data1;
		});
	}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};



Tbfmispaymentdetailinterface.remoteMethod ('list',{
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
	

};
