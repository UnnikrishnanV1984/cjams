

DELETE FROM referencetype WHERE  referencetypeid= 358;
INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(358, 'Provider Roles', 'provdroles', 1, 'admin', '2019-04-17 18:55:14.571', 'admin', '2019-04-17 18:55:14.571', NULL);

DELETE FROM referencevalues WHERE  referencetypeid= 358;

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('APLCNT', 358, 'Applicant', 'Applicant', NULL, 1, 1, NULL, '2019-04-23 12:15:17.838', NULL, '2019-04-23 12:15:17.838', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('COAPLCNT', 358, 'Co-Applicant', 'Co-Applicant', NULL, 1, 2, NULL, '2019-04-23 12:15:17.838', NULL, '2019-04-23 12:15:17.838', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CHILD', 358, 'Child', 'Child', NULL, 1, 3, NULL, '2019-04-23 12:15:17.838', NULL, '2019-04-23 12:15:17.838', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTHHM', 358, 'Other Household Member', 'Other Household Member', NULL, 1, 4, NULL, '2019-04-23 12:15:17.838', NULL, '2019-04-23 12:15:17.838', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFRFC', 358, 'Client for Restricted Foster Care', 'Client for Restricted Foster Care', NULL, 1, 5, NULL, '2019-04-23 12:15:17.838', NULL, '2019-04-23 12:15:17.838', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('REF', 358, 'Reference', 'Reference', NULL, 1, 6, NULL, '2019-04-23 12:15:17.838', NULL, '2019-04-23 12:15:17.838', NULL, NULL, NULL);
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BCKP', 358, 'Backup', 'Backup', NULL, 1, 7, NULL, '2019-04-23 12:15:17.838', NULL, '2019-04-23 12:15:17.838', NULL, NULL, NULL);
