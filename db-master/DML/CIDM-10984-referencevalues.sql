Delete from cjams.referencetype where referencetypeid in (500801,500802,500803);
Delete from cjams.referencevalues where referencetypeid in (500801,500802,500803);
-- F2F Contact Reasons
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500801, 'F2F Contact Untimely Reasons', 'F2F Contact Untimely Reasons', 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('NOJ', 500801, 'Newborn out of the jurisdiction', 'Newborn out of the jurisdiction', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('FRCD', 500801, 'Family refused to cooperate with Department', 'Family refused to cooperate with Department', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('ESPIC', 500801, 'Emergency situation prevented initial contact', 'Emergency situation prevented initial contact', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('DEEF2F', 500801, 'Data entry error but face to face met mandate', 'Data entry error but face to face met mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('CNAT', 500801, 'Case not assigned timely', 'Case not assigned timely', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('WAMC', 500801, 'Worker assigned multiple cases all requiring 24-48 hour responses', 'Worker assigned multiple cases all requiring 24-48 hour responses', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('FCU', 500801, 'Family was contacted but unavailable to meet within mandate', 'Family was contacted but unavailable to meet within mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('DURF', 500801, 'The Department attempted contact but was unable to reach the family within the mandate', 'The Department attempted contact but was unable to reach the family within the mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('NDCF', 500801, 'The notification did not provide contact information that would enable the Department to contact the family', 'The notification did not provide contact information that would enable the Department to contact the family', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('OTR', 500801, 'Other', 'Other', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());

-- SAFEC Reasons
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500802, 'SafeC Untimely Reasons', 'SafeC Untimely Reasons', 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('NOJ', 500802, 'Newborn out of the jurisdiction', 'Newborn out of the jurisdiction', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('FRCD', 500802, 'Family refused to cooperate with Department', 'Family refused to cooperate with Department', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('ESPIC', 500802, 'Emergency situation prevented initial contact', 'Emergency situation prevented initial contact', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('DEEF2F', 500802, 'Data entry error but face to face met mandate', 'Data entry error but face to face met mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('CNAT', 500802, 'Case not assigned timely', 'Case not assigned timely', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('WAMC', 500802, 'Worker assigned multiple cases all requiring 24-48 hour responses', 'Worker assigned multiple cases all requiring 24-48 hour responses', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('FCU', 500802, 'Family was contacted but unavailable to meet within mandate', 'Family was contacted but unavailable to meet within mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('DURF', 500802, 'The Department attempted contact but was unable to reach the family within the mandate', 'The Department attempted contact but was unable to reach the family within the mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('NDCF', 500802, 'The notification did not provide contact information that would enable the Department to contact the family', 'The notification did not provide contact information that would enable the Department to contact the family', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('OTR', 500802, 'Other', 'Other', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());

-- MFIRA Reasons
INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(500803, 'MFIRA Untimely Reasons', 'MFIRA Untimely Reasons', 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('NOJ', 500803, 'Newborn out of the jurisdiction', 'Newborn out of the jurisdiction', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('FRCD', 500803, 'Family refused to cooperate with Department', 'Family refused to cooperate with Department', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('ESPIC', 500803, 'Emergency situation prevented initial contact', 'Emergency situation prevented initial contact', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('DEEF2F', 500803, 'Data entry error but face to face met mandate', 'Data entry error but face to face met mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('CNAT', 500803, 'Case not assigned timely', 'Case not assigned timely', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('WAMC', 500803, 'Worker assigned multiple cases all requiring 24-48 hour responses', 'Worker assigned multiple cases all requiring 24-48 hour responses', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('FCU', 500803, 'Family was contacted but unavailable to meet within mandate', 'Family was contacted but unavailable to meet within mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('DURF', 500803, 'The Department attempted contact but was unable to reach the family within the mandate', 'The Department attempted contact but was unable to reach the family within the mandate', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('NDCF', 500803, 'The notification did not provide contact information that would enable the Department to contact the family', 'The notification did not provide contact information that would enable the Department to contact the family', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode, referencevaluesid)
VALUES('OTR', 500803, 'Other', 'Other', 'CW', 1, 1, 'CIDM-10984', now(), 'CIDM-10984', now(), NULL, NULL, NULL, gen_random_uuid());