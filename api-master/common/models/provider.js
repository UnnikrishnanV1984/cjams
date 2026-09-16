'use strict';
const LOGGER = require("log4js").getLogger("provider");
const util = require('../utils/utils');
var app = require('../../server/server');
var loopback = require('loopback');

module.exports = function(Provider) {

Provider.search=async (request, reqctx)=>{
    var _email=util.getSecurityDetails(request, reqctx).email;  
    var requestuserinfo = {'token': '', 'email': _email};
    let distanceToDest;
    var teamtype ;
    await util.getuserinfo(requestuserinfo).then (data => {
        teamtype = data.teamtypekey;
    });
    if(request.where.distance){
        distanceToDest = request.where.distance;}
    LOGGER.debug('MY REQUESTTTTTTTTTT ',request.where['from']);
    if(request.where['from']){
        var sql= 'select * from serviceplanprovidersearch_newwithrates($1)';
        return util.executeDBQuery(sql,[JSON.stringify(request.where)])
        .then(data => {
            return data;
        })
        .then(data => {
                let totalCount = 0;
                const serviceArray=[], fosterCareMinAge=[], fosterCareMaxAge=[], fosterCareMonthlyRate=[];
                const fosterCareStartDate=[], fosterCareEndDate=[], fosterCarePerDiemRate=[];                
                if (data.length > 0 ) {totalCount = data[0].totalcount;}
    
                //Added for Grouping Providers based on ID 
                const result = data.reduce(function (r, a) {
                    delete a.totalcount;
                    if(!r[a.providerid]){
                        serviceArray.length = 0;
                        fosterCareMaxAge.length = 0;
                        fosterCareMinAge.length = 0;
                        fosterCareMonthlyRate.length = 0;
                        fosterCarePerDiemRate.length = 0;
                        fosterCareStartDate.length = 0;
                        fosterCareEndDate.length = 0;
                    }
                    if(!serviceArray.includes(a.servicename)){
                        serviceArray.push(a.servicename);
                    }
                    fosterCareMinAge.push(a.fostercareminage);
                    fosterCareMaxAge.push(a.fostercaremaxage);
                    fosterCareMonthlyRate.push(a.fostercaremonthlyrate);
                    fosterCarePerDiemRate.push(a.fostercareperdiemrate);
                    fosterCareStartDate.push(a.fostercarestartdate);
                    fosterCareEndDate.push(a.fostercareenddate);                
                    a['services'] = serviceArray;
                    a['fosterCareMinAge'] = fosterCareMinAge;
                    a['fosterCareMaxAge'] = fosterCareMaxAge;
                    a['fosterCareMonthlyRate'] = fosterCareMonthlyRate;
                    a['fosterCarePerDiemRate'] = fosterCarePerDiemRate;
                    a['fosterCareStartDate'] = fosterCareStartDate;
                    a['fosterCareEndDate'] = fosterCareEndDate;
                    r[a.providerid] = a;                
                    return r;
                }, Object.create(null));
        
                return {count: totalCount, data: Object.values(result)};
            })
        .catch(err => {
            LOGGER.error(err);
            return err;
        })
    } else {
        
            return getServiceplanprovidersearch(request, teamtype, distanceToDest);
    }
    
}

	function getServiceplanprovidersearch(request, teamtype, distanceToDest) {
		var sql = 'select * from serviceplanprovidersearch($1)';
		return util.executeDBQuery(sql,[JSON.stringify(request.where)])
			.then(data => {
				return data;
			})
			.then(data => {
				let totalCount = 0;
				if (data.length > 0) { totalCount = data[0].totalcount; }
				if (teamtype === "AS") {

					data.forEach(x => {
						var source = new loopback.GeoPoint({ lat: 39.5353803,lng: -76.3530285 });
						var destination = new loopback.GeoPoint({ lat: x.latitude,lng: x.longitude });
						const distance = source.distanceTo(destination,{ type: 'miles' });
						x.distance = distance;
					});

					if (distanceToDest) {
						const filteredProviders = data.filter(x => x.distance <= distanceToDest);

						return { count: filteredProviders.length,data: filteredProviders };
					}
					else {
						return { count: totalCount,data: data };
					}
				}
				else {
					return { count: totalCount,data: data };
				}

			})
			.catch(err => {
				LOGGER.error(err);
				return err;
			})
	}
 


    Provider.remoteMethod(
        'search', 
             {
             http: {
                   path: '/search',
                   verb: 'post'
             },
             accepts : [ {arg : 'data',type : 'Object',
                    http : {source : 'body'}}, 
                    {arg: 'reqctx', type: 'object',
			        http: {source: 'context'}}],
             returns: {
                  type : 'object',
                        root : true
             }
             }
    );
 

    Provider.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Provider.observe('access', (ctx, next) => util.access(ctx, next));
    Provider.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));
};