delete from referencevalues where ref_key = 'GAAP';
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GAAP', 46, 'Guardianship Application Review', 'Guardianship Application Review', NULL, 1, 5, 'Admin', '2019-01-14 02:06:10.221', NULL, '2019-01-14 02:06:10.221', NULL, NULL, NULL);
