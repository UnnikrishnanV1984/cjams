UPDATE cjams.referencetype
SET typedescription='IV-E Foster Care Status', tablename='IV-E Foster Care Status', activeflag=1, updatedon=now()
WHERE referencetypeid=506;

UPDATE cjams.referencevalues
SET activeflag=1, updatedon = now()
WHERE referencetypeid=506;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES('MI', 506, '201_MISSING_INFO', '201_MISSING_INFO', 'CW', 1, 7, 'Admin', now(), 'Admin', now());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES('CP', 506, 'CRITERIA_PASSED', 'CRITERIA_PASSED', 'CW', 1, 8, 'Admin', now(), 'Admin', now());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon)
VALUES('CF', 506, 'CRITERIA_FAILED', 'CRITERIA_FAILED', 'CW', 1, 9, 'Admin', now(), 'Admin', now());