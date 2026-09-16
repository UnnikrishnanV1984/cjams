delete from cjams.referencetype where typedescription='jurisdictioncode';

INSERT INTO cjams.referencetype
(referencetypeid,typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(163,'jurisdictioncode', 'jurisdictioncode', 1, 'admin', now(), 'admin', now(), NULL);

delete from cjams.referencevalues where referencetypeid=163;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ALLG', 163, 'ALLG', 'ALLG', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('AARU', 163, 'AARU', 'AARU', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('BCNY', 163, 'BCNY', 'BCNY', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CITY', 163, 'CITY', 'CITY', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CALV', 163, 'CALV', 'CALV', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CLNE', 163, 'CLNE', 'CLNE', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CRRL', 163, 'CRRL', 'CRRL', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CECL', 163, 'CECL', 'CECL', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('CHAS', 163, 'CHAS', 'CHAS', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('DORC', 163, 'DORC', 'DORC', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('FRED', 163, 'FRED', 'FRED', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('GARR', 163, 'GARR', 'GARR', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES(' HARF', 163, ' HARF', ' HARF', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('HOWD', 163, 'HOWD', 'HOWD', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('KENT', 163, 'KENT', 'KENT', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MONT', 163, 'MONT', 'MONT', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PGEO', 163, 'PGEO', 'PGEO', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('QANN', 163, 'QANN', 'QANN', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('STMY', 163, 'STMY', 'STMY', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('SOMT', 163, 'SOMT', 'SOMT', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('TALB', 163, 'TALB', 'TALB', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WASH', 163, 'WASH', 'WASH', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WICO', 163, 'WICO', 'WICO', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('WORC', 163, 'WORC', 'WORC', 'CW', 1, NULL, 'Admin', now(), NULL, now(), NULL, NULL, NULL);
