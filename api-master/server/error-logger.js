'use strict';
const util = require('../common/utils/utils');
module.exports = function(options) {
  return function logError(err, req, res, next) {
    // Pass the request along: this middleware is the only place that still has
    // it, and without the URL the log line cannot be matched to the endpoint
    // APM reported.
    util.logError(err, req);
    const error = new Error();
    error.name = 'ERROR';
    error.statusCode = 400;
    error.message = err.message;
    // Carry the originating stack across. Without this the replacement Error
    // above only points back at this middleware, so APM reports every failure
    // as a bare "400, No stack trace" with no way back to the real cause.
    // Safe to attach: strong-error-handler runs with debug:false, and its 4xx
    // responses copy only name/message/code/details, never the stack.
    if (err?.stack) {
      error.stack = err.stack;
    }
    if (err.code === 'LOGIN_FAILED') {
      error.code = err.code;
    } else if (err.code === '22001' || err.code === '22003') {
      error.code = 'MAX_LENGTH_EXCEEDED';
    } else if (err.code === '22P02') {
      error.code = 'INTEGER_EXPECTED';
    } else {
      error.code = err.code;
    }
    next(error);
  };
};
