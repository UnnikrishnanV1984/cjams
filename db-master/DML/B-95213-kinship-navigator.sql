Delete from programareaconfig where programkey = 'IHSFP' and subprogramkey = 'KN';

INSERT INTO programareaconfig (programkey, subprogramkey, servicerequestsubtypekey,isdefault, activeflag, effectivedate, insertedby,updatedby, insertedon, updatedon)
 VALUES('IHSFP','KN','IHM',0,1, now(), 'admin','admin',now(),now());
 
Delete from referencevalues where referencetypeid = 12 and ref_key = 'KN';

 INSERT INTO referencevalues (ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode) 
 VALUES(	'KN',	12,	'Kinship Navigator', 'Kinship Navigator',	'CW',	1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL);
