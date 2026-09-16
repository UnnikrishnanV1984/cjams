'use strict';
const LOGGER = require("log4js").getLogger("tb-afs-interfaces");
var app = require('../../server/server');
const util = require('../utils/utils');
var fs =require('fs');

const afs_vendor_master_interface_outbound_file = 'AFS_VENDOR_MASTER_INTERFACE_OUTBOUND.txt';
const afs_payment_invoice_interface_outbound_file = 'AFS_PAYMENT_INVOICE_INTERFACE_OUTBOUND.txt';

module.exports = function(TbAfsInterfaces) {
    TbAfsInterfaces.vendorlist = function(request) {
		var proSql = "SELECT * FROM sp_interfaceafsvendoroutbound()";
		return util.executeDBQuery(proSql).then(data => {
			LOGGER.debug("data" ,data);
			fs.writeFile(afs_vendor_master_interface_outbound_file, '', function(){LOGGER.debug('Existing Data Got Cleared')});
			var sql = "SELECT * FROM interfaceafsvendoroutbound";
			return util.executeDBQuery(sql).then(data1 => {
				const Json2csvParser = require('json2csv').Parser;

				LOGGER.debug('data',data1);
				if(data1.length > 0) {
					const json2csvParser = new Json2csvParser({  delimiter: '\n',quote: '',header:false  });
					const csv = json2csvParser.parse(data1);
					LOGGER.debug(csv);

					fs.writeFile(afs_vendor_master_interface_outbound_file, csv, (err2) => {
						if (err2) {
							LOGGER.error(err2);
							return;
						}
						LOGGER.debug("File has been created");
					});
				} else {
					fs.createWriteStream(afs_vendor_master_interface_outbound_file);
				}

				return data1;
			});
		}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};

TbAfsInterfaces.paymentlist = function(request) {
    var proSql = "SELECT * FROM sp_interfaceafspaymentoutbound()";
    return util.executeDBQuery(proSql).then(data => {
            LOGGER.debug("data" ,data);
            fs.writeFile(afs_payment_invoice_interface_outbound_file, '', function(){LOGGER.debug('Existing Data Got Cleared')});
            var sql = "SELECT * FROM interfaceafspaymentoutbound";
            return util.executeDBQuery(sql).then(data4 => {
                    const Json2csvParser = require('json2csv').Parser;

            LOGGER.debug('data',data4);
            if(data4.length > 0) {
                const json2csvParser = new Json2csvParser({  delimiter: '\n',quote: '',header:false  });
                const csv = json2csvParser.parse(data4);
                LOGGER.debug(csv);

                fs.writeFile(afs_payment_invoice_interface_outbound_file, csv, (err5) => {
                    if (err5) {
                        LOGGER.error(err5);
                        return;
                    }
                    LOGGER.debug("File has been created");
                });
            } else {
                fs.createWriteStream(afs_payment_invoice_interface_outbound_file);
            }

            return data4;
    });
}).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};



TbAfsInterfaces.remoteMethod ('vendorlist',{
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			path: '/vendorlist',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});
    
    TbAfsInterfaces.remoteMethod ('paymentlist',{
		accepts : {
			arg : 'filter',
			type : 'Object',
			http : {
				source : 'query'
			}
		},
		http : {
			path: '/paymentlist',
			verb : 'get'
		},
		returns : {
			type : 'string',
			root : true
		}
	});

};
