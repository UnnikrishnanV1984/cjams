INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(342, 'CW Person Primary Role', 'CWPersonPrimaryRole', 1, 'Admin', '2019-05-01 13:27:52.423', 'Admin', '2019-05-01 13:27:52.423', NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RA', 342, 'RA', 'RA', 'CW', 1, 1, 'admin', '2018-11-30 16:09:22.933', 'admin', '2018-11-30 16:09:22.933', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RC', 342, 'RC', 'RC', 'CW', 1, 1, 'admin', '2018-11-30 16:09:22.933', 'admin', '2018-11-30 16:09:22.933', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CLI', 342, 'CLI', 'CLI', 'CW', 1, 1, 'admin', '2018-11-30 16:09:22.933', 'admin', '2018-11-30 16:09:22.933', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CHILD', 342, 'CHILD', 'CHILD', 'CW', 1, 1, 'admin', '2018-11-30 16:09:22.933', 'admin', '2018-11-30 16:09:22.933', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BIOCHILD', 342, 'BIOCHILD', 'BIOCHILD', 'CW', 1, 1, 'admin', '2018-11-30 16:09:22.933', 'admin', '2018-11-30 16:09:22.933', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTHERCHILD', 342, 'OTHERCHILD', 'OTHERCHILD', 'CW', 1, 1, 'admin', '2018-11-30 16:09:22.933', 'admin', '2018-11-30 16:09:22.933', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LG', 342, 'LG', 'LG', 'CW', 1, 1, 'admin', '2018-11-30 16:09:22.933', 'admin', '2018-11-30 16:09:22.933', NULL, NULL, NULL);
commit;
