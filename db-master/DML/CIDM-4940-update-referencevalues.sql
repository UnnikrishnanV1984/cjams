delete from referencetype where referencetypeid = '147';
INSERT INTO referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(147, 'School Enrollment', 'schoolenroll', 1, 'CIDM-4940', now(), 'CIDM-4940',now(), NULL);

delete from referencevalues where ref_key='NTE' and referencetypeid = '147';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NTE', 147, 'Not Enrolled', 'Not Enrolled', NULL, 1, 3, NULL, now(), NULL, now(), NULL, NULL, 'NTE');

delete from referencevalues where ref_key='NTSA' and referencetypeid = '147';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('NTSA', 147, 'Not school-age', 'Not school-age', NULL, 1, 4, NULL, now(), NULL, now(), NULL, NULL, 'NTSA');

delete from referencevalues where ref_key='ELSC' and referencetypeid = '147';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ELSC', 147, 'Elementary school', 'Elementary school', NULL, 1, 2, NULL, now(), NULL, now(), NULL, NULL, 'ELSC');

delete from referencevalues where ref_key='SESC' and referencetypeid = '147';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SESC', 147, 'Secondary school', 'Secondary school', NULL, 1, 6, NULL, now(), NULL, now(), NULL, NULL, 'SESC');

delete from referencevalues where ref_key='PSEOT' and referencetypeid = '147';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PSEOT', 147, 'Post-secondary education or training', 'Post-secondary education or training', NULL, 1, 5, NULL, now(), NULL, now(), NULL, NULL, 'PSEOT');

delete from referencevalues where ref_key='COLLG' and referencetypeid = '147';
INSERT INTO referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('COLLG', 147, 'College', 'College', NULL, 1, 1, NULL, now(), NULL, now(), NULL, NULL, 'COLLG');