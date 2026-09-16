'use strict';
const LOGGER = require("log4js").getLogger("intakeservreqchildremoval");
const util = require('../utils/utils');
var app = require('../../server/server');
var email = require('../models/email');
var binti = require('./binti');
const childremovalreviewmsg = 'Child Removal Submitted for review';
const childremovalapprovedmsg = 'Child Removal approved';
const childremovalrejectedmsg = 'Child Removal Rejected';
var config = require('../../server/config.json');

function addRemovalAttachments(attachments, objectid, caller) {
    attachments.forEach(attach => {
        attach.objectid = objectid;
        try {
            const attachPromise = app.DocumentProperties.addattchment(attach);
            if (attachPromise && typeof attachPromise.catch === 'function') {
                attachPromise.catch(err => LOGGER.error('Error adding attachment in ' + caller, err));
            }
        } catch (e) {
            LOGGER.error('Exception adding attachment in ' + caller, e);
        }
    });
}

module.exports = function (Intakeservreqchildremoval) {

    const hasDifferentFamilyFindingClientInfo = (existingFamilyFinding, clientInfo) => {
        const fieldsToCompare = ['firstname', 'lastname', 'dob', 'gender', 'county', 'binticlientid'];
        for (const field of fieldsToCompare) {
            let dbValue = existingFamilyFinding[field] || existingFamilyFinding[field?.toLowerCase()] || existingFamilyFinding[field?.replace(/([A-Z])/g, '_$1').toLowerCase()];
            let clientValue = clientInfo[field];
            if (field === 'dob' && dbValue && clientValue) {
                dbValue = dbValue.toISOString ? dbValue.toISOString().slice(0, 10) : (dbValue + '').slice(0, 10);
                clientValue = (clientValue + '').slice(0, 10);
            }
            if (dbValue != null && clientValue != null && dbValue !== clientValue) {
                return true;
            }
        }
        return false;
    };

    const parseSocialConnectionExternalIdentifier = (externalIdentifier) => {
        const raw = (externalIdentifier || '').toString().trim();
        const match = raw.match(/^SC_(\d+)_([0-9]+)_(.+)$/i);
        if (!match) {
            return null;
        }

        return {
            childBintiClientId: match[1],
            relativeCjamspid: match[2],
            kinship: match[3] || 'UNKNOWN',
        };
    };

    const toArrayFromMaybeObject = (value) => {
        if (Array.isArray(value)) {
            return value;
        }
        if (value) {
            return [value];
        }
        return [];
    };

    const getRequestBintiEntries = (request) => {
        const requestBintiInfo = request?.bintiinfo ?? request?.bintiInfo;
        return toArrayFromMaybeObject(requestBintiInfo);
    };

    const getClientSelectedRelationships = (client, entry) => {
        if (Array.isArray(client?.selected_relationships)) {
            return client.selected_relationships;
        }
        if (Array.isArray(entry?.selected_relationships)) {
            return entry.selected_relationships;
        }
        return [];
    };

    const getPersonByCjamsPid = async (cjamspid) => {
        if (!cjamspid) {
            return null;
        }

        const sql = 'SELECT personid, cjamspid FROM person WHERE activeflag = 1 AND cjamspid = $1 LIMIT 1';
        const data = await util.executeDBQuery(sql, [cjamspid]);
        return data?.[0] || null;
    };

    const resolveRelationshipForImport = async (childPersonId, relativePersonId) => {
        const defaultRelationship = {
            relationshipTypeKey: 'NORLTN',
            relationshipTypeDescription: 'No Relation',
        };

        if (!childPersonId || !relativePersonId) {
            return defaultRelationship;
        }

        const relSql = `
            SELECT ar.relationshiptypekey, rt.description AS relationshiptype
            FROM actorrelationship ar
            LEFT JOIN relationshiptype rt
              ON rt.relationshiptypekey = ar.relationshiptypekey
             AND rt.activeflag = 1
            WHERE ar.activeflag = 1
              AND ar.person2id = $1
              AND ar.person1id = $2
            ORDER BY ar.updatedon DESC, ar.actorrelationshipid DESC
            LIMIT 1`;
        const relData = await util.executeDBQuery(relSql, [childPersonId, relativePersonId]);

        return {
            relationshipTypeKey: relData?.[0]?.relationshiptypekey || defaultRelationship.relationshipTypeKey,
            relationshipTypeDescription: relData?.[0]?.relationshiptype || defaultRelationship.relationshipTypeDescription,
        };
    };

    const buildImportedRelationUpsertPayload = ({ childCjamsPid, childBintiClientId, relativePerson, relationshipTypeKey, relationshipTypeDescription, attributes, mapping, socialConnectionId, externalapilogsid, securityUserId }) => {
        const lineageType = attributes['lineage-type'];
        const resolvedLineageType = lineageType !== undefined ? lineageType : mapping.lineageType;

        return {
            childcjamspid: childCjamsPid,
            child_cjamspid: childCjamsPid,
            childbinticlientid: childBintiClientId,
            child_binti_clientid: childBintiClientId,
            relativepersonid: relativePerson.personid,
            relative_personid: relativePerson.personid,
            relativecjamspid: relativePerson.cjamspid,
            relative_cjamspid: relativePerson.cjamspid,
            relationshiptypekey: relationshipTypeKey,
            cjamsrelationship: relationshipTypeDescription,
            cjams_relationship: relationshipTypeDescription,
            bintikinshiprelationship: attributes['kinship-relationship'] || mapping.kinshipRelationship,
            binti_kinship_relationship: attributes['kinship-relationship'] || mapping.kinshipRelationship,
            bintilineagetype: resolvedLineageType,
            binti_lineage_type: resolvedLineageType,
            bintirolelabel: mapping.bintiRoleLabel,
            binti_role_label: mapping.bintiRoleLabel,
            bintisocialconnectionid: socialConnectionId,
            binti_social_connection_id: socialConnectionId,
            syncstatus: 'SYNCED',
            syncedon: attributes['updated-at'] || attributes['created-at'] || new Date().toISOString(),
            syncedby: securityUserId,
            externalapilogsid: externalapilogsid || null,
            insertedby: securityUserId,
            updatedby: securityUserId,
        };
    };

    const importOneBintiSocialConnection = async ({ item, childCjamsPid, childBintiClientId, childPersonId, securityUserId, responseExternalApiLogId }) => {
        const attributes = item?.attributes || {};
        const parsedExternalIdentifier = parseSocialConnectionExternalIdentifier(attributes['external-identifier']);
        if (!parsedExternalIdentifier?.relativeCjamspid) {
            return false;
        }

        const relativePerson = await getPersonByCjamsPid(parsedExternalIdentifier.relativeCjamspid);
        if (!relativePerson?.personid) {
            return false;
        }

        const relationship = await resolveRelationshipForImport(childPersonId, relativePerson.personid);
        const mapping = await binti.resolveSocialConnectionMapping(relationship.relationshipTypeKey, relationship.relationshipTypeDescription);
        const upsertPayload = buildImportedRelationUpsertPayload({
            childCjamsPid,
            childBintiClientId,
            relativePerson,
            relationshipTypeKey: relationship.relationshipTypeKey,
            relationshipTypeDescription: relationship.relationshipTypeDescription,
            attributes,
            mapping,
            socialConnectionId: item?.id || null,
            externalapilogsid: responseExternalApiLogId,
            securityUserId,
        });

        const saveSql = 'select * from addorupdatebinticlientrelations($1::json)';
        const saveResult = await util.executeDBQuery(saveSql, [upsertPayload]);
        return !!saveResult?.[0]?.addorupdatebinticlientrelations;
    };

    const importBintiSocialConnectionsToLocal = async (childCjamsPid, childBintiClientId, securityUserId = 'System') => {
        if (!childCjamsPid || !childBintiClientId) {
            return { imported: 0, scanned: 0 };
        }

        const response = await binti.listSocialConnectionsForChild(childBintiClientId, {
            updatedby: securityUserId,
            insertedby: securityUserId,
        });

        const socialConnections = response?.data || [];
        if (!Array.isArray(socialConnections) || socialConnections.length === 0) {
            return { imported: 0, scanned: 0 };
        }

        const childPerson = await getPersonByCjamsPid(childCjamsPid);
        const childPersonId = childPerson?.personid || null;

        let imported = 0;
        for (const item of socialConnections) {
            const saved = await importOneBintiSocialConnection({
                item,
                childCjamsPid,
                childBintiClientId,
                childPersonId,
                securityUserId,
                responseExternalApiLogId: response?.externalapilogsid,
            });
            if (saved) {
                imported += 1;
            }
        }

        return { imported, scanned: socialConnections.length };
    };

    
    Intakeservreqchildremoval.getfamilyfindingshistory = async function (input) {
        const cjamspid = input.where.cjamspid;
        const page = input.where.page || 1;
        const limit = input.where.limit || 10;
        if (!cjamspid) {
            return { success: false, data: { message: 'cjamspid is required' } };
        }
        const sql = 'select * from getfamilyfindingshistory($1, $2, $3)';
        try {
            const data = await util.executeSecondaryNodeDBQuery(sql, [cjamspid, page, limit]);
            if (data.length > 0) {
                return { success: true, data: data[0].getfamilyfindingshistory?.data || [], totalcount: data[0].getfamilyfindingshistory?.totalcount || 0 };
            } else {
                return { success: true, data: [], totalcount: 0 };
            }
        } catch (err) {
            LOGGER.error('getfamilyfindingshistory error', err);
            return { success: false, data: { message: err.message } };
        }
    };

    
    Intakeservreqchildremoval.remoteMethod('getfamilyfindingshistory', {
        accepts: {
            arg: 'input',
            type: 'Object',
            http: { source: 'body' },
            required: true
        },
        http: {
            verb: 'post',
            path: '/getfamilyfindingshistory'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    const isPendingSelectionStatus = (selectionStatus) => {
        const normalized = (selectionStatus || '').toString().trim().toUpperCase();
        return normalized === 'PENDING' || normalized === 'AWAIT_SYNC' || normalized === 'SYNCING' || normalized === 'SELECTED';
    };

    const isRelationshipExplicitlySelected = (relation, options = {}) => {
        const selectedValue = relation?.selected;
        const assumeSelectedWhenMissing = options.assumeSelectedWhenMissing === true;
        if (selectedValue === true || selectedValue === 1 || selectedValue === '1' || selectedValue === 'true') {
            return true;
        }
        if (selectedValue === false || selectedValue === 0 || selectedValue === '0' || selectedValue === 'false') {
            return false;
        }
        if (isPendingSelectionStatus(relation?.selectionstatus)) {
            return true;
        }
        return assumeSelectedWhenMissing;
    };

    const normalizeSelectedRelationshipsForChild = (selectedRelationships, childCjamsPid, options = {}) => {
        const rows = Array.isArray(selectedRelationships) ? selectedRelationships : [];
        return rows
            .filter((relation) => isRelationshipExplicitlySelected(relation, options))
            .filter((relation) => relation?.relationshiptypekey && (relation?.relativepersonid || relation?.relative_personid || relation?.relativecjamspid || relation?.relative_cjamspid || relation?.relativeCjamspid))
            .map((relation) => ({
                childcjamspid: childCjamsPid,
                relativepersonid: relation?.relativepersonid || relation?.relative_personid || relation?.relativePersonId,
                relativecjamspid: relation?.relativecjamspid || relation?.relative_cjamspid || relation?.relativeCjamspid,
                relationshiptypekey: relation?.relationshiptypekey,
                relationshiptype: relation?.relationshiptype || relation?.cjamsRole || relation?.cjamsrelationship || relation?.cjams_relationship,
            }))
            .filter((relation) => relation.childcjamspid && relation.relativepersonid);
    };

    const normalizeSelectedRelationsForSync = (request) => {
        const normalizedRows = [];

        const selectedClient = request?.binti?.client || {};
        const selectedClientRelationships = Array.isArray(selectedClient?.selected_relationships)
            ? selectedClient.selected_relationships
            : [];
        const selectedClientCjamsPid = selectedClient?.cjamspid || selectedClient?.clientId || selectedClient?.childcjamspid || selectedClient?.child_cjamspid || selectedClient?.childCjamsPid;
        normalizedRows.push(...normalizeSelectedRelationshipsForChild(selectedClientRelationships, selectedClientCjamsPid));

        const bintiEntries = getRequestBintiEntries(request);
        bintiEntries.forEach((entry) => {
            const client = entry?.client || entry || {};
            const childCjamsPid = client?.cjamspid || client?.clientId || client?.childcjamspid || client?.child_cjamspid || client?.childCjamsPid;
            const selectedRelationships = getClientSelectedRelationships(client, entry);
            normalizedRows.push(...normalizeSelectedRelationshipsForChild(selectedRelationships, childCjamsPid));
        });

        return normalizedRows;
    };

    const normalizeSelectedRelationshipsForAwaitSync = (selectedRelationships) => {
        const rows = Array.isArray(selectedRelationships) ? selectedRelationships : [];
        return rows
            .filter((relation) => isRelationshipExplicitlySelected(relation))
            .filter((relation) =>
                relation?.relationshiptypekey &&
                (relation?.relativepersonid || relation?.relative_personid || relation?.relativePersonId || relation?.relativecjamspid || relation?.relative_cjamspid || relation?.relativeCjamspid)
            )
            .map((relation) => ({
                relativepersonid: relation?.relativepersonid || relation?.relative_personid || relation?.relativePersonId || null,
                relativecjamspid: relation?.relativecjamspid || relation?.relative_cjamspid || relation?.relativeCjamspid || null,
                relationshiptypekey: relation?.relationshiptypekey,
                relationshiptype:
                    relation?.relationshiptype ||
                    relation?.cjamsRelationship ||
                    relation?.cjamsRole ||
                    relation?.cjamsrelationship ||
                    relation?.cjams_relationship ||
                    null,
            }))
            .filter((relation) => relation.relativepersonid);
    };

    const persistSelectedRelationshipsAwaitSync = async (childCjamsPid, selectedRelationships, securityUserId = 'System') => {
        if (!childCjamsPid) {
            return { success: false, data: { message: 'childcjamspid is required' } };
        }

        const validSelections = normalizeSelectedRelationshipsForAwaitSync(selectedRelationships);
        const selectedKeyRows = validSelections.map((relation) => ({
            relativepersonid: relation.relativepersonid,
            relationshiptypekey: relation.relationshiptypekey,
        }));

        if (selectedKeyRows.length > 0) {
            const deactivateStaleSql = `
                UPDATE cjams.binticlientrelations bcr
                   SET activeflag = 0,
                       updatedby = $2,
                       updatedon = now()
                 WHERE bcr.childcjamspid = $1
                   AND bcr.activeflag = 1
                   AND bcr.syncstatus = 'AWAIT_SYNC'
                   AND NOT EXISTS (
                        SELECT 1
                          FROM json_to_recordset($3::json) AS x(relativepersonid uuid, relationshiptypekey text)
                         WHERE x.relativepersonid = bcr.relativepersonid
                           AND x.relationshiptypekey = bcr.relationshiptypekey
                   )`;
            await util.executeDBQuery(deactivateStaleSql, [childCjamsPid, securityUserId, JSON.stringify(selectedKeyRows)]);
        } else {
            const deactivateAllPendingSql = `
                UPDATE cjams.binticlientrelations
                   SET activeflag = 0,
                       updatedby = $2,
                       updatedon = now()
                                 WHERE childcjamspid = $1
                   AND activeflag = 1
                   AND syncstatus = 'AWAIT_SYNC'`;
            await util.executeDBQuery(deactivateAllPendingSql, [childCjamsPid, securityUserId]);
        }

        for (const relation of validSelections) {
            const mapping = await binti.resolveSocialConnectionMapping(relation.relationshiptypekey, relation.relationshiptype);
            const savePayload = {
                childcjamspid: childCjamsPid,
                child_cjamspid: childCjamsPid,
                childbinticlientid: null,
                child_binti_clientid: null,
                relativepersonid: relation.relativepersonid,
                relative_personid: relation.relativepersonid,
                relativecjamspid: relation.relativecjamspid || null,
                relative_cjamspid: relation.relativecjamspid || null,
                relationshiptypekey: relation.relationshiptypekey,
                cjamsrelationship: relation.relationshiptype || null,
                cjams_relationship: relation.relationshiptype || null,
                bintikinshiprelationship: mapping.kinshipRelationship,
                binti_kinship_relationship: mapping.kinshipRelationship,
                bintilineagetype: mapping.lineageType,
                binti_lineage_type: mapping.lineageType,
                bintirolelabel: mapping.bintiRoleLabel,
                binti_role_label: mapping.bintiRoleLabel,
                bintisocialconnectionid: null,
                binti_social_connection_id: null,
                syncstatus: 'AWAIT_SYNC',
                syncedon: null,
                syncedby: securityUserId,
                externalapilogsid: null,
                insertedby: securityUserId,
                updatedby: securityUserId,
            };

            const saveSql = 'select * from addorupdatebinticlientrelations($1::json)';
            const saveResult = await util.executeDBQuery(saveSql, [savePayload]);
            if (!(saveResult?.[0]?.addorupdatebinticlientrelations)) {
                return {
                    success: false,
                    data: { message: 'Failed to persist family finding relationship selections' },
                };
            }
        }

        return {
            success: true,
            data: {
                message: 'Family finding relationship selections saved successfully',
                savedcount: validSelections.length,
            },
        };
    };

    const persistSelectedRelationshipsFromRequestBintiInfo = async (request, securityUserId = 'System') => {
        const bintiEntries = getRequestBintiEntries(request);
        const selectionOwnerSecurityUserId = request?.v_securityusersid || request?.securityuserid || securityUserId;
        if (!bintiEntries.length) {
            return { success: true, data: { savedcount: 0, message: 'No binti info provided' } };
        }

        let totalSaved = 0;
        for (const entry of bintiEntries) {
            const client = entry?.client || entry || {};
            const childCjamsPid = client?.cjamspid || client?.clientId || client?.childcjamspid || client?.child_cjamspid || client?.childCjamsPid;
            const selectedRelationships = getClientSelectedRelationships(client, entry);

            if (!childCjamsPid) {
                continue;
            }

            const result = await persistSelectedRelationshipsAwaitSync(childCjamsPid, selectedRelationships, selectionOwnerSecurityUserId);
            if (!result?.success) {
                return result;
            }
            totalSaved += result?.data?.savedcount || 0;
        }

        return { success: true, data: { savedcount: totalSaved } };
    };

    const syncRelationsAfterFamilyFindingInit = async (request, _securityusersid) => {
        const relationsToSync = normalizeSelectedRelationsForSync(request);
        const relationSource = 'request-selected';

        if (!relationsToSync.length) {
            return {
                success: true,
                data: {
                    source: relationSource,
                    attemptedcount: 0,
                    syncedcount: 0,
                    failedcount: 0,
                    message: 'No selected relationships found for sync',
                },
            };
        }

        const uniqueSyncRows = [];
        const seen = new Set();
        relationsToSync.forEach((relation) => {
            const dedupeKey = `${relation.childcjamspid}:${relation.relativepersonid}:${relation.relationshiptypekey}`;
            if (!seen.has(dedupeKey)) {
                seen.add(dedupeKey);
                uniqueSyncRows.push(relation);
            }
        });

        let syncedcount = 0;
        const failures = [];

        for (const relation of uniqueSyncRows) {
            try {
                const syncResponse = await Intakeservreqchildremoval.syncbinticlientrelation(
                    {
                        childcjamspid: relation.childcjamspid,
                        child_cjamspid: relation.childcjamspid,
                        relativepersonid: relation.relativepersonid,
                        relative_personid: relation.relativepersonid,
                        relativecjamspid: relation.relativecjamspid,
                        relative_cjamspid: relation.relativecjamspid,
                        relationshiptypekey: relation.relationshiptypekey,
                        relationshiptype: relation.relationshiptype,
                    },
                    { securityuserid: _securityusersid }
                );

                if (syncResponse?.success) {
                    syncedcount++;
                } else {
                    failures.push({
                        relationshiptypekey: relation.relationshiptypekey,
                        relativepersonid: relation.relativepersonid,
                        relative_personid: relation.relativepersonid,
                        message: syncResponse?.data?.message || 'Failed to sync relation',
                    });
                }
            } catch (err) {
                failures.push({
                    relationshiptypekey: relation.relationshiptypekey,
                    relativepersonid: relation.relativepersonid,
                    relative_personid: relation.relativepersonid,
                    message: err?.message || 'Failed to sync relation',
                });
            }
        }

        return {
            success: failures.length === 0,
            data: {
                source: relationSource,
                attemptedcount: uniqueSyncRows.length,
                syncedcount,
                failedcount: failures.length,
                failures,
            },
        };
    };

    const getExistingBintiClientByCjamsPid = async (cjamspid) => {
        try {
            const sql = 'SELECT * FROM cjams.binticlients WHERE cjamspid = $1 and activeflag = 1 LIMIT 1';
            const dbResult = await util.executeDBQuery(sql, [cjamspid]);
            if (Array.isArray(dbResult) && dbResult.length > 0) {
                return dbResult[0];
            }
        } catch (err) {
            LOGGER.error('Error checking binticlients for current client values', err);
        }
        return null;
    };

    const getExistingFamilyFindingByCjamsPid = async (cjamspid) => {
        try {
            const sql = 'SELECT * FROM cjams.bintifamilyfindings WHERE cjamspid = $1 and activeflag = 1 ORDER BY binticasestartdate DESC LIMIT 1';
            const dbResult = await util.executeDBQuery(sql, [cjamspid]);
            if (Array.isArray(dbResult) && dbResult.length > 0 && dbResult[0].binticasenumber) {
                return dbResult[0];
            }
        } catch (err) {
            LOGGER.error('Error checking local DB for existing family finding search', err);
        }
        return null;
    };

    const resolveBintiCaseForChild = async (existingFamilyFinding, bintiChildId) => {
        let bintiCaseId = existingFamilyFinding?.binticasenumber || null;
        let bintiCaseIdSource = bintiCaseId ? 'local_db' : null;

        if (bintiCaseId) {
            return { bintiCaseId, bintiCaseIdSource };
        }

        try {
            const apiResp = await binti.bintiApiRequest(`/family_finding_searches?child_id=${bintiChildId}`, 'GET');
            if (apiResp && Array.isArray(apiResp.data) && apiResp.data.length > 0) {
                bintiCaseId = apiResp.data[0].id;
                bintiCaseIdSource = 'binti_api';
            }
        } catch (err) {
            LOGGER.error('Error checking Binti API for existing family finding search', err);
        }

        return { bintiCaseId, bintiCaseIdSource };
    };

    const getCaseWorkerContext = (caseWorker) => {
        return {
            agencyWorkerEmail: caseWorker?.email || null,
            agencySecurityUserId: caseWorker?.securityuserid || caseWorker?.userid || null,
        };
    };

    const resolveLineageTypeFromRelationRow = (row, mapping) => {
        if (row.bintilineagetype !== undefined) {
            return row.bintilineagetype;
        }
        if (row.binti_lineage_type !== undefined) {
            return row.binti_lineage_type;
        }
        return mapping.lineageType;
    };

    const mapBintiClientRelationRow = async (row) => {
        const mapping = await binti.resolveSocialConnectionMapping(row.relationshiptypekey, row.relationshiptype);
        const lineageType = resolveLineageTypeFromRelationRow(row, mapping);

        return {
            ...row,
            bintikinshiprelationship: row.bintikinshiprelationship || row.binti_kinship_relationship || mapping.kinshipRelationship,
            binti_kinship_relationship: row.bintikinshiprelationship || row.binti_kinship_relationship || mapping.kinshipRelationship,
            bintilineagetype: lineageType,
            binti_lineage_type: lineageType,
            bintirolelabel: row.bintirolelabel || row.binti_role_label || mapping.bintiRoleLabel,
            binti_role_label: row.bintirolelabel || row.binti_role_label || mapping.bintiRoleLabel,
            ismapped: mapping.isMapped,
        };
    };

    const getExistingRelationAuditForSync = async ({ childCjamsPid, resolvedRelativePersonId, relationshipTypeKey }) => {
        if (!resolvedRelativePersonId) {
            return null;
        }

        const existingSql = `
            SELECT syncedby, insertedby
            FROM cjams.binticlientrelations
            WHERE childcjamspid = $1
              AND relativepersonid = $2
              AND relationshiptypekey = $3
              AND activeflag = 1
            ORDER BY insertedon DESC
            LIMIT 1`;

        const existingData = await util.executeDBQuery(existingSql, [
            childCjamsPid,
            resolvedRelativePersonId,
            relationshipTypeKey,
        ]);

        return {
            syncedby: existingData?.[0]?.syncedby || null,
            insertedby: existingData?.[0]?.insertedby || null,
        };
    };

    const saveSyncRelationResult = async ({ childCjamsPid, resolvedChildBintiClientId, relativePersonId, relativeCjamsPidInput, relationshipTypeKey, relationshipTypeDescription, mapping, syncStatus, socialConnectionId, externalapilogsid, relativePerson, securityUserId }) => {
        const resolvedRelativePersonId = relativePerson?.personid || relativePersonId;
        const existingAudit = await getExistingRelationAuditForSync({
            childCjamsPid,
            resolvedRelativePersonId,
            relationshipTypeKey,
        });

        const syncPayload = {
            childcjamspid: childCjamsPid,
            child_cjamspid: childCjamsPid,
            childbinticlientid: resolvedChildBintiClientId,
            child_binti_clientid: resolvedChildBintiClientId,
            relativepersonid: resolvedRelativePersonId,
            relative_personid: resolvedRelativePersonId,
            relativecjamspid: relativePerson?.cjamspid || relativeCjamsPidInput,
            relative_cjamspid: relativePerson?.cjamspid || relativeCjamsPidInput,
            relationshiptypekey: relationshipTypeKey,
            cjamsrelationship: relationshipTypeDescription,
            cjams_relationship: relationshipTypeDescription,
            bintikinshiprelationship: mapping.kinshipRelationship,
            binti_kinship_relationship: mapping.kinshipRelationship,
            bintilineagetype: mapping.lineageType,
            binti_lineage_type: mapping.lineageType,
            bintirolelabel: mapping.bintiRoleLabel,
            binti_role_label: mapping.bintiRoleLabel,
            bintisocialconnectionid: socialConnectionId,
            binti_social_connection_id: socialConnectionId,
            syncstatus: syncStatus,
            syncedon: new Date().toISOString(),
            syncedby: existingAudit?.syncedby || existingAudit?.insertedby || securityUserId,
            externalapilogsid: externalapilogsid || null,
            insertedby: existingAudit?.insertedby || securityUserId,
            updatedby: securityUserId,
        };

        const saveSql = 'select * from addorupdatebinticlientrelations($1::json)';
        const saveResult = await util.executeDBQuery(saveSql, [syncPayload]);
        return !!(saveResult?.[0]?.addorupdatebinticlientrelations);
    };

    const resolveChildSyncContext = async (childCjamsPid, inputBintiCaseNumber, resolvedChildBintiClientId) => {
        const childSql = `
            SELECT
                bc.binti_clientid,
                bff.binticasenumber
            FROM cjams.binticlients bc
            LEFT JOIN LATERAL (
                SELECT bff1.binticasenumber
                FROM cjams.bintifamilyfindings bff1
                WHERE bff1.cjamspid = bc.cjamspid
                  AND bff1.activeflag = 1
                ORDER BY bff1.insertedon DESC
                LIMIT 1
            ) bff ON true
            WHERE bc.cjamspid = $1
              AND bc.activeflag = 1
            LIMIT 1`;

        const childData = await util.executeDBQuery(childSql, [childCjamsPid]);
        const childInfo = childData?.[0];
        const childBintiClientId = childInfo?.binti_clientid || resolvedChildBintiClientId;
        let bintiCaseNumber = childInfo?.binticasenumber || inputBintiCaseNumber;

        if (!bintiCaseNumber) {
            const familyFindingSql = `
                SELECT bff1.binticasenumber
                FROM cjams.bintifamilyfindings bff1
                WHERE bff1.cjamspid = $1
                  AND bff1.activeflag = 1
                ORDER BY bff1.insertedon DESC
                LIMIT 1`;
            const familyFindingData = await util.executeDBQuery(familyFindingSql, [childCjamsPid]);
            bintiCaseNumber = familyFindingData?.[0]?.binticasenumber || bintiCaseNumber;
        }

        return {
            resolvedChildBintiClientId: childBintiClientId,
            resolvedBintiCaseNumber: bintiCaseNumber,
        };
    };

    const resolveRelativePersonForSync = async (relativePersonId, relativeCjamsPidInput) => {
        if (relativePersonId) {
            const sqlByPersonId = 'SELECT p.personid, p.cjamspid, p.firstname, p.middlename, p.lastname, p.dob::date, p.gendertypekey, (SELECT gr.typedescription FROM gendertype gr WHERE gr.gendertypekey = p.gendertypekey LIMIT 1) AS gender FROM person p WHERE p.activeflag = 1 AND p.personid = $1 LIMIT 1';
            const dataByPersonId = await util.executeDBQuery(sqlByPersonId, [relativePersonId]);
            if (Array.isArray(dataByPersonId) && dataByPersonId.length > 0) {
                return dataByPersonId[0];
            }
        }

        if (relativeCjamsPidInput) {
            const sqlByCjamsPid = 'SELECT p.personid, p.cjamspid, p.firstname, p.middlename, p.lastname, p.dob::date, p.gendertypekey, (SELECT gr.typedescription FROM gendertype gr WHERE gr.gendertypekey = p.gendertypekey LIMIT 1) AS gender FROM person p WHERE p.activeflag = 1 AND p.cjamspid = $1 LIMIT 1';
            const dataByCjamsPid = await util.executeDBQuery(sqlByCjamsPid, [relativeCjamsPidInput]);
            if (Array.isArray(dataByCjamsPid) && dataByCjamsPid.length > 0) {
                return dataByCjamsPid[0];
            }
        }

        return null;
    };

    const buildInitFamilyFindingsInputFromRequest = (request) => {
        const bintiPayload = request?.binti || request?.bintiinfo || request?.bintiInfo || {};
        return {
            ...bintiPayload,
            client: bintiPayload?.client || null,
            case_worker: bintiPayload?.case_worker || bintiPayload?.caseworker || null,
            search_date: bintiPayload?.search_date || bintiPayload?.searchDate || new Date().toISOString().slice(0, 10),
        };
    };

    
    module.exports.triggerInitFamilyFindings = async (request, _securityusersid) => {
        try {
            const initFamilyFindingsInput = buildInitFamilyFindingsInputFromRequest(request);
            if (!initFamilyFindingsInput?.client) {
                return {
                    success: false,
                    data: {
                        message: 'Invalid Binti payload: client details are required',
                    }
                };
            }
    
            const result = await Intakeservreqchildremoval.initfamilyfindings(initFamilyFindingsInput, { securityuserid: _securityusersid });
            const canProceedWithSync = !!(result?.success || result?.data?.isDuplicate);
            if (!canProceedWithSync) {
                return result;
            }
    
            const syncResult = await syncRelationsAfterFamilyFindingInit(request, _securityusersid);
            if (!syncResult.success) {
                LOGGER.error('One or more family finding relations failed during approval-time sync', {
                    source: syncResult?.data?.source,
                    attemptedcount: syncResult?.data?.attemptedcount,
                    syncedcount: syncResult?.data?.syncedcount,
                    failedcount: syncResult?.data?.failedcount,
                    failures: syncResult?.data?.failures,
                });
            }
    
            return {
                success: true,
                data: {
                    familyfinding: result?.data || null,
                    relationshipsync: syncResult?.data || null,
                },
            };
        } catch (err) {
            return {
                success: false,
                data: {
                    message: err && err.message ? err.message : 'Failed to create Init Family findings',
                    error: err
                }
            };
        }
    }

    
    Intakeservreqchildremoval.initfamilyfindings = async function (input, reqctx) {
        const securityDetails = util.getSecurityDetails(null, reqctx) || {};
        // When invoked from CHRR approval trigger, reqctx.securityuserid carries routing tosecurityusersid.
        const _securityusersid = reqctx?.securityuserid || securityDetails.securityuserid || 'System';
        const clientInfo = input.client;
        const caseWorker = input.case_worker;
    
        const existingBintiClient = await getExistingBintiClientByCjamsPid(clientInfo.cjamspid);
        const existingFamilyFinding = await getExistingFamilyFindingByCjamsPid(clientInfo.cjamspid);
    
        if (existingFamilyFinding && existingBintiClient) {
            const isDifferent = hasDifferentFamilyFindingClientInfo(existingBintiClient, clientInfo);
            if (!isDifferent) {
                return {
                    success: false,
                    data: {
                        message: 'A family finding search already exists with the same client information. No new search was created.',
                        existingCaseId: existingFamilyFinding.binticasenumber,
                        externalapilogsid: existingFamilyFinding.externalapilogsid,
                        isDuplicate: true
                    }
                };
            }
        }
    
        const childResponse = await binti.ensureBintiChildAndSync(clientInfo, _securityusersid);
        if (!childResponse.success) {
            LOGGER.error('Failed to ensure Binti child and sync to DB', childResponse.message, childResponse.error);
            return {
                success: false,
                data: {
                    message: 'Failed to create Init Family findings', error: childResponse.error,
                    externalapilogsid: childResponse.externalapilogsid
                }
            };
        }
        const bintiChildId = childResponse.bintiChildId;
    
        const resolvedCase = await resolveBintiCaseForChild(existingFamilyFinding, bintiChildId);
        const bintiCaseId = resolvedCase.bintiCaseId;
        const bintiCaseIdSource = resolvedCase.bintiCaseIdSource;
    
        LOGGER.info('Family finding case resolution', {
            cjamspid: clientInfo.cjamspid,
            bintiChildId,
            resolvedBintiCaseId: bintiCaseId || null,
            source: bintiCaseIdSource || 'none',
            localDbCaseId: existingFamilyFinding?.binticasenumber || null,
        });
    
        const caseWorkerContext = getCaseWorkerContext(caseWorker);
        const servicecaseid = clientInfo.caseid;
    
        const ffPayload = {
            bintiChildId,
            searchDate: input.search_date,
            agencyWorkerEmail: caseWorkerContext.agencyWorkerEmail,
            agencySecurityUserId: caseWorkerContext.agencySecurityUserId,
            insertedby: _securityusersid,
            updatedby: _securityusersid,
            cjamspid: clientInfo.cjamspid,
            servicecaseid
        };
        if (bintiCaseId) {
            ffPayload.bintiCaseId = bintiCaseId;
        }
    
        const ffResult = await binti.createFamilyFindingSearchWithWorker(ffPayload);
    
        if (!ffResult.success) {
            return {
                success: false,
                data: {
                    message: 'Failed to create or update Init Family findings', error: ffResult.error
                }
            };
        }
    
        const familyFindingResponse = ffResult.data;
        return {
            success: true,
            data: {
                message: bintiCaseId ? 'Family finding search updated successfully' : 'Family finding search created successfully',
                caseId: familyFindingResponse?.data?.id,
                externalapilogsid: familyFindingResponse?.externalapilogsid,
                agencyWorkerId: ffResult.agencyWorkerId || null
            }
        };
    }


    
    Intakeservreqchildremoval.remoteMethod('initfamilyfindings', {
        accepts: [
            { arg: 'input', type: 'object', http: { source: 'body' }, required: true },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        http: { verb: 'post', path: '/initfamilyfindings' },
        returns: { type: 'Object', root: true }
    });


    
    Intakeservreqchildremoval.getfamilyfindings = async function (filter) {
        const objectid = filter?.where?.objectid;
        const page = filter?.page || 1;
        const limit = filter?.limit || 10;
        if (!objectid) {
            return { success: false, data: { message: 'objectid (servicecaseid) is required' } };
        }
        const sql = 'select * from getfamilyfindings($1, $2, $3)';
        try {
            const data = await util.executeSecondaryNodeDBQuery(sql, [objectid, page, limit]);
            if (data.length > 0) {
                return { success: true, data: data[0].getfamilyfindings?.data || [], totalcount: data[0].getfamilyfindings?.totalcount || 0 };
            } else {
                return { success: true, data: [], totalcount: 0 };
            }
        } catch (err) {
            LOGGER.error('getfamilyfindings error', err);
            return { success: false, data: { message: err.message } };
        }
    };

    
    Intakeservreqchildremoval.remoteMethod('getfamilyfindings', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: { source: 'query' },
            required: true
        },
        http: {
            verb: 'get',
            path: '/getfamilyfindings'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    
    Intakeservreqchildremoval.getbinticlientrelations = async function (input, reqctx) {
        const cjamspid = input?.where?.cjamspid;
        const servicecaseid = input?.where?.servicecaseid || null;
        const page = input?.where?.page || 1;
        const limit = input?.where?.limit || 10;
        const importFromBinti = input?.where?.importfrombinti === true || input?.where?.importfrombinti === 1 || input?.where?.importfrombinti === 'true';
        const securityDetails = util.getSecurityDetails(null, reqctx) || {};
        const _securityusersid = securityDetails.securityuserid || reqctx?.securityuserid || 'System';
    
        if (!cjamspid) {
            return { success: false, data: { message: 'cjamspid is required' } };
        }
    
        const sql = 'select * from getbinticlientrelations($1, $2, $3, $4)';
        try {
            const childBintiSql = 'SELECT binti_clientid FROM cjams.binticlients WHERE cjamspid = $1 AND activeflag = 1 LIMIT 1';
            const childBintiData = await util.executeDBQuery(childBintiSql, [cjamspid]);
            const childBintiClientId = childBintiData?.[0]?.binti_clientid;
    
            if (childBintiClientId && importFromBinti) {
                try {
                    await importBintiSocialConnectionsToLocal(cjamspid, childBintiClientId, _securityusersid);
                } catch (importErr) {
                    LOGGER.error('importBintiSocialConnectionsToLocal error', importErr);
                }
            }
    
            const data = await util.executeSecondaryNodeDBQuery(sql, [cjamspid, page, limit, servicecaseid]);
            const relationRows = data?.[0]?.getbinticlientrelations?.data || [];
    
            const mappedRows = await Promise.all(relationRows.map((row) => mapBintiClientRelationRow(row)));
    
            return {
                success: true,
                data: mappedRows,
                totalcount: data?.[0]?.getbinticlientrelations?.totalcount || 0,
            };
        } catch (err) {
            LOGGER.error('getbinticlientrelations error', err);
            return { success: false, data: { message: err.message } };
        }
    };

    
    Intakeservreqchildremoval.remoteMethod('getbinticlientrelations', {
        accepts: [
            {
                arg: 'input',
                type: 'Object',
                http: { source: 'body' },
                required: true,
            },
            {
                arg: 'reqctx',
                type: 'object',
                http: { source: 'context' },
            },
        ],
        http: {
            verb: 'post',
            path: '/getbinticlientrelations',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    
    Intakeservreqchildremoval.savebinticlientrelations = async function (input, reqctx) {
        const securityDetails = util.getSecurityDetails(null, reqctx) || {};
        const _securityusersid = securityDetails.securityuserid || reqctx?.securityuserid || 'System';
        const childCjamsPid = input?.childcjamspid || input?.child_cjamspid || input?.cjamspid;
        const selectedRelationships = Array.isArray(input?.selected_relationships) ? input.selected_relationships : [];
    
        if (!childCjamsPid) {
            return { success: false, data: { message: 'childcjamspid is required' } };
        }
    
        try {
            return await persistSelectedRelationshipsAwaitSync(childCjamsPid, selectedRelationships, _securityusersid);
        } catch (err) {
            LOGGER.error('savebinticlientrelations error', err);
            return {
                success: false,
                data: { message: err?.message || 'Failed to save family finding relationship selections' },
            };
        }
    };

    
    Intakeservreqchildremoval.remoteMethod('savebinticlientrelations', {
        accepts: [
            {
                arg: 'input',
                type: 'object',
                http: { source: 'body' },
                required: true,
            },
            {
                arg: 'reqctx',
                type: 'object',
                http: { source: 'context' },
            },
        ],
        http: {
            verb: 'post',
            path: '/savebinticlientrelations',
        },
        returns: {
            type: 'Object',
            root: true,
        },
    });

    const parseSyncRelationInput = (input, reqctx) => {
        const securityDetails = util.getSecurityDetails(null, reqctx) || {};
        return {
            securityUserId: securityDetails.securityuserid || reqctx?.securityuserid || 'System',
            childCjamsPid: input?.childcjamspid || input?.child_cjamspid,
            relativePersonId: input?.relativepersonid || input?.relative_personid,
            relativeCjamsPidInput: input?.relativecjamspid || input?.relative_cjamspid,
            relationshipTypeKey: input?.relationshiptypekey,
            relationshipTypeDescription: input?.relationshiptype,
            inputBintiCaseNumber: input?.binti_case_number || input?.bintiCaseNumber || null,
            resolvedChildBintiClientId: input?.childbinticlientid || input?.child_binti_clientid || null,
        };
    };

    const persistSyncRelationFailure = async (ctx, err) => {
        try {
            const mapping = await binti.resolveSocialConnectionMapping(ctx.relationshipTypeKey, ctx.relationshipTypeDescription);
            await saveSyncRelationResult({
                childCjamsPid: ctx.childCjamsPid,
                resolvedChildBintiClientId: ctx.resolvedChildBintiClientId,
                relativePersonId: ctx.relativePersonId,
                relativeCjamsPidInput: ctx.relativeCjamsPidInput,
                relationshipTypeKey: ctx.relationshipTypeKey,
                relationshipTypeDescription: ctx.relationshipTypeDescription,
                mapping,
                syncStatus: 'FAILED',
                socialConnectionId: null,
                externalapilogsid: err?.externalapilogsid || err?.error?.externalapilogsid || null,
                relativePerson: {
                    personid: ctx.relativePersonId,
                    cjamspid: ctx.relativeCjamsPidInput,
                },
                securityUserId: ctx.securityUserId,
            });
        } catch (saveErr) {
            LOGGER.error('Failed to save binticlientrelation failure status', saveErr);
        }
    };

    const performSyncRelation = async (ctx) => {
        const childSyncContext = await resolveChildSyncContext(ctx.childCjamsPid, ctx.inputBintiCaseNumber, ctx.resolvedChildBintiClientId);
        ctx.resolvedChildBintiClientId = childSyncContext.resolvedChildBintiClientId;

        if (!childSyncContext.resolvedBintiCaseNumber || !ctx.resolvedChildBintiClientId) {
            return {
                success: false,
                data: {
                    message: 'Family finding must be initiated before syncing relationships',
                },
            };
        }

        const relativePerson = await resolveRelativePersonForSync(ctx.relativePersonId, ctx.relativeCjamsPidInput);
        if (!relativePerson) {
            return {
                success: false,
                data: { message: 'Relative person not found for sync' },
            };
        }

        const mapping = await binti.resolveSocialConnectionMapping(ctx.relationshipTypeKey, ctx.relationshipTypeDescription);
        const externalIdentifier = binti.buildSocialConnectionExternalIdentifier(
            ctx.resolvedChildBintiClientId,
            relativePerson.cjamspid,
            mapping.kinshipRelationship
        );

        const socialConnectionResponse = await binti.createSocialConnectionForChild({
            childId: ctx.resolvedChildBintiClientId,
            relationshipTypeKey: ctx.relationshipTypeKey,
            relationshipTypeDescription: ctx.relationshipTypeDescription,
            connectionPerson: {
                firstName: relativePerson.firstname,
                middleName: relativePerson.middlename,
                lastName: relativePerson.lastname,
                dateOfBirth: binti.formatDateForBinti(relativePerson.dob),
                gender: await binti.mapGenderForBinti(relativePerson.gender || relativePerson.gendertypekey),
                personId: `CJAMS_${relativePerson.cjamspid}`,
            },
            externalIdentifier,
            logDetails: {
                updatedby: ctx.securityUserId,
                insertedby: ctx.securityUserId,
            },
        });

        const socialConnectionId = socialConnectionResponse?.data?.id || null;
        const externalapilogsid = socialConnectionResponse?.externalapilogsid || null;

        const saved = await saveSyncRelationResult({
            childCjamsPid: ctx.childCjamsPid,
            resolvedChildBintiClientId: ctx.resolvedChildBintiClientId,
            relativePersonId: ctx.relativePersonId,
            relativeCjamsPidInput: ctx.relativeCjamsPidInput,
            relationshipTypeKey: ctx.relationshipTypeKey,
            relationshipTypeDescription: ctx.relationshipTypeDescription,
            mapping,
            syncStatus: 'SYNCED',
            socialConnectionId,
            externalapilogsid: socialConnectionResponse?.externalapilogsid,
            relativePerson,
            securityUserId: ctx.securityUserId,
        });

        if (!saved) {
            return {
                success: false,
                data: {
                    message: 'Social connection synced, but failed to persist local sync status',
                    socialconnectionid: socialConnectionId,
                    externalapilogsid,
                },
            };
        }

        return {
            success: true,
            data: {
                message: 'Relationship synced successfully',
                socialconnectionid: socialConnectionId,
                externalapilogsid,
            },
        };
    };

    
    Intakeservreqchildremoval.syncbinticlientrelation = async function (input, reqctx) {
        const ctx = parseSyncRelationInput(input, reqctx);
    
        if (!ctx.childCjamsPid || !ctx.relationshipTypeKey || (!ctx.relativePersonId && !ctx.relativeCjamsPidInput)) {
            return {
                success: false,
                data: {
                    message: 'childcjamspid, relationshiptypekey and relative person reference are required',
                },
            };
        }
    
        try {
            return await performSyncRelation(ctx);
        } catch (err) {
            LOGGER.error('syncbinticlientrelation error', err);
            await persistSyncRelationFailure(ctx, err);
            return {
                success: false,
                data: {
                    message: err?.message || 'Failed to sync relationship with Binti',
                    externalapilogsid: err?.externalapilogsid || err?.error?.externalapilogsid || null,
                },
            };
        }
    };

    
    Intakeservreqchildremoval.remoteMethod('syncbinticlientrelation', {
        accepts: [
            { arg: 'input', type: 'object', http: { source: 'body' }, required: true },
            { arg: 'reqctx', type: 'object', http: { source: 'context' } }
        ],
        http: { verb: 'post', path: '/syncbinticlientrelation' },
        returns: { type: 'Object', root: true }
    });

    Intakeservreqchildremoval.persondisabilityadd = (request) => {
        if (request.persondisability != null && request.persondisability != undefined) {
            if (request.persondisability.personid != null && request.persondisability.personid != undefined) {
                return app.models.Persondisability.findOne({
                    where: {
                        personid: request.persondisability.personid,
                    }
                }).then(data => {
                    if (data != null) {
                        return app.models.Persondisability.updateAll(
                            { personid: request.persondisability.personid },
                            {
                                disabilityconditiontypekey: request.persondisability.disabilityconditiontypekey,
                                diagnoiseddisabilitynotes: request.persondisability.diagnoiseddisabilitynotes,
                                startdate: request.persondisability.startdate,
                                enddate: request.persondisability.enddate,
                                evaluationdate: request.persondisability.evaluationdate,
                                disabilityflag: request.persondisability.disabilityflag,
                                evaluatorname: request.persondisability.evaluatorname,
                                disabilitytypekey: request.persondisability.disabilitytypekey,
                                comments: request.persondisability.comments
                            }
                        ).catch(err => LOGGER.error('Error updating persondisability', err));
                    }
                    else {
                        return app.models.Persondisability.create({
                            personid: request.persondisability.personid,
                            disabilityconditiontypekey: request.persondisability.disabilityconditiontypekey,
                            diagnoiseddisabilitynotes: request.persondisability.diagnoiseddisabilitynotes,
                            startdate: request.persondisability.startdate,
                            enddate: request.persondisability.enddate,
                            evaluationdate: request.persondisability.evaluationdate,
                            disabilityflag: request.persondisability.disabilityflag,
                            evaluatorname: request.persondisability.evaluatorname,
                            disabilitytypekey: request.persondisability.disabilitytypekey,
                            comments: request.persondisability.comments
                        }).catch(err => LOGGER.error('Error creating persondisability', err));
                    }
                }).catch(err => LOGGER.error('Error finding persondisability', err));
            }
        }
        return Promise.resolve(); // Ensure returns a promise
    }

    Intakeservreqchildremoval.add = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid;
        if (request.intakeservreqchildremovalid !== undefined && request.intakeservreqchildremovalid !== null) {

            return Intakeservreqchildremoval.updatechildremovalv1(request, _securityusersid);
        } else {
            return Intakeservreqchildremoval.addchildremoval(request, _securityusersid);
        }
    }

    Intakeservreqchildremoval.addchildremoval = function (request, _securityusersid) {

        var status = 15;
        if (request.intakeserviceid === null || request.intakeserviceid === undefined) { request.intakeserviceid = null; }

        if (request.servicecaseid === null || request.servicecaseid === undefined) { request.servicecaseid = null; }
        if (request.v_securityusersid) {
            request.insertedby = request.v_securityusersid;
            request.updatedby = request.v_securityusersid;
        }

        return Intakeservreqchildremoval.create(request)
            .then(res => {
                Intakeservreqchildremoval.persondisabilityadd(request).catch(err => LOGGER.error('persondisabilityadd error', err));
                if (Array.isArray(request.removalreason)) {
                    request.removalreason.map(reason => {
                        app.models.Intakeservreqchildremovalreason.create({
                            insertedby: _securityusersid,
                            updatedby: _securityusersid,
                            intakeservreqchildremovalid: res.intakeservreqchildremovalid,
                            removalreasontypekey: reason.removalreasontypekey,
                            inputtypekey: 'CHFE'
                        }).catch(err => LOGGER.error('Error creating removalreason', err));
                    })
                }
                if (Array.isArray(request.caregiverreason)) {
                    request.caregiverreason.forEach(cgrk => {
                        app.models.Intakeservreqchildremovalreason.create({
                            insertedby: _securityusersid,
                            updatedby: _securityusersid,
                            intakeservreqchildremovalid: res.intakeservreqchildremovalid,
                            removalreasontypekey: cgrk.reasontypekey,
                            inputtypekey: 'CGFE'
                        }).catch(err => LOGGER.error('Error creating caregiverreason', err));
                    })
                }
                if (Array.isArray(request.reasonableefforts)) {
                    request.reasonableefforts.forEach(rek => {
                        app.models.Intakeservreqchildremovalreason.create({
                            intakeservreqchildremovalid: res.intakeservreqchildremovalid,
                            insertedby: _securityusersid,
                            updatedby: _securityusersid,
                            removalreasontypekey: rek.reasontypekey,
                            otherdescription: rek.otherdescription,
                            inputtypekey: 'REPCR'
                        }).catch(err => LOGGER.error('Error creating reasonableefforts', err));
                    })
                }
                if (Array.isArray(request.notmakingefforts)) {
                    request.notmakingefforts.forEach(nmek => {
                        app.models.Intakeservreqchildremovalreason.create({
                            intakeservreqchildremovalid: res.intakeservreqchildremovalid,
                            insertedby: _securityusersid,
                            updatedby: _securityusersid,
                            removalreasontypekey: nmek.reasontypekey,
                            inputtypekey: 'RNME'
                        }).catch(err => LOGGER.error('Error creating notmakingefforts', err));
                    })
                }
                if (Array.isArray(request.exitreason)) {
                    request.exitreason.forEach(erk => {
                        app.models.Intakeservreqchildremovalreason.create({
                            intakeservreqchildremovalid: res.intakeservreqchildremovalid,
                            insertedby: _securityusersid,
                            updatedby: _securityusersid,
                            removalreasontypekey: erk.reasontypekey,
                            inputtypekey: 'ECR'
                        }).catch(err => LOGGER.error('Error creating exitreason', err));
                    })
                }

                persistSelectedRelationshipsFromRequestBintiInfo(request, _securityusersid)
                    .catch((persistErr) => {
                        LOGGER.error('Failed to persist selected family finding relationships during addchildremoval', persistErr);
                    });

                updatechildremovalrevisionandAttachments(res, request, status, _securityusersid);
                return res;
            })
            .catch(err => {
                LOGGER.error('Failed to create Intakeservreqchildremoval', err);
                throw err;
            });
    }

    function updatechildremovalrevisionandAttachments(res, request, status, _securityusersid) {
        if (util.isNullorEmpty(request.attachment)) {
            addRemovalAttachments(request.attachment, res.intakeservreqchildremovalid, 'updatechildremovalrevisionandAttachments');
        }
        if (request.isreviewsubmit === 1) {
            Intakeservreqchildremoval.review(res.intakeservreqchildremovalid, request.intakeserviceid, request.servicecaseid, status, request.v_securityusersid, _securityusersid);

            const sql = "select * from childremovalrevisionupdate($1::uuid, $2::timestamp, $3::character varying, $4::timestamp, $5::character varying, $6::character varying, $7::character varying, $8::boolean, $9::boolean, $10::character varying, $11::boolean, $12::character varying, $13::timestamp)";

            util.executeDBQuery(sql, [res.intakeservreqchildremovalid, request.exitdate, request.removalexitreason, null, null, null, null, null, null, null, null, _securityusersid, new Date()])
                .catch(err => {
                    LOGGER.error('Error in childremovalrevisionupdate', err);
                    throw err;
                });

        }
    }
    function saveExitDraft(request, _securityusersid) {
        const updateExitSql = `SELECT * FROM cjams.childremovalrevisionupdate($1::uuid, $2::timestamp, $3::character varying, $4::timestamp, $5::character varying, $6::character varying, $7::character varying, $8::boolean, $9::boolean, $10::character varying, $11::boolean, $12::character varying, $13::timestamp)`;
        return util.executeDBQuery(updateExitSql, [request.intakeservreqchildremovalid, request.exitdate || null, request.removalexitreason || null, request.returntransts || null, request.transferagency || null, request.otherpublicagency || null, request.locationofadoption || null, request.childremovalluggage || null, request.luggageprovided || null, request.luggagecomments || null, request.placementdisposableortrasbag || null, _securityusersid || null, new Date()])
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }

    // A review submission routes for approval; otherwise the contact page saves the
    // exit fields as a draft. Both are fire-and-forget.
    function routeOrDraftAfterUpdate(request, status, _securityusersid) {
        if (request.isreviewsubmit === 1) {
            Intakeservreqchildremoval.review(request.intakeservreqchildremovalid, request.intakeserviceid, request.servicecaseid, status, request.v_securityusersid, _securityusersid);
        } else if (request.showcontactpage) {
            // Save exit-related fields on Save as Draft
            saveExitDraft(request, _securityusersid).catch(err => LOGGER.error('saveExitDraft error', err));
        }
    }

    // Everything triggered once the removal row is saved. All of it is
    // fire-and-forget: none of these may fail the update itself.
    function runUpdateSideEffects(data, request, _securityusersid) {
        Intakeservreqchildremoval.persondisabilityadd(request).catch(err => LOGGER.error('persondisabilityadd error in updatechildremovalv1', err));

        persistSelectedRelationshipsFromRequestBintiInfo(request, _securityusersid)
            .catch((persistErr) => {
                LOGGER.error('Failed to persist selected family finding relationships during updatechildremovalv1', persistErr);
            });

        if (request.attachment != null && request.attachment != undefined && request.attachment != "") {
            addRemovalAttachments(request.attachment, data.intakeservreqchildremovalid, 'updatechildremovalv1');
        }

        routeOrDraftAfterUpdate(request, returnStatusFn(request, 15), _securityusersid);
    }

    Intakeservreqchildremoval.updatechildremovalv1 = function (request, _securityusersid) {

        if (request.exitdate !== undefined && request.exitdate !== null) {
            request.returntransts = new Date().toLocaleDateString();
        }

        var sql = 'SELECT * FROM update_childremoval($1::uuid, $2::json, $3::uuid);';
        return util.executeDBQuery(sql, [request.intakeservreqchildremovalid, request, _securityusersid])
            .then(data => {
                console.log('success')
                runUpdateSideEffects(data, request, _securityusersid);
                return { "intakeservreqchildremovalid": request.intakeservreqchildremovalid };
            })
            .catch(err => {
                LOGGER.error(err);
                throw err;
            })
    }

    Intakeservreqchildremoval.review = (childremovalid, intakeserviceid, servicecaseid, status, secuserid, _securityusersid) => {
        var securityusersid = secuserid ? secuserid : _securityusersid;

        var caseid = intakeserviceid;
        var isservicecase = 0;
        let notifymsg, routeddescription, comments;
        if (status == 15) {
            notifymsg = childremovalreviewmsg;
            routeddescription = childremovalreviewmsg;
            comments = childremovalreviewmsg;
        } else if (status == 16) {
            notifymsg = childremovalapprovedmsg;
            routeddescription = childremovalapprovedmsg;
            comments = childremovalapprovedmsg;
        } else if (status == 17) {
            notifymsg = childremovalrejectedmsg;
            routeddescription = childremovalrejectedmsg;
            comments = childremovalrejectedmsg;
        }
        if (servicecaseid !== null && servicecaseid !== undefined) {
            caseid = servicecaseid;
            isservicecase = 1
        }
        var sql1 = "update routing set activeflag =0 WHERE  eventcode ='CHRR' and routingstatustypeid=15 and objectid =$1 ::character varying ";
        return util.executeDBQuery(sql1, [childremovalid])
            .then(data => {
                LOGGER.info(data);
                var sql = 'select * from routingintake($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14)';
                return util.executeDBQuery(sql,
                    [childremovalid, securityusersid, 'CHRR', status, comments, '', false, false, false, notifymsg, routeddescription, caseid, '', isservicecase]);
            })
            .then(data => {
                const input = {
                    objectid: childremovalid,
                    status: 'Review'
                }
                if (status === 16) {
                    input.status = 'Approved'
                } else if (status === 17) {
                    input.status = 'Rejected'
                }

                if (status === 16 || status === 15 || status === 17) {
                    return Intakeservreqchildremoval.updatechildremovalexitdate(input, securityusersid)
                        .then(() => data);
                }
                return data;
            })
            .catch(err => {
                LOGGER.error(err)
                return err;
            })
    }

    module.exports.updatechildremovalexitdata = (request, _securityusersid) => {
        return new Promise((resolve, reject) => {
            Intakeservreqchildremoval.updatechildremovalexitdate(request, _securityusersid)
                .then(() => resolve('success'))
                .catch(err => reject(err));
        })
    }

    Intakeservreqchildremoval.updatechildremovalexitdate = async (request, _securityusersid) => {
        var fullname;
        await util.getuserinfo(app.currentUser).then(_data => {
            fullname = _data.fullname;
        }).catch(err => LOGGER.error('Error fetching user info', err));

        var securityusersid = (request && request.securityuserid ? request.securityuserid : _securityusersid);

        let data = [];

        if (request.status == 'Review') {
            data = [
                {
                    "key": "submittedby",
                    "new_value": fullname,
                    "old_value": null,
                    "display_name": "Submitted By"
                },
                {
                    "key": "submittedon",
                    "new_value": new Date(),
                    "old_value": null,
                    "display_name": "Submitted On"
                },
                {
                    "key": "status",
                    "new_value": 'Review',
                    "old_value": null,
                    "display_name": "Status"
                }
            ]
        } else if (request.status == 'Approved') {

            data = [
                {
                    "key": "approvedby",
                    "new_value": fullname,
                    "old_value": null,
                    "display_name": "Approved By"
                },
                {
                    "key": "approvedon",
                    "new_value": new Date(),
                    "old_value": null,
                    "display_name": "Approved On"
                },
                {
                    "key": "status",
                    "new_value": 'Approved',
                    "old_value": null,
                    "display_name": "Status"
                }
            ]
        } else if (request.status == 'Rejected') {
            data = [
                {
                    "key": "rejectedby",
                    "new_value": fullname,
                    "old_value": null,
                    "display_name": "Rejected By"
                },
                {
                    "key": "rejectedon",
                    "new_value": new Date(),
                    "old_value": null,
                    "display_name": "Rejected On"
                },
                {
                    "key": "status",
                    "new_value": 'Rejected',
                    "old_value": null,
                    "display_name": "Status"
                }
            ]
        }

        const modifiedjson = {
            status: 'Updated',
            data: data
        }

        var sql = ` SELECT * FROM update_childremoval_approval($1::uuid, $2::json, $3::uuid, $4::character varying) `;

        return util.executeDBQuery(sql, [request.objectid, modifiedjson, securityusersid, request.status])
            .catch(err => util.logError(err));
    }

    Intakeservreqchildremoval.getremovallist = function (intakeserviceid, page, limit, isExpungementSuperUser, iscaseexpunged) {
        var sql = 'select * from getremovallist($1,$2,$3,$4,$5)';
        return util.executeSecondaryNodeDBQuery(sql, [intakeserviceid, page, limit, isExpungementSuperUser, iscaseexpunged])
            .then(data => data[0].getremovallist)
            .catch(err => {
                LOGGER.error('>>>>ERROR:', err);
                throw err;
            });
    }


    Intakeservreqchildremoval.getservicecaseremovallist = (objectid, isgroup, page, limit) => {
        var sql = 'select * from getservicecaseremovallist($1,$2,$3,$4)';
        return util.executeDBQuery(sql, [objectid, isgroup, page, limit])
            .then(data => data[0].getservicecaseremovallist)
            .catch(err => util.logError(err))
    }

    Intakeservreqchildremoval.getremovallistbypersonid = (personid, cjamspid) => {
        var sql = 'select * from getremovallistbypersonid($1,$2)';
        return util.executeDBQuery(sql, [personid, cjamspid])
            .then(data => data[0].getremovallistbypersonid)
            .catch(err => util.logError(err))
    }

    Intakeservreqchildremoval.getchildremoval = (request) => {
        const iscaseexpunged = request.where.iscaseexpunged ?? 0;
        if (request.where.intakeserviceid != null && request.where.intakeserviceid != undefined) {
            return Intakeservreqchildremoval.getremovallist(request.where.intakeserviceid, request.page, request.limit, request.where.isExpungementSuperUser, iscaseexpunged);
        } else if (request.where.objectid != null && request.where.objectid != undefined) {
            if (request.where.objecttypekey != null && request.where.objecttypekey != undefined && request.where.objecttypekey === 'personid') {
                var personid = request.where.objectid || null;
                var cjamspid = request.where.cjamspid || null;
                return Intakeservreqchildremoval.getremovallistbypersonid(personid, cjamspid);
            }
            else { return Intakeservreqchildremoval.getservicecaseremovallist(request.where.objectid, request.where.isgroup, request.page, request.limit); }
        }
        return Promise.resolve([]);
    }
    Intakeservreqchildremoval.servicecasevalidation = (request, reqctx) => {
        let _securityusersid = undefined;
        if (reqctx?.req?.headers?.securityusersid) {
            _securityusersid = reqctx.req.headers.securityusersid;
        }
        var securityuserid = (request.securityuserid ? request.securityuserid : _securityusersid);
        var sql = 'SELECT * FROM  servicecasevalidation($1)';
        return util.executeDBQuery(sql, [request.where.intakeserviceid])
        .then(result => result[0].servicecasevalidation)
        .then(res => {
            if (res > 0) {
                const sql1 = 'SELECT * FROM listservicecase($1,$2,$3,$4)';
                return util.executeDBQuery(sql1, [request.where.intakeserviceid, securityuserid, request.page, request.limit])
                    .then(result => {
                        var returnjson = { "isavailable": 1, "data": [] };
                        returnjson.data = result[0].listservicecase;
                        return returnjson;
                    });
            } else if (res == 0) {
                var crerequest = {};
                crerequest.intakeserviceid = request.where.intakeserviceid;
                crerequest.subtypekey = request.where.subtypekey;
                crerequest.source = request.where.source;
                crerequest.servicecaseid = null;
                crerequest.isnewcase = 1;
                crerequest.userid = securityuserid;
                crerequest.isoverriderequest = request.where.isoverriderequest;
                return app.models.Servicecase.createservicecase(crerequest, reqctx)
                    .then(resp => {
                        var returnjson = { "isavailable": 0, "data": [] };
                        returnjson.data = resp;
                        return returnjson;
                    })
            }
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        })
    }

    Intakeservreqchildremoval.remoteMethod('servicecasevalidation', {
        accepts: [{
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        }, {
            arg: 'reqctx',
            type: 'object',
            http: { source: 'context' }
        }],
        http: {
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqchildremoval.removalnotification = request => {

        return app.models.Intakeservreqchildremoval.find({
            where: {
                and: [{ intakeserviceid: request.intakeserviceid }, { intakeservreqchildremovalid: request.intakeservreqchildremovalid }]
            }
        }).then(res => {
            if (res.length) {
                const sql = 'select * from getpersonsbyinvestigation($1, $2, $3)';
                const params = [request.intakeserviceid, 1, 100];

                return util.executeDBQuery(sql, params).then(result => {
                    let notification_res;
                    request.where.objectid = request.intakeservreqchildremovalid
                    return app.models.Notificationlog.list(request)
                        .then(_res => {
                            notification_res = _res;
                            result.map(x => {
                                notification_res.map(y => {
                                    if (y.personid === x.personid) {
                                        x.notificationlog = y.__data;
                                    }
                                })
                            })
                            return result
                        });
                }).catch(err => err);
            }
        })
    }

    Intakeservreqchildremoval.removalnotificationmail = (request, reqctx) => {
        const _securityusersid = util.getSecurityDetails(request, reqctx).securityuserid
        var result = [];
        var response = [];
        request.map(x => {
            if (x.userid) {
                var securityuserid = _securityusersid;
                const sql = 'select * from send_notification($1, $2, $3, $4, $5, $6, $7, $8, $9)';
                util.executeDBQuery(sql, [x.userid, securityuserid, x.userid, 'System', 'Normal', x.message, x.message, x.intakeserviceid, false])
                    .then(data => {
                        response.push(data);
                    })
                    .catch(err => {
                        LOGGER.error(err)
                        throw err;
                    })
            } else {
                if ((x.personid || x.objecttypekey == 'assessment') && x.email) {
                    var msg = email.SendAssessmentEmail(x.email, 'CJAMS Notification', x.message, x.objecttypekey)
                    LOGGER.debug(msg);
                    x.securityuserid = _securityusersid;
                    if (msg == "Mail sent successfully") { app.models.Notificationlog.add(x, _securityusersid); }
                    response.push(msg);
                }
            }
        });
        return Promise.all(response).then(function (values) {
            values.map(x => {
                result.push(x);
            });
            return result;
        });
    }

    Intakeservreqchildremoval.remoteMethod('add', {
        accepts: [{
            arg: 'data',
            type: 'object',

            http: { source: 'body' }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: { source: 'context' }
        }],
        http: {
            'verb': 'post',
            'path': '/add'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqchildremoval.remoteMethod('removalnotification', {
        accepts: {
            arg: 'data',
            type: 'object',

            http: { source: 'body' }
        },
        http: {
            'verb': 'post',
            'path': '/removalnotification'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqchildremoval.remoteMethod('removalnotificationmail', {
        accepts: [{
            arg: 'data',
            type: 'array',

            http: { source: 'body' }
        }, {
            arg: 'reqctx',
            type: 'object',
            http: { source: 'context' }
        }],
        http: {
            'verb': 'post',
            'path': '/removalnotificationmail'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqchildremoval.remoteMethod('getchildremoval', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqchildremoval.getchildremovalDetailsForDisorderCheck = (request) => {
        var sql = 'select * from getservicecaseremovallistForDisorderCheck($1)';
        return util.executeDBQuery(sql, [request.where.objectid])
            .then(data => data[0].getservicecaseremovallistfordisordercheck)
            .catch(err => util.logError(err))
    }

    Intakeservreqchildremoval.remoteMethod('getchildremovalDetailsForDisorderCheck', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            },
            required: true
        },
        http: {
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqchildremoval.list = (request) => {
        var page = request.page;
        var limit = request.limit;
        var totalcount = 0;
        var sql = 'select * from getchildremovallist($1, $2, $3)';
        return util.executeSecondaryNodeDBQuery(sql, [request.where.intakeserviceid, page, limit])
            .then(data => {
                if (data != null && data.length > 0) { totalcount = data[0].totalcount; }
                return {
                    'data': data,
                    'count': totalcount
                };
            })
            .catch(err => { LOGGER.error('>>>>ERROR:', err); return util.logError(err); });
    }

    Intakeservreqchildremoval.remoteMethod('list', {
        accepts: {
            arg: 'filter',
            type: 'Object',
            http: {
                source: 'query'
            }
        },
        http: {
            verb: 'get'
        },
        returns: {
            type: 'Object',
            root: true
        }
    })

    Intakeservreqchildremoval.remoteMethod('addlegalstatus', {
        accepts: {
            arg: 'data',
            type: 'object',

            http: { source: 'body' }
        },
        http: {
            'verb': 'post',
            'path': '/addlegalstatus'
        },
        returns: {
            type: 'Object',
            root: true
        }
    });

    Intakeservreqchildremoval.addlegalstatus = function (request) {
        LOGGER.debug(request.where)
        var sql = "select * from fc_sp_legal_status($1)";
        return util.executeDBQuery(sql, [request.where]).then(res => {
            return res
        })
        .catch(err => {
            LOGGER.error('>>>>ERROR:', err);
            throw err;
        });
    }

    Intakeservreqchildremoval.observe('before save', (ctx, next) => util.beforesave(ctx, next));
    Intakeservreqchildremoval.observe('access', (ctx, next) => util.access(ctx, next));
    Intakeservreqchildremoval.beforeRemote('*', (ctx, data, next) => util.beforeremote(ctx, next));
}

function returnStatusFn(request, status) {
    if (request.issupervisor === 1) {
        if (request.status === "Approved") {
            status = 16;
        } else if (request.status === "Rejected") {
            status = 17;
        }
    }
    return status;
}
