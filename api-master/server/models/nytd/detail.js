'use strict';
const LOGGER = require("log4js").getLogger("detail");
const util = require('../../../common/utils/utils');

module.exports = function(Detail) {
  const _getElements = () => {
    const app = require('../../../server/server');
    const NytdDataElement = app.models.NytdDataElement;
    return NytdDataElement.find({})
    .then((results) => {
      return results.sort((a, b) => (a.old_id > b.old_id) ? 1 : -1);
    })
    .catch((error) => { return error; });
  };

  const _getParticipationChoices = async () => {
    const sql = '' +
      'SELECT description_tx FROM tb_picklist_values ' +
      'WHERE picklist_type_id = 10017 ' +
      'AND active_sw = \'Y\'';

    let results;
    try {
      results = await util.executeDBQuery(sql, []);
    } catch (error) {
      LOGGER.error('>>>>ERROR:', error);
      throw error;
    }

    // format for key: value
    const participantChoices = results.reduce((acc, result) => {
      const value = result.description_tx;
      acc[value] = value;
      return acc;
    }, {});

    LOGGER.info(participantChoices);
    return participantChoices;
  };

  const _addElementChoices = async (elements) => {
    const participation = await _getParticipationChoices();

    const yesNo = {
      yes: 'Yes',
      no: 'No',
      declined: 'Declined',
    };

    const yesNoWithNotApplicable = Object.assign({
      na: 'Not Applicable',
    }, yesNo);

    const yesNoWithDoNotKnow = Object.assign({
      doNotKnow: 'Do not know',
    }, yesNo);

    const yesNoWithDoNotKnowAndNotApplicable = Object.assign({
      na: 'Not Applicable',
      doNotKnow: 'Do not know',
    }, yesNo);

    const education = {
      highSchoolGed: 'High school diploma / GED',
      vocationalCertificate: 'Vocational Certificate',
      vocationalLicense: 'Vocational License',
      associate: 'Associate’s degree',
      bachelor: 'Bachelor’s degree',
      higherDegree: 'Higher Degree',
      noneOfTheAbove: 'None of the above',
      declined: 'Declined',
    };

    const yesNoElements = [37, 38, 39, 40, 41, 45, 47, 48, 49, 50, 51, 52];
    const yesNoWithNotApplicableElements = [42, 43, 44, 53];
    const yesNoWithDoNotKnowElements = [54, 55];
    const yesNoWithDoNotKnowAndNotApplicableElements = [56, 57, 58];

    const other = {
      34: participation,
      46: education,
    };

    return elements.map((element) => {
      if (yesNoElements.includes(element.id)) {
        element.choices = yesNo;
      } else if (yesNoWithNotApplicableElements.includes(element.id)) {
        element.choices = yesNoWithNotApplicable;
      } else if (yesNoWithDoNotKnowElements.includes(element.id)) {
        element.choices = yesNoWithDoNotKnow;
      } else if (yesNoWithDoNotKnowAndNotApplicableElements.includes(element.id)) {
        element.choices = yesNoWithDoNotKnowAndNotApplicable;
      } else if (element.id in other) {
        element.choices = other[element.id];
      }

      return element;
    });
  };

  const _getDetails = (id) => {
    const app = require('../../../server/server');
    const PersonNytdDetail = app.models.PersonNytdDetail;
    return PersonNytdDetail.find({where: {summaryid: id}})
      .then((results) => {
        return results.sort((a, b) => (a.old_id > b.old_id) ? 1 : -1);
      })
      .catch((error) => { return error; });
  };

  // GET /details/:id
  Detail.findById = async (id) => {
    const elements = await _getElements();
    const details = await _getDetails(id);

  // create elements
    const data = elements.map((element) => {
      const detail = details.find((e) => element.elementid === e.elementid);
      return {
        id: element.old_id,
        description: element.elementdesc,
        value: detail.elementvalue,
      };
    });

  // group by tab
    const grouped = data.reduce((accumulator, datum) => {
      let key = 'survey';
      if (datum.id < 14) {
        key = 'summary';
      } else if (datum.id < 34) {
        key = 'served';
      }
      accumulator[key] = accumulator[key] || [];
      (accumulator[key]).push(datum);
      return accumulator;
    }, {});
  // add choices
    grouped.survey = await _addElementChoices(grouped.survey);

    return Object.assign({id}, grouped);
  };
};
