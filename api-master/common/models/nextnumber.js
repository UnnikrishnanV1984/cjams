'use strict';
const LOGGER = require("log4js").getLogger("nextnumber");
var server = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Nextnumber) {
		Nextnumber.getNextNumber = function(apptype) {
		let app ='';
			if (apptype !== null && apptype !== undefined && apptype !== '') {
			    app = apptype.toLowerCase();
		}
		var sql = 'select * from getNextNumber($1)';
			if (app === 'intakenumber' || app === 'servicerequestauthorizationnumber' ||
			    app === 'groupauthorizationnumber' || app === 'serviceplannumber') {
				sql = 'select * from getnextdanumber($1)';
			}
		return util.executeDBQuery(sql, [app])
			.then(data => doFormatID(app, data[0]))
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	}
		
	const doFormatID = function(apptype, data) {
      var d = new Date();
  		if (apptype=='intakenumber'){
  			return "I"+ data.getnextdanumber;
  		} else if(apptype=='servicerequestauthorizationnumber') {
			return data.getnextdanumber;
  		} else if(apptype == 'groupauthorizationnumber') {
  			return "G" + data.getnextdanumber;
  		} else if (apptype== 'serviceplannumber'){
			return "SPLAN"+ data.getnextdanumber;
		} else if(apptype == 'providerreferral') {
  			return "R"+d.getFullYear()+("000" + d.getDay()).slice(-3)+
        ("00000" + data.getnextnumber).slice(-5);
			 } else if(apptype == 'vendorreferral') {
  			return "V"+d.getFullYear()+("000" + d.getDay()).slice(-3)+
        ("00000" + data.getnextnumber).slice(-5);
			}
			 else if (apptype=='providertraining'){
  			return "PT"+d.getFullYear()+("000" + d.getDay()).slice(-3)+
        ("00000" + data.getnextnumber).slice(-5);
			}	else if (apptype=='providercomplaint'){
  			return "PC"+d.getFullYear()+("000" + d.getDay()).slice(-3)+
        ("00000" + data.getnextnumber).slice(-5);
			} else if (apptype=='providerincident'){
  			return "UIR"+d.getFullYear()+("000" + d.getDay()).slice(-3)+
        ("00000" + data.getnextnumber).slice(-5);
			} else if (apptype=='providerportalrequest'){
  			return "REQ"+d.getFullYear()+("000" + d.getDay()).slice(-3)+
        ("00000" + data.getnextnumber).slice(-5);
  		} 	else {
  			return data.getnextnumber
  		}
	};


  Nextnumber.remoteMethod (
    'getNextNumber', 
    {
      http: {
      		path: '/getNextNumber',
      		verb: 'get'
      },
      accepts: {
      		arg: 'apptype', 
      		type: 'string'
      },   
      returns: {
      		arg: 'nextNumber', 
      		type: 'object'
      }
     }
  );

	Nextnumber.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Nextnumber.observe('access', (ctx, next) => util.access(ctx, next));
	Nextnumber.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

};
