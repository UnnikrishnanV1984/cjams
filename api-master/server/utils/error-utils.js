'use strict';

const servererrmsg = 'Internal server error';
const exceptionObject = {
  'ProcessRequestsResult': {
    'Response': {
      'Exception': {
        'Message': servererrmsg,
        'StackTrace': '',
        'Type': '',
      },
      'ExceptionType': 'Unknown',
      'IsCached': 'false',
    },
  },
};

const formatExceptionError = (err) => {
  const error = exceptionObject;
  error.ProcessRequestsResult.Response.Exception.Message = err.message || servererrmsg;
  error.ProcessRequestsResult.Response.Exception.StackTrace = err.stack || servererrmsg;
  error.ProcessRequestsResult.Response.Exception.Type = err.code || servererrmsg;
  return error;
};

module.exports = {
  exceptionObject,
  formatExceptionError,
};
