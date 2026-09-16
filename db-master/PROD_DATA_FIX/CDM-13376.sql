	
INSERT INTO cjams.servicecasedisposition ( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
			insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
	      VALUES('fd77a9fa-f1d6-4d49-a691-80b8dbd5e28c', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
		'CDM-13376', now(), 'CDM-13376', now(), NULL, null, NULL, null);
	
	
UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-13376',updatedon = now() WHERE servicecaseid = 'fd77a9fa-f1d6-4d49-a691-80b8dbd5e28c';

update caseassignment c set enddate = null, updatedby = 'CDM-13376', updatedon = now() where caseassignmentid in ('d9e3b926-0413-40e6-8f78-4160e9120f34', '26c96a61-a0ae-4c96-9438-4b9cfb1db8a1', '31392fee-c69b-458c-9d72-e4d39f95c2af');

update personprogramarea set enddate = null, updatedby = 'CDM-13376', updatedon = now() where personprogramid in ('9f2ab821-d089-40dd-b690-3be34a57cab8');