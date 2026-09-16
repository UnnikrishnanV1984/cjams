'use strict';
const util = require('../utils/utils');
var app = require('../../server/server');
var fs = require('fs');
var config = require('../../server/config.json');
let path = require('path');

module.exports = function(Fileoutput){

  Fileoutput.docs = function(filename, res) {
   
    const mime = require('mime');
    const uploadRoot = path.resolve(app.dataSources.localstorage.settings.root,'docs');
    const requested = path.basename(filename);
    var dest = path.resolve(uploadRoot, requested);
    // ASCII fallback + RFC 5987 name: raw filenames with non-latin1 chars make
    // setHeader throw ERR_INVALID_CHAR.
    const ascii = requested.replace(/[^\x20-\x7e]/g, '_').replace(/["\\]/g, '_');
    res.setHeader('Content-Disposition',
      'inline; filename="' + ascii + '"; filename*=UTF-8\'\'' + encodeURIComponent(requested));
    res.setHeader('Content-Transfer-Encoding', 'binary');
    res.setHeader('Content-Type', mime.lookup(dest));
    res.sendFile(dest)
    
  }

  Fileoutput.remoteMethod('docs', {
    accepts: [
      {arg: 'filename', type: 'string', required: true},
      {arg: 'res', type: 'object', 'http': {source: 'res'}}
    ],
    http: {path: '/docs/:filename', verb: 'get'},
		returns: {type: 'file',	root: true}
  });
};