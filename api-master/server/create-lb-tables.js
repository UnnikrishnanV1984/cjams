'use strict';

/* eslint-disable */
var server = require('./server');
var ds = server.dataSources.hcuewelfare;
var lbTables = ['User', 'AccessToken', 'ACL', 'RoleMapping', 'Role'];
ds.automigrate(lbTables, function(er) {
  if (er) {throw er;}
  ds.disconnect();
});
