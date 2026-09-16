delete from cjams.referencevalues where ref_key in('JUFATY','LEGUHO','OTHER','PAHOLD','RELHLD','RELGUL') and referencetypeid=5470;

delete from cjams.referencetype where referencetypeid=5470;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('JUFATY', 5470, 'Justice facility', 'Justice facility', 'CW', 1, 1, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('LEGUHO', 5470, 'Legal guardian household', 'Legal guardian household', 'CW', 1, 2, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('MEHEFA', 5470, 'Medical/mental health facility', 'Medical/mental health facility', 'CW', 1, 3, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL, NULL, NULL);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('OTHER', 5470, 'Other', 'Other', 'CW', 1, 4, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL, NULL, NULL);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PAHOLD', 5470, 'Parent household', 'Parent household', 'CW', 1, 5, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RELHLD', 5470, 'Relative household', 'Relative household', 'CW', 1, 6, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL, NULL, NULL);



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('RELGUL', 5470, 'Relative legal guardian household', 'Relative legal guardian household', 'CW', 1, 7, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL, NULL, NULL);


INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(5470, 'Environment at Removal', 'Environment at Removal:', 1, 'CIDM-5740', now(), 'CIDM-5740', now(), NULL);