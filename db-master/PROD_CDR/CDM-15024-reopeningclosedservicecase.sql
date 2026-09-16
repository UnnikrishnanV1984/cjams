/*
   Issue Description: CDM-15024
   Category/ Module  :  case closure
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


INSERT INTO cjams.servicecasedisposition ( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
			insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
		VALUES('8cbea4d3-df5b-481b-a3b4-ba5763c10e8a','2021-06-17 00:00:00', 'Reopen', 'Inprogress', 'Case Re-Opened','2021-06-17 00:00:00', 1, 
		'CDM-15024', now(), 'CDM-15024', now(), NULL, null, NULL, null);

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-15024',updatedon = now() WHERE servicecaseid = '8cbea4d3-df5b-481b-a3b4-ba5763c10e8a';
