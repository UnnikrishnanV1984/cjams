-- CIDM-8662 Youth Transition Plan FTDM enhancement - (LJ 24)
delete from cjams.referencevalues where insertedby = 'CIDM-8662';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('ytpmeeting', 1000, 'My Youth Transition Plan and Meeting Summary', 'My Youth Transition Plan and Meeting Summary', 'CW', 1, NULL, 'CIDM-8662', now(), 'CIDM-8662', now(), NULL, 'ytp', NULL, gen_random_uuid());

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('ytp', 1000, 'Ready by 21', 'Ready by 21', 'CW', 1, 11, 'CIDM-8662', now(), 'CIDM-8662', now(), NULL, NULL, NULL, gen_random_uuid());