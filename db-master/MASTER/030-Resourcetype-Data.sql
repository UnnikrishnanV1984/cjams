DELETE FROM referencevalues WHERE referencetypeid = 344;
DELETE FROM referencetype WHERE referencetypeid = 344; 
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(344, 'Resource Type', 'Resourcetype', 1, 'Admin', '2019-05-25 16:10:18.851', 'Admin', '2019-05-25 16:10:18.851', NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('4', 344, 'Action', 'Action', 'CW', 1, 2, 'Admin', '2019-05-25 16:10:18.851', 'Admin', '2019-05-25 16:10:18.851', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('3', 344, 'Screen', 'Screen', 'CW', 1, 2, 'Admin', '2019-05-25 16:10:18.851', 'Admin', '2019-05-25 16:10:18.851', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('2', 344, 'Module', 'Module', 'CW', 1, 2, 'Admin', '2019-05-25 16:10:18.851', 'Admin', '2019-05-25 16:10:18.851', NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('1', 344, 'Menu', 'Menu', 'CW', 1, 1, 'Admin', '2019-05-25 16:10:18.851', 'Admin', '2019-05-25 16:10:18.851', NULL, NULL, NULL);
