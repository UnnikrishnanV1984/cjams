delete from referencetype where referencetypeid = '517';
INSERT INTO referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(517, 'SafecarePlan Roles', 'safecareplanrole', 1, 'CIDM-5024', now(), 'CIDM-5024',now(), NULL);

delete from referencevalues where referencetypeid = '517';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HSWN', 517, 'Hospital Social Worker/Nurse', 'Hospital Social Worker/Nurse', NULL, 1, 1, NULL, now(), NULL, now(), NULL, NULL, 'HSWN');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CGR', 517, 'Caregiver Relative', 'Caregiver Relative', NULL, 1, 2, NULL, now(), NULL, now(), NULL, NULL, 'CGR');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CGNR', 517, 'Caregiver Non-Relative', 'Caregiver Non-Relative', NULL, 1, 3, NULL, now(), NULL, now(), NULL, NULL, 'CGNR');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NPCD', 517, 'Newborns Primary Care Doctor', 'Newborns Primary Care Doctor', NULL, 1, 4, NULL, now(), NULL, now(), NULL, NULL, 'NPCD');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NSCD', 517, 'Newborns Speciality Care Doctor', 'Newborns Speciality Care Doctor', NULL, 1, 5, NULL, now(), NULL, now(), NULL, NULL, 'NSCD');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NMC', 517, 'Newborns MCO Cordinator', 'Newborns MCO Cordinator', NULL, 1, 6, NULL, now(), NULL, now(), NULL, NULL, 'NMC');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HV', 517, 'Home Visitor', 'Home Visitor', NULL, 1, 7, NULL, now(), NULL, now(), NULL, NULL, 'HV');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IAT', 517, 'Infants and Toddlers', 'Infants and Toddlers', NULL, 1, 8, NULL, now(), NULL, now(), NULL, NULL, 'IAT');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MSMP', 517, 'Mothers SUD or MAT Provider', 'Mothers SUD or MAT Provider', NULL, 1, 9, NULL, now(), NULL, now(), NULL, NULL, 'MSMP');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FSMP', 517, 'Fathers SUD or MAT Provider', 'Fathers SUD or MAT Provider', NULL, 1, 10, NULL, now(), NULL, now(), NULL, NULL, 'FSMP');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MMHP', 517, 'Mothers Mental Health Provider', 'Mothers Mental Health Provider', NULL, 1, 11, NULL, now(), NULL, now(), NULL, NULL, 'MMHP');


INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FMHP', 517, 'Fathers Mental Health Provider', 'Fathers Mental Health Provider', NULL, 1, 12, NULL, now(), NULL, now(), NULL, NULL, 'FMHP');













