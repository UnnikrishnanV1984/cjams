'use strict';
const LOGGER = require("log4js").getLogger("checkprotectivesupervision");
var loopback = require('loopback');
const util = require('../utils');
var app = require('../../../server/server');

module.exports.runSchedule = request => {

        LOGGER.debug('Notification scheduler!');
        var sql = "select * from checkprotectivesupervision()"
        return util.executeDBQuery(sql, [])
          .then(data => {
            LOGGER.debug(data);
            return data;
          })
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
};
