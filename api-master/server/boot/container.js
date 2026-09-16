'use strict';

module.exports = function (app) {
  // NOSONAR
  // app.dataSources.s3welfare.connector.getFilename = function (origFilename, req, res) {
  //   var origFilename = origFilename.name;
  //   var parts = origFilename.split('.'),
  //     extension = parts[parts.length - 1];
  //   var newFilename = (new Date()).getTime() + '_' + parts[parts.length - 2] + '.' + extension;
  //   return newFilename;
  // }
};
