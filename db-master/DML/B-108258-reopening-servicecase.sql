DELETE FROM referencetype WHERE referencetypeid = 754;
DELETE FROM referencevalues WHERE referencetypeid = 754;

INSERT INTO referencetype (referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(754, 'Reopen Service Case', 'reopencase', 1, 'admin', now(), 'admin',now(), NULL);

INSERT INTO cjams.referencevalues (ref_key, referencetypeid, value_text, description,  teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon) 
VALUES('EACN',754,'Enter a Contact Note','Enter a Contact Note','CW', 1, 2, 'admin', now(), 'admin', now()),
	  ('RSIE',754,'Reopen a Service Case closed in error','Reopen a Service Case closed in error','CW', 1, 3, 'admin', now(), 'admin', now()),
	  ('IVED',754,'IVE-Determination','IVE-Determination','CW', 1, 5, 'admin', now(), 'admin', now());