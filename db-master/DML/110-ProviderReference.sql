delete from referencevalues where referencetypeid='750' and ref_key='RRH';
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RRH', 750, 'Regular Resource Home', 'Regular Resource Home', NULL, 1, NULL, NULL, now(), NULL, now(), NULL, NULL, NULL);
