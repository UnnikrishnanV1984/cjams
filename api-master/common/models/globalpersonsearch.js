'use strict';
const LOGGER = require("log4js").getLogger("globalpersonsearch");
var server = require('../../server/server');
const dateTime = require('date-time');
const util = require('../utils/utils');
var https = require('https');
const axios = require('axios');
var config = require('../../server/config.json');
const _ = require('lodash');
const commonapi = require('../models/commonapi');

// Short term private caching solution. shared/distributed cache is better for this application, redis or memcached
// It will take a long time to get state to setup the shared cache so this will do for now.
// Because this is a short term fix, I intentionally did not setup a cache service.
const NodeCache = require( "node-cache" );
const ttlSeconds = 3 * 60 * 1; // cache for 3 mins: keep short because it's specific to a search criteria. No need to persist for very long.
const searchCache = new NodeCache({ stdTTL: ttlSeconds, checkperiod: ttlSeconds * 0.2, useClones: true });

// True when the search is address-driven without a full name, which is the case
// the result sort treats specially.
function addressCheck(data) {
	if ((data.where.address1 &&  data.where.address1 != null) ||
		(data.where.address2 &&  data.where.address1 != null) ||
		(data.where.city &&  data.where.city != null) ||
		(data.where.zip  &&  data.where.zip != null) ||
		(data.where.stateid &&  data.where.stateid != null)) {
		if  ( !(data.where.firstname &&  data.where.lastname && data.where.middlename)) {
			return true;
		}

	}
	return false;
}

function returnSortParamsFn(data) {
	const sortParams = {};
	if (data.where.sortcolumn) {
		sortParams['order'] = (data.where.sortorder) ? data.where.sortorder : 'asc';
		sortParams['column'] = data.where.sortcolumn;
	} else {
		//default sort, front end always passes sortorder key but not sortcolumn
		sortParams['column'] = 'exactmatch';
		sortParams['order'] = 'desc';
	}

	sortParams['address'] = addressCheck(data);
	return sortParams;
}

