-- CJAMS-64744: updating jurisdiction from Baltimore County to Baltimore City for #I261013797898.
/*
   Issue Description: Data fix needed to update jurisdiction from Baltimore County to Baltimore City for #I261013797898.
   Category/ Module  : Intake (Jurisdiction)
   Root cause: The intakedastaging json object did not update jurisdiction after intake transfer
   Fix provided: Data fix has been to done to update json data countyid from Baltimore County to Baltimore City of intakedastaging.
   Data/Code fix ticket#: CJAMS-64744
   Regression Impacts: No
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: QA not able to replicate this as jurisdiction is getting transfered
*/

--Intake referral:  I261013797898
--Baltimore City: 7665ca54-5374-4174-be07-a687b811a82c	 
--Baltimore County: 1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b	

UPDATE intakedastaging
SET updatedby = 'CJAMS-64744', updatedon = now(), 
jsondata = 	jsonb_set(jsondata, '{General}', 
				jsonb_set(jsondata->'General', '{countyid}', '"7665ca54-5374-4174-be07-a687b811a82c"'))
WHERE intakenumber = 'I261013797898' AND activeflag = 1;