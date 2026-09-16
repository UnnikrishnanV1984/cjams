'use strict';
const util = require('../utils/utils');
const app = require('../../server/server');
const LOGGER = require('log4js').getLogger('apgtpetition');

module.exports = function (Apgtpetition) {

  Apgtpetition.remoteMethod('addapgtpetition', {
    http: { path: '/addapgtpetition', verb: 'post' },
    accepts: [
      { arg: 'data', type: 'object', http: { source: 'body' } },
      { arg: 'reqctx', type: 'object', http: { source: 'context' } }
    ],
    returns: { type: 'object', root: true }
  });

  async function handleCreateChildren(created, req, userId, now) {
    try {
      await upsertChildren(created.apgtpetitionid, req.children || [], userId, now);
    } catch (childErr) {
      LOGGER.error('add: upsertChildren failed', childErr);
      util.logError?.(childErr);
      return { ...created, childrenStatus: 'failed' };
    }

    return created;
  }

  async function handleUpdateChildren(req, userId, now) {
    try {
      await upsertChildren(req.apgtpetitionid, req.children || [], userId, now);
    } catch (childErr) {
      LOGGER.error('update: upsertChildren failed', childErr);
      util.logError?.(childErr);
      return { apgtpetitionid: req.apgtpetitionid, status: 'updated (children failed)' };
    }

    return { apgtpetitionid: req.apgtpetitionid, status: 'updated' };
  }

  Apgtpetition.addapgtpetition = async function (req, reqctx) {
    const sec = util.getSecurityDetails(req, reqctx);
    const userId = sec.securityuserid;
    const now = new Date().toLocaleString();

    const isCreate = !req.apgtpetitionid;
    if (isCreate) {
      const header = {
        intakeservicerequestpetitionid: req.intakeservicerequestpetitionid,
        activeflag: 1,
        insertedby: userId, insertedon: now,
        updatedby: userId, updatedon: now
      };
  
      try {
        const created = await Apgtpetition.create(header);
        if (!created?.apgtpetitionid) {
          LOGGER.error('add: create returned no id', created);
          return { error: true, message: 'create failed' };
        }

      return await handleCreateChildren(created, req, userId, now);
      } catch (err) {
        LOGGER.error('add: create failed', err);
        util.logError?.(err);
        return { error: true, message: 'create failed', details: String(err?.message || err) };
      }
    }

      try { 
        const updRes = await Apgtpetition.updateAll(
          { apgtpetitionid: req.apgtpetitionid },
          { updatedby: userId, updatedon: now, activeflag: req.activeflag ?? 1 }
        );

        if (!updRes || !updRes.count) { 
          LOGGER.error('update: header update failed', updRes);
          return { apgtpetitionid: req.apgtpetitionid, status: 'update failed' };
        }

        const sdOk = await softDeleteChildren(req.apgtpetitionid, userId); 
        if (!sdOk) {
          return { apgtpetitionid: req.apgtpetitionid, status: 'children delete failed' }; 
        }

      return await handleUpdateChildren(req, userId, now);
      } catch (err) {
        LOGGER.error('update failed', err);
        util.logError?.(err);
        return { error: true, message: 'update failed', details: String(err?.message || err) };
    }
  };

  Apgtpetition.remoteMethod('list', {
    http: { path: '/list', verb: 'get' },
    accepts: [{ arg: 'filter', type: 'object', http: { source: 'query' } }],
    returns: { type: 'object', root: true }
  });

  Apgtpetition.list = async function (filter) {
    const isrPid = filter?.where?.intakeservicerequestpetitionid;
    if (!isrPid) return { data: [] };

    const headerSql = `
      SELECT * FROM apgtpetition
      WHERE activeflag=1 AND intakeservicerequestpetitionid=$1
      ORDER BY insertedon DESC LIMIT 1
    `;
    const headers = await util.executeDBQuery(headerSql, [isrPid]);
    if (!headers?.length) return { data: [] };

    const apgtpetitionid = headers[0].apgtpetitionid;

    const childrenSql = `
       SELECT
    c.*,
    la.primarycaregiver
  FROM apgtpetitionchildren c
  LEFT JOIN LATERAL (
    SELECT l.primarycaregiver
    FROM livingarrangement l
    WHERE l.placementid = c.placementid
      AND c.placementid IS NOT NULL
    ORDER BY l.insertedon DESC
    LIMIT 1
  ) la ON true
  WHERE c.activeflag=1
    AND c.apgtpetitionid=$1
    `;
    const children = await util.executeDBQuery(childrenSql, [apgtpetitionid]);

    const result = { data: headers, children };
   return (!filter?.isNotEncrpt ? util.encryptresponse(result) : result);
  };

  Apgtpetition.remoteMethod('delete', {
    http: { path: '/delete', verb: 'post' },
    accepts: [
      { arg: 'data', type: 'object', http: { source: 'body' } },
      { arg: 'reqctx', type: 'object', http: { source: 'context' } }
    ],
    returns: { type: 'object', root: true }
  });
  
  Apgtpetition.delete = async function (req, reqctx) {
    const userId = util.getSecurityDetails(req, reqctx).securityuserid;
  
    let apgtpetitionid = req.apgtpetitionid;
    const isrPid = req.intakeservicerequestpetitionid;
  
    try {
    if (!apgtpetitionid && isrPid) {
      const rows = await util.executeDBQuery(
        'SELECT apgtpetitionid FROM apgtpetition WHERE activeflag=1 AND intakeservicerequestpetitionid=$1',
        [isrPid]
      );
      apgtpetitionid = rows?.[0]?.apgtpetitionid;
    }
  
    if (!apgtpetitionid) {
      LOGGER.warn('delete: missing apgtpetitionid'); 
      return { status: 'missing id' };
    }
  
      const childrenOk = await softDeleteChildren(apgtpetitionid, userId); 
      if (!childrenOk) {
      return { apgtpetitionid, status: 'children delete failed' }; 
    }

    const updRes = await Apgtpetition.updateAll(
      { apgtpetitionid },
      { activeflag: 0, updatedby: userId, updatedon: new Date().toLocaleString() }
    );
  
      if (!updRes || !updRes.count) { 
        LOGGER.error('delete: header update failed', updRes);
        return { apgtpetitionid, status: 'delete failed' };
      }
  
      return { apgtpetitionid, status: 'deleted' };
    } catch (err) { 
      LOGGER.error('delete failed', err);
      util.logError?.(err);
      return { error: true, message: 'delete failed', details: String(err?.message || err) };
    }
  };
  
  
  async function softDeleteChildren(apgtpetitionid, userId) {
    const now = new Date().toLocaleString();
    try {
      const res = await app.models.Apgtpetitionchildren.updateAll(
        { apgtpetitionid, activeflag: 1 },
        { activeflag: 0, updatedby: userId, updatedon: now }
      );
      if (!res || typeof res.count !== 'number') {
        LOGGER.error('softDeleteChildren: unexpected response', res);
        return false;
      }
      return true;
    } catch (err) {
      LOGGER.error('softDeleteChildren failed', err);
      return false;
    }
  }
  

  async function upsertChildren(apgtpetitionid, children, userId, now) {
    if (!Array.isArray(children) || !children.length) return;
    for (const child of children) {
      try {
        await app.models.Apgtpetitionchildren.create({
          apgtpetitionid,
  
          intakeservicerequestactorid: child.intakeservicerequestactorid,
  
          personid: child.personid,
          firstcertificationdate: child.firstcertificationdate || null,
          disabilitynarrative: child.disabilitynarrative || null,
          vabenefits: child.vabenefits ?? null,
          vabenefitscomment: child.vabenefitscomment || null,
          financialsummary: child.financialsummary || null,
          secondcertificationbyactorid: child.secondcertificationbyactorid || null,
          secondcertificationappointment: child.secondcertificationappointment || null,
          interestedpersons: child.interestedpersons,
          placementid: child.placementid || null,  
          activeflag: 1,
          insertedby: userId, insertedon: now,
          updatedby: userId, updatedon: now
        });
      } catch (err) {
        LOGGER.error('child create payload failed', { child, err });
        throw err; 
      }
    }
  }
  

  Apgtpetition.observe('before save', (ctx, next) => util.beforesave(ctx, next));
  Apgtpetition.observe('access', (ctx, next) => util.access(ctx, next));
  Apgtpetition.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
};