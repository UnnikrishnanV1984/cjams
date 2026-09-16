delete from cjams.referencetype where referencetypeid = 10000;
delete from cjams.referencevalues where referencetypeid = 10000;

INSERT INTO cjams.referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(10000, 'Delay In Enrollment', 'delayinenrollment', 1, 'admin', now(), 'admin',now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon) 
VALUES('CH',10000,'Child hospitalized','Child hospitalized','CW', 1, 1, 'admin', now(), 'admin', now()),
	  ('CR',10000,'Child on runaway','Child on runaway','CW', 1, 2, 'admin', now(), 'admin', now()),
	  ('ESDE',10000,'Educational setting delayed enrollment','Educational setting delayed enrollment','CW', 1, 3, 'admin', now(), 'admin', now()),
	  ('SOC',10000,'School offices closed','School offices closed','CW', 1, 4, 'admin', now(), 'admin', now()),
	  ('T',10000,'Transportation','Transportation','CW', 1, 5, 'admin', now(), 'admin', now()),
	  ('O',10000,'Other','Other','CW', 1, 6, 'admin', now(), 'admin', now());