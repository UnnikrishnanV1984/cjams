'use strict';
const LOGGER = require("log4js").getLogger("restitutionpaymentflatfile");
var app = require('../../server/server');
var loopback = require('loopback');
var boot = require('loopback-boot');
const util = require('../utils/utils');
var csv = require('csv-array');

module.exports = function(Restitutionpaymentflatfile) {
    
    Restitutionpaymentflatfile.createheader = (requestJson) => {
        var sql = "select * from saverestitutionpaymentflatfile($1)";
        return util.executeDBQuery(sql, [requestJson])
        .then(data => {
            return data;
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    };

    Restitutionpaymentflatfile.loadfiledata = (loadpath,restitutionpaymentflatfileid) => {
        return new Promise((resolve, reject) => {csv.parseCSV(loadpath, function(data){
        LOGGER.debug(JSON.stringify(data));
        resolve(restitutionpaymentflatfiledatauploads(data,restitutionpaymentflatfileid));
        });
        });
    };

    function restitutionpaymentflatfiledatauploads(data,restitutionpaymentflatfileid) {
            var prs = data.map(elements => {
            var asofdate = elements["As of Date"];
            if (asofdate!=null || asofdate!=undefined || asofdate!=''|| asofdate!="")
            {

            var sql = "select * from saverestitutionpaymentflatfilecontent($1,$2)";
            return util.executeDBQuery(sql, [elements,restitutionpaymentflatfileid])
            .then(data1 => {
                return data1;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });

            }
            else
            {
            return Promise.resolve(null);
            }
            });
            return Promise.all(prs);
            
    }

    Restitutionpaymentflatfile.updaterestitutionpaymentmatched = () => {
        var sql = "select * from updaterestitutionpaymentmatched()";
        return util.executeDBQuery(sql, [])
        .then(data => {
            return data;
        })
        .catch(err1 => {
            LOGGER.error('>>>>ERROR:', err1);
            throw err1;
        });
    };

    Restitutionpaymentflatfile.restitutionpaymentismatchedlist = function(data) {
        var Totalcount = 0;
        var showCount = false;
        var filtercol='';
        var filtervalue='';
        var obj = data.where;
        if(data.page === 1){
            showCount = true;
        }/* else{showCount = false}; */             //SonarQube fix - commented as showCount is already set to false above
        data.where.startdate = util.nullcheck(data.where.startdate);
        data.where.enddate = util.nullcheck(data.where.enddate);
        if (data.where.matched==null || data.where.matched==undefined) {data.where.matched=false;}
       
        
        if (util.isNullorEmpty(obj))
		{
			
			if(Object.keys(obj)[0].toLowerCase() !="activeflag")
			{
				filtercol =Object.keys(obj)[0] ;
				var obj1 = obj[Object.keys(obj)[0]];
				if (obj1 !=null && obj1 !=undefined)
				{
					filtervalue=obj1;
				}
			}
        }
        
        var sql1 = 'select * from restitutionpaymentismatched($1,$2,$3,$4,$5,$6,$7)';
        return util.executeDBQuery(sql1,[data.where.startdate,data.where.enddate,data.page,
            data.limit,data.where.matched,filtercol,filtervalue])
        .then(data2 => {
            if (data2.length>0 ) {Totalcount = data2[0].totalcount;}
                    var result = JSON.parse(JSON.stringify(data2));
                    result.forEach(x => {
                    delete x.totalcount;
                    });
                    if(showCount)
                    {
                    result = {
                        'data': result,
                        'count' : Totalcount
                    };
                    }
                    else
                    {
                    result = {
                        'data': result
                    };
                    }
                return result;
        })
        .catch(err => {
            LOGGER.error(err);
            throw err;
        })
    };

    Restitutionpaymentflatfile.remoteMethod('restitutionpaymentismatchedlist', {
        accepts : {
                arg : 'data',
                type : 'object',
                required : true,
                http : { source: 'query' }
            },
        http: {
            'verb': 'get', 
            'path': '/restitutionpaymentismatchedlist'
            },
        returns : {
            type : 'object',
            root : true
            }
    });
    
   Restitutionpaymentflatfile.observe('before save', (ctx, next) => util.beforesave(ctx, next));
   Restitutionpaymentflatfile.observe('access', (ctx, next) => util.access(ctx, next));
   Restitutionpaymentflatfile.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
}
