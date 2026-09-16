-- CIDM-8547-Placement-Request-Form-Enhancements
-- Adding reference values to add a dropdown categroy and sub category
-- Adding a new objecttype to enable saving the data

-- Delete scripts in case of delete
DELETE FROM cjams.referencevalues
WHERE referencevaluesid='ce4a5129-4c0d-4a5d-9883-2c2cc4d469a2';

DELETE FROM cjams.referencevalues
WHERE referencevaluesid='b8eb119f-7035-4c93-b901-d338c89319d4';

-- generating two randomids() using gen_random_id()
-- id1 - 'ce4a5129-4c0d-4a5d-9883-2c2cc4d469a2'
-- id2 - 'b8eb119f-7035-4c93-b901-d338c89319d4'

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('placementprf', 1000, 'Placement', 'Placement', 'CW', 1, 11, 'CIDM-8547', now(), 'CIDM-8547', now(), NULL, NULL, NULL, 'ce4a5129-4c0d-4a5d-9883-2c2cc4d469a2');


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('prf', 1000, 'Child Placement Information Form', 'Child Placement Information Form', 'CW', 1, NULL, 'CIDM-8547', now(), 'CIDM-8547', now(), NULL, 'placementprf', NULL, 'b8eb119f-7035-4c93-b901-d338c89319d4');