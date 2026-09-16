'use strict';

const LOGGER = require('log4js').getLogger('poolerrorhandler');

/**
 * Attach an error listener to every postgres connection pool.
 *
 * pg emits 'error' on the pool when an *idle* client dies -- a DB restart or
 * failover, an administrator running pg_terminate_backend, or a firewall/NLB
 * dropping a socket it considered idle. That event has no query and no request
 * attached to it, so nothing in the normal callback chain can catch it. With no
 * listener registered, node treats it as an unhandled 'error' event.
 *
 * Logging it here lets the pool discard the dead client and carry on. The
 * failing client is already removed by pg before this fires, so there is
 * nothing to clean up -- the next query simply gets a fresh connection.
 */
module.exports = function(app) {
  Object.keys(app.dataSources || {}).forEach((name) => {
    const ds = app.dataSources[name];
    const pool = ds && ds.connector && ds.connector.pg;

    // Only the postgresql connector exposes a pg Pool as connector.pg.
    if (!pool || typeof pool.on !== 'function') {
      return;
    }

    pool.on('error', (err) => {
      LOGGER.error(`Idle client error on datasource "${name}"`, err);
    });

    LOGGER.info(`Pool error handler attached for datasource "${name}"`);
  });
};
