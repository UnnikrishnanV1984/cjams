
delete from routingconfig where routingconfigid='27143e0f-6b45-42d3-9198-e21cba2ee976';
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('27143e0f-6b45-42d3-9198-e21cba2ee976', 'VNDR', 'CWSP', 1, 'admin', '2019-06-26 18:29:32.165', NULL, '2019-06-26 18:29:32.165', '2019-06-26 18:29:32.165', NULL, NULL, 'CWCW', NULL, NULL, NULL);
delete from referencevalues where referencetypeid='751';
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('APR', 751, 'Approve', 'Approve', NULL, 1, NULL, NULL, '2019-06-27 14:27:28.405', NULL, '2019-06-27 14:27:28.405', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('REJ', 751, 'Reject', 'Reject', NULL, 1, NULL, NULL, '2019-06-27 14:27:19.727', NULL, '2019-06-27 14:27:19.727', NULL, NULL, NULL);
delete from referencetype where referencetypeid='751';
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(751, 'Vendor Supervisor decision', 'vendordecision', 1, 'admin', '2019-06-27 14:25:29.151', 'admin', '2019-06-27 14:25:29.151', NULL);

