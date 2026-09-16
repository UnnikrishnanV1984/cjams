'use strict';

const LOGGER = require("log4js").getLogger("settings");
const app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Settings) {

  Settings.getvalue = function(settingname) {
    if (!settingname) {
      const error = new Error('Setting name is required');
      error.status = 400;
      throw error;
    }

    const settingnameArray = settingname.split(',');

    const sql = 'SELECT settingname, settingvalue FROM settings WHERE settingname = $1 AND activeflag = 1';

    const results = [];

    const querySettingValue = (index) => {
      if (index >= settingnameArray.length) {
        return results;
      }

      const currentSettingName = settingnameArray[index].trim();

      return util.executeDBQuery(sql, [currentSettingName])
        .then(data => {
          if (data && data.length > 0) {
            results.push({ settingname: currentSettingName, settingvalue: data[0].settingvalue });
          } else {
            LOGGER.warn(`Setting not found for name: ${currentSettingName}`);
          }

          return querySettingValue(index + 1);
        });
    };

    return Promise.resolve()
      .then(() => querySettingValue(0))
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  };

  Settings.remoteMethod('getvalue', {
    http: { path: '/getvalue', verb: 'get' },
    accepts: { arg: 'settingname', type: 'string', required: true, http: { source: 'query' } },
    returns: { arg: 'settings', type: 'array' }
  });
};