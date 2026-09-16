'use strict';
const loopback = require('loopback');
var app = require('../../server/server');
const util = require('../utils/utils');

module.exports = function(Localstorage) {

    Localstorage.saveFile = function(ctx,res,srno) {
        var returnData = {};
        return new Promise((resolve, reject) => {
            var conname = 'uploads';

            // This needs to be commented later
            if(ctx.req.fileUploaded){
                returnData.filename = ctx.req.filename;
                resolve(returnData);
                return;
            }
            
            Localstorage.upload(ctx.req, res, {container: conname}, function(err,resp) {
                if (err)  
                    {reject(err);}
                else {
                    returnData.filename = resp.files.file[0].name;
                    ctx.req.fileUploaded = true;
                    ctx.req.filename = resp.files.file[0].name;
                    resolve(returnData);
                }
            });
        });
    }

    Localstorage.remoteMethod('saveFile', {
        accepts: [
            {arg: 'req', type: 'object', 'http': {source: 'context'}},
            {arg: 'res', type: 'object', 'http': {source: 'res'}},
            {arg: 'srno', type: 'string','http': {source: 'query'}}
            ],
        http: { path: '/saveFile', verb: 'post' },
        returns: {  type: 'json',  root : true }
    });
         
    Localstorage.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Localstorage.observe('access', (ctx, next) => util.access(ctx, next));
    Localstorage.beforeRemote('*', (ctx,data, next) => util.beforeremote(ctx, next)); 
};
