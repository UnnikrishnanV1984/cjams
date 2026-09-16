--------------------------------------
--Revision(s)
-- 02/26/2026 - Sandeep kiran Anugolu - CIDM-11146 - Person Search adding mdmcode for phone communication type
-----------------------------------------

-- phone type
--Secondary
UPDATE cjams.referencevalues
SET mdmcode='BUSINESS',
updatedby = 'CIDM-11146',
updatedon = now()
WHERE referencevaluesid='b8b0810a-94f2-45c5-a70b-a433fb253251'::uuid;

--Primary
UPDATE cjams.referencevalues
SET mdmcode='BUSINESS',
updatedby = 'CIDM-11146',
updatedon = now()
WHERE referencevaluesid='b51900ac-b7e3-414c-aef8-0415cf21d97d'::uuid;

--Fax
UPDATE cjams.referencevalues
SET mdmcode='BUSINESS',
updatedby = 'CIDM-11146',
updatedon = now()
WHERE referencevaluesid='7172e375-9589-45d8-a5ba-0b42753012fc'::uuid;

-- phone comm type mdmcodes
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(201, 'Phone Communication Type', 'phonecommtype', 1, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL);

delete from cjams.referencevalues where referencetypeid =201;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('SEC', 201, 'Secondary', 'Secondary', NULL, 1, 10, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL, NULL, 'PHONE', gen_random_uuid());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('PRI', 201, 'Primary', 'Primary', NULL, 1, 9, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL, NULL, 'PHONE', gen_random_uuid());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('CL', 201, 'Cell', 'Cell', NULL, 1, 2, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL, NULL, 'CELL', gen_random_uuid());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('HM', 201, 'Home', 'Home', NULL, 1, 1, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL, NULL, 'PHONE', gen_random_uuid());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('BU', 201, 'Business', 'Business', NULL, 1, 6, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL, NULL, 'PHONE', gen_random_uuid());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('WK', 201, 'Work', 'Work', NULL, 1, 3, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL, NULL, 'PHONE', gen_random_uuid());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('FA', 201, 'Fax', 'Fax', NULL, 1, 8, 'CIDM-11146', now(), 'CIDM-11146', now(), NULL, NULL, 'FAX', gen_random_uuid());

