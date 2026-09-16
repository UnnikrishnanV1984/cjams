/**
 * Binti API Utility
 * Provides helper functions for interacting with the Binti API, including logging and error handling.
 */
const axios = require('axios');
const config = require('../../server/config.json');
const commonapi = require('./commonapi');
const LOGGER = require("log4js").getLogger("intakeservreqchildremoval");
const util = require('../utils/utils');
var app = require('../../server/server');

const DEFAULT_SOCIAL_CONNECTION_MAPPING = Object.freeze({
  kinshipRelationship: 'unknown',
  lineageType: null,
  bintiRoleLabel: 'Unknown',
  isMapped: false,
});

const SOCIAL_CONNECTION_REFERENCE_TYPE_ID = 91001;
const GENDER_REFERENCE_TYPE_ID = 91002;
const SOCIAL_CONNECTION_PARENT_KEYS = ['BINTI_ROLE'];
const GENDER_REFERENCE_PARENT_KEY = 'BINTI_GENDER';
const GENDER_REFERENCE_TEAM_TYPE_KEY = 'CW';
const formatDateForBinti = util.formatISODateOnly;

function normalizeRelationshipKey(value) {
  return util.normalizeCompactUpperKey(value);
}

function normalizeMapperKey(value) {
  return util.normalizeCompactLowerKey(value);
}

