DELETE FROM referencevalues WHERE referencetypeid = 752 AND ref_key='6';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('6', 752, 'adoptioncase', 'Adoption Case', 'CW', 1, 2, 'Admin', '2019-09-15 23:17:42.816', 'Admin', '2019-09-15 23:17:42.816', NULL, NULL, NULL);
