--2021-05-23 10:52:10
update personprogramarea set enddate = null, updatedby = 'CDM-14651',updatedon = now() where personprogramid = 'db645959-5d2f-40c3-9b24-e950c58a2ecf';

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-14651',updatedon = now() WHERE servicecaseid = 'f65adbc4-b3e6-4f5e-bde0-d9724e3a1568';


INSERT INTO cjams.servicecasedisposition ( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
			insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('f65adbc4-b3e6-4f5e-bde0-d9724e3a1568', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-14651', now(), 'CDM-14651', now(), NULL, null, NULL, null);