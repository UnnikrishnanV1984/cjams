'use strict';
const LOGGER = require("log4js").getLogger("tb-temp-fmis-vendor-interface");
var app = require('../../server/server');
const util = require('../utils/utils');
var fs =require('fs');
const tempfmisvendorinterfacefilename = 'TEMP_FMIS_VENDOR_INTERFACE-Outbound.txt';

module.exports = function(Tbtempfmisvendorinterface) {
    Tbtempfmisvendorinterface.list = function(request) {
		var proSql = "select SP_FMIS_VENDOR_INTERFACE()";
		return util.executeDBQuery(proSql).then(data => {
				LOGGER.debug("data" ,data);
				fs.writeFile(tempfmisvendorinterfacefilename, '', function(){LOGGER.debug('Existing Data Got Cleared')});
				var sql = "select * from TB_TEMP_FMIS_VENDOR_INTERFACE";
				return util.executeDBQuery(sql).then(data1 => {
						const Json2csvParser = require('json2csv').Parser;

				LOGGER.debug('data',data1);
				if(data1.length > 0) {
					const json2csvParser = new Json2csvParser({  delimiter: '\n',quote: '',header:false  });
					const csv = json2csvParser.parse(data1);
					LOGGER.debug(csv);

					fs.writeFile(tempfmisvendorinterfacefilename, csv, (err2) => {
						if (err2) {
							LOGGER.error(err2);
							return;
						}
						LOGGER.debug("File has been created");
					});
				} else {
					fs.createWriteStream(tempfmisvendorinterfacefilename);
				}


					return data1;
		});
	}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};



Tbtempfmisvendorinterface.remoteMethod ('list',{
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
