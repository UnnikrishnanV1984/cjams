--D-17208 Add adoptive parent as a role

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ADOPTIVEPARENT', 176, 'Adoptive Parent', 'Adoptive Parent', NULL, 1, 1, NULL, now(), NULL, now(), NULL, NULL, 'ADOPTIVEPARENT');
