delete from cjams.referencevalues where referencetypeid = 800;

delete from cjams.referencetype where referencetypeid = 800;

INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(800, 'Persons Appeared', 'personsappeared', 1, NULL, now(), NULL,now(), NULL);

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CH', 800, 'Child', 'Child', 'CW', 1, 1, NULL, now(), NULL, now(), NULL, NULL, 'CH');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CHATT', 800, 'Child’s Attorney', 'Child’s Attorney', 'CW', 1, 2, NULL, now(), NULL, now(), NULL, NULL, 'CHATT');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CSW', 800, 'Case Worker', 'Case Worker', 'CW', 1, 3, NULL, now(), NULL, now(), NULL, NULL, 'CSW');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DSATT', 800, 'DSS Attorney', 'DSS Attorney', 'CW', 1, 4, NULL, now(), NULL, now(), NULL, NULL, 'DSATT');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GUA', 800, 'Guardian', 'Guardian', 'CW', 1, 5, NULL, now(), NULL, now(), NULL, NULL, 'GUA');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MOT', 800, 'Mother', 'Mother', 'CW', 1, 6, NULL, now(), NULL, now(), NULL, NULL, 'MOT');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MOTATT', 800, 'Mother’s Attorney', 'Mother’s Attorney', 'CW', 1, 7, NULL, now(), NULL, now(), NULL, NULL, 'MOTATT');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FAT', 800, 'Father', 'Father', 'CW', 1, 8, NULL, now(), NULL, now(), NULL, NULL, 'FAT');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FATATT', 800, 'Father’s Attorney', 'Father’s Attorney', 'CW', 1, 9, NULL, now(), NULL, now(), NULL, NULL, 'FATATT');

INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CASA', 800, 'CASA', 'CASA', 'CW', 1, 10, NULL, now(), NULL, now(), NULL, NULL, 'CASA');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PREAP', 800, 'Pre-adoptive Parent', 'Pre-adoptive Parent', 'CW', 1, 11, NULL, now(), NULL, now(), NULL, NULL, 'PREAP');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FOSP', 800, 'Foster Parent', 'Foster Parent', 'CW', 1, 12, NULL, now(), NULL, now(), NULL, NULL, 'FOSP');

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTH', 800, 'Other', 'Other', 'CW', 1, 13, NULL, now(), NULL, now(), NULL, NULL, 'OTH');