function isValidHeaderName(name) {
  if (!name || typeof name !== 'string') {
    return false;
  }
  const validTokenRegex = /^[!#$%&'*+\-.0-9A-Za-z^_`|~]+$/;
  return validTokenRegex.test(name);
}

async function loadGenderReferenceMap() {
  try {
    const sql = `
      SELECT ref_key, value_text
      FROM cjams.referencevalues
      WHERE activeflag = 1
        AND referencetypeid = $1
        AND upper(trim(coalesce(parentkey, ''))) = $2
        AND upper(trim(coalesce(teamtypekey, ''))) = $3
    `;

    const rows = await util.executeDBQuery(sql, [
      GENDER_REFERENCE_TYPE_ID,
      GENDER_REFERENCE_PARENT_KEY,
      GENDER_REFERENCE_TEAM_TYPE_KEY,
    ]);

    const byKey = {};
    (rows || []).forEach((row) => {
      const normalizedRefKey = normalizeMapperKey(row?.ref_key);
      const mappedValue = (row?.value_text || '').toString().trim();
      if (normalizedRefKey && mappedValue) {
        byKey[normalizedRefKey] = mappedValue;
      }
    });

    return byKey;
  } catch (err) {
    LOGGER.error('Failed to load gender mapping from referencevalues', err);
    return {};
  }
}

async function mapGenderForBinti(gender) {
  const normalized = normalizeMapperKey(gender);
  if (!normalized) {
    return null;
  }

  const genderReferenceMap = await loadGenderReferenceMap();
  const mappedFromDb = genderReferenceMap[normalized];
  if (mappedFromDb) {
    return mappedFromDb;
  }

  return null;
}

async function loadSocialConnectionReferenceMap() {
  try {
    const sql = `
      SELECT ref_key, value_text, description, mdmcode
      FROM cjams.referencevalues
      WHERE activeflag = 1
        AND referencetypeid = $1
        AND upper(trim(coalesce(parentkey, ''))) = ANY($2::text[])
    `;

    const rows = await util.executeDBQuery(sql, [
      SOCIAL_CONNECTION_REFERENCE_TYPE_ID,
      SOCIAL_CONNECTION_PARENT_KEYS.map((key) => key.toUpperCase()),
    ]);

    const byKey = {};
    const byDescription = {};

    (rows || []).forEach((row) => {
      const normalizedRefKey = normalizeRelationshipKey(row?.ref_key);
      const normalizedDescription = normalizeRelationshipKey(row?.description);

      const mappedValue = {
        kinshipRelationship: (row?.value_text || DEFAULT_SOCIAL_CONNECTION_MAPPING.kinshipRelationship).toString().trim().toLowerCase(),
        lineageType: row?.mdmcode ? row.mdmcode.toString().trim().toLowerCase() : null,
        bintiRoleLabel: row?.description || row?.value_text || DEFAULT_SOCIAL_CONNECTION_MAPPING.bintiRoleLabel,
        isMapped: true,
      };

      if (normalizedRefKey) {
        byKey[normalizedRefKey] = mappedValue;
      }
      if (normalizedDescription) {
        byDescription[normalizedDescription] = mappedValue;
      }
    });

    return { byKey, byDescription };
  } catch (err) {
    LOGGER.error('Failed to load social connection mapping from referencevalues', err);
    return { byKey: {}, byDescription: {} };
  }
}

async function resolveSocialConnectionMapping(relationshipTypeKey, relationshipTypeDescription) {
  const normalizedKey = normalizeRelationshipKey(relationshipTypeKey);
  const normalizedDescription = normalizeRelationshipKey(relationshipTypeDescription);

  const referenceMap = await loadSocialConnectionReferenceMap();
  const mapped = referenceMap.byKey[normalizedKey] || referenceMap.byDescription[normalizedDescription];

  if (mapped) {
    return mapped;
  }

  return {
    ...DEFAULT_SOCIAL_CONNECTION_MAPPING,
    bintiRoleLabel: relationshipTypeDescription || relationshipTypeKey || DEFAULT_SOCIAL_CONNECTION_MAPPING.bintiRoleLabel,
  };
}

function buildSocialConnectionExternalIdentifier(childBintiId, relativeCjamsPid, kinshipRelationship) {
  const normalizedKinship = (kinshipRelationship || 'unknown').toString().trim().toUpperCase();
  return `SC_${childBintiId}_${relativeCjamsPid}_${normalizedKinship}`;
}


async function initFamilyFindingSearchForChild(clientInfo, _securityusersid) {
  if (!clientInfo.bintiChildId) {
    LOGGER.error('Cannot create family finding search: clientInfo missing bintiChildId', clientInfo);
    return { success: false, message: 'Cannot create family finding search: clientInfo missing bintiChildId' };
  }
  let externalapilogsid = null;
  let bintiCaseId = null;
  const familyFindingsInfo = {
    bintiChildId: clientInfo.bintiChildId,
    searchDate: clientInfo.searchDate
  };
  try {
    const familyFindingResponse = await createFamilyFindingSearch(clientInfo.bintiChildId, { 'start-date': clientInfo.searchDate });
    externalapilogsid = familyFindingResponse?.externalapilogsid;
    if (!familyFindingResponse?.data?.id) {
      LOGGER.error('Family finding search creation did not return expected data', familyFindingResponse);
      return { success: false, message: 'Failed to create family finding search: No id returned', externalapilogsid };
    } else {
      bintiCaseId = familyFindingResponse?.data?.id;
      LOGGER.info('Family finding search created successfully', { caseId: familyFindingResponse.data.id, externalapilogsid });
      familyFindingsInfo.binticasenumber = bintiCaseId;
      familyFindingsInfo.binticasestartdate = clientInfo.searchDate;
      familyFindingsInfo.cjamspid = clientInfo.cjamspid;
      familyFindingsInfo.externalapilogsid = externalapilogsid;
      familyFindingsInfo.insertedby = _securityusersid;
      familyFindingsInfo.updatedby = _securityusersid;
      const sql = 'select * from addorupdatefamilyfindings($1::json)';
      try {
        const result = await util.executeDBQuery(sql, [familyFindingsInfo]);
        LOGGER.info('addorupdatefamilyfindings executed successfully', { result });

        if (!result?.[0]?.addorupdatefamilyfindings) {
          LOGGER.error('addorupdatefamilyfindings did not return expected result', result);
          return { success: false, message: 'Failed to execute addorupdatefamilyfindings: No result returned', externalapilogsid };
        } else if (result[0].addorupdatefamilyfindings === false) {
          LOGGER.error('addorupdatefamilyfindings returned false', result);
          return { success: false, message: 'addorupdatefamilyfindings returned false', externalapilogsid };
        }

      }
      catch (err) {
        LOGGER.error('Error executing addorupdatefamilyfindings', err);

        return { success: false, message: 'Failed to execute addorupdatefamilyfindings', error: err, externalapilogsid };
      }

      return { success: true, caseId: familyFindingResponse?.data?.id, externalapilogsid: familyFindingResponse?.externalapilogsid };
    }
  } catch (err) {
    LOGGER.error('Error creating family finding search', err);
    return { success: false, message: 'Failed to create family finding search', error: err };
  }
}


async function syncBintiClientToDb(clientInfo, bintiChildId, externalapilogsid, _securityusersid) {
  clientInfo.binti_client_id = bintiChildId;
  clientInfo.insertedby = _securityusersid;
  clientInfo.updatedby = _securityusersid;
  clientInfo.externalapilogsid = externalapilogsid;
  const sql = 'select * from addorupdatebinticlient($1::json)';
  try {
    await util.executeDBQuery(sql, [clientInfo]);
    return { success: true, bintiChildId, externalapilogsid };
  } catch (err) {
    LOGGER.error('Error executing addorupdatebinticlient', err);
    return { success: false, message: 'Failed to execute addorupdatebinticlient', error: err, externalapilogsid, bintiChildId };
  }
}

async function ensureBintiChildAndSync(clientInfo, _securityusersid) {
  let bintiChildId = clientInfo.binticlientid;
  let externalapilogsid = null;
  let bintiChild = null;
  if (!bintiChildId) {
    bintiChild = await findChildByExternalId(clientInfo.cjamspid);
    if (bintiChild?.id) {
      const bintiRes = await updateChild(bintiChild.id, {
        first_name: clientInfo.firstname,
        last_name: clientInfo.lastname,
        date_of_birth: formatDateForBinti(clientInfo.dob),
        gender: clientInfo.gender,
        counties: [clientInfo.county]
      });
      bintiChildId = bintiRes.data.id;
      externalapilogsid = bintiRes.externalapilogsid;
    } else {
      try {
        const childData = {
          first_name: clientInfo.firstname,
          last_name: clientInfo.lastname,
          client_id: clientInfo.cjamspid,
          date_of_birth: formatDateForBinti(clientInfo.dob),
          gender: clientInfo.gender,
          counties: [clientInfo.county]
        };
        const bintiResp = await createChild(childData);
        externalapilogsid = bintiResp?.externalapilogsid;
        bintiChildId = bintiResp?.data?.id;
        if (!bintiChildId) {
          LOGGER.error('Binti createChild did not return id', bintiResp);
          return { success: false, message: 'Failed to create Binti child: No id returned' };
        }
        clientInfo.bintiChildId = bintiChildId;
      } catch (err) {
        LOGGER.error('Error creating Binti child', err);
        return { success: false, message: 'Failed to create Binti child', error: err };
      }
    }
    const syncResult = await syncBintiClientToDb(clientInfo, bintiChildId, externalapilogsid, _securityusersid);
    if (!syncResult.success) return syncResult;
    return { success: true, message: 'Binti child created and DB sync complete', bintiChildId, externalapilogsid };
  } else {
    const bintiRes = await updateChild(bintiChildId, {
      first_name: clientInfo.firstname,
      last_name: clientInfo.lastname,
      date_of_birth: formatDateForBinti(clientInfo.dob),
      gender: clientInfo.gender,
      counties: [clientInfo.county]
    });
    bintiChildId = bintiRes.data.id;
    externalapilogsid = bintiRes.externalapilogsid;
    return syncBintiClientToDb(clientInfo, bintiChildId, externalapilogsid, _securityusersid);
  }
}


function deriveObjectSubtype(endpoint, method) {
  return util.deriveApiObjectSubtype(endpoint, method, 'binti_api');
}


function buildEsbPath(endpoint, method) {
  const basePath = endpoint.split('?')[0].replace(/\/\d+/g, '');

  // Direct ESB path mapping
  if (method === 'GET' && basePath.includes('/agency_workers')) return '/agencies';
  if (method === 'POST' && basePath.includes('/worker_assignments')) return '/worker_assignment';
  if (method === 'GET' && basePath.includes('/worker_assignments')) return '/worker_assignment';
  if (basePath.includes('/children/') && basePath.includes('/family_finding_searches')) {
    return '/children/family_finding_searches';
  }
  if (basePath.includes('/family_finding_searches')) {
    if (method === 'GET' && endpoint.includes('child_id=')) {
      return '/children/family_finding_searches';
    }
    return '/family/family_finding_searches';
  }
  if (basePath.includes('/social_connections')) return '/social_connections';
  if (basePath.includes('/children')) return '/children';

  throw new Error(`No ESB mapping for: ${method} ${endpoint}`);
}

function buildRequestHeaders(basePath, queryParams, endpoint) {
  const headers = {
    accept: 'application/json',
    'x-api-key': app.get('apiKeys').ESB_BINTI_API_KEY,
    'content-type': 'application/json',
  };

  // Only add query parameters with valid HTTP header names
  // Special handling below will provide sanitized versions for params with invalid chars
  for (const [key, value] of queryParams.entries()) {
    if (isValidHeaderName(key)) {
      headers[key] = value;
    } else {
      LOGGER.debug(`Skipping invalid header name from query param: ${key}`);
    }
  }

  const childIdMatch = basePath.match(/\/children\/(\d+)/);
  if (childIdMatch && childIdMatch[1]) {
    headers.child_id = childIdMatch[1];
  }

  const familyFindingSearchMatch = (endpoint || '').match(/\/family_finding_searches\/([^/?]+)/);
  if (familyFindingSearchMatch && familyFindingSearchMatch[1]) {
    headers.family_finding_search_id = familyFindingSearchMatch[1];
  }

  return headers;
}

async function executeWithRetry(options, externalapidata, endpoint, esbPath) {
  const attachErrorMetadata = retrunAttachErrorMetadataFn(esbPath, endpoint);

  const persistErrorLog = async (errorDetails) => {
    externalapidata.response = errorDetails;
    externalapidata.resstatus = 'error';
    const logResult = await commonapi.addupdateexternalapilogs(externalapidata).catch(() => null);
    return logResult || null;
  };

  const buildFinalError = returnBuildFinalErrorFn(attachErrorMetadata);

  let externalapilogsid = null;
  let lastError = null;
  for (let attempt = 1; attempt <= 2; attempt++) {
    try {
      const axiosResponse = await axios(options);
      const response = axiosResponse.data;
      externalapidata.response = response;
      externalapidata.resstatus = 'success';
      const logResult = await commonapi.addupdateexternalapilogs(externalapidata).catch(() => null);
      externalapilogsid = logResult || null;
      if (response && typeof response === 'object') {
        response.externalapilogsid = externalapilogsid;
      }
      return response;
    } catch (error) {
      lastError = error;
      const errorDetails = error.response?.data || error.message || error;

      LOGGER.error(`[BINTI ESB] Error calling ${options.method} ${endpoint} → ${esbPath}`, {
        statusCode: error.response?.status,
        error: errorDetails,
        attempt
      });

      externalapilogsid = await persistErrorLog(errorDetails);

      if (attempt === 2) {
        throw buildFinalError(error, attempt, externalapilogsid);
      }

      await new Promise(res => setTimeout(res, 2000));
    }
  }
  throw lastError;
}

function returnBuildFinalErrorFn(attachErrorMetadata) {
  return (error, attempt, logsid) => {
    attachErrorMetadata(error, logsid);
    attachErrorMetadata(error?.response?.data, logsid);

    if (attempt === 2 && error?.response?.data && typeof error.response.data === 'object') {
      return error.response.data;
    }

    return error;
  };
}

function retrunAttachErrorMetadataFn(esbPath, endpoint) {
  return (target, logsid) => {
    if (target && typeof target === 'object') {
      target.externalapilogsid = logsid;
      target.esbEndpoint = esbPath;
      target.bintiEndpoint = endpoint;
    }
  };
}

async function resolveWorkerLookupByEmail(email) {
  if (!email) {
    return { agencyWorkerId: null, externalapilogsid: null };
  }

  const lookup = await lookupAgencyWorkerSafe(email);
  return {
    agencyWorkerId: lookup?.agencyWorkerId || null,
    externalapilogsid: lookup?.externalapilogsid || null,
  };
}

async function resolveWorkerAssignmentLookup(servicecaseid, cjamspid) {
  if (!servicecaseid || !cjamspid) {
    return { agencyWorkerId: null, externalapilogsid: null };
  }

  const assignedWorkerEmail = await getAssignedCaseWorkerEmail(servicecaseid, cjamspid);
  if (!assignedWorkerEmail) {
    LOGGER.warn('No assigned case worker found in database', { servicecaseid, cjamspid });
    return { agencyWorkerId: null, externalapilogsid: null };
  }

  LOGGER.info('Found assigned case worker for worker assignment', {
    assignedWorkerEmail,
    servicecaseid,
    cjamspid
  });

  return resolveWorkerLookupByEmail(assignedWorkerEmail);
}

async function createWorkerAssignment({ agencyWorkerId, bintiChildId, servicecaseid, cjamspid }) {
  if (!servicecaseid || !cjamspid) {
    return;
  }

  if (!agencyWorkerId || !bintiChildId) {
    LOGGER.info('Skipping worker assignment - worker not found in Binti', {
      servicecaseid,
      cjamspid,
      workerAssignmentAgencyWorkerId: agencyWorkerId
    });
    return;
  }

  try {
    await bintiApiRequest('/worker_assignments', 'POST', {
      data: {
        type: 'worker-assignments',
        attributes: { role: 'case-carrying' },
        relationships: {
          worker: { data: { type: 'agency-workers', id: agencyWorkerId } },
          child: { data: { type: 'children', id: bintiChildId } }
        }
      }
    }, {
      objecttype: 'binti_worker_assignment_create',
      objectsubtype: 'worker_assignments_create'
    });
    LOGGER.info('Worker assignment created successfully', {
      workerAssignmentAgencyWorkerId: agencyWorkerId,
      bintiChildId
    });
  } catch (err) {
    LOGGER.error('Error assigning worker to child in Binti', err);
  }
}

async function createOrUpdateFamilyFindingSearchRequest({ bintiCaseId, familyFindingPayload }) {
  if (bintiCaseId) {
    return bintiApiRequest(`/family_finding_searches/${bintiCaseId}`, 'PUT', familyFindingPayload);
  }

  return bintiApiRequest('/family_finding_searches', 'POST', familyFindingPayload);
}

async function syncFamilyFindingRecord({ bintiChildId, searchDate, familyFindingResponse, externalapilogsid, agencySecurityUserId, agencyWorkerId, cjamspid, insertedby, updatedby }) {
  if (!familyFindingResponse?.data?.id) {
    return null;
  }

  const familyFindingsInfo = {
    bintiChildId,
    searchDate,
    binticasenumber: familyFindingResponse.data.id,
    binticasestartdate: searchDate,
    externalapilogsid,
    caseworkerid: agencySecurityUserId,
    caseworkeragencyid: agencyWorkerId,
    cjamspid,
    insertedby,
    updatedby
  };

  try {
    const sql = 'select * from addorupdatefamilyfindings($1::json)';
    return await util.executeDBQuery(sql, [familyFindingsInfo]);
  } catch (err) {
    LOGGER.error('Error executing addorupdatefamilyfindings', err);
    return { error: err };
  }
}

async function bintiApiRequest(endpoint, method, body, logDetails = {}) {
  if (!config.binti || !config.binti.esb_base_url) {
    throw new Error('Binti ESB configuration missing in config.binti');
  }

  const [basePath, queryString] = endpoint.split('?');
  const queryParams = new URLSearchParams(queryString || '');

  const esbPath = buildEsbPath(endpoint, method);
  const url = `${config.binti.esb_base_url}${esbPath}`;

  LOGGER.info(`[BINTI ESB] Calling ${method} ${endpoint} → ESB: ${esbPath}`);

  const headers = buildRequestHeaders(basePath, queryParams, endpoint);
  const requestDebugHeaders = {
    child_id: headers.child_id || null,
    family_finding_search_id: headers.family_finding_search_id || null,
  };

  const options = {
    method,
    url: url,
    headers,
    data: body,
  };

  const objectid = logDetails.caseid || '00000000-0000-0000-0000-000000000000';
  const objectsubtype = logDetails.objectsubtype || deriveObjectSubtype(endpoint, method);
  const externalapidata = {
    details: {
      ...logDetails,
      objecttype: logDetails.objecttype || 'binti_api',
      objectsubtype,
      updatedby: logDetails.updatedby || 'System',
      insertedby: logDetails.insertedby || 'System',
      objectid,
    },
    request: { endpoint, method, body, esbPath, requestDebugHeaders },
    response: null,
    resstatus: '',
    status: 'add',
  };

  return executeWithRetry(options, externalapidata, endpoint, esbPath);
}

async function findAgencyWorkerByEmail(agencyWorkerEmail) {
  if (!agencyWorkerEmail) {
    return { agencyWorkerId: null, externalapilogsid: null };
  }

  const normalizedEmail = agencyWorkerEmail.trim().toLowerCase();
  if (!normalizedEmail) {
    return { agencyWorkerId: null, externalapilogsid: null };
  }

  const endpoint = `/agency_workers?email=${normalizedEmail}`;
  const agencyWorkersResp = await bintiApiRequest(endpoint, 'GET', null, {
    objecttype: 'binti_agency_workers',
    objectsubtype: 'agency_workers_get'
  });

  const externalapilogsid = agencyWorkersResp?.externalapilogsid || null;
  const workers = Array.isArray(agencyWorkersResp?.data) ? agencyWorkersResp.data : [];

  const matched =
    workers.find(w =>
      w?.attributes?.email &&
      w.attributes.email.trim().toLowerCase() === normalizedEmail
    ) || workers[0];

  return { agencyWorkerId: matched?.id || null, externalapilogsid };
}

async function lookupAgencyWorkerSafe(agencyWorkerEmail) {
  try {
    const agencyWorkerLookup = await findAgencyWorkerByEmail(agencyWorkerEmail);
    if (agencyWorkerLookup) {
      return { agencyWorkerId: agencyWorkerLookup.agencyWorkerId, externalapilogsid: agencyWorkerLookup.externalapilogsid || null };
    }
    return { agencyWorkerId: null, externalapilogsid: null };
  } catch (err) {
    LOGGER.error('Error fetching agency workers from Binti', err);
    return { agencyWorkerId: null, externalapilogsid: null };
  }
}

function buildFamilyFindingPayload(bintiChildId, searchDate, agencyWorkerId) {
  const familyFindingPayload = {
    data: {
      type: 'family-finding-searches',
      attributes: {
        'start-date': searchDate,
        'end-date': null
      }
    }
  };
  if (agencyWorkerId) {
    familyFindingPayload.data.relationships = {
      'agency-workers': {
        data: [{ type: 'agency-workers', id: agencyWorkerId }]
      },
      child: { data: { type: 'children', id: bintiChildId } }
    };
  } else {
    familyFindingPayload.data.relationships = {
      child: { data: { type: 'children', id: bintiChildId } }
    };
  }
  return familyFindingPayload;
}

async function getAssignedCaseWorkerEmail(caseid, cjamspid) {
  if (!caseid || !cjamspid) {
    return null;
  }

  try {
    const sql = `
      SELECT coalesce(
        (SELECT u.email
         FROM caseassignment ca
         JOIN caseassignmentactor cr ON cr.caseassignmentid = ca.caseassignmentid
         JOIN intakeservicerequestactor isr ON isr.intakeservicerequestactorid = cr.intakeservicerequestactorid
           AND isr.activeflag = 1
         JOIN userprofile u ON ca.toworkeridno = u.securityusersid
           AND u.activeflag = 1
         WHERE ca.objectid = $1
           AND lower(ca.responsibilitytypekey) = 'child'
           AND ca.activeflag = 1
           AND ca.enddate IS NULL
           AND isr.personid IN (
             SELECT personid FROM person
             WHERE activeflag = 1
               AND cjamspid = $2
           )
         ORDER BY ca.insertedon DESC
         LIMIT 1
        ),
        -- Get the Family Assignment
        (SELECT u.email
         FROM caseassignment ca
         JOIN userprofile u ON ca.toworkeridno = u.securityusersid
           AND u.activeflag = 1
         WHERE ca.objectid = $1
           AND lower(ca.responsibilitytypekey) = 'family'
           AND ca.activeflag = 1
           AND ca.enddate IS NULL
         ORDER BY ca.insertedon DESC
         LIMIT 1
        )
      ) AS assigned_worker_email
    `;

    const rows = await util.executeSecondaryNodeDBQuery(sql, [caseid, cjamspid]);
    return rows?.[0]?.assigned_worker_email || null;
  } catch (err) {
    LOGGER.error('Failed to get assigned case worker email', { caseid, cjamspid, error: err });
    return null;
  }
}

async function createFamilyFindingSearchWithWorker({ bintiChildId, searchDate, agencyWorkerEmail, agencySecurityUserId, insertedby, updatedby, cjamspid, bintiCaseId, servicecaseid }) {
  const familyFindingLookup = await resolveWorkerLookupByEmail(agencyWorkerEmail);
  let externalapilogsid = familyFindingLookup.externalapilogsid;
  const agencyWorkerId = familyFindingLookup.agencyWorkerId;

  const workerAssignmentLookup = await resolveWorkerAssignmentLookup(servicecaseid, cjamspid);
  if (workerAssignmentLookup.externalapilogsid) {
    externalapilogsid = workerAssignmentLookup.externalapilogsid;
  }

  await createWorkerAssignment({
    agencyWorkerId: workerAssignmentLookup.agencyWorkerId,
    bintiChildId,
    servicecaseid,
    cjamspid,
  });

  const familyFindingPayload = buildFamilyFindingPayload(bintiChildId, searchDate, agencyWorkerId);
  let familyFindingResponse;
  try {
    familyFindingResponse = await createOrUpdateFamilyFindingSearchRequest({ bintiCaseId, familyFindingPayload });
    externalapilogsid = familyFindingResponse?.externalapilogsid;
  } catch (err) {
    LOGGER.error('Failed to create/update family finding search for child', err);
    return {
      success: false,
      error: err?.message || err,
      agencyWorkerId,
      externalapilogsid
    };
  }

  const dbSyncResult = await syncFamilyFindingRecord({
    bintiChildId,
    searchDate,
    familyFindingResponse,
    externalapilogsid,
    agencySecurityUserId,
    agencyWorkerId,
    cjamspid,
    insertedby,
    updatedby,
  });

  return {
    success: true,
    data: familyFindingResponse,
    agencyWorkerId,
    externalapilogsid,
    dbSyncResult
  };
}


async function findChildByExternalId(externalId) {
  if (!externalId) {
    return null;
  }
  const endpoint = `/children?external_identifier=${externalId}`;
  try {
    const resp = await bintiApiRequest(endpoint, 'GET', null, {
      objecttype: 'child_get',
      objectsubtype: 'children_get'
    });
    if (resp && Array.isArray(resp.data) && resp.data.length > 0) {
      return { ...resp.data[0], externalapilogsid: resp.externalapilogsid };
    }
    return null;
  } catch (err) {
    if (err?.externalapilogsid) {
      return { error: err, externalapilogsid: err.externalapilogsid };
    }
    return null;
  }
}

async function updateFamilyFindingSearch(familyFindingSearchId, attributes, logDetails = {}) {
  const body = {
    type: 'family-finding-searches',
    data: { attributes }
  };
  return bintiApiRequest(
    `/family_finding_searches/${familyFindingSearchId}`,
    'PUT',
    body,
    {
      objecttype: 'family_finding_search_update',
      objectsubtype: 'family_finding_searches_update',
      ...logDetails
    }
  );
}

async function createSocialConnectionForChild({ childId, relationshipTypeKey, relationshipTypeDescription, connectionPerson, externalIdentifier, logDetails = {} }) {
  if (!childId) {
    throw new Error('childId is required to create social connection');
  }

  const mapping = await resolveSocialConnectionMapping(relationshipTypeKey, relationshipTypeDescription);
  const payload = {
    data: {
      type: 'social-connections',
      attributes: {
        'kinship-relationship': mapping.kinshipRelationship,
        'lineage-type': mapping.lineageType,
        'external-identifier': externalIdentifier,
      },
      relationships: {
        'connection-person': {
          data: {
            type: 'people',
            attributes: {
              'first-name': connectionPerson.firstName || null,
              'middle-name': connectionPerson.middleName || null,
              'last-name': connectionPerson.lastName || null,
              'date-of-birth': connectionPerson.dateOfBirth || null,
              'gender': connectionPerson.gender || null,
            },
          },
        },
      },
    },
  };

  return bintiApiRequest(
    `/children/${childId}/relationships/social_connections`,
    'POST',
    payload,
    {
      objecttype: 'binti_social_connection_create',
      objectsubtype: 'social_connections_create',
      ...logDetails,
    }
  );
}

async function listSocialConnectionsForChild(childId, logDetails = {}) {
  if (!childId) {
    throw new Error('childId is required to list social connections');
  }

  return bintiApiRequest(
    `/children/${childId}/relationships/social_connections`,
    'GET',
    null,
    {
      objecttype: 'binti_social_connection_list',
      objectsubtype: 'social_connections_list',
      ...logDetails,
    }
  );
}


async function createChild(childData) {
  return bintiApiRequest(
    '/children',
    'POST',
    { child: childData },
    {
      objecttype: 'binti_child_create',
      objectsubtype: 'children_create',
      updatedby: 'System',
      insertedby: 'System',
    }
  );
}


async function getChild(childId) {
  return bintiApiRequest(
    `/children/${childId}`,
    'GET',
    null,
    {
      objecttype: 'binti_child_get',
      objectsubtype: 'children_get',
      updatedby: 'System',
      insertedby: 'System',
    }
  );
}

async function updateChild(childId, childData) {
  return bintiApiRequest(
    `/children/${childId}`,
    'PUT',
    { child: childData },
    {
      objecttype: 'binti_child_update',
      objectsubtype: 'children_update',
      updatedby: 'System',
      insertedby: 'System',
    }
  );
}

async function createFamilyFindingSearch(childId, attributes) {
  const body = {
    type: 'family-finding-searches',
    data: { attributes },
  };
  return bintiApiRequest(
    `/children/${childId}/relationships/family_finding_searches`,
    'POST',
    body,
    {
      objecttype: 'binti_family_finding_search',
      objectsubtype: 'family_finding_searches_create'
    }
  );
}

module.exports = {
  bintiApiRequest,
  createChild,
  createSocialConnectionForChild,
  listSocialConnectionsForChild,
  getChild,
  updateChild,
  createFamilyFindingSearch,
  findChildByExternalId,
  ensureBintiChildAndSync,
  initFamilyFindingSearchForChild,
  createFamilyFindingSearchWithWorker,
  buildSocialConnectionExternalIdentifier,
  mapGenderForBinti,
  formatDateForBinti,
  resolveSocialConnectionMapping,
  updateFamilyFindingSearch,
  getAssignedCaseWorkerEmail,
};