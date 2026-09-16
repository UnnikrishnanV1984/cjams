'use strict';
const LOGGER = require("log4js").getLogger("closealertgbc");
var loopback = require('loopback');
const util = require('../utils');
var app = require('../../../server/server');

module.exports.runSchedule = request => {
    LOGGER.debug('Notification scheduler!');
    var sql = "select * from closealertgbc()"
    return util.executeDBQuery(sql, [])
      .then(data => {
        LOGGER.debug(data);
        return data;
      })
      .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};
