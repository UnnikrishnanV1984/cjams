'use strict';
const LOGGER = require("log4js").getLogger("form1080a");
const util = require('../utils/utils');
var app = require('../../server/server');

module.exports = function (Form1080a) {

  Form1080a.addupdate = function (request, reqctx) {
    let suserid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers && reqctx.req.headers.securityusersid) {
      suserid = reqctx.req.headers.securityusersid
    }
    var sql = 'select * from addupdateform1080a($1::json,$2::uuid)';
    var userid = request && request.securityuserid ? request.securityuserid : suserid;
    return util.executeDBQuery(sql, [request, userid])
      .then(data => {
        if (data.length > 0) {
          return data[0];
        } else {
          return { message: 'Please try again later', code: 500 };
        }
      })
      .catch(err => {
        LOGGER.error(err.message);
        return { message: err?.message, code: 500 };
      });
  };
  
  Form1080a.remoteMethod('addupdate', {
    accepts: [{
      arg: 'filter',
      type: 'Object',
      http: {
        source: 'body'
      },
      required: true
    }, {
      arg: 'reqctx',
      type: 'object',
      http: { source: 'context' }
    }]
    ,
    http: {
      path: '/addupdate',
      verb: 'post'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  
  /**
  * Retrieving complete Form 1080A by calling a single stored proc
  */
  Form1080a.getform1080adetails = async (request, reqctx) => {
    try {
      const form1080aid = request?.where?.form1080aid;
      if (!form1080aid) {
        throw new Error("form1080aid is required");
      }

      const sql = 'SELECT * FROM cjams.getform1080adetails($1::uuid)';

      return util.executeSecondaryNodeDBQuery(sql, [form1080aid])
      .then(data => {
          if (data && data.length > 0 && data[0].getform1080adetails) {
            return data[0].getform1080adetails;
          } else {
            return null; 
          }
      })
      .catch(err => {
          LOGGER.error("Error in getform1080adetails:", err.message);
          return util.logError(err);
      });
    } catch (err) {
      LOGGER.error('>>>>ERROR:', err);
      return util.logError(err);
    }
  };

  Form1080a.getForm1080a = async (request, reqctx) => {
    try {
      const form1080aid = request?.where?.form1080aid;
      if (!form1080aid) {
        throw new Error("form1080aid is required");
      }

      //helper function to build a proise around util.executeDBQuery we could move to common utils
      const executeSecondaryNodeDBQuery = (sql, params) => {
        return util.executeDBQuery(sql, params)
          .catch(err => { LOGGER.error('>>>>ERROR:', err); throw err; });
      };

      const form1080aQuery = `
        SELECT * FROM cjams.form1080a 
        WHERE form1080aid = $1 AND activeflag = 1
      `;
      const formRecordPromise = executeSecondaryNodeDBQuery(form1080aQuery, [form1080aid]);

      const maltreatorsQuery = `
        SELECT * FROM cjams.parentmaltreator1080forma 
        WHERE form1080aid = $1 AND isMaltreator = 1 AND activeflag = 1
      `;
      const maltreatorsPromise = executeSecondaryNodeDBQuery(maltreatorsQuery, [form1080aid]);

      const parentsQuery = `
        SELECT * FROM cjams.parentmaltreator1080forma 
        WHERE form1080aid = $1 AND isParent = 1 AND activeflag = 1
      `;
      const parentsPromise = executeSecondaryNodeDBQuery(parentsQuery, [form1080aid]);

      const otherChildrenQuery = `
        SELECT * FROM cjams.listotherchildren1080forma 
        WHERE form1080aid = $1 AND activeflag = 1
      `;
      const otherChildrenPromise = executeSecondaryNodeDBQuery(otherChildrenQuery, [form1080aid]);
      
      const householdChildrenQuery = `
        SELECT * FROM cjams.listotherchildrenhousehold1080forma 
        WHERE form1080aid = $1 AND activeflag = 1
      `;
      const householdChildrenPromise = executeSecondaryNodeDBQuery(householdChildrenQuery, [form1080aid]);

      //running all the db queries in parallel
      const [
        formRecordResult,
        maltreatorsResponse,
        parentsResponse,
        otherChildrenResponse,
        otherChildrenResponseHouseHold
      ] = await Promise.all([
        formRecordPromise,
        maltreatorsPromise,
        parentsPromise,
        otherChildrenPromise,
        householdChildrenPromise
      ]);

      if (!formRecordResult) {
        throw new Error("Form1080a record not found");
      }
      
      const formRecord = JSON.parse(JSON.stringify(formRecordResult[0]));

      //assembling all to return the final json object
      return {
        ...formRecord,
        maltreators: maltreatorsResponse || [],
        parents: parentsResponse || [],
        otherChildren: otherChildrenResponse || [],
        otherChildrenHouseHold: otherChildrenResponseHouseHold || [],
      };
    } catch (err) {
      LOGGER.error('>>>>ERROR:', err);
      return util.logError(err);
    }
  };

  Form1080a.remoteMethod('getform1080adetails', {
    accepts: [
      {
        arg: 'filter',
        type: 'object',
        required: true,
        http: { source: 'query' }
      },
      {
        arg: 'reqctx',
        type: 'object',
        http: { source: 'context' }
      }
    ],
    http: { verb: 'get', path: '/getForm1080a' },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Form1080a.list = function (request, reqctx) {
    let sql = 'select * from getform1080a($1::jsonb)';
    const param = {
      objectid: request.where.objectid
    };
    return util.executeSecondaryNodeDBQuery(sql, [JSON.stringify(param)])
    .then(data => {
        let response = [];
        if (data && data[0] && data[0].getform1080a) {
          response = data[0].getform1080a;
        }
        return response;
    })
    .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        return util.logError(err);
    });
  };

  
  Form1080a.remoteMethod('list', {
    accepts: [
      {
        arg: 'filter',
        type: 'Object',
        http: { source: 'query' },
        required: true
      },
      {
        arg: 'reqctx',
        type: 'object',
        http: { source: 'context' }
      }
    ],
    http: {
      path: '/list',
      verb: 'get'
    },
    returns: {
      type: 'Object',
      root: true
    }
  });

  Form1080a.delete = (form1080aid, reqctx) => {
    let suserid = undefined;
    if (reqctx && reqctx.req && reqctx.req.headers) {
      suserid = reqctx.req.headers.securityusersid
    }
    let sql = ` UPDATE form1080a SET activeflag=0, updatedby = $2, updatedon = now() WHERE form1080aid= $1 `;
    var params = [form1080aid, suserid];

    return util.executeDBQuery(sql, params)
      .then(data => {
        return data;
      })
      .catch(err => {
        LOGGER.error('>>>>ERROR:', err);
        throw err;
      });
  }

  Form1080a.remoteMethod('delete', {
    accepts:
      [{
        arg: 'form1080aid',
        type: 'string',
        required: true,
        http: { source: 'path' }
      },
      {
        arg: 'reqctx',
        type: 'object',
        http: { source: 'context' }
      }
      ],
    http: { "verb": "delete", "path": "/delete/:form1080aid" },
    returns: {
      type: 'Object',
      root: true
    }
  });
  
}