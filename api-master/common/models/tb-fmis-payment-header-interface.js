'use strict';
const LOGGER = require("log4js").getLogger("tb-fmis-payment-header-interface");
var app = require('../../server/server');
const util = require('../utils/utils');
var fs =require('fs');
const fmispaymentheaderinterfaceoutboundfile = './outboundfiles/fmis/FMIS_PAYMENT_HEADER_INTERFACE-Outbound.txt';

module.exports = function(Tbfmispaymentheaderinterface) {
	Tbfmispaymentheaderinterface.list = function (request) {
		var proSql = "select sp_fmis_pmnt_interface(1, current_date)";
		return util.executeDBQuery(proSql).then(data => {
				LOGGER.debug("data", data);
				fs.writeFile(fmispaymentheaderinterfaceoutboundfile, '', function () { LOGGER.debug('Existing Data Got Cleared') });
				var sql = "select * from TB_FMIS_PAYMENT_HEADER_INTERFACE";
				return util.executeDBQuery(sql).then(data1 => {
						const Json2csvParser = require('json2csv').Parser;

						LOGGER.debug('data', data1);
						if (data1.length > 0) {
							const json2csvParser = new Json2csvParser({ delimiter: '\n', quote: '', header: false });
							const csv = json2csvParser.parse(data1);
							LOGGER.debug(csv);

							fs.writeFile(fmispaymentheaderinterfaceoutboundfile, csv, (err2) => {
								if (err2) {
									LOGGER.error(err2);
									return;
								}
								LOGGER.debug("File has been created");
							});
						} else {
							fs.createWriteStream(fmispaymentheaderinterfaceoutboundfile);
						}

						return data1;
					});
			}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
	};



Tbfmispaymentheaderinterface.remoteMethod ('list',{
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
