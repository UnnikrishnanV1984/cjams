delete from cjams.referencevalues where referencetypeid = 339;

delete from cjams.referencetype where referencetypeid = 339;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(339, 'Medication Classification', 'medicationclassification', 1, 'CIDM-6692' ,now(), 'CIDM-6692' , now(), NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AD', 339, 'Antidepressants', 'Antidepressants', 'CW', 1, 1, 'CIDM-6692' ,now(), 'CIDM-6692' , now(), NULL, NULL, 'AD');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AAM', 339, 'Anti-anxiety medications', 'Anti-anxiety medications', 'CW', 1, 1, 'CIDM-6692' ,now(), 'CIDM-6692' , now(), NULL, NULL, 'AAM');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ST', 339, 'Stimulants', 'Stimulants', 'CW', 1, 1, 'CIDM-6692' ,now(), 'CIDM-6692' , now(), NULL, NULL, 'ST');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AP', 339, 'Antipsychotics', 'Antipsychotics', 'CW', 1, 1, 'CIDM-6692' ,now(), 'CIDM-6692' , now(), NULL, NULL, 'AP');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MS', 339, 'Mood stabilizers', 'Mood stabilizers', 'CW', 1, 1, 'CIDM-6692' ,now(), 'CIDM-6692' , now(), NULL, NULL, 'MS');