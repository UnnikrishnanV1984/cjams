'use strict';
const LOGGER = require("log4js").getLogger("tb_foster_care_rate");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');

module.exports = function(Tb_foster_care_rate) {
    Tb_foster_care_rate.remoteMethod('addupdate', {
        http: {
            path: '/addupdate',
            verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}},{
                arg: 'reqctx',
                type: 'object',
                http: {source: 'context'}
              } ],
        returns: {
            type : 'string',
            root : true
        }
    });

    Tb_foster_care_rate.addupdate = function(request,reqctx) {
        const suserid = util.getSecurityDetails(request, reqctx).securityuserid;
        var rate_id = request.rate_id ? request.rate_id : null;
        var securityusersid = suserid;
        request.create_user_id = securityusersid;
        request.update_user_id = securityusersid;
        var insertedon = new Date().toLocaleString();
        request.create_ts= insertedon;
        let generatedId ='';

        if (rate_id == undefined || rate_id == '' || rate_id == null){
            const sql = "select * from nextval('tb_foster_care_rate_seq'::regclass)"; //@TM: Generate Rate ID for FCR tbl
            return util.executeDBQuery(sql,[])
            .then(resp => {
                    generatedId = JSON.parse(JSON.stringify(resp));
                    request.rate_id = generatedId[0].nextval;

                    return Tb_foster_care_rate.create(request).then(data => {
                        var res= JSON.parse(JSON.stringify(data));
                        request.main_rate_id = request.rate_id;
                        delete request['rate_id']; //@TM: Reset Rate ID and Generate Rate ID for FCR stg tbl
                        util.executeDBQuery(sql,[])
                        .then(_data => {
                                generatedId = JSON.parse(JSON.stringify(_data));
                                request.rate_id = generatedId[0].nextval;

                                //@TM: Foster Care Rate - always new insert into Staging table, put corresponding main rate id into staging 
                                app.models.Tb_foster_care_rate_stg.create(request).then(data1 => {
                                    var response = JSON.parse(JSON.stringify(data1));

                                    //@TM: Insert County IDs into reference table - if differential amt is entered, use stg rate_id as reference
                                    var countyIds = response.countyidlist;
                                    if (countyIds && Array.isArray(countyIds)) {
                                        countyIds.forEach(data2 => {
                                            request.stg_rate_id = request.rate_id;
                                            request.county_id = data2.county_id;
                                            app.models.County_fcrate.create(request).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                                        });
                                    }
                                }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            throw err;
                        })
                        return res;     
                        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            })
            .catch(err => {
                LOGGER.error(err);
                throw err;
            })
        } else if (rate_id) {
            return new Promise((resolve, reject) => {
                LOGGER.debug("dirty status --->" + JSON.stringify(request));

                if(request.dirty_status == 0) {              //@TM: rate approved -> update main rate table
                    const sql = "select * from updatefostercarerate($1)";
                    LOGGER.debug("sql --->" + sql);
                    return util.executeDBQuery(sql,[request])
                    .then(data => {
                        LOGGER.info(data);
                        return data;
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        return err;
                    })
                } else {                                    //@TM: rate is not approved -> keep dirty
                    const sql = ' UPDATE tb_foster_care_rate SET '+
                        ' dirty_status=\''+request.dirty_status+'\'' +
                        ' WHERE rate_id =\''+request.rate_id+'\'';
                        LOGGER.debug("update --->" + sql);
                    return util.executeDBQuery(sql,[])
                        .then(data => {
                            LOGGER.info(data);
                            return data;
                        })
                        .catch(err => {
                            LOGGER.error(err);
                            return err;
                        })
                }
            }).then(res => {
                request.main_rate_id = request.rate_id;
                LOGGER.debug("rate status --->" + JSON.stringify(request));

                var sql1 = "select * from nextval('tb_foster_care_rate_seq'::regclass)";
                util.executeDBQuery(sql1,[])
                    .then(data => {
                        var generatedId1 = JSON.parse(JSON.stringify(data));
                        request.rate_id = generatedId1[0].nextval;

                        //@TM: Foster Care Rate - always new insert into Staging table, put corresponding main rate id into staging 
                        app.models.Tb_foster_care_rate_stg.create(request).then(data1 => {
                            insertCounty_fcrate(data1, request)
                            
                        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
                    })
                    .catch(err => {
                        LOGGER.error(err);
                        throw err;
                    })
                return res;
            });
        }
    };

    function insertCounty_fcrate(data1, request){
        var response = JSON.parse(JSON.stringify(data1));
        //@TM: Insert County IDs into reference table - if differential amt is entered, use stg rate_id as reference
        var countyIds = response.countyidlist ? response.countyidlist : null;
        if (countyIds && Array.isArray(countyIds)) {
            countyIds.forEach(data2 => {
                request.stg_rate_id = request.rate_id;
                request.county_id = data2.county_id;
                app.models.County_fcrate.create(request).then(r => {
                    return r;
                }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
            });
        }
    }

      Tb_foster_care_rate.list = (request) => {
        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;

        var sql= 'select * from getfostercareratelist($1,$2,$3,$4,$5)';
        return util.executeSecondaryNodeDBQuery(sql,[request.where.rateid, pagesize, pageno,request.where.sortcolumn,request.where.sortorder])
            .then(data => {
                if (data!==null && data.length>0)
                    {totalcount= data[0].totalcount;
                    
                }
                var result;
                result = {
                    'data' : data,
                    'count' : totalcount,
                    
                };
                return result;
            })
            .then(data => { return data; })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });                  
    };
    
    Tb_foster_care_rate.remoteMethod('list', {
        accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
        source : 'query'
        },
        required : true
        },
        http : {
        path: '/list',
        verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
        });

    //@TM: Get history for a given rate id
    Tb_foster_care_rate.hist = (request) => {
        const pageno = request.page;
        const pagesize = request.limit;
        var totalcount = 0;

        var sql= 'select * from getfostercareratehist($1,$2,$3,$4,$5)';
        return util.executeDBQuery(sql,[request.where.mainrateid, pagesize, pageno,request.where.sortcolumn,request.where.sortorder])
    .then(data => {
                    if (data!==null && data.length>0) {
                        totalcount= data[0].totalcount;
                    }
                    var result;
                    result = {
                        'count' : totalcount,
                        'data' : data,
                    };
                    return result;
    })
    .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
    };
    
    Tb_foster_care_rate.remoteMethod('hist', {
        accepts : {
        arg : 'filter',
        type : 'Object',
        http : {
        source : 'query'
        },
        required : true
        },
        http : {
        path: '/hist',
        verb : 'get'
        },
        returns : {
        type : 'Object',
        root : true
        }
    });
        
    Tb_foster_care_rate.deletePayment = function(request, reqctx) {  
        let _securityusersid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  _securityusersid = reqctx.req.headers.securityusersid;
		}  
		
        return Tb_foster_care_rate.updateAll({rate_id:request.rate_id}, {"delete_sw":"Y", update_user_id: request && request.securityuserid?request.securityuserid: _securityusersid}).then(data => {
            return data;
        }).catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });   
    };
    
    Tb_foster_care_rate.remoteMethod('deletePayment', {
        http: {
                path: '/deletePayment',
                verb: 'post'
        },
        accepts : [ {arg : 'data',type : 'object',
            http : {source : 'body'}}, {
                arg: 'reqctx',
                type: 'object',
                http: {
                  source: 'context'
                }
              }],
        returns: {
            type : 'string',
            root : true
        }
    });
    
    Tb_foster_care_rate.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Tb_foster_care_rate.observe('access', (ctx, next) => util.access(ctx, next));
    Tb_foster_care_rate.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

}
