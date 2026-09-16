UPDATE referencevalues
SET activeflag=0, updatedon=now()
WHERE ref_key='LA' and referencetypeid=171;
UPDATE referencevalues
SET activeflag=0, updatedon=now()
WHERE ref_key='OT' and referencetypeid=171;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OT', 171, 'Others', 'Others', NULL, 1, 13, NULL, now(), NULL, now(), NULL, NULL, 'OT');

