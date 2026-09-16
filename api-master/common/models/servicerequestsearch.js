'use strict';
const LOGGER = require("log4js").getLogger("servicerequestsearch");
var server = require('../../server/server');
const util = require('../utils/utils');
var config = require('../../server/config.json');
const usersservicerequestsql = 'select * from usersservicerequest($1,$2,$3,$4,$5,$6,$7,$8)';
const limitsql = ' LIMIT 10 OFFSET ' ; 

module.exports = function (Servicerequestsearch) {
	Servicerequestsearch.usersservicerequest = function (data, reqctx) {
		try {
			const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
			var { filtervalue, filtercol, actiontype, foldertypekey, status } = handleFilterActionFn(data);

			var v_pagenumber = parseInt(data.page) - 1;
			var v_pageoffset = v_pagenumber * 10;

			//sql injection checking
			var sortColumns = ['servicerequestnumber', 'srtype', 'srsubtype', 'focusname', 'legalguardian', 'datereceived', 'approvaldate', 'intakedaterecieved'];
			var sortDirections = ['asc', 'desc'];

			var sql1 = typeof usersservicerequestsql !== 'undefined' ? usersservicerequestsql : '';
			if (data.where && data.where.totalNumber) {
				sql1 = 'select servicerequestnumber as CASE_NUMBER, srtype as TYPE, srsubtype as SUB_TYPE, focusname as FOCUS, legalguardian as LEGAL_GUARDIAN, to_char(datereceived,\'MM/dd/yyyy hh:mm:ss\') as RECEIVED_DATE_TIME, to_char(datereceived,\'MM/dd/yyyy hh:mm:ss\') as START_DATE_TIME, to_char(approvaldate,\'MM/dd/yyyy hh:mm:ss\') as ACCEPTED_DATE_TIME, open_closed as STATUS, county as JURISDICTION from usersservicerequest($1,$2,$3,$4,$5,$6,$7,$8)';
			}

			if (data.where && data.where.sort && data.where.sort.active && data.where.sort.direction &&
				sortColumns.includes(data.where.sort.active) && sortDirections.includes(data.where.sort.direction)) {
				sql1 = sql1 + ' ORDER BY ' + data.where.sort.active + ' ' + data.where.sort.direction;
			}

			const sanitizedTotalNumber = parseInt(data.where?.totalNumber, 10) || 10;
			const sanitizedOffset = parseInt(v_pageoffset, 10) || 0;
			sql1 = sql1 + ' LIMIT $9 OFFSET $10';

			const params = [suserid, data.page, data.limit, filtervalue, filtercol, actiontype, foldertypekey, status, sanitizedTotalNumber, sanitizedOffset];

			// Call the data fetching method strictly relying on its returned Promise
			const resultPromise = getuserservicerequest(sql1, params, data);

			if (resultPromise && typeof resultPromise.catch === 'function') {
				return resultPromise.catch(err => {
					LOGGER.error('Error in getuserservicerequest:', err);
					throw err;
				});
			}

			return resultPromise;

		} catch (err) {
			LOGGER.error('Synchronous error in usersservicerequest:', err);
			return Promise.reject(err);
		}
	};

	function getuserservicerequest(sql, params, data) {
		let Totalcount = 0;
		let showCount = false;
		if (data.page === 1) {
			showCount = true ;
		   }
		return connectDbAndExecute(sql,params)
			.then(data1 => {
				if (data1.length > 0) { Totalcount = data1[0].totalcount; }
				let result = JSON.parse(JSON.stringify(data1));
				result.forEach(x => {
					delete x.totalcount;
				});
				if (showCount) {
					result = {
						'data': result,
						'count': Totalcount
					};
				}
				else {
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
	}

	function connectDbAndExecute(sqlQuery, data){
		// Secondry node connectoin - handled by util.executeSecondaryNodeDBQuery
		return util.executeSecondaryNodeDBQuery(sqlQuery, data)
        .then(results => results)
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

	Servicerequestsearch.arcaselist = function (data,reqctx) {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;

		var filtercol = '';
		var filtervalue = '';
		var obj = data.where;
		var actiontype = "AR";
		var status = "";
		var foldertypekey ='';
		
		if (util.isNullorEmpty(data.where.status)) {
			status = data.where.status;
		} 

	if (obj != null && obj != undefined) { 
					if (Object.keys(obj)[0].toLowerCase() != "activeflag") {
						filtercol = Object.keys(obj)[0];
						var obj1 = obj[Object.keys(obj)[0]];
						if (obj1 != null && obj1 != undefined) {
					 
							filtervalue = obj1;
						}
					}
				}

		if (data.page === 1) {
			 showCount = true 
		}/*  else { showCount = false }; */				//SonarQube fix - commented as showCount is already set to false above
 
		var sql1 = usersservicerequestsql;

		return util.executeDBQuery(sql1, [suserid, data.page,
			data.limit, filtervalue, filtercol, actiontype, foldertypekey,
			 status])
		.then(data2 => {
			if (data2.length > 0) {Totalcount = data2[0].totalcount;}

			var result = JSON.parse(JSON.stringify(data2));
			result.forEach(x => {
				delete x.totalcount;
			});
			if (showCount) {
				result = {
					'data': result,
					'count': Totalcount
				};
			}
			else {
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
	
	Servicerequestsearch.remoteMethod('arcaselist', {
		accepts:[ {
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/arcaselist'
		},
		returns: {
			type: 'object',
			root: true
		}
	});
Servicerequestsearch.ircaselist = function (data,reqctx) {
	const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;

		var filtercol = '';
		var filtervalue = '';
		var obj = data.where;
		var actiontype = "IR";
		var status = "";
		var foldertypekey ='';

		
		if (util.isNullorEmpty(data.where.status)) {
			status = data.where.status;
		} 

	if (obj != null && obj != undefined) { 
					if (Object.keys(obj)[0].toLowerCase() != "activeflag") {
						filtercol = Object.keys(obj)[0];
						var obj1 = obj[Object.keys(obj)[0]];
						if (obj1 != null && obj1 != undefined) {
					 
							filtervalue = obj1;
						}
					}
				}

		if (data.page === 1) { 
			showCount = true;
		} /* else { showCount = false }; */						//SonarQube fix - commented as showCount is already set to false above
 
		var sql1 = usersservicerequestsql;
		return util.executeDBQuery(sql1, [suserid, data.page,
			data.limit, filtervalue, filtercol, actiontype, foldertypekey,
			 status])
		.then(data3 => {
			if (data3.length > 0) {Totalcount = data3[0].totalcount;}

			var result = JSON.parse(JSON.stringify(data3));
			result.forEach(x => {
				delete x.totalcount;
			});
			if (showCount) {
				result = {
					'data': result,
					'count': Totalcount
				};
			}
			else {
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
	
	Servicerequestsearch.remoteMethod('ircaselist', {
		accepts: [{
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/ircaselist'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.pendingreviewdalist = function (data,reqctx) {
		let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
		var Totalcount = 0;
		var showCount = false;

		if (data.page === 1) {
			showCount = true;
		}

		var sql1 = 'select * from getpendingreviewda($1,$2,$3,$4)';
		var params = [data && data.securityuserid?data.securityuserid:suserid, data.page,
		data.limit, null];

		return util.executeDBQuery(sql1, params)
			.then(data4 => {
				if (data4.length > 0) {Totalcount = data4[0].totalcount;}
				var result = JSON.parse(JSON.stringify(data4));
				result.forEach(x => {
					delete x.totalcount;
				});
				if (showCount) {
					result = {
						'data': result,
						'count': Totalcount
					};
				}
				else {
					result = {
						'data': result
					};
				}
				return result;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};
	Servicerequestsearch.closeddalist = function (data,reqctx) {
		let suserid = undefined;
    if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
      suserid = reqctx.req.headers.securityusersid
    } 
		var Totalcount = 0;
		var showCount = false;

		if (data.page === 1) {
			showCount = true;
		}

		var sql1 = 'select * from getclosedda($1,$2,$3)';
		var params = [data && data.securityuserid?data.securityuserid:suserid, data.page,
		data.limit];

		return util.executeDBQuery(sql1, params)
			.then(data5 => {
				if (data5.length > 0) {Totalcount = data5[0].totalcount;}
				var result = JSON.parse(JSON.stringify(data5));
				result.forEach(x => {
					delete x.totalcount;
				});
				if (showCount) {
					result = {
						'data': result,
						'count': Totalcount
					};
				}
				else {
					result = {
						'data': result
					};
				}
				return result;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Servicerequestsearch.getDetails = function (data) {
		const userid = server.currentUser.id;
		var Totalcount = 0;
		var showCount = false;
		var statusObj = [];
		if (data.page === 1) { 
			showCount = true;
		}
		var newJsonStructure = data.where;
		newJsonStructure["pagenumber"] = data.page;
		newJsonStructure["pagesize"] = data.limit;

		if (newJsonStructure.status != null) {
			for (const element of newJsonStructure.status) {
				var statObj = { "Status": element };
				statusObj.push(statObj);
			}
		}
		newJsonStructure["status"] = statusObj;
		if (newJsonStructure.srtype != null) {
			for (var j = 0; j < newJsonStructure.srtype.length; j++) {
				newJsonStructure["srtype_" + (j + 1)] = newJsonStructure.srtype[j];
			}
		}
		newJsonStructure["userid"] = userid;

		if (showCount) {
			var countQuery = 'select * from servicerequestsearch_cnt(\'' + JSON.stringify(newJsonStructure) + '\')';
			return util.executeDBQuery(countQuery,[])
			.then(data1 => {
				Totalcount = data1[0].servicerequestsearch_cnt;
					if (Totalcount > 0) {
						var sql = 'select * from servicerequestsearch(\'' + JSON.stringify(newJsonStructure) + '\')';
						return util.executeDBQuery(sql,[])
						.then(data2 => {
							var result;
							result = {
								'data': data2,
								'count': Totalcount
							};
							return result;
						})
						.catch(err => {
							LOGGER.error(err);
							throw err;
						})
					} else {
						var result1;
						result1 = {
							'data': [],
							'count': Totalcount
						};
						return result1;
					}
			})
			.catch(err => {
				LOGGER.error(err);
				throw err;
			})
		} else {
			var sql1 = 'select * from servicerequestsearch(\'' + JSON.stringify(newJsonStructure) + '\')';
			return util.executeDBQuery(sql1,[])
			.then(data3 => {
				var result2;
					result2 = {
						'data': data3
					};
					return result2;
			})
			.catch(err => {
				LOGGER.error(err);
				throw err;
			})
		}
	}

	Servicerequestsearch.remoteMethod(
		'getDetails',
		{
			http: {
				path: '/getDetails',
				verb: 'post'
			},
			accepts: [{
				arg: 'data', type: 'object',
				http: { source: 'body' }
			}],
			returns: {
				type: 'object',
				root: true
			}
		}
	);




	Servicerequestsearch.remoteMethod('usersservicerequest', {
		accepts:[ {
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
		http: {
			'verb': 'get',
			'path': '/usersservicerequest'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.remoteMethod('pendingreviewdalist', {
		accepts:[ {
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/pendingreviewdalist'
		},
		returns: {
			type: 'object',
			root: true
		}
	});
	Servicerequestsearch.remoteMethod('closeddalist', {
		accepts: [{
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/closeddalist'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.usersservicerequestclw = function (data,reqctx) {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;

		
		var obj = data.where;
		var actiontype = "";
		var sortcolumn = data.where.sortcolumn;
		var sortorder = data.where.sortorder;

		if (sortorder == null || sortorder == undefined) {sortorder = "asc";}
		if (sortcolumn == null || sortcolumn == undefined) {
			sortcolumn = "intakenumber";
			sortorder = "desc";
		}

		if (data.where.actiontype != null && data.where.actiontype != undefined) {
			actiontype = data.where.actiontype;
		}
		const fVal =  filterItems(obj, 'clw');
		const filtercol = fVal.filtercol;
		const filtervalue = fVal.filtervalue;
		
		
		if (data.page === 1) { 
			showCount = true;
		}

		var sql1 = 'select * from usersservicerequestclw($1,$2,$3,$4,$5,$6,$7,$8)';
		return util.executeDBQuery(sql1, [suserid, data.page,
			data.limit, filtervalue, filtercol, actiontype, sortcolumn, sortorder])
		.then(data6 => {
			if (data6.length > 0) {Totalcount = data6[0].totalcount;}
			var result = JSON.parse(JSON.stringify(data6));
			result.forEach(x => {
				delete x.totalcount;
			});
			if (showCount) {
				result = {
					'data': result,
					'count': Totalcount
				};
			}
			else {
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

	function filterItems(obj, type){
		let filtercol = '';
		let filtervalue = '';
		if (obj !== null && obj !== undefined) {

			if (Object.keys(obj)[0].toLowerCase() !== "activeflag") {
				filtercol = Object.keys(obj)[0];
				const obj1 = obj[Object.keys(obj)[0]];
				if (obj1 !== null && obj1 !== undefined) {
					filtervalue = type === 'clw' ? obj1[Object.keys(obj1)[0]] : obj1;
				}
			}
		}
		return {
			filtercol,
			filtervalue
		}
	}

	Servicerequestsearch.remoteMethod('usersservicerequestclw', {
		accepts:[ {
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  }],
		http: {
			'verb': 'get',
			'path': '/usersservicerequestclw'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.usersservicerequestfolders = function (data,reqctx) {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;
		if (data.where.searchkey == null || data.where.searchkey == undefined) {data.where.searchkey = null;}
		var searchkey = data.where.searchkey;
		if (data.where.foldertypekey == null || data.where.foldertypekey == undefined) {data.where.foldertypekey = null;}
		var foldertypekey = data.where.foldertypekey;

		if (data.page === 1) {
			showCount = true
		}

		var sql1 = 'select * from usersservicerequestfolders($1,$2,$3,$4,$5)';
		var params = [suserid, data.page,
		data.limit, foldertypekey, searchkey];

		return util.executeDBQuery(sql1, params)
			.then(data7 => {
				if (data7.length > 0) {Totalcount = data7[0].totalcount;}
				var result = JSON.parse(JSON.stringify(data7));
				result.forEach(x => {
					delete x.totalcount;
				});
				if (showCount) {
					result = {
						'data': result,
						'count': Totalcount
					};
				}
				else {
					result = {
						'data': result
					};
				}
				return result;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	Servicerequestsearch.remoteMethod('usersservicerequestfolders', {
		accepts:[ {
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/usersservicerequestfolders'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.remoteMethod('getservicecase', {
		accepts: [{
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/getservicecase'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.getservicecase = (data,reqctx) => {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;

		if (data.page === 1) { 
			showCount = true 
		}
    	var	v_pagenumber = parseInt(data.page) - 1;
		var v_pageoffset = v_pagenumber * 10;
				
		//sql injection checking
		var sortColumns = ['servicecasenumber', 'legalguardian', 'programarea', 'startdate', 'enddate','open_closed'];
		var sortDirections = ['asc','desc'];

		var sql1 = 'select * from getservicecase($1,$2,$3,$4,$5,$6)';
		if(data.where.totalNumber){
			sql1 = 'select servicecasenumber as CASE_NUMBER,legalguardian->0->>\'personname\' AS LEGAL_GUARDIAN,programarea->0->>\'programname\' AS PROGRAM_AREA,to_char(startdate,\'MM/dd/yyyy hh:mm:ss\') as START_DATE_TIME ,to_char(enddate,\'MM/dd/yyyy hh:mm:ss\') as END_DATE_TIME ,open_closed AS STATUS, county as JURISDICTION, responsibilitytypekey as Assignment_Type from getservicecase($1,$2,$3,$4,$5,$6)';

		}
		if(data.where  && data.where.sort && data.where.sort.active &&  data.where.sort.direction && sortColumns.includes(data.where.sort.active) && sortDirections.includes(data.where.sort.direction)) {
			if("legalguardian" === data.where.sort.active){
				sql1 = sql1 + 'ORDER BY legalguardian->0->>\'personname\'' + ' '+data.where.sort.direction;
			} else if("programarea" === data.where.sort.active){
				sql1 = sql1 + 'ORDER BY programarea->0->>\'subprogramname\'' + ' '+data.where.sort.direction;
			} else {
				sql1 = sql1 + ' ORDER BY '+ data.where.sort.active + ' '+data.where.sort.direction;
			}

		}
		const sanitizedTotalNumber = parseInt(data.where.totalNumber, 10) || 10;
		const sanitizedOffset = parseInt(v_pageoffset, 10) || 0;
		sql1 = sql1 + ' LIMIT $7 OFFSET $8';

		return connectDbAndExecute(sql1, [suserid, data.page,
			data.limit, data.where.servicerequestnumber, data.where.status, data.where.currentrole, sanitizedTotalNumber, sanitizedOffset])
		.then(data8 => {
			if (data8.length > 0) {Totalcount = data8[0].totalcount;}
			var result = JSON.parse(JSON.stringify(data8));
			result.forEach(x => {
					delete x.totalcount;
			});
		    
			if (showCount) {
				result = {
					'data': result,
					'count': Totalcount
				};
			} else {
				result = {
					'data': result
				};
			}
			return result;
		})
		.catch(err => {
			LOGGER.error(err);
			return err;
		});
	};


	Servicerequestsearch.remoteMethod('getservicecpscase', {
		accepts: [{
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/getservicecpscase'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.getservicecpscase = function (data,reqctx) {
		let suserid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  suserid = reqctx.req.headers.securityusersid
		}
		var Totalcount = 0;
		var showCount = false;
		if (data.page === 1) {
			showCount = true
		}
		var sql1 = 'select * from sp_service_cps($1,$2,$3,$4,$5,$6)';
		var params = [data && data.securityuserid?data.securityuserid:suserid, data.page,
			data.limit, data.where.status,data.where.servicecase,data.where.cpscase];

		return util.executeDBQuery(sql1, params)
			.then(data9 => {
				if (data9.length > 0) {Totalcount = data9[0].totalcount;}
				var result = JSON.parse(JSON.stringify(data9));
				result.forEach(x => {
					delete x.totalcount;
				});
				if (showCount) {
					result = {
						'data': result,
						'count': Totalcount
					};
				} else {
					result = {
						'data': result
					};
				}
				return result;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};
	Servicerequestsearch.remoteMethod('getadoptioncase', {
		accepts:[ {
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/getadoptioncase'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.getadoptioncase = function (data,reqctx) {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;
		
		if (data.page === 1) {
			showCount = true;
		 }
		var casenumber='';
		if (util.isNullorEmpty(data.where.casenumber)) {
			casenumber = data.where.casenumber;			
		}
		
		if (data.where.status == '' || data.where.status == undefined) {data.where.status = null;}

		const sql1 = getAdoptionQuery(data);

		return connectDbAndExecute(sql1, [suserid, casenumber,data.page,
			data.limit,data.where.status,data._sanitizedLimit,data._sanitizedOffset])
		 .then(data10 => {
			if (data10.length > 0) {Totalcount = data10[0].totalcount;}
			var result = JSON.parse(JSON.stringify(data10));
			result.forEach(x => {
				delete x.totalcount;
			});
			if (showCount) {
				result = {
					'data': result,
					'count': Totalcount
				};
			} else {
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

	function getAdoptionQuery(data){
		const	v_pagenumber = parseInt(data.page) - 1;
		const v_pageoffset = v_pagenumber * 10;
		let sql1 = 'select * from getadoptioncase($1,$2,$3,$4,$5)';
		if(data.where.totalNumber) {
            sql1 = 'select adoptioncasenumber as CASE_NUMBER,childdetails->0->>\'personname\' as CHILD_NAME,to_char(startdate,\'MM/dd/yyyy hh:mm:ss\') as START_DATE_TIME,to_char(enddate,\'MM/dd/yyyy hh:mm:ss\') as END_DATE_TIME,statustypekey as STATUS from getadoptioncase($1,$2,$3,$4,$5)';
		}

		if(data.where && data.where.sort && data.where.sort.active &&  data.where.sort.direction) {
			if("childdetails" === data.where.sort.active){
				sql1 = sql1 + 'ORDER BY childdetails->0->>\'personname\'' + ' '+data.where.sort.direction;
			} else {
                sql1 = sql1 + ' ORDER BY '+ data.where.sort.active + ' '+data.where.sort.direction;
			}

		}

		const sanitizedTotalNumber = parseInt(data.where.totalNumber, 10) || 10;
		const sanitizedOffset = parseInt(v_pageoffset, 10) || 0;
		sql1 = sql1 + ' LIMIT $6 OFFSET $7';
		// Store sanitized values for caller to pass as parameters
		data._sanitizedLimit = sanitizedTotalNumber;
		data._sanitizedOffset = sanitizedOffset;
		return sql1;
	}

	Servicerequestsearch.remoteMethod('usersservicerequestwithrestricteduser', {
		accepts: [{
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/usersservicerequestwithrestricteduser'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.usersservicerequestwithrestricteduser = function (data,reqctx) {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;

		var obj = data.where;
		var actiontype = "";
		var status = "";
		if (data.where.actiontype != null && data.where.actiontype != undefined) {
			actiontype = data.where.actiontype;
		}
		if (data.where.status != null && data.where.status != undefined) {
			status = data.where.status;
		}
		const fVal =  filterItems(obj, 'restricteduser');
		const filtercol = fVal.filtercol;
		const filtervalue = fVal.filtervalue;

		if (data.where.foldertypekey == null || data.where.foldertypekey == undefined) {data.where.foldertypekey = null;}
		var foldertypekey = data.where.foldertypekey;

		if (data.page === 1) {
			showCount = true;
		}

		var sql1 = 'select * from usersservicerequestwithrestricteduser($1,$2,$3,$4,$5,$6,$7,$8)';
		var params = [suserid, data.page,
		data.limit, filtervalue, filtercol, actiontype, foldertypekey, status];

		return util.executeDBQuery(sql1, params)
			.then(data11 => {
				if (data11.length > 0) {Totalcount = data11[0].totalcount;}
				var result = JSON.parse(JSON.stringify(data11));
				result.forEach(x => {
					delete x.totalcount;
				});
				if (showCount) {
					result = {
						'data': result,
						'count': Totalcount
					};
				} else {
					result = {
						'data': result
					};
				}
				return result;
			})
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});

	};

	
	Servicerequestsearch.remoteMethod('myCaseSearch', {
		accepts: [{
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/myCaseSearch'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.myCaseSearch = function (data,reqctx) {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;

		var filtercol = '';
		var filtervalue = '';
		
		var obj = data.where;
		var actiontype = "";
		var status = "";
		if (data.where.actiontype != null && data.where.actiontype !== undefined) {
			actiontype = data.where.actiontype;
		}
		if (data.where.status != null && data.where.status !== undefined) {
			status = data.where.status;
		}
		if (obj.servicerequestnumber) {
			filtervalue = obj.servicerequestnumber;
		}

		if(obj.workername) {
			filtercol = obj.workername;
		}

		if (data.where.foldertypekey == null || data.where.foldertypekey == undefined) {data.where.foldertypekey = null;}
		var foldertypekey = data.where.foldertypekey;

		if (data.page === 1) { 
			showCount = true 
		}
		
		var sql1 = 'select * from mycasesearch($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)';
		return connectDbAndExecute(sql1, [suserid, data.page,
			data.limit, filtervalue, data.sortorder, data.sortcolumn, filtercol, actiontype, foldertypekey, status])
		.then(data12 => {
			if (data12.length > 0) {Totalcount = data12[0].totalcount;}
			var result = JSON.parse(JSON.stringify(data12));
			if (showCount) {
				result = {
					'data': result,
					'count': Totalcount
				};
			} else {
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

	Servicerequestsearch.remoteMethod('myexpungedcasesearch', {
		accepts: [{
			arg: 'data',
			type: 'object',
			required: true,
			http: { source: 'query' }
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			'verb': 'get',
			'path': '/myexpungedcasesearch'
		},
		returns: {
			type: 'object',
			root: true
		}
	});

	Servicerequestsearch.myexpungedcasesearch = function (data,reqctx) {
		const suserid = util.getSecurityDetails(data, reqctx).securityuserid;
		var Totalcount = 0;
		var showCount = false;

		var filtercol = '';
		var filtervalue = '';
		
		var obj = data.where;
		var actiontype = "";
		var status = "";
		if (data.where.actiontype != null && data.where.actiontype !== undefined) {
			actiontype = data.where.actiontype;
		}
		if (data.where.status != null && data.where.status !== undefined) {
			status = data.where.status;
		}
		if (obj.servicerequestnumber) {
			filtervalue = obj.servicerequestnumber;
		}

		if(obj.workername) {
			filtercol = obj.workername;
		}

		if (data.where.foldertypekey == null || data.where.foldertypekey == undefined) {data.where.foldertypekey = null;}
		var foldertypekey = data.where.foldertypekey;

		if (data.page === 1) { 
			showCount = true 
		}
		
		var sql1 = 'select * from mycasesearch_expunge($1,$2,$3,$4,$5,$6,$7,$8,$9,$10)';
		return connectDbAndExecute(sql1, [suserid, data.page,
			data.limit, filtervalue, data.sortorder, data.sortcolumn, filtercol, actiontype, foldertypekey, status])
		.then(data12 => {	// NOSONAR
			if (data12.length > 0) {Totalcount = data12[0].totalcount;}
			var result = JSON.parse(JSON.stringify(data12));
			if (showCount) {
				result = {
					'data': result,
					'count': Totalcount
				};
			} else {
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


	Servicerequestsearch.remoteMethod('getappeal', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			verb: 'get'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	Servicerequestsearch.getadoptionorgapreport = (request,reqctx) => {
		let suserid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
			suserid = reqctx.req.headers.securityusersid
		}
		const sql = 'select * from getadoptionorgapreportbyuser($1,$2,$3,$4)';
		const params = [request && request.securityuserid?request.securityuserid:suserid, request.page, request.limit, request.where.filterdatetype];
		return util.executeDBQuery(sql, params)
			.then(data => data)
			.catch(err => {
				LOGGER.error('>>>>ERROR:', err);
				throw err;
			});
	};

	Servicerequestsearch.remoteMethod('getadoptionorgapreport', {
		accepts: [{
			arg: 'filter',
			type: 'Object',
			http: {
				source: 'query'
			},
			required: true
		},{
			arg: 'reqctx',
			type: 'object',
			http: {source: 'context'}
		  } ],
		http: {
			verb: 'get'
		},
		returns: {
			type: 'string',
			root: true
		}
	});

	Servicerequestsearch.getappeal = (request,reqctx) => {
		let suserid = undefined;
		if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
		  suserid = reqctx.req.headers.securityusersid
		} 
		var pageno = request.page;
		var pagesize = request.limit;
	 
		var obj = request.where;
		var servicerequestnumber = obj.servicerequestnumber;
		var focusname = obj.focusname;
		var sortcolumn = obj.sort.active;
		var sortdirection = obj.sort.direction;
		var actionstatus = obj.currentStatus;

		const sql = 'select * from getappealdashboard($1,$2,$3,$4,$5,$6,$7,$8)';
		const params = [request && request.securityuserid?request.securityuserid:suserid,pageno, pagesize,servicerequestnumber,focusname, sortdirection, sortcolumn, actionstatus];
		return util.executeDBQuery(sql, params).then(resp => resp)
			.catch(err => err);
	}


	Servicerequestsearch.observe('before save', (ctx, next) => util.beforesave(ctx, next));
	Servicerequestsearch.observe('access', (ctx, next) => util.access(ctx, next));
	Servicerequestsearch.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};

function handleFilterActionFn(data) {
	let filtercol = '';
	let filtervalue = '';

	var { obj, actiontype, status } = returnObjActionStatusFn(data);

	if (util.isNullorEmpty(obj) && Object.keys(obj).length > 0) {
		let firstKey = Object.keys(obj)[0];
		if (firstKey && firstKey.toLowerCase() !== "activeflag") {
			filtercol = 'servicerequestnumber';
			if (obj.servicerequestnumber) {
				filtervalue = obj.servicerequestnumber;
			}
		}
	}

	if (!data.where || data.where.foldertypekey == null || data.where.foldertypekey == undefined) {
		if (data.where) {
			data.where.foldertypekey = null
		}
	}
	var foldertypekey = data.where ? data.where.foldertypekey : null;
	return { filtervalue, filtercol, actiontype, foldertypekey, status };
}
function returnObjActionStatusFn(data) {
	var obj = data.where || {};
	var actiontype = "";
	var status = "";

	if (data.where && util.isNullorEmpty(data.where.actiontype)) {
		actiontype = data.where.actiontype;
	}
	if (data.where && util.isNullorEmpty(data.where.status)) {
		status = data.where.status;
	}
	return { obj, actiontype, status };
}

