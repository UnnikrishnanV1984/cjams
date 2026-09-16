-- New reference type

DELETE FROM referencetype WHERE referencetypeid = 516;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(516, 'Service Plan Imminent', 'serviceplanimminent', 1, 'admin', now(), 'admin', now(), NULL);

-- Reference values

DELETE FROM referencevalues WHERE referencetypeid = 516;

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ROH', 516, 'Risk of Harm', 'Risk of Harm', 'CW', 1, 1, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SUD', 516, 'Substance Use Disorder', 'Substance Use Disorder', 'CW', 1, 2, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('VT', 516, 'Victim of Trafficking', 'Victim of Trafficking', 'CW', 1, 3, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ULC', 516, 'Unsafe Living Conditions', 'Unsafe Living Conditions', 'CW', 1, 4, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CMN', 516, 'Complex Medical Needs', 'Complex Medical Needs', 'CW', 1, 5, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CPBN', 516, 'Complex Psychological or Behavioral Needs', 'Complex Psychological or Behavioral Needs', 'CW', 1, 6, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PCWE', 516, 'Prior Child Welfare Experience', 'Prior Child Welfare Experience', 'CW', 1, 6, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DJSI', 516, 'DJS Involvement', 'DJS Involvement', 'CW', 1, 7, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('INK', 516, 'Informal Kinship', 'Informal Kinship', 'CW', 1, 8, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTH', 516, 'Other', 'Other', 'CW', 1, 9, 'admin', now(), 'admin', now(), NULL, NULL, NULL);

INSERT INTO cjams.referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NONE', 516, 'None', 'None', 'CW', 1, 10, 'admin', now(), 'admin', now(), NULL, NULL, NULL);
