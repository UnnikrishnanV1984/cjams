'use strict';
const LOGGER = require("log4js").getLogger("clearancesearch");
var server = require('../../server/server');
const util = require('../utils/utils');
var config = require('../../server/config.json');
const _ = require('lodash');

module.exports = function (Clearancesearch) {
  Clearancesearch.personsearch = function (data) {
    var tempRes = {};
    if (data.where.SEARCH_TYPE === 'S')
    {
      data.where.ssn = data.where.SSN_NO;
    }
    else if (data.where.SEARCH_TYPE === 'N')
    {
      data.where.firstname = data.where.FIRST_NM;
      data.where.lastname = data.where.LAST_NM;
      data.where.dob = data.where.DOB_DT;
      data.where.age = data.where.APPROXIMATE_AGE_NO;
      switch(data.where.GENDER) {
        case 'MALE':
          data.where.gender = 'M';
          break;
        case 'FEMALE':
          data.where.gender = 'F';
          break;
        case 'TRANSGENDER':
          data.where.gender = 'T';
          break;
      }
}
 
    else if (data.where.SEARCH_TYPE === 'A' && data.where.ADDRESS) {
      data.where.address1 = [data.where.ADDRESS.ADR_STREET_TX , data.where.ADDRESS.ADR_PRE_DIR_CD , data.where.ADDRESS.ADR_STREET_NM , data.where.ADDRESS.ADR_STREET_SUFFIX_CD , data.where.ADDRESS.ADR_POS_DIR_CD].filter(x => x!='' && x!= null).join(' ');
      data.where.address2 = [data.where.ADDRESS.ADR_UNIT_TYPE_CD , data.where.ADDRESS.ADR_UNIT_NO_TX].filter(x => x!='' && x!= null).join(' ');
      data.where.city = data.where.ADDRESS.ADR_CITY_NM;
      data.where.stateid = data.where.ADDRESS.ADR_STATE_CD;
      data.where.zip = data.where.ADDRESS.ADR_ZIP5_NO;
    }
    
    var newJsonStructure = data.where;
    newJsonStructure["pagenumber"] = 1;
    newJsonStructure["pagesize"] = 1000;

    // not currently using max ranking code in display
    const pagination = {};
    pagination.gPageno = data.page;
    pagination.gLimit = data.limit;

    const sortParams = {};
    if (data.where.sortcolumn) {
      sortParams['order'] = (data.where.sortorder) ? data.where.sortorder : 'asc';
      sortParams['column'] = data.where.sortcolumn;
    } else {
      //default sort, front end always passes sortorder key but not sortcolumn
      sortParams['column'] = 'exactmatch';
      sortParams['order'] = 'desc';
    }

    var maxRank;
    if (newJsonStructure.intakeNumber) {
      maxRank = parseInt(Object.keys(newJsonStructure).length) - 3;
    } else if (!newJsonStructure.intakeNumber) {
      maxRank = parseInt(Object.keys(newJsonStructure).length) - 1;
    }
    LOGGER.debug('####--->', maxRank);
    const personsearchquery = "select * from personsearch_global_nosort($1)";
    return util.executeDBQuery(personsearchquery, [JSON.stringify(newJsonStructure)])
    .then(result => {
      LOGGER.debug("Data received");
      tempRes.count = 0;
      //Local DB results
      const tempIntdata = JSON.parse(JSON.stringify(result));
      result = tempIntdata;
      const intPersons = JSON.parse(JSON.stringify(result));
      tempRes.count += tempIntdata.length;
      LOGGER.debug('merging done');
      tempRes.data = intPersons;
      tempRes.data = personSort(tempRes.data, sortParams, pagination);
      tempRes = getdetails(tempRes);
      return tempRes;
    })
    .catch(err => {
        LOGGER.error(err);
        util.logError(err);
        return err;
    })
  }

  function getdetails(tempRes){
    var parsedExtData = [];
    if(tempRes.data.length > 0) {
      var extPersons = JSON.parse(JSON.stringify(tempRes.data));
      for (const element of extPersons) {
        LOGGER.debug(element, 'extPersonsextPersons');
        if(element.gendertypekey === 'M'){
          element.gendertypekey = 'MALE';	
        }else if(element.gendertypekey === 'F'){
          element.gendertypekey = 'FEMALE';
        }else if(element.gendertypekey === 'T'){
          element.gendertypekey = 'TRANSGENDER';
        }
        var feed = {
          SELECT_SW: 'N',
          TYPE: 'CLIENT',
          CLIENT_ID: element.cjamspid,
          CIS_CLIENT_ID: element.cisclientid,
          GENDER: element.gendertypekey,
          FIRST_NM: element.firstname,
          MIDDLE_NM: element.middlename,
          LAST_NM: element.lastname,
          SSN_NO: element.ssn,
          DOB_DT: element.dob,
          APPROXIMATE_AGE_NO: 0,
          RACE: getracekeys(element.racetypekey),
          TYPE_CD: 2955,
          PREFIX: element.prefx,
          SUFFIX: element.suffix,
          P14:"",
          P15:"",
          ADDRESS: formataddress(element),
          RELEVANCY_PCT: 1
        }
        parsedExtData.push(feed);
      }
      LOGGER.debug(parsedExtData, 'parsedExtData')
      tempRes.data = parsedExtData;
    }
    return tempRes;
  }

  function getracekeys(racetypekey) {
    let race = null;
    racetypekey = JSON.parse(racetypekey);
    if(racetypekey && Array.isArray(racetypekey) && racetypekey.length >0) {
      racetypekey.forEach(element => {

      race = [race, element.value_text].filter(x => x!='' && x!= null).join(', ');
      });  
    } else {
      race =  '';
    }
    return race;
  }

  function formataddress(extPersons){

    return [extPersons.address , extPersons.address2 , extPersons.city , extPersons.state , extPersons.zipcode].filter(x => x!='' && x!= null).join(', ');

  }

  // private function for global search results sorting
  function personSort(data, sortParams, pagination) {
    // Sorting
    //make names sort case insensitive
    let sortColumn = sortParams.column;
    if (['firstname', 'middlename', 'lastname'].find(item => { return (item == sortParams.column); })) {
      sortColumn = function (person) { return (person[sortParams.column]) ? person[sortParams.column].toString().toLowerCase() : ''; };
    }
    // align search parameter with response
    if (sortColumn == 'gender') {sortColumn = 'gendertypekey';}

    LOGGER.debug('sorting ', sortColumn, sortParams.order);

    data = _.orderBy(data,
      [sortColumn, 'source', 'rankno', 'ranksound', 'lastname', 'firstname', 'middlename', 'dob', 'cjamspid'],
      [sortParams.order, 'asc', 'desc', 'desc', 'asc', 'asc', 'asc', 'asc', 'asc']);

    //Explicit Paging
    var startno = ((pagination.gPageno - 1) * pagination.gLimit);
    var endno = startno + pagination.gLimit;

    return data.slice(startno, endno);

  }

  Clearancesearch.remoteMethod(
    'personsearch',
    {
      http: {
        path: '/personsearch',
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
  Clearancesearch.maltreatorsearch = function (data) {
    const cjamspid = data.where.cjamspid;
    const maltreatorsearchquery = "select * from sp_maltreatment_search($1)";

    return util.executeSecondaryNodeDBQuery(maltreatorsearchquery, [cjamspid])
      .then(result => {
        return result;
      })
      .then(data1 => { return data1; })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        util.logError(err);
        throw err;
      });

  }

  Clearancesearch.remoteMethod(
    'maltreatorsearch',
    {
      http: {
        path: '/maltreatorsearch',
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

}