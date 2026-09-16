'use strict';
const LOGGER = require("log4js").getLogger("survey");
const util = require('../../../common/utils/utils');

module.exports = function(Survey) {
  

    // POST /survey/:id
    Survey.replaceById = async (id, request) => {

        const answers = request.answers;
        const validated = request.validated;

        // get elements
        const details = await _getDetails(id);
        const elements = await _getElements().filter(element => element.old_id > 33);

        const data = elements.map(element => {
            const detail = details.find(e => element.elementid == e.elementid)
            Logger.info(detail);
            return {
                elementId: element.elementid,
                value: answers[element.old_id]
            }
        });

        // update all the elements
        const updates = await Promise.all(data.map(async (element) => {
            return _saveElement(id, element.elementId, element.value);
        }));

        if(!validated) {
            return updates;
        }

        const response = await _validate(id);

        if(response) {
            return {id, validated: true}
        }
    }

  const _saveElement = (summaryId, elementId, value) => {
    const sql = "" +
      "UPDATE personnytddetail SET elementvalue='" + value + "' " +
      "WHERE summaryid='" + summaryId + "' " +
      "AND elementid='" + elementId + "';";

    return util.executeDBQuery(sql, null)
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  const _getDetails = (id) => {
        const app = require('../../../server/server');
        const PersonNytdDetail = app.models.PersonNytdDetail;
      return PersonNytdDetail.find({where: {summaryid: id}})
      .then(results => {
        return results.sort((a, b) => (a.old_id > b.old_id) ? 1 : -1);
      })
            .catch(error => { return error; });
    }

    const _getElements = () => {
        const app = require('../../../server/server');
        const NytdDataElement = app.models.NytdDataElement;
      return NytdDataElement.find({})
      .then(results => {
        return results.sort((a, b) => (a.old_id > b.old_id) ? 1 : -1);
      })
            .catch(error => { return error; });
    }

    const _validate = async (id) => {
        const app = require('../../../server/server');
        const PersonNytdSummary = app.models.PersonNytdSummary;

        const resp = await PersonNytdSummary.findById(id)
            .then(async summary => {
                const updateResp = await summary.updateAttribute({validationFlag: 1});
                LOGGER.info(updateResp);
                return updateResp;
            })
            .catch(error => { return error; });
            LOGGER.info(resp);
            return resp;
    }
}
