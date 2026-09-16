INSERT INTO cjams.servicecasedisposition ( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
			insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('95be6d0b-0d9d-41b7-ba70-659668330c8a', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-13295', now(), 'CDM-13295', now(), NULL, null, NULL, null);

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-13295',updatedon = now() WHERE servicecaseid = '95be6d0b-0d9d-41b7-ba70-659668330c8a';

update personprogramarea set enddate = null, updatedby = 'CDM-13295', updatedon = now() where personprogramid in ('3406b967-4627-4771-9634-104054b3c209', '985a55d8-78f1-47dc-9d16-25df0d3a1eac');

update caseassignment c set enddate = null, updatedby = 'CDM-13295', updatedon = now() where caseassignmentid in ('2ac07528-b93d-4b9d-be6f-941322b190ac', '2e6ae430-c286-4de4-90fd-889ad2678e4a');
