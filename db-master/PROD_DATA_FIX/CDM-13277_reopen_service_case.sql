INSERT INTO cjams.servicecasedisposition ( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
			insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
		VALUES('75632216-08f1-4088-899f-f4b5b572635d', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
		'CDM-13277', now(), 'CDM-13277', now(), NULL, null, NULL, null);

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-13277',updatedon = now() WHERE servicecaseid = '75632216-08f1-4088-899f-f4b5b572635d';

update personprogramarea set enddate = null, updatedby = 'CDM-13277', updatedon = now() where personprogramid in ('2b40c2c0-5de0-499c-8237-0c923a7c27f2');

update caseassignment c set enddate = null, updatedby = 'CDM-13277', updatedon = now() where caseassignmentid in ('680351dc-a865-4935-8806-298d1b4f5943');