module.exports = function(Globalpersonsearch) {
	Globalpersonsearch.logsearchsdr =(request,requestid) =>{
		LOGGER.debug('>> ',request, requestid);
		var values = [];
		var query ='';
		requestid = parseInt(requestid);

			query = 'insert into sdrlog (requestid,typeofpayload,payload,insertedby,updatedby) values ($1,$2,$3,$4,$5)';
			values = [requestid,'request',request,'SDR log','SDR log'];

	   return util.executeDBQuery(query, values)
		.then(result => {
			LOGGER.debug('>>',result);
			return result;
		})
		.catch(err => {
			LOGGER.debug('<<>>', err);
			util.logError(err);
			throw err;
		});
	}

	function getEnhancedDetails(newJsonStructure, searchParam){ 	// NOSONAR
		let hasCjamspid = false;
		let t_cisID= '';
		let t_mdmID= '';
		let t_firstname='';
		let t_middlename='';
		let t_lastname='';
		let t_city='';
		let t_zip='';
		let t_address1='';
		let t_address2='';
		let t_state='';
		let t_phone='';
		let t_email='';
		let t_ssn='';
		let inputssn;
		let t_cjamspid;
		let t_dl='';
		let t_cjamsFlag;
		let t_deceased;

		let ssnflag = false;
		if(newJsonStructure.cjamspid){
			t_cjamspid = newJsonStructure.cjamspid;
			searchParam['es_cjams_pid'] = t_cjamspid;
			hasCjamspid = true;
		}
		if(newJsonStructure.cjisnumber){
			t_cisID=newJsonStructure.cjisnumber;
			searchParam['es_irn'] = lPad(t_cisID,9);
		}
		if(newJsonStructure.mdmId){
			t_mdmID=newJsonStructure.mdmId;
			searchParam['es_mdm_id'] = t_mdmID;
		}
		if(newJsonStructure.firstname){
			t_firstname=newJsonStructure.firstname;
			searchParam['es_first_name'] = t_firstname;
		}
		if(newJsonStructure.middlename){
			t_middlename=newJsonStructure.middlename;
			searchParam['es_middle_name'] = t_middlename;
		}
		if(newJsonStructure.lastname){
			t_lastname=newJsonStructure.lastname;
			searchParam['es_last_name'] = t_lastname;
		}
		if(newJsonStructure.dl){
			t_dl=newJsonStructure.dl;
			searchParam['es_driving_license_number'] = t_dl;
		}
		if(newJsonStructure.city){
			t_city=newJsonStructure.city;
			searchParam['es_city'] = t_city;
		}
		if(newJsonStructure.zip){
			t_zip=newJsonStructure.zip;
			searchParam['es_zip'] = t_zip;
		}
		if(newJsonStructure.address1){
			t_address1=newJsonStructure.address1;
			searchParam['es_address_line1'] = t_address1;
		}
		if(newJsonStructure.address2){
			t_address2=newJsonStructure.address2;
			searchParam['es_address_line2'] = t_address2;
		}
		if(newJsonStructure.state){
			t_state=newJsonStructure.state;
			searchParam['es_state'] = t_state;
		}
		if(newJsonStructure.phone){
			t_phone=newJsonStructure.phone;
			searchParam['es_phone_no'] = t_phone;
		}
		if(newJsonStructure.email){
			t_email=newJsonStructure.email;
			searchParam['es_email_address'] = t_email;
		}
		if(newJsonStructure.ssn){
			t_ssn=newJsonStructure.ssn;
			searchParam['es_ssn'] = t_ssn;
			ssnflag = true;
			inputssn = t_ssn;
		}
		if(newJsonStructure.es_cjamsFlag){
			t_cjamsFlag=newJsonStructure.es_cjamsFlag;
			searchParam['es_cjamsFlag'] = t_cjamsFlag;
		}
		if(newJsonStructure.es_include_deceased){
			t_deceased=newJsonStructure.es_include_deceased;
			searchParam['es_include_deceased'] = t_deceased;
		}
		searchParam = getGenderDetails(newJsonStructure, searchParam)

		return {
			hasCjamspid,
			ssnflag,
			inputssn,
			searchParam
		}
	}

	Globalpersonsearch.getPersonSearchDataR360 = function(data, reqctx) {
		const userid = util.getSecurityDetails(data, reqctx).securityuserid;
		// build cache key
		const keyObject = JSON.parse(JSON.stringify(data.where)); // deep copy
		delete keyObject.sortorder;
		delete keyObject.sortcolumn;

		return getEnhancedPersonSearchData(data, userid)
		.catch(_err => {
			LOGGER.error('>>>>ERROR:', _err);
			throw _err;
		});
	};

	async function getEnhancedPersonSearchData(data, userid) {
	let { where: newJsonStructure } = data || {};
	
	const selectedCodes = normalizeSelectedTypes(
		newJsonStructure?.searchtypes,
	  );
	// Base payload
	let searchParam = {
		es_pageNumber: newJsonStructure?.es_pageNumber,
		es_pageLength: newJsonStructure?.es_pageLength,
		es_sourceSystem: 'MDM',
		es_soundex_search: false,
		es_synonym_search: false,
		es_fuzzy_search: false,
	};
	searchParam.es_soundex_search = selectedCodes.has('SXM');
	searchParam.es_synonym_search = selectedCodes.has('SYN');
	searchParam.es_fuzzy_search   = selectedCodes.has('FZM');
	
	// Dates: MM/DD/YYYY → YYYY-MM-DD
	if (newJsonStructure.fromDate) {
		const [mm, dd, yyyy] = newJsonStructure.fromDate.split('/');
		searchParam.es_dob_from = `${yyyy}-${mm}-${dd}`;
	}
	if (newJsonStructure.toDate) {
		const [mm, dd, yyyy] = newJsonStructure.toDate.split('/');
		searchParam.es_dob_to = `${yyyy}-${mm}-${dd}`;
	}

	const params = getEnhancedDetails(newJsonStructure, searchParam);
	searchParam = params.searchParam;
	// Sonarcube
	const i = getSearchString(searchParam).index;

	const options = {
		url: config.personSearchConfig.enhancedurl,
		json: true,
		body: searchParam,
		headers: {
		cookie: config.personSearchConfig.cookie,
		role: config.personSearchConfig.role,
		uid: config.personSearchConfig.uid,
		'content-type': 'application/json',
		}
	};
	
	LOGGER.debug('Enhanced search request', { url: options.url, body: searchParam });
	
	if (i <= 4) return;
	
	// Insert external API log BEFORE the call so we always have an ID to update
	const externalapidataAdd = {
		details: {
		objectid: 'globalpersonsearch',
		objecttype: 'personsearch',
		objectsubtype: null,
		updatedby: userid,
		insertedby: userid,
		},
		resstatus: '',
		request: JSON.stringify(searchParam),
		response: null,
		status: 'add',
	};
	
	let v_externalapilogsid = null;
	try {
		v_externalapilogsid = await commonapi.addupdateexternalapilogs(externalapidataAdd);
	} catch (e) {
		LOGGER.error('Failed to insert external API log', { error: e && e.message });
	}
	try {
		const { statusCode, body, headers } = await postJson(options);
	
		if (statusCode !== 200) {
		// Include the API’s error payload for diagnostics
		const err = new Error(`Enhanced person search failed with status ${statusCode}`);
		err.statusCode = statusCode;
		err.url = options.url;
		err.requestBody = searchParam;
		err.responseBody = body;
		err.responseHeaders = headers;
	
		// Update log with detailed error
		await safeUpdateExternalApiLog({
			externalapilogsid: v_externalapilogsid,
			objecttype: 'personsearch',
			updatedby: userid,
			insertedby: userid,
		}, 'error', body);
	
		throw err;
		}
		const response_body = body && body.response ? body.response : body;
		// Success path
		await safeUpdateExternalApiLog({
		externalapilogsid: v_externalapilogsid,
		objecttype: 'personsearch',
		updatedby: userid,
		insertedby: userid,
		data: response_body
		}, 'success', 'success');
	
		return response_body;
	
	} catch (err) {	
		LOGGER.error('Enhanced person search HTTP error', {
		message: err.message,
		code: err.code,
		statusCode: err.statusCode,
		url: options.url,
		responseBody: err.responseBody,
		stack: err.stack,
		});
	
		// Update log with raw error 
		await safeUpdateExternalApiLog({
		externalapilogsid: v_externalapilogsid,
		objecttype: 'personsearch',
		updatedby: userid,
		insertedby: userid,
		}, 'error', err.responseBody || err.message);
	
		// Re-throw for LoopBack to handle
		throw err;
	}
	}
	/** Promise wrapper around request1.post that returns statusCode, body, headers */
	function postJson(opts) {
	return new Promise((resolve, reject) => {
		axios.post(opts.url, opts.body, {
			headers: opts.headers
		})
		.then((res) => {
			resolve({
				statusCode: res ? res.status : undefined,
                headers: res ? res.headers : undefined,
                body: res ? res.data : undefined
			});
		})
		.catch((err) => {
			err.code = err.code || 'REQUEST_ERROR';
			return reject(err);
		});
	});
	}
	  
	  /** Normalize multi-select to a Set of codes */
	  function normalizeSelectedTypes(searchtypes) {
		const set = new Set();
	  
		if (Array.isArray(searchtypes)) {
		  for (const it of searchtypes) {
			if (!it) continue;
			const code = (typeof it === 'string' ? it : it.ref_key || it.code || it.value || '').toUpperCase();
			if (code) set.add(code);
		  }
		}
	  
		set.add('EXM');	  
		return set;
	  }
	  
	
	/** Don’t let log update failures crash the main flow */
	async function safeUpdateExternalApiLog(details, resstatus, response) {
	try {
		await commonapi.addupdateexternalapilogs({
		details,
		info: null,
		status: 'update',
		resstatus,
		response,
		});
	} catch (e) {
		LOGGER.warn('Failed to update external API log', { error: e && e.message });
	}
}

	Globalpersonsearch.remoteMethod(
		'getPersonSearchDataR360',
		{
			http: {
				path: '/getEnhancedPersonSearchData',
				verb: 'post'
			},
			accepts: [{
				arg: 'data', type: 'object',
				http: { source: 'body' }
			},
			{
				arg: 'reqctx', type: 'object',
				http: { source: 'context' }
			}
			],
			returns: {
				type: 'object',
				root: true
			}
		}
	);

	Globalpersonsearch.getPersonSearchDataSDR = function(data, reqctx) {
		const userid = util.getSecurityDetails(data, reqctx).securityuserid;
		// build cache key
		const keyObject = JSON.parse(JSON.stringify(data.where)); // deep copy
		delete keyObject.sortorder;
		delete keyObject.sortcolumn;
		const key = JSON.stringify(keyObject);

		const pagination = {};
		pagination.gPageno = data.page;
		pagination.gLimit = data.limit;

		const sortParams = returnSortParamsFn(data);

		return new Promise((resolve, reject) => {
			searchCache.get(key, function (err, value) {
				LOGGER.debug("get search results", err);

				if (!err && value) {
					// found in cache
					LOGGER.debug("found in cache");

					// sort and paginate
					value.data = personSort(value.data, sortParams, pagination);

					resolve(util.encryptresponse(value));
				} else {
					// Not found in cache, get search records
					getPersonSearchData(data, userid)
					.then(result => {
						searchCache.set(key, result, function (err1, value1) {
							if (!err1 && value1) {
								LOGGER.debug("set in cache", key);
							}
						});


						// sort and paginate
						result.data = personSort(result.data, sortParams, pagination);

						resolve(util.encryptresponse(result));
					})
					.catch(_err => {
						LOGGER.error('>>>>ERROR:', _err);
						reject(_err);
					});

				}
			});
		});
	};

	// private function for padding irn numbers before SDR search
	function lPad(n, width) {
		const z = '0';
		n = n + '';
		return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
	}
	
	// private function for global search results sorting
	function personSort (data, sortParams, pagination) {
		// Sorting
		//make names sort case insensitive
		let sortColumn = sortParams.column;
		if (['firstname','middlename','lastname'].find(item => {return (item == sortParams.column); })) {
			sortColumn = function (person) { return (person[sortParams.column]) ? person[sortParams.column].toString().toLowerCase() : ''; };
		}
		// align search parameter with response
			if(sortColumn == 'gender') {sortColumn = 'gendertypekey';}
			
			LOGGER.debug('sorting ', sortColumn, sortParams.order);

			if(sortColumn === 'exactmatch'){
				data = sortParams.address ?  _.orderBy(data, 
					['exactmatch'],
					['desc']) : _.orderBy(data, 
						['rankno', 'dob', 'lastname', 'firstname', 'cjamspid'],
						['desc','asc', 'desc', 'desc', 'asc']); 
				}
			else{
				data = sortColumn === 'dob' ? _.sortBy(data, function(dateObj) {
					return sortParams.order === 'desc' ? (new Date(dateObj.dob)) * -1 : (new Date(dateObj.dob)) * 1; 
				  }) : _.orderBy(data, 
					[sortColumn],
					[sortParams.order]);
	}
			//Explicit Paging
			var startno = ((pagination.gPageno - 1) * pagination.gLimit);
			var endno = startno + pagination.gLimit;
			
			return data.slice(startno, endno);

		}
		
		// get data from local db and if in the state environment retrieve data from SDR webservice
		// data results are combined and then returned for later sorting and pagination
		async function  getPersonSearchData(data, userid){
			var tempRes = {};
			var ssnflag = false;
			var inputssn;
			
			
			var newJsonStructure = data.where;
			newJsonStructure["pagenumber"] = 1;
			newJsonStructure["pagesize"] = 1000;

		// not currently using max ranking code in display
		var maxRank;
		maxRank = newJsonStructure.intakeNumber ? parseInt(Object.keys(newJsonStructure).length) - 3 : parseInt(Object.keys(newJsonStructure).length) - 1;
		LOGGER.debug('####--->',maxRank);
		
		let prs = [];
		const piplsearchQuery = "select settingvalue from settings where settingname = 'piplsearch'";
		return util.executeDBQuery(piplsearchQuery,[])
		.then(result => {
			LOGGER.info(result);
			return result;
		})
		.then(_result => {

			// local database results
			const dataQuery = 'select * from personsearch_global_nosort($1)';
			
			prs.push(util.executeDBQuery(dataQuery, [JSON.stringify(newJsonStructure)])
						.then(result => {
							LOGGER.info(result);
							return result;
						})
						.catch(err => {
							LOGGER.error(err);
							return err;
						}));

			// SDR SEARCH build and execute
//			config.state = true;
			if(config.state && !config.trainingEnv) { // If traning env, MDM interface is not needed
				var searchParam = {
					'es_start': '1',
					'es_pageLength': '300',
					'es_sourceSystem': 'CJAMS',
					'es_name_fuzzy': true
				};
				// request Id
				var datetime = dateTime();
				var dateandtimeArray = datetime.split(" ",2);
				var time = dateandtimeArray[1];
				var timeArray = time.split(":",3);
				var finaltime = timeArray.join('');
				var Final = finaltime.toString();
				
				var hasCjamspid = false;
				
				const params = getDetails(newJsonStructure, searchParam);
				hasCjamspid = params.hasCjamspid;
				ssnflag = params.ssnflag;
				inputssn = params.inputssn;
				searchParam = params.searchParam;
				
				// Sonarcube
				const i = getSearchString(searchParam).index;
				var options = {
					url: config.personSearchConfig.url,
					json: true,
					body: searchParam,
					headers: {
						//Authorization: config.personSearchConfig.authorization,
						cookie: config.personSearchConfig.cookie,
						role: config.personSearchConfig.role,
						uid: config.personSearchConfig.uid,
						'content-type': 'application/json' 
					}
				};
				LOGGER.debug('****', options);
				Globalpersonsearch.logsearchsdr(searchParam,Final);
				if(i>4 && !hasCjamspid) {
					const externalapidata = {};   
					externalapidata.details =  {
						objectid: 'globalpersonsearch',
						objecttype: 'personsearch',
						objectsubtype: null,
						updatedby: userid,
						insertedby: userid
					}
					externalapidata.resstatus = '';
					externalapidata.request = JSON.stringify(searchParam);
					externalapidata.response = null;
					externalapidata.status = 'add';
					var v_externalapilogsid = null;
					commonapi.addupdateexternalapilogs(externalapidata).then(_data => {
						v_externalapilogsid = _data;
					});
					prs = updateexternalapilogs(options, v_externalapilogsid, userid, prs);
				}
				LOGGER.debug("request sent");
			}
			return Promise.all(prs);
		})
		.then(_data => {
			LOGGER.debug("Data received");
		    var parsedExtData = [];
			let mergedData = {};
			tempRes.count = 0;

			//Local DB results
			const tempIntdata = JSON.parse(JSON.stringify(_data[0]));

			// not currently using rank in display
			for (const element of tempIntdata){
				var rank = parseFloat(element.rankno);
				var percentageMatch = ((rank/maxRank).toFixed(2)) * 100;
				element["percentage"] = percentageMatch+'%';
			}
			_data[0] = tempIntdata;
			const intPersons = JSON.parse(JSON.stringify(_data[0]));
			tempRes.count += tempIntdata.length;

			//SDR results
			
			if(_data.length >= 1 && _data[1] != undefined) {
				var extPersons = JSON.parse(JSON.stringify(_data[1]));
				LOGGER.debug('@@@@', extPersons.response.result);
				
				const outerdata = gpsOuterloop(extPersons,ssnflag, inputssn, newJsonStructure, intPersons, parsedExtData,tempRes);
				parsedExtData = outerdata.parsedExtData;
				tempRes = outerdata.tempRes;
				mergedData = _data[0].concat(parsedExtData);
			} else {
				mergedData = intPersons;
			}
			tempRes.data = mergedData;
			return tempRes;
		})
		.catch(err => {
			util.logError(err)
			LOGGER.error(err);
			return err;
		});
	}

	function getSearchString(searchParam){
		var index = 0;
		var searchString = '?';
		for (const key in searchParam) {
			index++;
			if (searchParam.hasOwnProperty(key)) {
				searchString = searchString + key + '=' + searchParam[key] + '&';
			}
		}
		searchString = searchString.slice(0,-1);
		return {
			index, searchString
		}
	}

	function updateexternalapilogs(options, v_externalapilogsid, userid, prs){
		prs.push(new Promise((resolve, reject) => {
			axios.post(options.url, options.body, {
				headers: options.headers
			})
			.then((res) => {
				const externalapidata = {};
				externalapidata.details =  {
					externalapilogsid: v_externalapilogsid,
					objecttype: 'personsearch',
					updatedby: userid,
					insertedby: userid
				}
				externalapidata.info = null;
				externalapidata.status = 'update';
				externalapidata.response = 'success';
				externalapidata.resstatus = 'success';
				commonapi.addupdateexternalapilogs(externalapidata);
				resolve(res.data);
			})
			.catch((err) => {
				const externalapidata = {};
				externalapidata.details =  {
					externalapilogsid: v_externalapilogsid,
					objecttype: 'personsearch',
					updatedby: userid,
					insertedby: userid                           
				}
				externalapidata.info = null;
				externalapidata.status = 'update';
				externalapidata.resstatus = 'error';
				if (err.response) {
					externalapidata.response = err.response.data;
					commonapi.addupdateexternalapilogs(externalapidata);
					reject(err.response.status); 
				} else {
					externalapidata.response = err;
					commonapi.addupdateexternalapilogs(externalapidata);
					LOGGER.error(err); 
					reject(err);
				}
			});
		}));
		return prs;
	}

	function checkTotalCount(newJsonStructure){
		let totalsearchcount = 0;
		const searchParams = ['firstname','lastname','ssn','address1','address2','city','state','zip','dob','age','phone','gender'];
		searchParams.forEach(param => {
			if(_.isEmpty(newJsonStructure[param]) === false){ totalsearchcount++;}
		});
		return totalsearchcount;
	}

	function gpsOuterloop(extPersons,ssnflag, inputssn, newJsonStructure, intPersons, parsedExtData,tempRes) {
		let rank1 = 0;
		const intPersonsMdmIds = intPersons.map( item => item.mdm_id); 
		const totalsearchcount = checkTotalCount(newJsonStructure);
		for (const element of extPersons.response.result) { // START OUTER LOOP 
			element.gender = element.gender.charAt(0).toUpperCase();
			rank1 = 0;
			if (ssnflag && element.ssn === inputssn) {
				rank1 = 99;
			}

			const sdrDate = element.date_of_birth;
			if (util.isNullorEmpty(sdrDate) && sdrDate.includes('/')) {
				const dateSplit1 = sdrDate.split('/');
				const person_dob = dateSplit1[2] + '-' + dateSplit1[0] + '-' + dateSplit1[1];
				element.date_of_birth = person_dob;
			}

			if (element.identificationTypes && Array.isArray(element.identificationTypes)) { // Inner IF
				const data = gpsInnerloop(newJsonStructure,totalsearchcount,rank1,intPersonsMdmIds, element, parsedExtData,tempRes);
				parsedExtData = data.parsedExtData;
				tempRes = data.tempRes;
			} else { // Inner IF 
				var feed = feedData(element,newJsonStructure,totalsearchcount,rank1,element.ee_id);
				if (!intPersonsMdmIds.includes(feed.mdm_id)) {
					parsedExtData.push(feed);
					tempRes.count += 1;
				}
			}
		} //END OUTER LOOP
		return {
			parsedExtData,
			tempRes
		}
	}

	function gpsInnerloop(newJsonStructure,totalsearchcount,rank1,intPersonsMdmIds,ele, parsedExtData,tempRes) {
		const identificationTypes = ele.identificationTypes;
		for (const element of identificationTypes) { // Inner LOOP
			LOGGER.debug('@@@@ identificationTypes',identificationTypes);
			if (element.identification_irn) {
				const feed = feedData(
					ele,
					newJsonStructure,totalsearchcount,rank1,
					element ? element.identification_irn : ele.ee_id
				);

				if (!intPersonsMdmIds.includes(feed.mdm_id)) {
					parsedExtData.push(feed);
					tempRes.count += 1;
				}
				break;
			}
		} // Inner LOOP
		return {
			parsedExtData,
			tempRes
		}
	}

	function getGenderDetails(newJsonStructure, searchParam){
		let t_gender = '';
		if (newJsonStructure.gender) {
			t_gender = newJsonStructure.gender;
			if (t_gender === 'TG' || t_gender === 'TGIF' || t_gender === 'TGIM') {
				t_gender = 'O';
			}
			searchParam['es_gender'] = t_gender;
		}
		return searchParam;
	}
	function getDetails(newJsonStructure, searchParam){
		let hasCjamspid = false;
		let t_cisID= '';
		let t_mdmID= '';
		let t_firstname='';
		let t_lastname='';
		let t_city='';
		let t_zip='';
		let t_address1='';
		let t_address2='';
		let t_state='';
		let t_phone='';
		let t_ssn='';
		let inputssn;
		let t_dob='';

		let ssnflag = false;
		if(newJsonStructure.cjamspid){
			hasCjamspid = true;
		}
		if(newJsonStructure.cjisnumber){
			t_cisID=newJsonStructure.cjisnumber;
			searchParam['es_irn'] = lPad(t_cisID,9);
		}
		if(newJsonStructure.mdmId){
			t_mdmID=newJsonStructure.mdmId;
			searchParam['es_mdm_id'] = t_mdmID;
		}
		if(newJsonStructure.firstname){
			t_firstname=newJsonStructure.firstname;
			searchParam['es_first_name'] = t_firstname;
		}
		if(newJsonStructure.lastname){
			t_lastname=newJsonStructure.lastname;
			searchParam['es_last_name'] = t_lastname;
		}
		if(newJsonStructure.city){
			t_city=newJsonStructure.city;
			searchParam['es_city'] = t_city;
		}
		if(newJsonStructure.zip){
			t_zip=newJsonStructure.zip;
			searchParam['es_zip'] = t_zip;
		}
		if(newJsonStructure.address1){
			t_address1=newJsonStructure.address1;
			searchParam['es_address1'] = t_address1;
		}
		if(newJsonStructure.address2){
			t_address2=newJsonStructure.address2;
			searchParam['es_address2'] = t_address2;
		}
		if(newJsonStructure.state){
			t_state=newJsonStructure.state;
			searchParam['es_state'] = t_state;
		}
		if(newJsonStructure.phone){
			t_phone=newJsonStructure.phone;
			searchParam['es_phone_number'] = t_phone;
		}
		if(newJsonStructure.ssn){
			t_ssn=newJsonStructure.ssn;
			searchParam['es_ssn'] = t_ssn;
			ssnflag = true;
			inputssn = t_ssn;
		}
		if(newJsonStructure.dob){
			const date = newJsonStructure.dob;
			const dateSplit = date.split('/');
			const t_dob_from_yyyy = parseInt(dateSplit[2]) - 3;
			const t_dob_to_yyyy = parseInt(dateSplit[2]) + 3;
			t_dob = t_dob_from_yyyy+'-01-01';
			searchParam['es_dob_from'] = t_dob;
			t_dob = t_dob_to_yyyy+'-12-31';
			searchParam['es_dob_to'] = t_dob;
		}
		if(newJsonStructure.age){
			const age = parseInt(newJsonStructure.age);
			const offset = 3;
			const datetime = dateTime();
			const dateandtimeArray = datetime.split(" ",2);
			const date = dateandtimeArray[0];
			const dateArray = date.split("-",3);
			const currentYear = parseInt(dateArray[0]);
			const assumedDob = currentYear - age;
			const yearfrom = assumedDob - offset;
			const yearto = assumedDob + offset;
			const t_dobFrom = yearfrom+'-'+'01'+'-'+'01';
			const t_dobTo = yearto+'-'+'12'+'-'+'31';
			searchParam['es_dob_from'] = t_dobFrom;
			searchParam['es_dob_to'] = t_dobTo;
		}
		searchParam = getGenderDetails(newJsonStructure, searchParam)

		return {
			hasCjamspid,
			ssnflag,
			inputssn,
			searchParam
		}
	}

    Globalpersonsearch.parseExtData = extData => {
		
		
		const isSingle = extData.person? true: false;
		const isMultiple = extData.possible_persons? true: false;
		
		let persons = [];
		if (isSingle)
		{persons = [extData.person];}
		if(isMultiple)
		{persons = extData.possible_persons;}
		
		const emptyUUID = '00000000-0000-0000-0000-000000000000';
		
		persons.forEach(p => {
			p.source = 'External';
			p.personid = p['@id'];
			p.search_pointer = p['@search_pointer'];
			p.personroleid = emptyUUID;
			p.personroletype = 'None';
			p.personrolesubtype = '';
			if(p.names && p.names.length > 0) {
				p.firstname = p.names[0].first;
				p.lastname = p.names[0].last;
				p.middlename = p.names[0].middle;
			}
			p.dob = null;
			p.dangerlevel = 0;
			p.ssn = null;
			p.dcn = null;
			if(p.addresses && p.addresses.length > 0) {
				const extAddress = p.addresses[0];
				p.primaryaddress = extAddress.display;
				
				const pAddress = {};
				pAddress.address = extAddress.street;
				pAddress.city = extAddress.city;
				pAddress.zipcode = extAddress.zip_code;
				pAddress.state = extAddress.state;
				pAddress.country = extAddress.country;
				pAddress.pAddressType = {personaddresstypekey: 'C', typedescription: 'Physical Address'};
				p.personaddress = [pAddress];
			}
			if (p.phones && p.phones.length > 0) {
				p.homephone = p.phones[0].display;
				p.personphonenumber = [{personphonetypekey: 'P', phonenumber: p.homephone}];
			}
			p.gendertypekey = null;
			p.loadnumber = null;
			p.teamname = null;
			p.priors = 0;
			
			//Remove other properties
			delete p['@id'];
			delete p['@search_pointer'];
			delete p.names;
			delete p.phones;
			delete p.gender;
			delete p.languages;
			delete p.origin_countries;
			delete p.addresses;
			delete p.urls;
			
		});
		
		return persons;
	};
	
	Globalpersonsearch.remoteMethod(
		'getPersonSearchDataSDR', 
		{
					      http: {
					      		path: '/getPersonSearchData',
					      		verb: 'post'
							},
							accepts : [ {arg : 'data',type : 'object',
										http : {source : 'body'}} ,
										{arg: 'reqctx',type: 'object',
										http: {source: 'context'}}
							],   
					      returns: {
							  type : 'object',
							  root : true
							}
					     }
						 );

    Globalpersonsearch.remoteMethod(
		'getPersonSsnValidation', 
		{
			  http: {
			  path: '/getPersonssnvalidation',
			  verb: 'post'
				},
			accepts : [ {arg : 'data',type : 'object',
				http : {source : 'body'}} ,
				{arg: 'reqctx',type: 'object',
     			http: {source: 'context'}}
			],   
		  returns: {
		  type : 'object',
    	  root : true
		 }
    	}
	);						 
						 
	Globalpersonsearch.afterRemote('getPersonSearchData', function(ctx, request, next) {
		var description,Servicerequestnumber,ipaddress ;
		var logtypekey = "PS";
		description = "Person has been searched from DA#";
        var logJson = {
			"data": {
				"danumber": "",
				"firstname":"",
				"lastname":"",
				"middlename":"",
				"dob":"",
				"gender":"",
				"phone":"",
				"ssn":"",
				"address":"",
				"zip":"",
				"city":"",
				"county":"",
				"state":""
            }
		};
		
		logJson.data.firstname  = ctx.args.data.where.firstname;
		logJson.data.lastname   = ctx.args.data.where.lastname;
		logJson.data.middlename = ctx.args.data.where.middlename;
		logJson.data.dob = ctx.args.data.where.dob;
		logJson.data.gender = ctx.args.data.where.gender;
		logJson.data.phone = ctx.args.data.where.phone;
		logJson.data.ssn =ctx.args.data.where.ssn;
		logJson.data.address =ctx.args.data.where.address;
		logJson.data.zip=ctx.args.data.where.zip;
		logJson.data.city=ctx.args.data.where.city;
		logJson.data.county=ctx.args.data.where.county;
		logJson.data.state=ctx.args.data.where.state;
		logJson.data.danumber= ctx.args.data.where.intakeNumber;
		logJson.data.dl =ctx.args.data.where.dl;
		logJson.data.fein = ctx.args.data.where.fein;
		logJson.data.complaintnumber = ctx.args.data.where.complaintnumber
		logJson.data.cjisnumber = ctx.args.data.where.cjisnumber
		logJson.data.petitionid =ctx.args.data.where.petitionid;
		Servicerequestnumber  = ctx.args.data.where.intakeNumber;
		ipaddress = ctx.req.connection.remoteAddress;
		
		var newadd = {
			"description":description,
			"logtypekey":logtypekey ,
			"servicerequestnumber":Servicerequestnumber,
			"ipaddress":ipaddress,
			"metadata":logJson
		}
		// Auditlog Recording Added here 
		return server.models.Auditlogtype.find(
			{where:{logtypekey:request.logtypekey},fields:['logtypekey']})
			.then(data=>{
				return server.models.Auditlog.create(newadd)
			})
		});

		Globalpersonsearch.remoteMethod('getPersonSearchResult', {
			http: {
							path: '/getPersonSearchResult',
							verb: 'post'
			},
			accepts : [ {arg : 'data',type : 'object',
					http : {source : 'body'}} ],
					returns: {
					type : 'string',
					root : true
			}
	});


	Globalpersonsearch.getPersonSsnValidation = request => {
		
		var newJsonStructure = request.where;
		newJsonStructure["pagenumber"] = 1;
		newJsonStructure["pagesize"] = 1000;

		let totalcount = 0;

        const sql = 'select * from personsearch_global_nosort($1)';
        return util.executeDBQuery(sql, [JSON.stringify(newJsonStructure)])
		.then(data => {
			if (data != null && data.length > 0) {
				totalcount = Number(data[0].totalcount);
			}
			return {
			  'data': data,
			  'count': totalcount
			};
		})
		.catch(
			err => util.logError(err)
		);
	};
	

	Globalpersonsearch.getPersonSearchResult = function(data){
			var showCount = false;
			if(data.page === 1) {
				showCount = true;
			}/* else {showCount = false};*/	//SonarQube fix - commented as showCount is already set to false above
			var newJsonStructure = data.where;
			newJsonStructure["pagenumber"] = data.page;
			newJsonStructure["pagesize"] = data.limit;

			const sort = data.order;
			let arrSort = [];
			let sSortBy = 'firstname';
			let sSortOrder = 'asc';
			if(sort) {
				arrSort = sort.split(' ');
				sSortBy = arrSort[0];
				if(arrSort.length > 1)
					{sSortOrder = arrSort[1];}
					/*else
					{sSortOrder = 'asc';}*/
			}
			/* else {
				sSortBy = 'firstname';
				sSortOrder = 'asc';
			} */

			newJsonStructure["sortcol"] = sSortBy;
			newJsonStructure["sortdir"] = sSortOrder;

			const dataQuery = 'select * from personsearchdata($1)';

			return util.executeDBQuery(dataQuery, [JSON.stringify(newJsonStructure)])
			.then(_data => {
				var tempRes = {};
				
				const persons = JSON.parse(JSON.stringify(_data));
				
				if(showCount) {
					if(persons.length > 0)
					{tempRes.count = persons.length ;}
					else
					{tempRes.count = 0;}
				}
				
				tempRes.data = persons.map(x=> {
					return x;
				}); 
				
				return tempRes;
			})
			.catch(err => util.logError(err));
		};
		
		Globalpersonsearch.observe('before save', (ctx, next) => util.beforesave(ctx, next));
		Globalpersonsearch.observe('access', (ctx, next) => util.access(ctx, next));
		Globalpersonsearch.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next));

		function checkCountCondition(value1, value2, count) {
			if(value1 && value2 === value1) {
				count++;
			}
			return count;
		}
		
		function isExact(row, searchParams, totalcount) {
			let count = 0;
			if(searchParams.firstname && row.first_name.toLowerCase() === searchParams.firstname.toLowerCase()) {
				count++;
			}
			if(searchParams.lastname && row.last_name.toLowerCase() === searchParams.lastname.toLowerCase()) {
				count++;
			}
			if(searchParams.city && row.resi_city.toLowerCase() === searchParams.city.toLowerCase()) {
				count++;
			}
			if(searchParams.state && row.resi_state.toLowerCase() === searchParams.state.toLowerCase()) {
				count++;
			}
			count = checkCountCondition(searchParams.zip, row.resi_zip_code, count);
			count = checkCountCondition(searchParams.address1, row.address_line_1, count);
			count = checkCountCondition(searchParams.address2, row.address_line_2, count);
			count = checkCountCondition(searchParams.dob, row.date_of_birth, count);
			count = checkCountCondition(searchParams.age, row.age, count);
			count = checkCountCondition(searchParams.phone, row.home_phone, count);
			count = checkCountCondition(searchParams.gender, row.gender_cd, count);
			count = checkCountCondition(searchParams.ssn, row.ssn, count);
			return (totalcount == count);
		}

		function feedData ( extData,newJsonStructure,totalsearchcount,rank,irn ) { 
					return { totalcount: '',
					exactmatch: isExact(extData, newJsonStructure, totalsearchcount),
					rankno: rank,
					source: 'SDR',
					personid: '',
					cjamspid: extData.cjams_id,
					cisclientid: irn,
					personroleid: '',
					personroletype: '',
					personrolesubtype: null,
					firstname: extData.first_name,
					middlename: extData.middle_name,
					lastname: extData.last_name,
					dob: extData.date_of_birth,
					dangerlevel: 0,
					dateofdeath: null,
					suffix: extData.legal_suffix,
					prefix: extData.legal_prefix,
					deceased: null,
					socialmediasource: null,
					userphoto: null,
					ssn: extData.ssn,
					ssnverified: extData.ssn_verification_cd,
					mdm_id: extData.mdm_id,
					dcn: null,
					primaryaddress: extData.full_address,
					homephone: extData.home_phone,
					gendertypekey: extData.gender_cd,
					loadnumber: null,
					teamname: null,
					priors: '',
					relationscount: '',
					relations: '',
					alias: [
								{
									aliasid: null,
									firstname: extData.alias_first_name,
									lastname: extData.alias_last_name,
									middlename: extData.alias_middle_name,
									sfxname: extData.alias_suffix,
									akatypetypekey: "AN",
									prefixtypekey: extData.alias_prefix,
									personid: null
								},
								{
									aliasid: null,
									firstname: extData.maiden_first_name,
									lastname: extData.maiden_last_name,
									middlename: extData.maiden_middle_name,
									sfxname: extData.maiden_suffix,
									akatypetypekey: "MN",
									prefixtypekey: extData.maiden_prefix,
									personid: null
								}
							],
					percentage:'',
					primarylanguage: extData.primary_language_cd,
					ethnicity: extData.ethnicity_cd,
					nationality: extData.country_of_origin_cd,
					race: extData.race_cd,
					stateid: extData.driver_license_number,
					aliennumber: extData.alien_number,
					alienstatus: extData.immigration_status,
					primarycitizenship: extData.primary_citizenship
				};
		}
		
	};
