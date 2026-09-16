INSERT INTO cjams.referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(752, 'Case Type', 'Casetype', 1, 'Admin', '2019-06-27 16:21:09.423', 'Admin', '2019-06-27 16:21:09.423', NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('5', 752, 'intake', 'Intake', 'CW', 1, 2, 'Admin', '2019-06-27 16:21:09.423', 'Admin', '2019-06-27 16:21:09.423', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('4', 752, 'noncps', 'Non-CPS', 'CW', 1, 2, 'Admin', '2019-06-27 16:21:09.423', 'Admin', '2019-06-27 16:21:09.423', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('3', 752, 'AR', 'CPS-AR', 'CW', 1, 2, 'Admin', '2019-06-27 16:21:09.423', 'Admin', '2019-06-27 16:21:09.423', NULL, NULL, NULL) ON CONFLICT DO NOTHING;
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('2', 752, 'IR', 'CPS-IR', 'CW', 1, 2, 'Admin', '2019-06-27 16:21:09.423', 'Admin', '2019-06-27 16:21:09.423', NULL, NULL, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('1', 752, 'servicecase', 'Service Case', 'CW', 1, 1, 'Admin', '2019-06-27 16:21:09.423', 'Admin', '2019-06-27 16:21:09.423', NULL, NULL, NULL) ON CONFLICT DO NOTHING;