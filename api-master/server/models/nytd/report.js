'use strict';

const LOGGER = require("log4js").getLogger("report");
const util = require('../../../common/utils/utils');
module.exports = function(Report) {
  const groupBy = (results, field, properties) => {
    return results.reduce((accumulator, result) => {
      if (! accumulator.includes(result[field])) {
        let element;
        if (properties === undefined) {
          element = result[field];
        } else {
          element = properties.reduce((acc, prop) => {
            (acc[prop] = result[prop]);
            return acc;
          }, {});
        }
        accumulator.push(element);
      }
      return accumulator;
    }, []);
  };

    // GET /reports
  Report.find = async () => {
    const app = require('../../../server/server');
    const PersonNytdSummary = app.models.PersonNytdSummary;

    return PersonNytdSummary.find({})
            .then((results) => {
              const periods = groupBy(results, 'reportingperiod');

              return periods.map((period) => {
                return {period};
              });
            })
            .catch((error) => {
              return error;
            });
  };

    // GET /reports/:period
  Report.findById = async (period) => {
    const app = require('../../../server/server');
    const PersonNytdSummary = app.models.PersonNytdSummary;
    const Person = app.models.Person;

    return PersonNytdSummary.find({where: {reportingperiod: period}})
            .then(async (results) => {
              const summaries = groupBy(results, 'personid', ['personid', 'summaryid']);
              let people = await Promise.all(summaries.map((person) => {
                return Person.findById(person.personid).then((result) => {
                  return {
                    id: result.personid,
                    cjamspid: result.cjamspid,
                    firstName: result.firstname,
                    lastName: result.lastname,
                    detailsId: person.summaryid,
                  };
                })
                    .catch((error) => { return error; });
              }));

              people = people.filter(e => e);

              return {
                period,
                people,
              };
            })
            .catch((error) => { return error; });
  };

  Report.xml = async (period) => {
    const NytdXml = require('./NytdXml');
    const xmler = new NytdXml();
    const reports = await Report.getReportsForXml(period);
    const xml = xmler.generate(period, reports);

    return [xml, 'application/xml'];
  };

  Report.getReportsForXml = async (period) => {
    const sql = `SELECT s.summaryid, e.old_id, d.elementvalue
    FROM personnytdsummary s
    JOIN personnytddetail d ON s.summaryid=d.summaryid
    JOIN nytddataelements e ON e.elementid = d.elementid
    WHERE s.reportingperiod = $1 AND s.personid IS NOT NULL AND s.validationflag = 1
    GROUP BY s.summaryid, e.old_id, d.elementvalue
    ORDER BY s.summaryid, e.old_id::integer, d.elementvalue`;

    let results;
    try {
      results = await util.executeDBQuery(sql, [period]);
    } catch (error) {
      LOGGER.error('>>>>ERROR:', error);
      throw error;
    }

    const reports = results.reduce((acc, record) => {
      acc[record.summaryid] = acc[record.summaryid] || [];
      (acc[record.summaryid]).push({
        id: record.old_id,
        value: record.elementvalue,
      });
      return acc;
    }, {});

    const reportXMl = Object.values(reports);
    LOGGER.info(reportXMl);
    return reportXMl;

  };

  Report.remoteMethod('xml', {
    accepts: {arg: 'period', type: 'string', required: true},
    http: {path: '/:period/xml', verb: 'get'},
          // returns: {type: 'object', root: true},
    returns: [
            {arg: 'body', type: 'file', root: true},
            {arg: 'Content-Type', type: 'string', http: {target: 'header'}},
    ],
  });



  /* 
   * Converting to xls for testing
   *
   * Following code is for testing. Should remain in repo, 
   * and remain commented out for the time being. To make functional,
   * remote call needs to be added to report under model-config.json.
   * Additionally, code relies on json2xls dependency, which can be
   * added by `npm install json2xls`
   *
   * @author jhester@dminc.com
  **/

  /*
  NOSONAR
  Report.remoteMethod('xls', {
    accepts: {arg: 'period', type: 'string', required: true},
    http: {path: '/:period/xls', verb: 'get'},

    returns: [
            {arg: 'body', type: 'string', root: true},
            {arg: 'Content-Type', type: 'string', http: {target: 'header'}},
    ],
  });
  
  const _flattenElements = (elements) => {
    let flat = [];
    for(let n = 0; n < elements.length; n++) {
      let element = elements[n]
      if (element.name.charAt(0) !== "E") {
        elements = elements.concat(element.elements)
      } else {
        flat.push(element)
      }
    }
    return flat;
  }

  const _reduceRecordToObject = (acc, element) => {

      if (element.elements) {
        acc[element.name] = element.elements[0].text
      } else {
        acc[element.name] = ""
      }
      return acc
  }

  Report.xls = async (period) => {

    const convert = require('xml-js')
    const json2xls = require('json2xls')
    const xmlReq = await Report.xml(period)
    const xml = xmlReq[0]

    // console.log(xml)
    const result = convert.xml2json(xml, {compact: false, spaces: 2})
    const resultObj = JSON.parse(result)
    const records = resultObj.elements[0].elements

    // remove headers
    records.splice(0, 5);

    records = records.map(record => {
      return _flattenElements(records.elements).reduce(_reduceRecordToObject(acc, element), {})
    })
    
    let json = records
    return [json, 'application/json'];
  };
  */
};
