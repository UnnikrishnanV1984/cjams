DELETE FROM cjams.referencetype WHERE referencetypeid = 500710;
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500710, 'SEN Criteria', 'sencriteria', 1, 'CIDM-10982', now(), 'CIDM-10982', now(), NULL);


DELETE FROM cjams.referencevalues WHERE referencetypeid = 500710;
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NBPTS', 500710, 'Newborn positive toxicology screen for a controlled substance', ' Newborn positive toxicology screen for a controlled substance', NULL, 1, 1, 'CIDM-10982', NOW(), NULL, NOW(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NBPSE', 500710, 'Newborn affected by prenatal substance exposure/displays the effects of controlled substance use or symptoms of withdrawal',
'Newborn affected by prenatal substance exposure/displays the effects of controlled substance use or symptoms of withdrawal',
NULL, 1, 2, 'CIDM-10982', NOW(), NULL, NOW(), NULL, NULL, NULL); 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NBFASD', 500710, 'Newborn displays the effects of FASD', 'Newborn displays the effects of FASD', NULL, 1, 3, 'CIDM-10982', NOW(), NULL, NOW(), NULL, NULL, NULL);