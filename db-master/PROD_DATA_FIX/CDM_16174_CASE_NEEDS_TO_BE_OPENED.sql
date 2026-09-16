/*
   Issue Description: CDM-16174
   Category/ Module  :  Case needs to be open
   Root cause: user wants to open
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   backup data: 
		No OOH Program area for the case			
		Service Case ID : 'ebf68c32-dc6c-4e5c-8503-b85985ee7022';
		Previsous statustypekey : 'Closed'
		Service Disposition ID: 'fc71b526-b15e-409e-9e9d-eed592cb6e74';
*/

/* Old script

UPDATE servicecase 
	SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16174',updatedon = now() 
	WHERE servicecaseid = 'ebf68c32-dc6c-4e5c-8503-b85985ee7022';

	update servicecasedisposition 
	set activeflag = 0, updatedby = 'CDM-16174',updatedon = now() 
	where servicecasedispositionid = '9697da0e-9feb-4880-a587-c7d3123e33cc';

	*/
/* This is a new script needs to execute now as a fix and please don't execute the old script */


INSERT INTO cjams.servicecasedisposition ( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
insertedby, insertedon, updatedby, updatedon)
VALUES('ebf68c32-dc6c-4e5c-8503-b85985ee7022', '2021-08-10 10:00:00', 'Open', 'Inprogress', 'Case Re-Opened', '2021-08-10 10:00:00', 1, 
'06c4c04d-c2f9-4b45-a94c-4c276a8784d2', now(), 'CDM-16174', now());

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-16174',updatedon = now() 
WHERE servicecaseid = 'ebf68c32-dc6c-4e5c-8503-b85985ee7022';