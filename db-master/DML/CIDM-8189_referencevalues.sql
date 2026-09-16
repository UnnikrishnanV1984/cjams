-- Code fix - API
-- Code fix - API, DB Scripts
-- Code fix - DB Script
-- Code fix - Web
-- Code fix - Web, API
-- Code fix - Web, API and DB scripts
-- Code fix - Web, DB scripts
-- Data Fix
-- Not a Defect
-- Not Yet Determined
-- Training
-- User Story Created

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500500, 'issuefixtype', 'issuefixtype', 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFA', 500500, 'Code fix - API', 'Code fix - API', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFAD', 500500, 'Code fix - API, DB Scripts', 'Code fix - API, DB Scripts', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFD', 500500, 'Code fix - DB Script', 'Code fix - DB Script', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFW', 500500, 'Code fix - Web', 'Code fix - Web', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFWA', 500500, 'Code fix - Web, API', 'Code fix - Web, API', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFWAD', 500500, 'Code fix - Web, API and DB scripts', 'Code fix - Web, API and DB scripts', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CFWD', 500500, 'Code fix - Web, DB scripts', 'Code fix - Web, DB scripts', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DF', 500500, 'Data Fix', 'Data Fix', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NAD', 500500, 'Not a Defect', 'Not a Defect', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NYD', 500500, 'Not Yet Determined', 'Not Yet Determined', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TRN', 500500, 'Training', 'Training', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('USC', 500500, 'User Story Created', 'User Story Created', 'CW', 1, 1, 'CIDM-8189', now(), 'CIDM-8189', now(), NULL, NULL, NULL) ON CONFLICT DO NOTHING; 
