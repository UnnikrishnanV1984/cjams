/*
   Issue Description: CJAMS-58557
   Category/ Module  : Intake (Jurisdiction)
   Root cause: The intakedastaging json object did not update jurisdiction after intake transfer
   Pull request# for code fix: 
   Reason why no related code fix: QA not able to replicate this as jurisdiction is getting transfered
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

--7665ca54-5374-4174-be07-a687b811a82c	Baltimore City   (Old)
--1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b	Baltimore County (New)

UPDATE intakedastaging
SET updatedby = 'CJAMS-58557', updatedon = now(), 
jsondata = 	jsonb_set(jsondata, '{General}', 
				jsonb_set(jsondata->'General', '{countyid}', '"1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b"'))
WHERE intakenumber = 'I251013249941' AND activeflag=1;