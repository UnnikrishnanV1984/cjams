
DELETE FROM referencetype where referencetypeid = 572 and typedescription = 'Subsidy Agreement Docs';
INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(572, 'Subsidy Agreement Docs', 'subsidyagreement', 1, 'admin', now(), 'admin', now(), NULL);


DELETE FROM referencevalues
WHERE ref_key = 'IVEAAAR' and referencetypeid = 572;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IVEAAAR', 572, 'IV-E Adoption Assistance Agreement Redetermination',
'IV-E Adoption Assistance Agreement Redetermination', 'CW', 1, 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL, NULL);

DELETE FROM referencevalues
WHERE ref_key = 'IVEAAA' and referencetypeid = 572;

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('IVEAAA', 572, 'IV-E Adoption Assistance Agreement',
'IV-E Adoption Assistance Agreement', 'CW', 1, 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL, NULL);


DELETE FROM referencevalues
WHERE ref_key = 'OTOAA' and referencetypeid = 572;

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTOAA', 572, 'One-Time-Only Adoption Agreement',
'One-Time-Only Adoption Agreement', 'CW', 1, 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL, NULL);


DELETE FROM referencevalues
WHERE ref_key = 'PAAA' and referencetypeid = 572;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PAAA', 572, 'Post Adoption Assistance Agreement',
'Post Adoption Assistance Agreement', 'CW', 1, 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL, NULL);

DELETE FROM referencevalues
WHERE ref_key = 'PASRF' and referencetypeid = 572;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PASRF', 572, 'Post Adoption Services Referral Form',
'Post Adoption Services Referral Form', 'CW', 1, 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL, NULL);


DELETE FROM referencevalues
WHERE ref_key = 'SAAAR' and referencetypeid = 572;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SAAAR', 572, 'State Adoption Assistance Agreement Redetermination',
'State Adoption Assistance Agreement Redetermination', 'CW', 1, 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL, NULL);


DELETE FROM referencevalues
WHERE ref_key = 'SAAA' and referencetypeid = 572;
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SAAA', 572, 'State Adoption Assistance Agreement',
'State Adoption Assistance Agreement', 'CW', 1, 1, 'admin', NOW(), 'admin', NOW(), NULL, NULL, NULL);
