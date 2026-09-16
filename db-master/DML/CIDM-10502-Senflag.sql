DELETE FROM cjams.routingconfig WHERE eventcode = 'SENCHECK';
INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('SENCHECK', 'CWSP', 1, 'admin', NOW(), 'admin',NOW(), NOW(), NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);

DELETE FROM cjams.referencevalues WHERE ref_key = 'SENCHECK' AND referencetypeid = 46;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SENCHECK', 46, 'SEN removal', 'SEN removal', 'CW', 1, 1, 'Admin',NOW(), NULL, NOW(), NULL, NULL, NULL);