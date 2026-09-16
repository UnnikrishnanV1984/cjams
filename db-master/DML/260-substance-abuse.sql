delete from cjams.referencevalues where ref_key='BENZO' AND referencetypeid = 55;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BENZO', 55, 'Benzodiazepine''s', 'Benzodiazepine''s', NULL, 1, 24, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

delete from cjams.referencevalues where ref_key='OPIA' AND referencetypeid = 55;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OPIA', 55, 'Opiates', 'Opiates', NULL, 1, 25, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
