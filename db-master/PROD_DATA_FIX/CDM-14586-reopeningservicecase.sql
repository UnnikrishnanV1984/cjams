INSERT INTO cjams.servicecasedisposition ( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
			insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('a1231ba3-c4bd-4203-bf89-092c45c43104', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-14586', now(), 'CDM-14586', now(), NULL, null, NULL, null);

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-14586',updatedon = now() WHERE servicecaseid = 'a1231ba3-c4bd-4203-bf89-092c45c43104';

update personprogramarea set enddate = null, updatedon = now() where personprogramid in ('55a114bd-04e3-4471-ada9-475cbe7a77cb');
