

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CPLAN2', 46, 'Case Plan 2 Review', 'Case Plan 2 Review', 'CW', 1, 1, 'admin', '2019-03-29 20:12:26.231', 'admin', '2019-03-29 20:12:26.231', NULL, NULL, NULL);


INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('CPLAN2', 'CWSP', 1, 'admin', '2019-03-21 12:21:53.592', NULL, '2019-03-21 12:21:53.592', '2019-03-21 12:21:53.592', NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);


INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('CPLAN2', 'CWSP', 1, 'admin', '2019-03-21 12:21:53.592', NULL, '2019-03-21 12:21:53.592', '2019-03-21 12:21:53.592', NULL, NULL, 'CWSP', NULL, NULL, NULL, NULL);