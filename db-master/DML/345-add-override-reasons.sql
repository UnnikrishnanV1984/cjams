INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(600, 'supervisoroverridereasons', NULL, 1, 'admin', now(), 'admin', now(), NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('ATLE', 600, 'Add to law enforcement','Add to law enforcement','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('ATNA', 600, 'Add to narrative','Add to narrative','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('ADMC', 600, 'Add/delete/modify clients','Add/delete/modify clients','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('IASS', 600, 'Inappropriate services selected','Inappropriate services selected','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('ITMS', 600, 'Inappropriate type of maltreament selected','Inappropriate type of maltreament selected','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('RISI', 600, 'Referral inappropriately screened in/referred','Referral inappropriately screened in/referred','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
values
('RISO', 600, 'Referral inappropriately screened out/not referred','Referral inappropriately screened out/not referred','CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);



