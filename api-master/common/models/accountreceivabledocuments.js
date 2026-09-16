'use strict';
const LOGGER = require("log4js").getLogger("accountreceivabledocuments");
const util = require('../utils/utils');
var server = require('../../server/server');
var app = require('../../server/server');
const attachement = require('./attachment');
var config = require('../../server/config.json'); 

module.exports = function (Accountreceivabledocuments) {

    Accountreceivabledocuments.addupdate = (request, reqctx) => {
        let _securityusersid = undefined;
        if(reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid){
          _securityusersid = reqctx.req.headers.securityusersid;
        }    
        if (request.accountreceivabledocumentsid !== undefined && request.accountreceivabledocumentsid !== null) {
            return Accountreceivabledocuments.updateaccountreceivabledocuments(request, _securityusersid);
        } else {
            return Accountreceivabledocuments.addaccountreceivabledocuments(request, _securityusersid);
        }
    }

    Accountreceivabledocuments.addaccountreceivabledocuments = function (request, _securityusersid) {
      
        return Accountreceivabledocuments.create({
            providerid: request.providerid,
            receivableid: request.receivableid,
            receivabledetailid: request.receivabledetailid,
            receivablebalance: request.receivablebalance,
            collectionstatus: request.collectionstatus,
            uploadedby: (request && request.securityuserid?request.securityuserid: _securityusersid),
            uploadpath: {'data' :request.uploadpath }, 
            activeflag: request.activeflag,
            filename  :request.filename,
            ecmsdocumentid: request.ecmsdocumentid
            
         }).then(data => {
            return data;
        })
            .catch(err => util.logError(err));

    }

    Accountreceivabledocuments.updateaccountreceivabledocuments = function (request, _securityusersid) {
       
        return Accountreceivabledocuments.updateAll({
            accountreceivabledocumentsid: request.accountreceivabledocumentsid
        }, {
                providerid: request.providerid,
                receivableid: request.receivableid,
                receivabledetailid: request.receivabledetailid,
                receivablebalance: request.receivablebalance,
                collectionstatus: request.collectionstatus,
                uploadedby: (request && request.securityuserid?request.securityuserid: _securityusersid),
                uploadpath: {'data' :request.uploadpath }, 
                activeflag: request.activeflag ,
                filename  :request.filename,
                ecmsdocumentid: request.ecmsdocumentid          
            
             }).then(data => {
                return "Account receivable documents Updated Successfully";
            })
            .catch(err => util.logError(err));
    }


    Accountreceivabledocuments.remoteMethod('addupdate', {
        accepts: [{
            arg: 'data',
            type: 'object',

            http: { source: 'body' }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: {source: 'context'}
          }],
        http: {
            'verb': 'post',
            'path': '/addupdate'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Accountreceivabledocuments.getaccountreceivabledocuments = function (request) {

        var pageno = request.page;
        var pagesize = request.limit;
        var providerid = request.where.providerid ? request.where.providerid : null;
        var sql = 'select * from getaccountreceivabledocuments($1 ,$2, $3)';
        var params = [providerid,pageno, pagesize];

        return util.executeDBQuery(sql, params)
            .then(data => {
                return data;
            })
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });

    };

    Accountreceivabledocuments.remoteMethod('getaccountreceivabledocuments', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            path: '/getaccountreceivabledocuments',
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    const DELETE_SUCCESS_MSG = 'Attachment Deleted Successfully ';

    // Every resolved path returns the same shape:
    //   { msg: string, data: <db result>, ecmsRes: <ecms result|null> }
    // so callers never have to test which branch ran.
    const deleteResult = (data, ecmsRes = null) => ({
      "msg": DELETE_SUCCESS_MSG,
      "ecmsRes": ecmsRes,
      "data": data
    });

    Accountreceivabledocuments.delete = (ids) => {
      const sql = 'UPDATE accountreceivabledocuments SET activeflag=0 WHERE accountreceivabledocumentsid=$1';

      if (config.state === false) {
        return util.executeDBQuery(sql, [ids])
        .then(data => deleteResult(data))
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
      }

      const idsArray = ids.split('&');
      const id = idsArray[0];   //DocumentPropertyID
      const docId = idsArray[1]; //ECMS ID
      // split() yields strings, so the old `idsArray?.[2] === 1` was never true.
      const skipEcms = idsArray?.[2] === '1';

      return util.executeDBQuery(sql, [id])
      .then(data => {
          // No ECMS id, or caller asked to skip ECMS: the row is already
          // deactivated, so report success rather than falling through and
          // resolving undefined as this used to. Wrapped in a promise so both
          // paths of this callback return the same type.
          if (skipEcms) {
            return Promise.resolve(deleteResult(data));
          }

          return attachement.deleteFileFromECMS(docId)
            .then(res => deleteResult(data, res))
            .catch(err1 => {
              // The row is deactivated either way and the file is gone from the
              // user's point of view, so this stays a resolved success - it just
              // records what ECMS reported. Matches Documentproperties.delete.
              LOGGER.error('>>>>ERROR: ECMS delete failed for ' + docId, err1);
              return {
                ...deleteResult(data),
                "statusCode": 400,
                "name": err1.name,
                "msg": err1.message,
                "customErrorMessage": "File already got deleted"
              };
            });
        })
      .catch(err => {
          LOGGER.error('>>>>ERROR:', err);
          throw err;
      });
    }
    
      Accountreceivabledocuments.remoteMethod('delete', {
        accepts:
        {
          arg: 'id',
          type: 'string',
          required: true,
          http: { source: 'path' }
        },
        http: { "verb": "delete", "path": "/delete/:id" },
        returns: {
          type: 'Object',
          root: true
        }
      });

        Accountreceivabledocuments.observe('before save', (ctx, next) => util.beforesave(ctx, next));
        Accountreceivabledocuments.observe('access', (ctx, next) => util.access(ctx, next));
        Accountreceivabledocuments.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}    
