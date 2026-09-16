delete from referencevalues where referencetypeid = 76 and ref_key = 'UNK';
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('UNK', 76, 'Unkonwn', 'Unkonwn', 'CW', 1, 16, 'Admin', '2019-03-14 18:41:47.488', 'Admin', '2019-03-14 18:41:47.488', NULL, NULL, NULL);
